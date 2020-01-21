From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Jan 2020 15:14:54 +0100
Subject: [LTP] [PATCH 1/1] memcg/stress: Lower swap memory use
In-Reply-To: <20200117063600.3451-1-pvorel@suse.cz>
References: <20200117063600.3451-1-pvorel@suse.cz>
Message-ID: <20200121141454.GA6337@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fix freeze on systems, where where swap size is more
> or less equal to a system RAM.
> 
> Fixes: #632
> 
> Reported-by: Zuo Liu <lz843723683@gmail.com>
> Tested-by: Zuo Liu <lz843723683@gmail.com>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index ad8605e16..a48d21e6e 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -33,7 +33,7 @@ setup()
>  	local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
>  	local pgsize=`tst_getconf PAGESIZE`
>  
> -	MEM=$(( $mem_free + $swap_free / 2 ))
> +	MEM=$(( $mem_free + $swap_free / 1O ))

I wonder if we can be a bit smarter about this. Maybe we should add some
percentage of RAM if enough swap is present.

-- 
Cyril Hrubis
chrubis@suse.cz
