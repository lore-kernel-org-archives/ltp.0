From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Mar 2019 14:58:56 +0100
Subject: [LTP] [PATCH 1/4] shell: Add tst_mount() helper
In-Reply-To: <20190220162014.5467-1-pvorel@suse.cz>
References: <20190220162014.5467-1-pvorel@suse.cz>
Message-ID: <20190313135856.GA31637@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> and TST_MOUNT, TST_MOUNT_PARAMS} variables.
       ^
       This should probably named TST_MNTPOINT and TST_MNT_PARAMS


Also we seem to use $FS_TYPE inside of the library which is not
documented anywhere in the change to the documentation, I see that it
will error out when users fails to set it but I do not like it at all.

Ideally we should either introduce TST_FS_TYPE or pass the fs type as an
agrument to the tst_mount function.

> + document changes.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/test-writing-guidelines.txt | 12 ++++++++----
>  testcases/lib/tst_test.sh       | 22 +++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index f2f72c4d6..5aa7e0279 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -2006,12 +2006,16 @@ The 'tst_mkfs' helper will format device with the filesystem.
>  tst_mkfs ext2 $TST_DEVICE
>  -------------------------------------------------------------------------------
>  
> -Umounting filesystems
> -+++++++++++++++++++++
> +Mounting and unmounting filesystems
> ++++++++++++++++++++++++++++++++++++
> +
> +The 'tst_mount' and 'tst_umount' helpers are a safe way to mount/umount a filesystem.
>  
> -The 'tst_umount' helper is a safe way to umount a filesystem.
> +The 'tst_mount' mounts '$TST_DEVICE' to '$TST_MOUNT', using optional '$TST_MOUNT_PARAMS'.
> +It creates before mounting the '$TST_MOUNT' directory if not exists and fails
> +if mounting was unsuccessful.
>  
> -If the path passed to the function is not mounted (present in '/proc/mounts')
> +If the path passed to the 'tst_umount' is not mounted (present in '/proc/mounts')
>  it's noop.
>  
>  Otherwise it retries to umount the filesystem a few times on a failure, which
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 3d2f5afde..4abea6665 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -235,6 +235,25 @@ TST_RTNL_CHK()
>  	tst_brk TBROK "$@ failed: $output"
>  }
>  
> +tst_mount()
> +{
> +	if [ -z "$FS_TYPE" ]; then
> +		tst_brk TBROK "Missing FS_TYPE variable"
> +	fi
> +
> +	ROD_SILENT mkdir -p $TST_MOUNT
> +	mount -t $FS_TYPE $TST_DEVICE $TST_MOUNT $TST_MOUNT_PARAMS
> +	local ret=$?
> +
> +	if [ $ret -eq 32 ]; then
> +		tst_brk TCONF "Cannot mount $FS_TYPE, missing driver?"
> +	fi
> +
> +	if [ $ret -ne 0 ]; then
> +		tst_brk TBROK "Failed to mount device: mount exit = $ret"
> +	fi
> +}
> +
>  tst_umount()
>  {
>  	local device="$1"
> @@ -401,7 +420,7 @@ tst_run()
>  			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
>  			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
>  			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
> -			NEEDS_DRIVERS);;
> +			NEEDS_DRIVERS|MOUNT|MOUNT_PARAMS);;
>  			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
>  			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
> @@ -461,6 +480,7 @@ tst_run()
>  		cd "$TST_TMPDIR"
>  	fi
>  
> +	TST_MOUNT="${TST_MOUNT:-mntpoint}"
>  	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
>  		if [ -z ${TST_TMPDIR} ]; then
>  			tst_brk TBROK "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
