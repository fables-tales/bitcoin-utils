require "json"

def assert(bool, msg)
    if !bool
        puts msg
    end
end
$start = 160332
$count = $start
$hash = "0000000000000d0b10e9eda3f39716dca42096a0ada8bc079aa0bbb5640387f3"
$prev = -1


while true
    f = open("blocks/#{$count}").read()
    obj = JSON.parse(f)
    assert($hash == obj["hash"], "block hash not equal to expected on block #{$count}")
    $count -= 1
    if $count % 512 == 0
        puts $count
        puts 100 - ($count * 100.0/$start)
    end
    $hash = obj["prev_block"]
end
