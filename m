Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2GLM-0004M7-IV
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 10:01:16 +0000
Date: Tue, 9 Jun 2015 12:00:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609100005.GB24041@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 1/5] acl_test01: Fixes
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> -
> -	tst_require_root

Why do we remove this? The test calls adduser and we need root for that
or don't we?

>  	rm -f $FILE_ACL
>  	rm -f $FILE_ACL_LINK
>  
> @@ -87,12 +81,12 @@ do_setup(){
>  	rm -rf $TEST_USER1_HOMEDIR
>  	userdel $TEST_USER1 > /dev/null 2>&1
>  	sleep 1
> -	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
> +	useradd -d $(readlink -f $TEST_USER1_HOMEDIR) -m \
> +	    -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
>  
>  	if [ $? -ne 0 ]; then
>  		tst_brkm TBROK "Could not add test user $TEST_USER1."
>  	fi
> -
>  }
>  
>  #-----------------------------------------------------------------------
> @@ -100,13 +94,13 @@ do_setup(){
>  #-----------------------------------------------------------------------
>  
>  do_cleanup() {
> -	rm -rf $TEST_USER1_HOMEDIR
>  	userdel $TEST_USER1 > /dev/null 2>&1
> -	rm -f $FILE_ACL > /dev/null 2>&1
> -	rm -f $FILE_ACL_LINK > /dev/null 2>&1
> -	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
> +
> +	MOUNT_POINT=$(readlink -f "mount-ext3")
> +	mount | grep $MOUNT_POINT && umount -d $MOUNT_POINT
>  	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
> -	rm -rf $TMP/tacl
> +
> +	tst_rmdir
>  
>  	# We set it back to Enforcing.
>  	if [ "$SELINUX" = "Enforcing" ]; then
> @@ -126,18 +120,15 @@ then
>  else
>  	tst_require_root
>  
> -	if ! ( test -d $TMP/tacl || mkdir -m 777 $TMP/tacl) ; then
> -		tst_brkm TBROK "Failed to create $TMP/tacl directory."
> -	fi
> -
> -	trap do_cleanup EXIT
> +	tst_tmpdir
> +	TST_CLEANUP=do_cleanup
>  
>  	#	The  following  commands  can  be  used as an example of using
>  	#	a loopback device.
>  
> -	dd if=/dev/zero of=$TMP/tacl/blkext3 bs=1k count=10240 && chmod 777 $TMP/tacl/blkext3
> +	dd if=/dev/zero of=blkext3 bs=1k count=10240 && chmod 777 blkext3
>  	if [ $? -ne 0 ] ; then
> -		tst_brkm TBROK "Failed to create $TMP/tacl/blkext3"
> +		tst_brkm TBROK "Failed to create blkext3"
>  	fi
>  
>  	# Avoid hardcoded loopback device values (-f tries to find the first
> @@ -146,7 +137,7 @@ else
>  		tst_brkm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
>  	fi
>  
> -	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
> +	if ! losetup $LOOP_DEV blkext3 2>&1 > /dev/null; then
>  		echo ""
>  		tst_brkm TCONF "[ losetup.2 ] Failed to setup the device."
>  	fi

There is an in flight patch to add tst_acquire_device into test.sh as
well.

See patch by Zeng Linggang:

[PATCH v4 1/2] test.sh: Add tst_acquire_device() and tst_release_device()

The v4 is likely to be commited as it is, can you pretty please make use
of it here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
