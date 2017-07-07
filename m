From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jul 2017 14:55:46 +0200
Subject: [LTP] [PATCH 1/3] commands/keyctl01: Fix potential infinite loop
In-Reply-To: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170707125546.GB28534@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
> index 076a130..5a97499 100644
> --- a/testcases/commands/keyctl/keyctl01.sh
> +++ b/testcases/commands/keyctl/keyctl01.sh
> @@ -62,15 +62,17 @@ cleanup()
>  
>  do_test()
>  {
> +	local quota_excd=0
>  	local maxkeysz=$((ORIG_KEYSZ + 100))
>  
> -	while true
> +	while [ $maxkeysz -gt $ORIG_KEYSZ ]

This may still be incorrect if some keys has been deleted after we
executed the setup() function though. This is quite unlikely but still
may happen. What about we ended the loop once $maxkeysz < 0?

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
