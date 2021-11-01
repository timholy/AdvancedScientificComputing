charlist = 'a':'z'

function randomstring(n::Integer)
    str = ""
    for i = 1:n
        str *= rand(charlist)
    end
    return str
end
