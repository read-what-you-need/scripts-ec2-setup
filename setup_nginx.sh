sudo apt install nginx
nginx -s
sudo cp ./predictor_and_pdf_convert_setup/nginx_predictor_api.conf  /etc/nginx/conf.d/predictorapi.deeps.site.conf

#sudo apt-get install python-certbot-nginx

#sudo nginx -t && nginx -s reload
#sudo certbot --nginx -d predictorapi.deeps.site
#sudo service nginx restart
