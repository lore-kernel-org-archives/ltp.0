From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat, 26 Nov 2016 09:09:51 +0100
Subject: [LTP] [PATCH v2 1/4] shell: fix bashisms: s/&>/>$1 2>&1/
In-Reply-To: <20161125210125.7299-1-petr.vorel@gmail.com>
References: <20161125210125.7299-1-petr.vorel@gmail.com>
Message-ID: <20161126080950.ocbc5r5rtqz7f62s@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  ltpmenu                                                        |  2 +-
>  runltplite.sh                                                  |  2 +-
>  testcases/commands/cron/cron_neg_tests.sh                      |  4 ++--
>  testcases/commands/cron/cron_pos_tests.sh                      |  6 +++---
>  .../ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh | 10 +++++-----
>  .../ext4-inode-version/ext4_inode_version_test.sh              |  6 +++---
>  .../ext4-journal-checksum/ext4_journal_checksum.sh             |  6 +++---
>  .../ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh          |  6 +++---
>  .../ext4-persist-prealloc/ext4_persist_prealloc_test.sh        |  4 ++--
>  .../ext4-subdir-limit/ext4_subdir_limit_test.sh                |  6 +++---
>  .../ext4-uninit-groups/ext4_uninit_groups_test.sh              |  8 ++++----
>  testcases/kernel/fs/iso9660/isofs.sh                           |  2 +-
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh      |  4 ++--
>  testcases/kernel/numa/numa01.sh                                |  4 ++--
>  testcases/kernel/security/mmc_security/ask_password.sh         |  4 ++--
>  testcases/kernel/security/mmc_security/assign_password.sh      |  4 ++--
>  testcases/lib/daemonlib.sh                                     |  8 ++++----
>  testcases/open_posix_testsuite/stress/threads/helper.c         |  2 +-
>  18 files changed, 44 insertions(+), 44 deletions(-)

> diff --git a/ltpmenu b/ltpmenu
> index 6a2338b..38d38c0 100755
> --- a/ltpmenu
> +++ b/ltpmenu
> @@ -112,7 +112,7 @@ compile_ltp()
>          0) \
>              for cmd in cc make lex ;
>              do \
> -                which $cmd &>/tmp/runltp.err.$$ ;
> +                which $cmd >/tmp/runltp.err.$$ 2>&1 ;
>                  if [ $? -ne 0 ] ;
>                      then \
>                          display_info_msg "Compiling LTP testsuite" \
> diff --git a/runltplite.sh b/runltplite.sh
> index 00a1078..9313649 100755
> --- a/runltplite.sh
> +++ b/runltplite.sh
> @@ -295,7 +295,7 @@ main()
>      }

>      # check for required users and groups
> -    ${LTPROOT}/IDcheck.sh &>/dev/null || \
> +    ${LTPROOT}/IDcheck.sh >/dev/null 2>&1 || \
>      {
>          echo "WARNING: required users and groups not present"
>          echo "WARNING: some test cases may fail"
> diff --git a/testcases/commands/cron/cron_neg_tests.sh b/testcases/commands/cron/cron_neg_tests.sh
> index 27f2137..9c3d6f6 100755
> --- a/testcases/commands/cron/cron_neg_tests.sh
> +++ b/testcases/commands/cron/cron_neg_tests.sh
> @@ -87,7 +87,7 @@ echo setuid test
>  echo

>  tmpscript=cron_neg01_test
> -rm -rf $tmpscript.out &> /dev/null
> +rm -rf $tmpscript.out >/dev/null 2>&1


>  cat > /tmp/$tmpscript << EOF
> @@ -127,7 +127,7 @@ else
>  fi
>  echo

> -rm /tmp/$tmpscript* &> /dev/null
> +rm /tmp/$tmpscript* >/dev/null 2>&1
>  crontab -r

>  # Restore crontab
> diff --git a/testcases/commands/cron/cron_pos_tests.sh b/testcases/commands/cron/cron_pos_tests.sh
> index 2dc4ecc..ece114c 100755
> --- a/testcases/commands/cron/cron_pos_tests.sh
> +++ b/testcases/commands/cron/cron_pos_tests.sh
> @@ -22,10 +22,10 @@ if [ $iam = "root" ]; then
>  		exit 1
>  	fi

> -	mv $CRON_ALLOW $CRON_ALLOW.old &> /dev/null
> +	mv $CRON_ALLOW $CRON_ALLOW.old >/dev/null 2>&1
>  	su $1 -c "$0 $*"
>          RC=$?
> -	mv $CRON_ALLOW.old $CRON_ALLOW &> /dev/null
> +	mv $CRON_ALLOW.old $CRON_ALLOW >/dev/null 2>&1
>  	exit $RC
>  fi

> @@ -53,7 +53,7 @@ fi

>  # 1. Add new job

> -rm -rf /tmp/crontest &> /dev/null
> +rm -rf /tmp/crontest >/dev/null 2>&1
>  mkdir -p /tmp/crontest

>  cat > /tmp/crontest/testjob_cron01 << EOF
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> index 16f621f..a5215bd 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> @@ -28,7 +28,7 @@ export TST_TOTAL=17
>  # Case 17: mount ext4 partition to ext3
>  ext4_test_remount()
>  {
> -	mkfs.ext3 -I 256 -b 1024 $EXT4_DEV &> /dev/null
> +	mkfs.ext3 -I 256 -b 1024 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
> @@ -60,7 +60,7 @@ ext4_test_remount()
>  	fi
>  	umount mnt_point

> -	fsck -p $EXT4_DEV &> /dev/null
> +	fsck -p $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "fsck returned failure"
>  		return
> @@ -78,13 +78,13 @@ ext4_test_delalloc_mballoc()
>  {
>  	tst_resm TINFO "isDelalloc: $1, isDirectIO: $2, Blocksize: $3, isAuto_da_alloc: $4"

> -	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV &> /dev/null
> +	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
>  	fi

> -	tune2fs -O extents $EXT4_DEV &> /dev/null
> +	tune2fs -O extents $EXT4_DEV >/dev/null 2>&1

>  	mount -t ext4 -o $1,$4 $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -105,7 +105,7 @@ ext4_test_delalloc_mballoc()
>  		return
>  	fi

> -	fsck -p $EXT4_DEV &> /dev/null
> +	fsck -p $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "fsck returned failure"
>  		return
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> index ac8f021..ef02cc0 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> @@ -33,13 +33,13 @@ ext4_test_128_inode_version()
>  {
>  	tst_resm TINFO "Test inode version is 32 bits with 128 inode size"

> -	mkfs.ext4 -I 128 $EXT4_DEV &> /dev/null
> +	mkfs.ext4 -I 128 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
>  	fi

> -	tune2fs -O extents $EXT4_DEV &> /dev/null
> +	tune2fs -O extents $EXT4_DEV >/dev/null 2>&1

>  	mount -t ext4 -o i_version $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -83,7 +83,7 @@ ext4_test_128_inode_version()
>  # $1: file operation
>  test_inode_version()
>  {
> -	mkfs.ext3 -I 256 $EXT4_DEV &> /dev/null
> +	mkfs.ext3 -I 256 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> index 87eb90b..2f357d8 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> @@ -55,13 +55,13 @@ ext4_test_journal_checksum()
>  		"journal_checksum: $checksum, " \
>  		"journal_async_commit: $async_commit, barrier: $5"

> -	mkfs.ext4 -I 256 $EXT4_DEV &> /dev/null
> +	mkfs.ext4 -I 256 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
>  	fi

> -	tune2fs -O extents $EXT4_DEV &> /dev/null
> +	tune2fs -O extents $EXT4_DEV >/dev/null 2>&1

>  	mount -t ext4 -o data=$1,commit=$2,$3,$4,barrier=$5 $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -82,7 +82,7 @@ ext4_test_journal_checksum()
>  		return
>  	fi

> -	e2fsck -p $EXT4_DEV &> /dev/null
> +	e2fsck -p $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "fsck returned failure"
>  		return
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> index ec1c6a3..c6ff7c2 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> @@ -33,13 +33,13 @@ ext4_test_sec_timestamps()
>  {
>  	tst_resm TINFO "Test timestamps with 128 inode size"

> -	mkfs.ext4 -I 128 $EXT4_DEV &> /dev/null
> +	mkfs.ext4 -I 128 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
>  	fi

> -	tune2fs -O extents $EXT4_DEV &> /dev/null
> +	tune2fs -O extents $EXT4_DEV >/dev/null 2>&1

>  	mount -t ext4 $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -74,7 +74,7 @@ ext4_test_nsec_timestamps()
>  {
>  	tst_resm TINFO "Test timestamps with 256 inode size"

> -	mkfs.ext3 -I 256 $EXT4_DEV &> /dev/null
> +	mkfs.ext3 -I 256 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> index e2b81a2..2a4b699 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> @@ -32,7 +32,7 @@ export TST_TOTAL=2
>  # $1: 1024 or 4096
>  ext4_test_persist_prealloc()
>  {
> -	mkfs.ext4 -I 256 -b $1 $EXT4_DEV &> /dev/null
> +	mkfs.ext4 -I 256 -b $1 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
> @@ -72,7 +72,7 @@ ext4_test_persist_prealloc()
>  		return
>  	fi

> -	e2fsck -p $EXT4_DEV &> /dev/null
> +	e2fsck -p $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "fsck returned failure"
>  		return
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> index 3162d67..5cc0523 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> @@ -59,14 +59,14 @@ ext4_run_case()
>  	# only mkfs if block size has been changed,
>  	# or previous case failed
>  	if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
> -		mkfs.ext4 -b $4 -I 256 $EXT4_DEV &> /dev/null
> +		mkfs.ext4 -b $4 -I 256 $EXT4_DEV >/dev/null 2>&1
>  		if [ $? -ne 0 ]; then
>  			tst_resm TFAIL "failed to create ext4 filesystem"
>  			return
>  		fi
>  		prev_block_size=$4

> -		tune2fs -O extents $EXT4_DEV &> /dev/null
> +		tune2fs -O extents $EXT4_DEV >/dev/null 2>&1
>  	fi

>  	prev_result=$FAIL
> @@ -113,7 +113,7 @@ ext4_run_case()
>  	fi

>  	# run fsck to make sure the filesystem has no errors
> -	e2fsck -p $EXT4_DEV &> /dev/null
> +	e2fsck -p $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "fsck: the filesystem has errors"
>  		return
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
> index 4db846a..1b0e00b 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
> @@ -66,7 +66,7 @@ ext4_test_uninit_groups()
>  {
>  	echo "Test $TST_COUNT" >> ext4_uninit_groups_result.txt

> -	mkfs.ext4 -I 256 -m 0 $EXT4_DEV &> /dev/null
> +	mkfs.ext4 -I 256 -m 0 $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to create ext4 filesystem"
>  		return
> @@ -78,10 +78,10 @@ ext4_test_uninit_groups()
>  		flag=$3
>  	fi

> -	tune2fs -O extents,uninit_groups,$flag $EXT4_DEV &> /dev/null
> +	tune2fs -O extents,uninit_groups,$flag $EXT4_DEV >/dev/null 2>&1

>  	# Must run fsck after setting uninit_groups
> -	fsck -p $EXT4_DEV &> /dev/null
> +	fsck -p $EXT4_DEV >/dev/null 2>&1

>  	mount -t ext4 -o $1,$2 $EXT4_DEV mnt_point
>  	if [ $? -ne 0 ]; then
> @@ -102,7 +102,7 @@ ext4_test_uninit_groups()
>  		return
>  	fi

> -	fsck -p $EXT4_DEV &> /dev/null
> +	fsck -p $EXT4_DEV >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "fsck returned failure"
>  		return
> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index 3533e76..f59bbde 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -62,7 +62,7 @@ gen_fs_tree()

>  		mkdir -p "$new_path"

> -		dd if=/dev/urandom of="$new_path/file" bs=1024 count=100 &> /dev/null
> +		dd if=/dev/urandom of="$new_path/file" bs=1024 count=100 >/dev/null 2>&1

>  		gen_fs_tree "$new_path" $((cur_depth + 1))
>  	done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index 4be2123..32a35ad 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -80,11 +80,11 @@ TST_CLEANUP=do_clean
>  until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do

>  	# Start up SAR and give it a couple cycles to run
> -	sar 1 0 &>/dev/null &
> +	sar 1 0 >/dev/null 2>&1 &
>  	sleep 2
>  	# "sar 1 0" is supported before 'sysstat-8.1.4(include sar)',
>  	# after that use "sar 1" instead of. Use 'ps -C sar' to check.
> -	if ps -C sar &>/dev/null; then
> +	if ps -C sar >/dev/null 2>&1; then
>  		pkill sar
>  		sar -P ALL 1 0 > $TMP/log_$$ &
>  	else
> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
> index 9c5f49a..0091f7c 100755
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -60,7 +60,7 @@ chk_ifexists()
>  {
>      RC=0

> -    which $2 &>$LTPTMP/tst_numa.err || RC=$?
> +    which $2 >$LTPTMP/tst_numa.err 2>&1 || RC=$?
>      if [ $RC -ne 0 ]
>      then
>          tst_brkm TBROK NULL "$1: command $2 not found."
> @@ -171,7 +171,7 @@ init()
>          LTPTMP=$TMP/tst_numa.$$
>      fi

> -    mkdir -p $LTPTMP &>/dev/null || RC=$?
> +    mkdir -p $LTPTMP >/dev/null 2>&1 || RC=$?
>      if [ $RC -ne 0 ]
>      then
>           tst_brkm TBROK NULL "INIT: Unable to create temporary directory"
> diff --git a/testcases/kernel/security/mmc_security/ask_password.sh b/testcases/kernel/security/mmc_security/ask_password.sh
> index 5136e13..e5b4357 100644
> --- a/testcases/kernel/security/mmc_security/ask_password.sh
> +++ b/testcases/kernel/security/mmc_security/ask_password.sh
> @@ -52,14 +52,14 @@ ask_password()
>  		while [ -z "$passwd" ]; do
>  			read -s -p "MMC password: " passwd; echo
>  		done
> -		if ! keyctl instantiate $1 "$passwd" $2 &>/dev/null; then
> +		if ! keyctl instantiate $1 "$passwd" $2 >/dev/null 2>&1; then
>  			echo "*** Wrong password! The card was not unlocked."
>  			exit 1
>  		fi
>  		echo "Password accepted."

>  		exit 0
> -	} &> $USER_CONSOLE < $USER_CONSOLE
> +	} >$USER_CONSOLE 2>&1 < $USER_CONSOLE
>  }

>  ask_password || exit $RC
> diff --git a/testcases/kernel/security/mmc_security/assign_password.sh b/testcases/kernel/security/mmc_security/assign_password.sh
> index 442486c..5d1eec5 100644
> --- a/testcases/kernel/security/mmc_security/assign_password.sh
> +++ b/testcases/kernel/security/mmc_security/assign_password.sh
> @@ -57,14 +57,14 @@ assign_password()
>  		echo "*** Passwords do not match."
>  		exit 1
>  	fi
> -	if ! keyctl instantiate $1 "$newpasswd" $2 &>/dev/null; then
> +	if ! keyctl instantiate $1 "$newpasswd" $2 >/dev/null 2>&1; then
>  		echo "*** Error while assigning new password"
>  		exit 1
>  	fi
>  	echo "Password assigned."

>  	exit 0
> -	} &> $USER_CONSOLE < $USER_CONSOLE
> +	} >$USER_CONSOLE 2>&1 < $USER_CONSOLE
>  }

>  assign_password || exit $RC
> diff --git a/testcases/lib/daemonlib.sh b/testcases/lib/daemonlib.sh
> index 3d67125..aa0a159 100644
> --- a/testcases/lib/daemonlib.sh
> +++ b/testcases/lib/daemonlib.sh
> @@ -48,7 +48,7 @@ start_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
>  		systemctl start $1.service > /dev/null 2>&1
> -	elif command -v service &> /dev/null; then
> +	elif command -v service >/dev/null 2>&1; then
>  		service $1 start > /dev/null 2>&1
>  	else
>  		/etc/init.d/$1 start > /dev/null 2>&1
> @@ -59,7 +59,7 @@ stop_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
>  		systemctl stop $1.service > /dev/null 2>&1
> -	elif command -v service &> /dev/null; then
> +	elif command -v service >/dev/null 2>&1; then
>  		service $1 stop > /dev/null 2>&1
>  	else
>  		/etc/init.d/$1 stop > /dev/null 2>&1
> @@ -70,7 +70,7 @@ status_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
>  		systemctl status $1.service > /dev/null 2>&1
> -	elif command -v service &> /dev/null; then
> +	elif command -v service >/dev/null 2>&1; then
>  		service $1 status > /dev/null 2>&1
>  	else
>  		/etc/init.d/$1 status > /dev/null 2>&1
> @@ -81,7 +81,7 @@ restart_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
>  		systemctl restart $1.service > /dev/null 2>&1
> -	elif command -v service &> /dev/null; then
> +	elif command -v service >/dev/null 2>&1; then
>  		service $1 restart > /dev/null 2>&1
>  	else
>  		/etc/init.d/$1 restart > /dev/null 2>&1
> diff --git a/testcases/open_posix_testsuite/stress/threads/helper.c b/testcases/open_posix_testsuite/stress/threads/helper.c
> index 9bcc4dd..d54a920 100644
> --- a/testcases/open_posix_testsuite/stress/threads/helper.c
> +++ b/testcases/open_posix_testsuite/stress/threads/helper.c
> @@ -29,7 +29,7 @@
>  #!/bin/sh

>  #monitor the system
> -vmstat -n 120 180 &> monitor.txt &
> +vmstat -n 120 180 >monitor.txt 2>&1 &

>  #run the tests
>  for TS in `ls -1 *.c`;

This is actually first version, sorry for confusion.


Kind regards,
Petr
