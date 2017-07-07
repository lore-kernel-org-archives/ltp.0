From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jul 2017 15:08:28 +0200
Subject: [LTP] [PATCH 2/3] commands/keyctl01: Fix getting key serial
 number
In-Reply-To: <1494483656-15971-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1494483656-15971-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170707130827.GC28534@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So fix this by adding a match with "inaccessible".
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/commands/keyctl/keyctl01.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
> index 5a97499..8ea2b25 100644
> --- a/testcases/commands/keyctl/keyctl01.sh
> +++ b/testcases/commands/keyctl/keyctl01.sh
> @@ -77,6 +77,11 @@ do_test()
>  		fi
>  
>  		local key=`keyctl show | awk '/debug:fred/ {print $1}'`
> +		if [ -z "$key" ]; then
> +			key=`keyctl show | \
> +				awk -F ':' '/inaccessible/ {print $1}'`
> +		fi

Can't we rather split the keyctl request and keyctl negate operations
into two and get the key after the key has been requested but before it
was negated?

Or is it required to do the request and negate operation in a signle
keyctl command in order to reproduce the kernel crash?

>  		if [ -n "$key" ]; then
>  			keyctl unlink $key @s >/dev/null
>  			tst_sleep 50ms
> -- 
> 1.8.4.2
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
