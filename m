From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 May 2018 10:35:09 +0200
Subject: [LTP] [PATCH 1/1] net/tst_netload: TBROK when TST_NEEDS_TMPDIR
	not set
In-Reply-To: <20180516131430.19090-1-pvorel@suse.cz>
References: <20180516131430.19090-1-pvorel@suse.cz>
Message-ID: <20180523083509.4ypk3prcbokvhnu6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> tst_netload function uses $TST_TMPDIR therefore requires
> TST_NEEDS_TMPDIR=1. It's better to tell user the reason, as current
> error message was a bit misleading:

> dccp_ipsec 1 TINFO: run server 'netstress -T dccp -R 500000 -B '
> netstress: option requires an argument -- 'B'

...
> +++ b/testcases/lib/tst_net.sh
> @@ -480,6 +480,10 @@ tst_netload()
>  	local s_replies="${TST_NETLOAD_MAX_SRV_REPLIES:-500000}"
>  	local s_opts=

> +	if [ ! "$TST_NEEDS_TMPDIR" = 1 ]; then
> +		tst_brk_ TBROK "Using tst_netload requires setting TST_NEEDS_TMPDIR=1"
> +	fi
> +

Pushed.


Kind regards,
Petr
