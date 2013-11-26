Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlN49-0001uf-0G
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 18:08:53 +0000
Date: Tue, 26 Nov 2013 19:08:23 +0100
From: chrubis@suse.cz
Message-ID: <20131126180823.GA14714@rei.suse.cz>
References: <528A07E4.7060608@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528A07E4.7060608@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] testscripts/test_robind.sh: add fs_readonly to
 default
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
> cleanup of testscripts/test_robind.sh

Can you send the cleanup as a separate patch?

> testscripts/fs_ro_tests: delete some unecessary tests

Why are these tests unnecessary?

> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  scenario_groups/default    |   1 +
>  testscripts/fs_ro_tests    |  19 ----
>  testscripts/test_robind.sh | 272 ++++++++++++++++++++++-----------------------
>  3 files changed, 134 insertions(+), 158 deletions(-)
> 
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 9eca8ad..520db8b 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -25,3 +25,4 @@ hugetlb
>  commands
>  hyperthreading
>  kernel_misc
> +fs_readonly

I generally don't like adding tests that are executed as a signle script
because it's hard to tell what went wrong when some of the tests has
failed. It would be better to split them into separate testcases.

> diff --git a/testscripts/fs_ro_tests b/testscripts/fs_ro_tests
> index ec4a86c..2ecd9c5 100644
> --- a/testscripts/fs_ro_tests
> +++ b/testscripts/fs_ro_tests
> @@ -35,22 +35,3 @@ rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10
>  rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:rwtest01%f
>  rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
>  fs_inod . 10 10 1
> -linktest.pl
> -openfile -f10 -t10
> -inode01
> -inode02
> -stream01
> -stream02
> -stream03
> -stream04
> -stream05
> -ftest01
> -ftest02
> -ftest03
> -ftest04
> -ftest05
> -ftest06
> -ftest07
> -ftest08
> -lftest 80
> -writetest
> diff --git a/testscripts/test_robind.sh b/testscripts/test_robind.sh
> index 4c01f4e..231419a 100755
> --- a/testscripts/test_robind.sh
> +++ b/testscripts/test_robind.sh
> @@ -45,23 +45,20 @@
>  $trace_logic
>  
>  # The test case ID, the test case count and the total number of test case
> -TCID=${TCID:-test_robind.sh}
> -TST_TOTAL=1
> -TST_COUNT=1
> -export TCID
> -export TST_COUNT
> -export TST_TOTAL
> +export TCID=${TCID:-test_robind.sh}
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
>  usage()
>  {
> -  cat << EOF
> -  usage: $0 [ext3,ext2,jfs,xfs,reiserfs,ramfs]
> +	cat << EOF
> +usage: $0 [ext3,ext2,jfs,xfs,reiserfs,ramfs]
>  
> -  This script verifies ReadOnly-filesystem, by mounting imagefile and
> -  executing the filesystem tests.
> +	This script verifies ReadOnly-filesystem, by mounting imagefile and
> +executing the filesystem tests.
>  
> -  OPTIONS
> -    -h    display this message and exit
> +OPTIONS
> +	-h    display this message and exit
>  EOF
>  }
>  
> @@ -81,18 +78,15 @@ trap cleanup INT
>  #==============================================================================
>  function cleanup
>  {
> -    umount ${TMPDIR}/dir3-ro 2> /dev/null > /dev/null
> -    umount ${TMPDIR}/dir2-bound 2> /dev/null 1> /dev/null
> -    umount ${TMPDIR}/dir1 2> /dev/null 1> /dev/null
> -    if [ ! -z $1 ]; then {
> -        rm -rf $1 || true
> -    }
> -    fi
> +	umount ${TMPDIR}/dir3-ro 2> /dev/null > /dev/null
> +	umount ${TMPDIR}/dir2-bound 2> /dev/null 1> /dev/null
> +	umount ${TMPDIR}/dir1 2> /dev/null 1> /dev/null
> +	if [ ! -z $1 ]; then
> +		rm -rf $1 || true
> +	fi
>  }
>  
> -#===============================================================================
> -# FUNCTION NAME:    setup
> -#
> +#=============================================================================== # FUNCTION NAME:    setup #

This newly added line looks like a mistake.

Also these comments are mostly useless and only make the test source
longer.

>  # FUNCTION DESCRIPTION: Does the initailization
>  #
>  # PARAMETERS:   File_systems (if any )
> @@ -101,33 +95,33 @@ function cleanup
>  #===============================================================================
>  function setup
>  {
> -    mkdir ${TMPDIR}
> -    FAILLOG="$TMPDIR/errs.log"
> -    PASSLOG="$TMPDIR/pass.log"
> +	mkdir ${TMPDIR}
> +	FAILLOG="$TMPDIR/errs.log"
> +	PASSLOG="$TMPDIR/pass.log"
>  
> -    for i in $DIRS; do
> -        rm -rf ${TMPDIR}/$i || true
> -        mkdir -p ${TMPDIR}/$i
> -    done;
> +	for i in $DIRS; do
> +		rm -rf ${TMPDIR}/$i || true
> +		mkdir -p ${TMPDIR}/$i
> +	done;
>  
> -    # Populating the default FS as ext3, if FS is not given
> -    if [ -z "$*" ]; then
> -        FSTYPES="ext3"
> -    else
> -        FSTYPES="$*"
> -    fi
> +	# Populating the default FS as ext3, if FS is not given
> +	if [ -z "$*" ]; then
> +		FSTYPES="ext3"
> +	else
> +		FSTYPES="$*"
> +	fi
>  
> -    # set the LTPROOT directory
> -    cd `dirname $0`
> -    echo "${PWD}" | grep testscripts > /dev/null 2>&1
> -    if [ $? -eq 0 ]; then
> -        cd ..
> -        export LTPROOT="${PWD}"
> -        export PATH="${PATH}:${LTPROOT}/testcases/bin"
> -    fi
> +	# set the LTPROOT directory
> +	cd `dirname $0`
> +	echo "${PWD}" | grep testscripts > /dev/null 2>&1
> +	if [ $? -eq 0 ]; then
> +		cd ..
> +		export LTPROOT="${PWD}"
> +		export PATH="${PATH}:${LTPROOT}/testcases/bin"
> +	fi
>  
> -    FS_Tests="${LTPROOT}/testscripts/fs_ro_tests"
> -    cd ${TMPDIR}
> +	FS_Tests="${LTPROOT}/testscripts/fs_ro_tests"
> +	cd ${TMPDIR}
>  }
>  

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
