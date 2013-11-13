Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vgctn-0003I2-20
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 16:02:35 +0000
Date: Wed, 13 Nov 2013 17:02:21 +0100
From: chrubis@suse.cz
Message-ID: <20131113160220.GA28712@rei>
References: <5283773E.5080505@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5283773E.5080505@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] fs/ext4-new-features: add ext4-new-features tests
 to the default
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
> Here treat every feature as a signle test program.
> 
> Makefile: add configure for ffsb
> 
> runtest/fs_ext4: 5 new features test currently enabled
> 
> run_ext4_test.sh: According to the input parameter to decide which
> feature test to be called.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/fs_ext4                                    |   6 +-
>  testcases/kernel/fs/Makefile                       |   2 +-
>  testcases/kernel/fs/ext4-new-features/Makefile     |   1 +
>  .../kernel/fs/ext4-new-features/run_ext4_test.sh   | 115 ++++++---------------
>  4 files changed, 37 insertions(+), 87 deletions(-)
> 
> diff --git a/runtest/fs_ext4 b/runtest/fs_ext4
> index c65ebab..84b6486 100644
> --- a/runtest/fs_ext4
> +++ b/runtest/fs_ext4
> @@ -1 +1,5 @@
> -ext4_new_feature_test	run_ext4_test.sh
> +ext4-inode-version	run_ext4_test.sh ext4_inode_version_test
> +ext4-nsec-timestamps	run_ext4_test.sh ext4_nsec_timestamps_test
> +ext4-persist-prealloc	run_ext4_test.sh ext4_persist_prealloc_test
> +ext4-subdir-limit	run_ext4_test.sh ext4_subdir_limit_test
> +ext4-uninit-groups	run_ext4_test.sh ext4_uninit_groups_test
> diff --git a/testcases/kernel/fs/Makefile b/testcases/kernel/fs/Makefile
> index afad6f9..81310f5 100644
> --- a/testcases/kernel/fs/Makefile
> +++ b/testcases/kernel/fs/Makefile
> @@ -27,6 +27,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  # XXX (garrcoop): Need to add autoconf checks for JFS.
>  # ext4-new-features: This test need to be configured be user.
>  # Please read $LTPROOT/README to see the detail information
> -FILTER_OUT_DIRS		:= dmapi ext4-new-features
> +FILTER_OUT_DIRS		:= dmapi
>  
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/fs/ext4-new-features/Makefile b/testcases/kernel/fs/ext4-new-features/Makefile
> index 208b8a6..1ad1c3c 100644
> --- a/testcases/kernel/fs/ext4-new-features/Makefile
> +++ b/testcases/kernel/fs/ext4-new-features/Makefile
> @@ -32,6 +32,7 @@ FILTER_OUT_DIRS		:= $(FFSBDIR)
>  FFSB			:= $(FFSBDIR)/ffsb
>  
>  $(FFSB): $(FFSBDIR)
> +	cd $^; ./configure
>  	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
>  	cp $(FFSBDIR)/ffsb ffsb

The way how ffsb is bundled in LTP is simply wrong, it shouldn't be in
the source tree at all. What I would like to see is to:

1. modify testcases that depends on it to return TCONF with
   message that explains that ffsb must be installed to run
   the testcases if ffsb is not found in PATH

   or alternatively use something different to create the
   I/O load

2. remove ffsb from the LTP git tree

> diff --git a/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh b/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
> index bfbd844..4ede8f7 100755
> --- a/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
> @@ -38,11 +38,15 @@
>  ################################################################################
>  
>  source ext4_funcs.sh;
> +test_features=$1
>  
>  export TCID="ext4_new_feature"
>  export TST_TOTAL=1
>  export TST_COUNT=1
>  
> +script_name="$test_features"".sh"
> +BLOCK_COUNT=3072
> +
>  tst_kvercmp 2 6 31
>  if [ $? -eq 0 ]; then
>  	tst_brkm TCONF ignored "kernel is below 2.6.31"
> @@ -71,6 +75,22 @@ if [ ! -f "ext4-test-config" ]; then
>  	exit 0
>  fi
>  
> +# create an ext4 partition
> +dd if=/dev/zero of=fs_ext4_new_features_$$.img bs=1M count=$BLOCK_COUNT
> +
> +if [ $? -ne 0 ];then
> +	tst_brkm TCONF ignored "failed to create an ext4 image file"
> +	exit 0
> +fi
> +
> +EXT4_DEV=$(losetup --show -f fs_ext4_new_features_$$.img)
> +if [ $? -ne 0 ];then
> +	tst_brkm TCONF ignored "set loop device failed"
> +	exit 0
> +fi
> +
> +echo "EXT4_DEV=$EXT4_DEV" > ./ext4-test-config
> +

We should use DEVICE passed to the runltp script instead, that way we
don't even need this helper (if there is some common code move it to
ex4_funcs.sh and use it from the tests) and call the test scripts
from runtest file directly.

And also remove the configure that asks user about which device to use.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
