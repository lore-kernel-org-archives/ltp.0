From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Sep 2016 13:19:45 +0200
Subject: [LTP] [patch]  kernel/zram: Fix  testcase for kernels >= v4.7
In-Reply-To: <1474962167.15058.3.camel@suse.de>
References: <1474962167.15058.3.camel@suse.de>
Message-ID: <20160927111945.GA12308@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> max_comp_streams is depreciated in kernels >= v4.7, bail instead
> of failing.
> 
> Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
> ---
>  testcases/kernel/device-drivers/zram/zram_lib.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> index d3e62e0dff43..2144227df001 100755
> --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -62,6 +62,14 @@ zram_load()
>  
>  zram_max_streams()
>  {
> +	tst_kvercmp 4 7 0
> +	if [ $? -gt 0 ]; then
> +		tst_resm TCONF "device attribute max_comp_streams is"\
> +			"depriciated since kernel v4.7, the running kernel"\
> +			"does not support it"
> +		return
> +	fi
> +
>  	tst_kvercmp 3 15 0
>  	if [ $? -eq 0 ]; then
>  		tst_resm TCONF "device attribute max_comp_streams is"\

Pushed, thanks.

BTW: The LTP mailing list is for quite some time hosted at
     lists.linux.it. And all places in documentation should
     have been fixed to point to it. Where did you find the
     old address?

-- 
Cyril Hrubis
chrubis@suse.cz
