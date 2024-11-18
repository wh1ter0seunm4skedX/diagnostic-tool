echo "Performing traceroute..."
traceroute google.com

echo "Performing DNS resolution..."
nslookup google.com

echo "Testing bandwidth (requires curl)..."
curl -o /dev/null http://speedtest.tele2.net/10MB.zip
