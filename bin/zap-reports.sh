echo $1
filename="$1/zap_report.html"
echo $filename
echo "saving $filename"
curl http://localhost:8080/OTHER/core/other/htmlreport/? > $filename
