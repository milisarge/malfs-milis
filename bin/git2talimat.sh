account="$1"
name="$2"
file="$name.html"
curl -k https://github.com/"$account/$name" > "$file" 
desc=`sed -n 's|[^<]*<span itemprop="about">\([^<]*\)</span>[^<]*|\1\n|gp' $file`
echo "# Description:$desc"
