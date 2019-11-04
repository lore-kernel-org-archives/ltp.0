From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Nov 2019 16:16:49 +0100
Subject: [LTP] [PATCH 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191104125228.17173-2-mdoucha@suse.cz>
References: <20191104125228.17173-1-mdoucha@suse.cz>
 <20191104125228.17173-2-mdoucha@suse.cz>
Message-ID: <20191104151647.GA15477@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> zram01 uses `free -m` to measure zram memory usage. The results are nonsense
> because they are polluted by all running processes on the system.

> Use /sys/block/zram<id>/mm_stat to measure memory usage instead. The file is
> available since kernel 4.1.
+1 even older kernels won't be covered.
Thanks!

...
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
>  zram_fill_fs()
>  {
> -	tst_test_cmds awk bc dd free
> -	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
> +	tst_test_cmds awk bc dd

>  	for i in $(seq 0 $(($dev_num - 1))); do
>  		tst_resm TINFO "fill zram$i..."
> @@ -75,29 +74,26 @@ zram_fill_fs()
>  			tst_brkm TBROK "cannot fill zram"
>  		fi
>  		tst_resm TINFO "zram$i can be filled with '$b' KB"
> -	done
> -
> -	local mem_free1=$(free -m | awk 'NR==2 {print $4}')
> -	local used_mem=$(($mem_free0 - $mem_free1))
> -
> -	local total_size=0
> -	for sm in $zram_sizes; do
> -		local s=$(echo $sm | sed 's/M//')
> -		total_size=$(($total_size + $s))
> -	done

> -	[ $used_mem -eq 0 ] && tst_brkm TBROK "no memory used by zram"
> +		if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
> +			if [ $i -eq 0 ]; then
> +				tst_resm TCONF "zram compression ratio test requires zram mm_stat sysfs file"
I wonder if /sys/block/zram0/mm_stat is missing whether it can be on any other
zram<id>. Is it it's presence file system specific? Shouldn't we just quit whole
test wit tst_brk TCONF.

Kind regards,
Petr
