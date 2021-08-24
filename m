From: Leo Liang <ycliang@andestech.com>
Date: Tue, 24 Aug 2021 19:27:37 +0800
Subject: [LTP] [PATCH v6,
 1/4] lib: tst_umount: umount a mount point instead of a device
In-Reply-To: <YSOuhTL87oYnwfk3@pevik>
References: <20210804015248.GA22328@andestech.com>
 <YSOuhTL87oYnwfk3@pevik>
Message-ID: <YSTXqWWebzq+mBIQ@ubuntu02>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Understood! Thanks for explaining everything!
I will send a v7 soon including all the modifications needed.

Best regards,
Leo

On Mon, Aug 23, 2021 at 04:19:49PM +0200, Petr Vorel wrote:
> Hi Leo,
> 
> as I noted at forth patch, some tests use tst_umount with the default parameter.
> Thus we should set the default TST_MNTPOINT to use $PWD as well.
> 
> I'd also add quotes around $mntpoint in TCONF/TINFO messages in tst_mount() as
> the original message was a bit confusing when the mountpoint was called
> 'mntpoint' (TWARN: The mntpoint is not an absolute path).
> 
> Kind regards,
> Petr
> 
> +++ testcases/lib/tst_test.sh
> @@ -279,31 +279,35 @@ tst_mount()
>  
>  tst_umount()
>  {
> -	local device="${1:-$TST_DEVICE}"
> +	local mntpoint="${1:-$TST_MNTPOINT}"
>  	local i=0
>  
> -	[ -z "$device" ] && return
> +	[ -z "$mntpoint" ] && return
>  
> -	if ! grep -q "$device" /proc/mounts; then
> -		tst_res TINFO "The $device is not mounted, skipping umount"
> +	if ! echo "$mntpoint" | grep -q ^/; then
> +		tst_brk TCONF "The '$mntpoint' is not an absolute path"
> +	fi
> +
> +	if ! grep -q "${mntpoint%/}" /proc/mounts; then
> +		tst_res TINFO "The '$mntpoint' is not mounted upon, skipping umount"
Will add this in v7!
>  		return
>  	fi
>  
>  	while [ "$i" -lt 50 ]; do
> -		if umount "$device" > /dev/null; then
> +		if umount "$mntpoint" > /dev/null; then
>  			return
>  		fi
>  
>  		i=$((i+1))
>  
> -		tst_res TINFO "umount($device) failed, try $i ..."
> +		tst_res TINFO "umount($mntpoint) failed, try $i ..."
>  		tst_res TINFO "Likely gvfsd-trash is probing newly mounted "\
>  		              "fs, kill it to speed up tests."
>  
>  		tst_sleep 100ms
>  	done
>  
> -	tst_res TWARN "Failed to umount($device) after 50 retries"
> +	tst_res TWARN "Failed to umount($mntpoint) after 50 retries"
>  }
>  
>  tst_mkfs()
> @@ -628,7 +632,7 @@ tst_run()
>  		cd "$TST_TMPDIR"
>  	fi
>  
> -	TST_MNTPOINT="${TST_MNTPOINT:-mntpoint}"
> +	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
This is a good catch.
I think I did notice that df01.sh uses tst_umount as a clean up
function, but didn't realize that this should be changed!
Thanks for the heads up!
>  	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
>  
>  		TST_DEVICE=$(tst_device acquire)
