# removes files that are older than 90 days and do not end in 01.tgz or 15.tgz
# i.e. keep all files that are younger than 90 days and those from beginning and middle of the month
find backups -type f ! \( -name '*01.tgz' -o -name '*15.tgz' \) -mtime +90 -exec rm {} \;

