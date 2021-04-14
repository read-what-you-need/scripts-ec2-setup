sudo apt install -y nginx

sudo cp ./predictor_and_pdf_convert_setup/nginx_predictor_api.conf  /etc/nginx/conf.d/predictorapi.deeps.site.conf

sudo apt-get install -y python-certbot-nginx

# make sure the predictorapi.deeps.site has correct A records pointing to the ec2 instance
#sudo nginx -t && nginx -s reload
sudo certbot --nginx -d predictorapi.deeps.site

#sudo service nginx restart