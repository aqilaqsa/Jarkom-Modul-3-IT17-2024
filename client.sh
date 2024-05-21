apt update
apt install lynx -y
apt install htop -y
apt install apache2-utils -y
apt-get install jq -y

# 15 - di Paul (yg laravel)
echo '
{
  "username": "kelompokIT17",
  "password": "passwordIT17"
}' > register.json

# command: ab -n 100 -c 10 -p register.json -T application/json http://10.72.2.1:8001/api/auth/register

# 16 - Paul
echo '
{
  "username": "kelompokIT17",
  "password": "passwordIT17"
}' > login.json

# command: ab -n 100 -c 10 -p login.json -T application/json http://10.72.2.1:8001/api/auth/login

# 17 - Paul
curl -X POST -H "Content-Type: application/json" -d @login.json http://10.72.2.1:8001/api/auth/login > login_output.txt

# command:

# token=$(cat login_output.txt | jq -r '.token')

# ab -n 100 -c 10 -H "Authorization: Bearer $token" http://10.72.2.1:8001/api/me

# 18-19-20
# ab -n 100 -c 10 -p login.json -T application/json atreides.IT17.com/api/auth/login