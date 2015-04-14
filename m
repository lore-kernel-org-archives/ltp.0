Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1YhxqV-0003kZ-8C
	for ltp-list@lists.sourceforge.net; Tue, 14 Apr 2015 10:13:31 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YhxqS-0004bZ-Ds
	for ltp-list@lists.sourceforge.net; Tue, 14 Apr 2015 10:13:31 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t3EADLsH001666
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Apr 2015 06:13:21 -0400
Date: Tue, 14 Apr 2015 06:13:21 -0400 (EDT)
From: Li Wang <liwang@redhat.com>
Message-ID: <107371458.10728144.1429006401201.JavaMail.zimbra@redhat.com>
In-Reply-To: <1426158755-20918-1-git-send-email-liwang@redhat.com>
References: <1426158755-20918-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3] fs/acls: fix some permission issue in the
 testcase
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
To: ltp-list@lists.sourceforge.net

Hi, 

Ping~

-- 
Regards, 
Li Wang 
Email: liwang@redhat.com 


----- Original Message -----
> * Use 'test.sh'.
> 
> * Do some cleanup.
> 
> * Remove useless changes.
> 
> * Check the getenforce/setenforce command exist or not.
> 
> * Waive the consideration of SElinux Disabled or Permitive situation.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/fs/acls/acl_test01 | 69
>  +++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/testcases/kernel/fs/acls/acl_test01
> b/testcases/kernel/fs/acls/acl_test01
> index af65213..fb08ce3 100755
> --- a/testcases/kernel/fs/acls/acl_test01
> +++ b/testcases/kernel/fs/acls/acl_test01
> @@ -41,6 +41,8 @@ export TCID=acltest01
>  export TST_TOTAL=5
>  export TST_COUNT=1
>  
> +. test.sh
> +
>  TMP=${TMP:=/tmp}
>  
>  TEST_USER1="acltest1"
> @@ -52,18 +54,33 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file"
>  FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
>  TCbin=`pwd`
>  
> +COMMAND=$(command -v "getenforce" "setenforce" |wc -l)
> +if [ $COMMAND -eq 2 ]; then
> +	SELINUX=$(getenforce)
> +else
> +	SELINUX=""
> +fi
> +
>  #-----------------------------------------------------------------------
>  # FUNCTION:  do_setup
>  #-----------------------------------------------------------------------
>  
>  do_setup(){
>  
> +	tst_require_root
> +
>  	rm -f $FILE_ACL
>  	rm -f $FILE_ACL_LINK
>  
> +	# We couldn't consider whether the SElinux is Disable or Permissive.
> +	# We only set it to Permissive when it it Enforcing.
> +	if [ "$SELINUX" = "Enforcing" ]; then
> +		echo "set the SElinux to Permissive."
> +		setenforce 0
> +	fi
> +
>  	if [ "x$TEST_USER1_HOMEDIR" = "x" ]; then
> -		echo "Could not find user $TEST_USER1's home directory."
> -		exit 1
> +		tst_brkm TBROK "Could not find user $TEST_USER1's home directory."
>  	fi
>  
>  	# XXX (garrcoop): why is cleanup junk being done in setup??? Bad test!!!
> @@ -73,8 +90,7 @@ do_setup(){
>  	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s
>  	/bin/sh
>  
>  	if [ $? -ne 0 ]; then
> -		echo "Could not add test user $TEST_USER1."
> -		exit 1
> +		tst_brkm TBROK "Could not add test user $TEST_USER1."
>  	fi
>  
>  }
> @@ -91,6 +107,12 @@ do_cleanup() {
>  	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
>  	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
>  	rm -rf $TMP/tacl
> +
> +	# We set it back to Enforcing.
> +	if [ "$SELINUX" = "Enforcing" ]; then
> +		echo "set the SElinux back to Enforcing."
> +		setenforce 1
> +	fi
>  }
>  
>  #-----------------------------------------------------------------------
> @@ -102,14 +124,10 @@ if [ "z$iam" = "z$TEST_USER1" ]
>  then
>  	echo ""
>  else
> -	if [ $(id -ru) != 0 ]; then
> -		tst_resm TCONF "must be root to execute this script"
> -		exit 0
> -	fi
> +	tst_require_root
>  
>  	if ! ( test -d $TMP/tacl || mkdir -m 777 $TMP/tacl) ; then
> -		tst_resm TCONF "failed to create $TMP/tacl directory."
> -		exit 1
> +		tst_brkm TBROK "Failed to create $TMP/tacl directory."
>  	fi
>  
>  	trap do_cleanup EXIT
> @@ -119,21 +137,18 @@ else
>  
>  	dd if=/dev/zero of=$TMP/tacl/blkext3 bs=1k count=10240 && chmod 777
>  	$TMP/tacl/blkext3
>  	if [ $? -ne 0 ] ; then
> -		tst_resm TCONF "Failed to create $TMP/tacl/blkext3"
> -		exit 0
> +		tst_brkm TBROK "Failed to create $TMP/tacl/blkext3"
>  	fi
>  
>  	# Avoid hardcoded loopback device values (-f tries to find the first
>  	# available loopback device name)!
>  	if ! LOOP_DEV=$(losetup -f) || [ "x$LOOP_DEV" = x ]; then
> -		tst_resm TCONF "[ losetup.1 ] Failed to find an available loopback device
> -- is the required support compiled in your kernel?"
> -		exit 0
> +		tst_brkm TCONF "[ losetup.1 ] Failed to find an available loopback device
> -- is the required support compiled in your kernel?"
>  	fi
>  
>  	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
>  		echo ""
> -		tst_resm TCONF "[ losetup.2 ] Failed to setup the device."
> -		exit 0
> +		tst_brkm TCONF "[ losetup.2 ] Failed to setup the device."
>  	fi
>  
>  	mount | grep ext2
> @@ -180,20 +195,18 @@ then
>  	${TCbin}/acl_file_test $FILE_ACL
>  	if [ $? -ne 0 ]
>  	then
> -		EXIT_CODE=1
> -		echo "Extended acls for files (FAILED)"
> +		tst_resm TFAIL "Extended acls for files."
>  	else
> -		echo "Extended acls for files (PASSED)"
> +		tst_resm TPASS "Extended acls for files."
>  	fi
>  
>  	echo "Trying extended acls for file links"
>  	${TCbin}/acl_link_test $FILE_ACL_LINK
>  	if [ $? -ne 0 ]
>  	then
> -		EXIT_CODE=1
> -		echo "Extended acls for links (FAILED)"
> +		tst_resm TFAIL "Extended acls for links."
>  	else
> -		echo "Extended acls for links (PASSED)"
> +		tst_resm TPASS "Extended acls for links."
>  	fi
>  else
>  	do_setup
> @@ -211,20 +224,18 @@ else
>  	${TCbin}/acl_file_test $FILE_ACL
>  	if [ $? -ne 0 ]
>  	then
> -		EXIT_CODE=1
> -		echo "Extended acls for files (FAILED)"
> +		tst_resm TFAIL "Extended acls for files."
>  	else
> -		echo "Extended acls for files (PASSED)"
> +		tst_resm TPASS "Extended acls for files."
>  	fi
>  
>  	echo "Trying extended acls for file links"
>  	${TCbin}/acl_link_test $FILE_ACL_LINK
>  	if [ $? -ne 0 ]
>  	then
> -		EXIT_CODE=1
> -		echo "Extended acls for links (FAILED)"
> +		tst_resm TFAIL "Extended acls for links."
>  	else
> -		echo "Extended acls for links (PASSED)"
> +		tst_resm TPASS "Extended acls for links."
>  	fi
>  
>  	chown $TEST_USER1 $FILE_ACL
> @@ -235,4 +246,4 @@ else
>  	do_cleanup
>  fi
>  
> -exit $EXIT_CODE
> +tst_exit
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website,
> sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for
> all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
