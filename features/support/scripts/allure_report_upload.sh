#!/bin/bash
set -e

server="";
accept="accept: */*";
conten_type="Content-Type: application/json";
# add below the reports folder relative to this script path
results_dir="reports/allure";
cd ${results_dir};
# rm categories.json
files=(*.json);

# iterate through all files arrau to create the encoded body
for ((i=0; i<${(#files[@])}; i++)); do
  encoded_data="$(base64 "${files[$i]}")";
  [ -z "$results" ] && results="{\"file_name\":\"${files[$i]}\",\"content_base64\":\"${encoded_data}\"}" || results +=",{\"file_name\":\"${files[$i]}\",\"content_base64\":\"${encoded_data}\"}";
done

body="{\"results\":[${results}]}";

tmpfile=$(mktemp /tmp/post.XXXXXXX --suffix ".json");
exec 3>"$tempfile";
echo ${body}>&3;

curl -X POST "${server}/send-results" -H "${accept}" -H "${conten_type}" -d @"${tempfile}";
rm "$tmpfile";

curl -X GET "${server}/generate-report" -H "${accept}";