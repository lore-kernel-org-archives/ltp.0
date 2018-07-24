From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jul 2018 14:28:51 +0200
Subject: [LTP] [PATCH v2 ltp] fs/ext4: enhance logic of
 ext4_nsec_timestamps_test
In-Reply-To: <20180504183842.32501-1-yixin.zhang@intel.com>
References: <20180504183842.32501-1-yixin.zhang@intel.com>
Message-ID: <20180724122851.GB21542@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. Check the big block device at do_setup(), TBROK if it's mounted
> 2. Replace umount to tst_umount to handle umount failed due to device busy
> 3. Fix typo error

Sorry for the delay.

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  .../ext4_nsec_timestamps_test.sh                   | 34 ++++++++--------------
>  .../kernel/fs/ext4-new-features/ext4_funcs.sh      |  3 ++
>  2 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> index c6ff7c2ba..69ae74c42 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> @@ -56,15 +56,10 @@ ext4_test_sec_timestamps()
>  	if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
>  		tst_resm TFAIL "Timestamp is not second(atime: $atime, mtime: \
>  				$mtime, ctime: $ctime)"
> -		umount mnt_point
> -		return
> -	fi
> -
> -	umount mnt_point
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "failed to umount ext4 filesystem"
> +		tst_umount mnt_point
>  		return
>  	fi
> +	tst_umount mnt_point
>  
>  	tst_resm TPASS "Ext4 nanosecond timestamps test with 128 inode size pass"
>  }
> @@ -76,8 +71,8 @@ ext4_test_nsec_timestamps()
>  
>  	mkfs.ext3 -I 256 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "failed to create ext4 filesystem"
> -		return
> +		tst_resm TFAIL "failed to create ext3 filesystem"
> +	  return
        ^
	The whitespace here should be keept consistent with the rest.

>  	fi
>  
>  	mount -t ext4 $EXT4_DEV mnt_point
> @@ -105,10 +100,9 @@ ext4_test_nsec_timestamps()
>  	nsec_ctime=`ext4_file_time mnt_point/tmp_file ctime nsec`
>  
>  	# Test nanosecond
> -	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]
> -	then
> +	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
>  		tst_resm TFAIL "The timestamp is not nanosecond(nsec_atime: $nsec_atime, nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)"
> -		umount mnt_point
> +		tst_mount mnt_point
>  		return
>  	fi
>  
> @@ -122,15 +116,11 @@ ext4_test_nsec_timestamps()
>  			than the current time we got.(sec_atime: $sec_atime, \
>  			sec_mtime: $sec_mtime, sec_ctime: $sec_ctime, \
>  			cur_time[s]: $sec)"
> -		umount mnt_point
> +		tst_umount mnt_point
>  		return
>  	fi
>  
> -	umount mnt_point
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "failed to umount ext4 filesystem"
> -		return
> -	fi
> +	tst_umount mnt_point
>  
>  	# Test mount to ext3 and then mount back to ext4
>  	mount -t ext3 $EXT4_DEV mnt_point
> @@ -138,7 +128,7 @@ ext4_test_nsec_timestamps()
>  		tst_resm TFAIL "failed to mount to ext3"
>  		return
>  	fi
> -	umount mnt_point
> +	tst_umount mnt_point
>  
>  	mount -t ext4 $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -148,7 +138,7 @@ ext4_test_nsec_timestamps()
>  
>  	nsec_atime2=`ext4_file_time mnt_point/tmp_file atime nsec`
>  	nsec_mtime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
> -	nsec_ctime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
> +	nsec_ctime2=`ext4_file_time mnt_point/tmp_file ctime nsec`

It would be cleaner if this change went as a separate patch.


>  	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
>  	     $nsec_mtime -ne $nsec_mtime2 ]; then
> @@ -156,11 +146,11 @@ ext4_test_nsec_timestamps()
>  			unexpected. Before[atime mtime ctime]: $nsec_atime \
>  			$nsec_mtime $nsec_ctime, After[atime mtime ctime]: \
>  			$nsec_atime2 $nsec_mtime2 $nsec_ctime2)"
> -		umount mnt_point
> +		tst_umount mnt_point
>  		return
>  	fi
>  
> -	umount mnt_point
> +	tst_umount mnt_point
>  	tst_resm TPASS "Ext4 nanosecond timestamps test with 256 inode size pass"
>  }

And we should also put the typos and formatting changes into a separate
patch as well.

> diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> index a9eb54e8d..1514da5a2 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> @@ -45,6 +45,9 @@ ext4_setup()
>  		tst_brkm TCONF "tests need a big block device(5G-10G)"
>  	else
>  		export EXT4_DEV=$LTP_BIG_DEV
> +		if mount | cut -d' ' -f1 | grep -q ^$EXT4_DEV$ ; then
> +			tst_brkm TBROK "$EXT4_DEV should be umounted before test"
> +		fi
>  	fi

And this should probably go as a separate patch as well.


The changes looks good but can you please split the changes into logical
groups and resend as a patchset?

-- 
Cyril Hrubis
chrubis@suse.cz
