  
server {
    listen        80 ;
    server_name   local.neoauto.search.com;
    root          /apps/neoauto-micro-service-search/app/public;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ .php$ {
        try_files     $uri =404;
        fastcgi_pass  127.0.0.1:9000;
        include       fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    error_page 404 /404.html;
        location = /40x.html {
    }

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
    }

    error_log /var/log/nginx/local.neoauto.search.com.error.log;
}