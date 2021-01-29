From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 21:17:20 +0100
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <20210129194144.31299-3-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
Message-ID: <YBRtUD8vJUuF4S6V@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> -# List of parameters for zram devices.
> -# For each number the test creates own zram device.
> -zram_max_streams="2 3 5 8"
Not sure about the meaning of zram_max_streams.
It looks like sequence of i+3, starting from 0.
Maybe instead of having variable behaving like array,
zram_max_streams() loop could be based on $dev_num.
But that's just cosmetic.
...
> +generate_vars()
> +{
> +	local fs limit size stream=-1
> +	dev_num=0
> +
> +	for fs in $(tst_supported_fs | grep -v -e fat -e ntfs -e fuse); do
> +		size="26214400"
> +		limit="25M"
> +		if [ "$fs" = "btrfs" ]; then
> +			get_btrfs_size || continue
> +			size="402653184"
> +			limit="$((size/1024/1024))M"
> +		fi
> +
> +		stream=$((stream+3))
> +		dev_num=$((dev_num+1))
> +		zram_filesystems="$zram_filesystems $fs"
> +		zram_mem_limits="$zram_mem_limits $limit"
> +		zram_sizes="$zram_sizes $size"
> +		zram_max_streams="$zram_max_streams $stream"

...
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -36,10 +36,12 @@ zram_load()
>  {
>  	local tmp

> -	dev_num=0
> -	for tmp in $zram_max_streams; do
> -		dev_num=$((dev_num+1))
> -	done
> +	if [ -z "$dev_num" ]; then
> +		dev_num=0
> +		for tmp in $zram_max_streams; do
> +			dev_num=$((dev_num+1))
> +		done
> +	fi

>  	if [ $dev_num -le 0 ]; then
>  		tst_brk TBROK "dev_num must be > 0"
> @@ -129,6 +131,7 @@ zram_set_disksizes()

>  		i=$(($i + 1))
>  		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
> +		[ $i -eq $dev_num ] && break
This check is not needed any more.
>  	done

>  	tst_res TPASS "test succeeded"
> @@ -155,6 +158,7 @@ zram_set_memlimit()

>  		i=$(($i + 1))
>  		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
> +		[ $i -eq $dev_num ] && break
And here.
>  	done

>  	tst_res TPASS "test succeeded"
> @@ -191,13 +195,10 @@ zram_swapoff()

>  zram_makefs()
>  {
> -	tst_require_cmds mkfs
>  	local i=0
> +	local fs

>  	for fs in $zram_filesystems; do
> -		# if requested fs not supported default it to ext2
> -		tst_supported_fs $fs 2> /dev/null || fs=ext2
> -
>  		tst_res TINFO "make $fs filesystem on /dev/zram$i"
>  		mkfs.$fs /dev/zram$i > err.log 2>&1
>  		if [ $? -ne 0 ]; then
> @@ -206,6 +207,7 @@ zram_makefs()
>  		fi

>  		i=$(($i + 1))
> +		[ $i -eq $dev_num ] && break
And here
>  	done

Kind regards,
Petr
