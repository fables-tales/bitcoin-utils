require 'net/http'
require "json"


$hash = "000000000002d01c1fccc21636b607dfd930d31d01c3a62104612a1719011250"

connection = Net::HTTP.start("blockexplorer.com")
resp = connection.get("/q/getblockcount")
$startblock = Integer(resp.body)
$hash  = connection.get("/q/latesthash").body

downloaded = Dir.new("blocks/").entries.length - 2


Net::HTTP.start("blockexplorer.com") do |http|
    while $startblock > downloaded
        resp = http.get("/rawblock/#{$hash}").body
        next_hash = JSON.parse(resp)["prev_block"]
        f = open("blocks/#{$startblock}", "w")
        f.write(resp)
        f.close
        $startblock -= 1
        $hash = next_hash
        puts $startblock
    end
end
