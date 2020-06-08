From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Jun 2020 16:58:31 +0200
Subject: [LTP] [PATCH] network/nfs_lib.sh: Use double quotes for grep
 pattern
In-Reply-To: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
References: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200608145831.GA2746544@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -58,7 +58,7 @@ nfs_server_udp_enabled()
>  	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
>  	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ] && printf "$f "; done')

> -	tst_rhost_run -c "grep -q '^[# ]*udp *= *y' /etc/nfs.conf $config"
> +	tst_rhost_run -c "grep -q \"^[# ]*udp *= *y\" /etc/nfs.conf $config"
Good catch. But I wonder if we shouldn't fix tst_rhost_run instead, to avoid
this error in the future. How about replacing ' with \" in $cmd?

Kind regards,
Petr
