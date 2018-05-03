From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 10:23:49 +0200
Subject: [LTP] [PATCH ltp] fs/ext4: enhance logic of
 ext4_nsec_timestamps_test
In-Reply-To: <20180429000213.685-1-yixin.zhang@intel.com>
References: <20180429000213.685-1-yixin.zhang@intel.com>
Message-ID: <20180503082348.GB29568@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. Check the big block devices at setup stage, umount it if it's mounted

I do not like this one much as this will only hide bugs in the rest of
the tests that fail to umount the device.

I would rather see the test exit with TBROK and let the user handle the
situation.

> 2. Add "sleep 1" between mount and umount, to avoid umount failed due to
>    device busy (accessed by system service like systemd-udev)

NACK to this.

In a case that we need to wait for something like this we are supposed
to retry in a loop with exponential backoff, which is usually faster
than hardcoded sleep but also more robust.

There is a in-flight patch for adding TST_RETRY_FUNC function to the
shell library "[PATCH] tst_test.sh: achieve TST_RETRY_FUNC function in shell"
which should make this really easy but we would have to add it to the
old shell test library as well so that we can reuse it here.

> 3. Add TFAIL if umount failed
> 4. Fix typo error

This looks good.

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  .../ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh      | 14 +++++++++-----
>  testcases/kernel/fs/ext4-new-features/ext4_funcs.sh        |  6 ++++++
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> index c6ff7c2ba..5d561adf3 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> @@ -76,8 +76,8 @@ ext4_test_nsec_timestamps()
>  
>  	mkfs.ext3 -I 256 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "failed to create ext4 filesystem"
> -		return
> +		tst_resm TFAIL "failed to create ext3 filesystem"
> +	  return
>  	fi
>  	mount -t ext4 $EXT4_DEV mnt_point
> @@ -105,8 +105,7 @@ ext4_test_nsec_timestamps()
>  	nsec_ctime=`ext4_file_time mnt_point/tmp_file ctime nsec`
>  
>  	# Test nanosecond
> -	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]
> -	then
> +	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
>  		tst_resm TFAIL "The timestamp is not nanosecond(nsec_atime: $nsec_atime, nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)"
>  		umount mnt_point
>  		return
> @@ -138,7 +137,12 @@ ext4_test_nsec_timestamps()
>  		tst_resm TFAIL "failed to mount to ext3"
>  		return
>  	fi
> +	sleep 1
>  	umount mnt_point
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "failed to umount ext3 filesystem"
> +		return
> +	fi
>  
>  	mount -t ext4 $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -148,7 +152,7 @@ ext4_test_nsec_timestamps()
>  
>  	nsec_atime2=`ext4_file_time mnt_point/tmp_file atime nsec`
>  	nsec_mtime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
> -	nsec_ctime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
> +	nsec_ctime2=`ext4_file_time mnt_point/tmp_file ctime nsec`
>  
>  	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
>  	     $nsec_mtime -ne $nsec_mtime2 ]; then
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> index a9eb54e8d..4de7899e4 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> @@ -45,6 +45,12 @@ ext4_setup()
>  		tst_brkm TCONF "tests need a big block device(5G-10G)"
>  	else
>  		export EXT4_DEV=$LTP_BIG_DEV
> +		if mount | cut -d' ' -f1 | grep -q ^$EXT4_DEV$ ; then
> +			umount $EXT4_DEV >/dev/null 2>&1
> +			if [ $? -ne 0 ]; then
> +				tst_brkm TCONF "umount $EXT4_DEV failed"
> +			fi
> +		fi
>  	fi
>  
>  	tst_tmpdir
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
