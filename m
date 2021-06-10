From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Jun 2021 15:44:27 +0200
Subject: [LTP] [PATCH v3 2/2] API: Remove TEST macro usage from library
In-Reply-To: <20210610121819.24626-2-rpalethorpe@suse.com>
References: <20210610121819.24626-1-rpalethorpe@suse.com>
 <20210610121819.24626-2-rpalethorpe@suse.com>
Message-ID: <YMIXO6IGN/1VHtbe@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
> index d098173d5..cc2766be8 100644
> --- a/lib/tst_netdevice.c
> +++ b/lib/tst_netdevice.c
> @@ -149,7 +149,7 @@ int tst_create_veth_pair(const char *file, const int lineno,
>  	tst_rtnl_destroy_context(file, lineno, ctx);
>  
>  	if (!ret) {
> -		tst_brk_(file, lineno, TBROK | TTERRNO,
> +		tst_brk_(file, lineno, TBROK | TERRNO,
>  			"Failed to create veth interfaces %s+%s", ifname1,
>  			ifname2);
>  	}
> @@ -183,7 +183,7 @@ int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
>  	tst_rtnl_destroy_context(file, lineno, ctx);
>  
>  	if (!ret) {
> -		tst_brk_(file, lineno, TBROK | TTERRNO,
> +		tst_brk_(file, lineno, TBROK | TERRNO,
>  			"Failed to remove netdevice %s", ifname);
>  	}
>  
> @@ -232,7 +232,7 @@ static int modify_address(const char *file, const int lineno,
>  	tst_rtnl_destroy_context(file, lineno, ctx);
>  
>  	if (!ret) {
> -		tst_brk_(file, lineno, TBROK | TTERRNO,
> +		tst_brk_(file, lineno, TBROK | TERRNO,
>  			"Failed to modify %s network address", ifname);
>  	}
>  
> @@ -301,7 +301,7 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
>  	tst_rtnl_destroy_context(file, lineno, ctx);
>  
>  	if (!ret) {
> -		tst_brk_(file, lineno, TBROK | TTERRNO,
> +		tst_brk_(file, lineno, TBROK | TERRNO,
>  			"Failed to move %s to another namespace", ifname);
>  	}
>  
> @@ -392,7 +392,7 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
>  	tst_rtnl_destroy_context(file, lineno, ctx);
>  
>  	if (!ret) {
> -		tst_brk_(file, lineno, TBROK | TTERRNO,
> +		tst_brk_(file, lineno, TBROK | TERRNO,
>  			"Failed to modify network route");
>  	}
>  
> diff --git a/lib/tst_rtnetlink.c b/lib/tst_rtnetlink.c
> index 1ecda3a9f..d93f7e18d 100644
> --- a/lib/tst_rtnetlink.c
> +++ b/lib/tst_rtnetlink.c
> @@ -380,7 +380,7 @@ int tst_rtnl_check_acks(const char *file, const int lineno,
>  		}
>  
>  		if (res->err->error) {
> -			TST_ERR = -res->err->error;
> +			errno = -res->err->error;
>  			return 0;
>  		}
>  	}
> @@ -394,7 +394,7 @@ int tst_rtnl_send_validate(const char *file, const int lineno,
>  	struct tst_rtnl_message *response;
>  	int ret;
>  
> -	TST_ERR = 0;
> +	errno = 0;
>  
>  	if (tst_rtnl_send(file, lineno, ctx) <= 0)
>  		return 0;

I've did a careful review and this part is actually not correct. The
tst_rtnl_send_validate() function uses TST_ERR to propagate error while
the caller calls tst_rtnl_destroy_context() before it reads the value.
It's not correct to use errno this way since it may be modified in the
functions that free messages or destroys the context.

I guess that fixing this part correctly would mean to change the
tst_rtnl_send_validate() to return the return value from
tst_rtnl_check_acks() and the tst_rtnl_check_acks() would have to return
error on a failure.

It may also make sense to split this patch into two and keep changes to
these two files in a separate patch, since the rest is more or less
mechanical replacement of the TEST() macro use which is as far as I can
tell correct.

-- 
Cyril Hrubis
chrubis@suse.cz
