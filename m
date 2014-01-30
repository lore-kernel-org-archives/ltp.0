Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W8toh-0003dZ-Pu
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 15:46:11 +0000
Date: Thu, 30 Jan 2014 16:45:36 +0100
From: chrubis@suse.cz
Message-ID: <20140130154536.GA21467@rei>
References: <52A999D4.2040108@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A999D4.2040108@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] fs/ext4-new-features: add
 ext4-new-features tests to default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Remove run_ext4_test.sh which calls all feature tests directly.
> Now we treat every feature as a signle test in fs_ext4 runtest file,
> keep one entry per test.
> Like that:
> 	ext4-nsec-timestamps    ext4_nsec_timestamps_test.sh -D $LTP_BIG_DEV
> 	ext4-uninit-groups      ext4_uninit_groups_test.sh -D $LTP_BIG_DEV
> 
> Configure script has been removed and ffsb has been moved to utils directory.
> 
> If want to run these tests, user should specify a big block device
> when run runltp, which will be parsed in ext4_setup() defined in ext4_funcs.sh.
> 
> Currently enable ext4-nsec-timestamps, ext4-persist-prealloc,
> ext4-subdir-limit, ext4-uninit-groups test.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/fs_ext4                                    |   5 +-
>  scenario_groups/default                            |   1 +
>  .../ext4-delalloc-mballoc/ext4-alloc-test.sh       |   5 +-
>  .../ext4-inode-version/ext4_inode_version_test.sh  |   5 +-
>  .../ext4-journal-checksum/ext4_journal_checksum.sh |   5 +-
>  .../ext4_nsec_timestamps_test.sh                   |   4 +-
>  .../ext4-online-defrag/ext4_online_defrag_test.sh  |   5 +-
>  .../ext4_persist_prealloc_test.sh                  |   5 +-
>  .../ext4-subdir-limit/ext4_subdir_limit_test.sh    |   4 +-
>  .../ext4-uninit-groups/ext4_uninit_groups_test.sh  |   4 +-
>  .../kernel/fs/ext4-new-features/ext4_funcs.sh      |  60 +++++--
>  .../kernel/fs/ext4-new-features/run_ext4_test.sh   | 179 ---------------------
>  12 files changed, 59 insertions(+), 223 deletions(-)
>  delete mode 100755 testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
> 
> diff --git a/runtest/fs_ext4 b/runtest/fs_ext4
> index c65ebab..2206b39 100644
> --- a/runtest/fs_ext4
> +++ b/runtest/fs_ext4
> @@ -1 +1,4 @@
> -ext4_new_feature_test	run_ext4_test.sh
> +ext4-nsec-timestamps	ext4_nsec_timestamps_test.sh -D $LTP_BIG_DEV
> +ext4-uninit-groups	ext4_uninit_groups_test.sh -D $LTP_BIG_DEV
> +ext4-persist-prealloc	ext4_persist_prealloc_test.sh -D $LTP_BIG_DEV
> +ext4-subdir-limit	ext4_subdir_limit_test.sh -D $LTP_BIG_DEV
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 9eca8ad..893909c 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -25,3 +25,4 @@ hugetlb
>  commands
>  hyperthreading
>  kernel_misc
> +fs_ext4
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> index dfa34c4..e40a1d1 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> @@ -28,11 +28,8 @@ export TCID="ext4-delalloc-mballoc"
>  export TST_TOTAL=17
>  export TST_COUNT=1
>  
> -# $1: the test config
> -
>  export TEST_DIR=$PWD
>  
> -read_config $1
>  
>  # Case 17: mount ext4 partition to ext3
>  ext4_test_remount()
> @@ -124,7 +121,7 @@ ext4_test_delalloc_mballoc()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  DELALLOC=( "delalloc" "nodelalloc" )
>  DIRECT_IO=( 0 1 )
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> index 998c3e4..f558571 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> @@ -33,9 +33,6 @@ export TST_COUNT=1
>  
>  export TEST_DIR=$PWD
>  
> -# $1: the test config
> -read_config $1
> -
>  # Test that inode version is not 32 bits with 128 inode size
>  ext4_test_128_inode_version()
>  {
> @@ -145,7 +142,7 @@ test_inode_version()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  RET=0
>  
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> index 1fd9bba..6a011b6 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> @@ -31,11 +31,8 @@ export TCID="ext4-journal-checksum"
>  export TST_TOTAL=36
>  export TST_COUNT=1
>  
> -# $1: the test config
> -
>  export TEST_DIR=$PWD
>  
> -read_config $1
>  
>  # Use ffsb to test journal checksumming
>  # $1: journal mode: writeback, ordered, journal
> @@ -100,7 +97,7 @@ ext4_test_journal_checksum()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  DATA=( "writeback" "ordered" "journal" )
>  COMMIT=( 1 100 )
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> index c91c1af..710bc00 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> @@ -31,8 +31,6 @@ export TCID="ext4-nsec-timestamps"
>  export TST_TOTAL=2
>  export TST_COUNT=1
>  
> -# $1: the test config
> -read_config $1
>  
>  TEST_DIR=$PWD
>  
> @@ -173,7 +171,7 @@ ext4_test_nsec_timestamps()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  RET=0
>  
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
> index 2aa3e5b..9845404 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
> @@ -30,9 +30,6 @@ export TST_COUNT=1
>  
>  export TEST_DIR=$PWD
>  
> -# $1: the test config
> -read_config $1
> -
>  # How to age filesystem
>  EMPTY=1
>  SMALL=2
> @@ -173,7 +170,7 @@ ext4_test_online_defrag()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  rm -f $LTPROOT/output/ext4_online_defrag_result.txt
>  
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> index e41b104..a83a84f 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
> @@ -33,9 +33,6 @@ export TST_COUNT=1
>  
>  export TEST_DIR=$PWD
>  
> -# $1: the test config
> -read_config $1
> -
>  # The test path of fallocate
>  export TMPDIR=$PWD/mnt_point/
>  
> @@ -91,7 +88,7 @@ ext4_test_persist_prealloc()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  RET=0
>  
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> index fdb6a08..e6ff372 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> @@ -31,8 +31,6 @@ export TCID="ext4-subdir-limit"
>  export TST_TOTAL=10
>  export TST_COUNT=1
>  
> -# $1: the test config
> -read_config $1
>  
>  TEST_DIR=$PWD
>  SHORT_DIR=1
> @@ -138,7 +136,7 @@ ext4_run_case()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  DIR_LEN=( $SHORT_DIR $LONG_DIR )
>  PARENT_DIR=( "mnt_point" "mnt_point/sub" )
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
> index e6d49e1..2f4911c 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
> @@ -29,8 +29,6 @@ export TST_TOTAL=24
>  export TST_COUNT=1
>  
>  export TEST_DIR=$PWD
> -# $1: the test config
> -read_config $1
>  
>  # How to age filesystem
>  EMPTY=1
> @@ -128,7 +126,7 @@ ext4_test_uninit_groups()
>  }
>  
>  # main
> -ext4_setup
> +ext4_setup "$@"
>  
>  ORLOV=( "orlov" "oldalloc" )
>  DELALLOC=( "delalloc" "nodelalloc" )
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> index b469bab..ddc67a2 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> @@ -25,23 +25,55 @@
>  
>  ext4_setup()
>  {
> +	tst_kvercmp 2 6 31
> +	if [ $? -eq 0 ]; then
> +		tst_brkm TCONF ignored "kernel is below 2.6.31"
> +		exit 0
> +	fi
> +
> +	if [ "$USER" != root ]; then
> +		tst_brkm TCONF ignored "Test must be run as root"
> +		exit 0
> +	fi

This should be:

if [ $(id -u) != 0 ]; then

or even better we can create a shell function tst_require_root and put
it some common shell library. There is allready testcases/lib/cmdlib.sh
but it's used only in small part of the tescases.

> +	EXT4_SUPPORT1=`grep -w ext4 /proc/filesystems | cut -f2`
> +	EXT4_SUPPORT2=`grep -w ext4 /proc/modules | cut -f1`
> +	if [ "$EXT4_SUPPORT1" != "ext4" ] && [ "$EXT4_SUPPORT2" != "ext4" ];then
> +		tst_brkm TCONF ignored "Ext4 is not supported"
> +		exit 0
> +	fi
> +
> +	if [ ! -f "ffsb" ]; then
> +		tst_brkm TCONF ignored "ffsb does not exist. Please " \
> +			"check whether ffsb was configed and compiled"
> +		exit 0
> +	fi

This should rather check that ffsb is in $PATH. There is exists()
function in the cmdlib.sh allready, what about using it?

> +	while getopts D:T: arg
> +	do
> +		case $arg in
> +		D)
> +			export EXT4_DEV=$OPTARG
> +			;;
> +		T)
> +			export FILE_SYSTEM_TYPE=$OPTARG
> +			;;
> +		\?)
> +			echo "not supproted option"
> +			;;
> +		esac
> +	done
> +
> +	# "d" indicates a invalid block device(read runltp)
> +	if [ "$EXT4_DEV" = "d" ];then
> +		tst_brkm TCONF ignored "tests need a big block device(5G-10G)"
> +		exit 0
> +	fi
> +
>  	mkdir mnt_point
>  }

Hmm, I would rather see a test for LTP_BIG_DEV being empty. There is no
need to pass the device via parameters once we have exported it as shell
variable. So we can set it empty in the runltp (if not passed by user)
and use it as:

if [ -z "$LTP_BIG_DEV" ]; then
...

>  ext4_cleanup()
>  {
> -	rmdir mnt_point
> -}
> -
> -# $1: the config file
> -read_config()
> -{
> -	while read config
> -	do
> -		echo $config | grep -q -E ".*=.*"
> -		if [ $? -eq 0 ]; then
> -			export $config
> -		fi
> -	done < $1
> +	rm -rf mnt_point
>  }

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
