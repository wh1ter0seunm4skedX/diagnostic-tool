echo "Running CPU benchmark..."
START=$(date +%s)
for i in {1..10000}; do echo $((i * i)) > /dev/null; done
END=$(date +%s)
echo "CPU benchmark completed in $((END - START)) seconds"
