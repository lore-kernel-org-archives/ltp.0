From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Jul 2019 13:42:04 +0200
Subject: [LTP] [PATCH 3/3] zram/zram_lib.sh: iterate through all
 available compression algorithms for all zram block devices
In-Reply-To: <20190703102303.32166-4-po-hsu.lin@canonical.com>
References: <20190703102303.32166-1-po-hsu.lin@canonical.com>
 <20190703102303.32166-4-po-hsu.lin@canonical.com>
Message-ID: <20190709114204.GB5888@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  .../kernel/device-drivers/zram/zram_lib.sh     | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> index d50be699d..96400b2d9 100755
> --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -101,12 +101,18 @@ zram_compress_alg()
>  	local zram_algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
>  	tst_resm TINFO "supported algs: $zram_algs"
>  	local i=0
> -	for alg in $zram_algs; do
> -		local sys_path="/sys/block/zram${i}/comp_algorithm"
> -		echo "$alg" >  $sys_path || \
> -			tst_brkm TFAIL "can't set '$alg' to $sys_path"
> -		i=$(($i + 1))
> -		tst_resm TINFO "$sys_path = '$alg' ($i/$dev_num)"
> +	local dev_max=0
> +	while [ -d /sys/block/zram$(($dev_max + 1)) ]; do
> +		dev_max=$(($dev_max + 1))
> +	done

The zram01.sh test defines dev_num that is passed to the modprobe zram
as num_devices, there is no point in counting the block devices like
this.

> +	for i in $(seq 0 $dev_max); do
> +		for alg in $zram_algs; do
> +			local sys_path="/sys/block/zram${i}/comp_algorithm"
> +			echo "$alg" >  $sys_path || \
> +				tst_brkm TFAIL "can't set '$alg' to $sys_path"
> +			tst_resm TINFO "$sys_path = '$alg' ($i/$dev_max)"
> +		done
>  	done

This is OK, but we should make sure we end up with expected compression
method for subsequent tests.

Maybe we should just set the alg to the zram_algs="" as defined in the
zram01.sh after this loop.

>  	tst_resm TPASS "test succeeded"
> -- 
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
