ignore = {
    "OllieN",
    "DevBot"}
function checkIgnore(nick)
    for i=1,#ignore do
        if ignore[i] == nick then
            return false
        end
    end
end
