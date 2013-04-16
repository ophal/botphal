sha256=require"sha256"
function hash(text)
    salt=""
	for i=1,25 do --gen salt
		uorl=math.random(1,2)
		if uorl==1 then --uppercase
			s=s..string.char(math.random(65,80))
		else --lowercase
			s=s..string.char(math.random(97,122))
		end
	end
	text=text..s
	return sha256.hash256(text),s
end
function hashnosalt(text)
	return sha256.hash256(text)
end
userdb=io.open("users.json","r")
if not userdb then
	os.execute("echo '\0'>users.json")
	print("It has been detected that there is no users DB. We will now create a new owner user.")
	users={}
	io.stdout:write"What is the username for this new user? "
	user=io.stdin:read'*l'
	io.stdout:write("What will the password for the user "..user.." be? ")
	pass=io.stdin:read'*l'
	users[user]={}
	users[user].perms={}
	users[user].perms["owner"]=true
	users[user].password,users[user].salt=hash(pass)
else
    userdb=json:decode(userdb:read'*a')
end
