Bought a domain on Cloudflare (jhayford.co.uk)

Launch an EC2 instance

- Amazon Linux 2
- Security groups allowed HTTP (port 80)
- Install and run NGINX

Commands used once the EC2 instance was launched.

Installing NGINX

sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start

I verified that NGINX was running using: 

sudo systemctl status nginx

I then tested the web server locally:

curl http://localhost

The server returned the default NGINX HTML page.

Security Group

The EC2 Security Group allows HTTP traffic over TCP port 80.

Relevant ports:

| Protocol | Port | Purpose               |
| -------- | ---- | --------------------- |
| SSH      | 22   | Remote administration |
| HTTP     | 80   | Web traffic           |
| HTTPS    | 443  | Encrypted web traffic |

DNS Configuration

- Created an A record in Cloudflare
- Pointed it to the EC2 public IPv4 address
- Once the DNS propagates, the domain loaded the NGINX default page

https://nginx.jhayford.co.uk/

An A record maps a hostname to an IPv4 address.

This allows users to access the server through a human-readable domain rather than entering the EC2 IP address directly.

Testing

I first tested the server directly using the EC2 public IPv4 address.

The NGINX default landing page loaded successfully.

I then tested the custom domain after configuring DNS.

Troubleshooting
SSH authentication

Initially, SSH could not locate my private key because the path to the
.pem file was incorrect.

I corrected the path and successfully authenticated to the EC2 instance.

NGINX commands

I initially attempted to run systemctl from Windows PowerShell.

I learned that systemctl is a Linux command and therefore must be run
after SSHing into the Linux EC2 instance.

Cloudflare 521 Error

When testing the domain, Cloudflare returned:

Error 521 - Web server is down

I troubleshoot the problem layer by layer.

I verified GINX locally:

curl http://localhost

I verified the EC2 Security Group allowed TCP port 80.

Lastly, I tested the EC2 public IP directly in the browser and was able to succesfully reach the NGINX landing page.

This helped isolate the problem to the DNS/proxy layer rather than the EC2 instance or NGINX itself.

What I Learned

Through this project I gained practical experience with:

- DNS A records
- Public and private IP addresses
- TCP ports
- AWS Security Groups
- SSH key authentication
- Linux server administration
- NGINX
- Cloudflare DNS
- Troubleshooting network connectivity layer by layer

The main lesson I was learing to isolate network problems rather than changing mutiple things at once.