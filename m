Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wf9yl-0005ya-GO
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 15:29:55 +0000
Date: Tue, 29 Apr 2014 17:29:00 +0200
From: chrubis@suse.cz
Message-ID: <20140429152859.GD12523@rei>
References: <1395930175-3138-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395930175-3138-4-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395930175-3138-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3 3/4] testscripts/isofs.sh: removed some
 "unnecessary" steps
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
> I suppose that neither `ls -lR` nor `exportfs` has any direct
> relationship to this test. Therefore I removed them to make the test
> more silent.

Giving it a second though it may. Because if you just mount and unmout
the device the kernel code coverage is likely much smaller.

What about we list all files on the device and redirect the output to
/dev/null and check for the ls exit value?

We may even run a find that cats all files into /dev/null or similar so
we stress the filesystem code a bit.

> But destroying of a loop device is an asynchronous operation
> (see a1ecac3b0656a68259927c234e505804d33a7b83) and so on we
> need to be sure that the device is destroyed before creating a new one.
> 
> To accomplish this I changed the test to use `losetup -f` and
> `losetup -d` explicitly.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testscripts/isofs.sh |   52 +++++++++++++++++++++++++++++++------------------
>  1 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
> index 2bb2555..294d6f0 100755
> --- a/testscripts/isofs.sh
> +++ b/testscripts/isofs.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
>  #
>  # Copyright (c) International Business Machines  Corp., 2003
> +# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
>  #
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
> @@ -29,6 +30,7 @@ TST_TOTAL=77
>  . test.sh
>  
>  NO_CLEANUP=""
> +IS_MOUNTED=""
>  
>  usage()
>  {
> @@ -41,7 +43,7 @@ cleanup()
>  	if [ "$NO_CLEANUP" = "no" ]; then
>  		tst_resm TINFO "Temporary directory $PWD was not removed"
>  	else
> -		tst_rmdir
> +		[ "$IS_MOUNTED" != "yes" ] && tst_rmdir
>  	fi
>  }
>  
> @@ -98,7 +100,7 @@ for mkisofs_opt in \
>  	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
>  do
>  	rm -f isofs.iso
> -	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
> +	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
>  	if [ $? -eq 0 ]; then
>  		tst_resm TPASS \
>  			"mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
> @@ -109,33 +111,45 @@ do
>  	fi
>  
>  	for mount_opt in \
> -		"loop" \
> -		"loop,norock" \
> -		"loop,nojoliet" \
> -		"loop,block=512,unhide" \
> -		"loop,block=1024,cruft" \
> -		"loop,block=2048,nocompress" \
> -		"loop,check=strict,map=off,gid=bin,uid=bin" \
> -		"loop,check=strict,map=acorn,gid=bin,uid=bin" \
> -		"loop,check=relaxed,map=normal" \
> -		"loop,block=512,unhide,session=2"
> -		# "loop,sbsector=32"
> +		"ro" \
> +		"norock" \
> +		"nojoliet" \
> +		"block=512,unhide" \
> +		"block=1024,cruft" \
> +		"block=2048,nocompress" \
> +		"check=strict,map=off,gid=bin,uid=bin" \
> +		"check=strict,map=acorn,gid=bin,uid=bin" \
> +		"check=relaxed,map=normal" \
> +		"block=512,unhide,session=2"
> +		# "sbsector=32"
>  	do
> -		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
> +		loop_dev=$(losetup --show -f isofs.iso)
> +		if [ $? -ne 0 ]; then
> +			tst_brkm TBROK "losetup failed"
> +		fi
> +
> +		mount -t iso9660 -o $mount_opt "$loop_dev" $MNT_POINT
>  		if [ $? -ne 0 ]; then
>  			tst_resm TFAIL \
> -				"mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT"
> +				"mount -t iso9660 -o $mount_opt "$loop_dev" $MNT_POINT"
>  			continue
>  		fi
> -
> -		ls -lR $MNT_POINT
> -		exportfs -i -o no_root_squash,rw *:$MNT_POINT
> -		exportfs -u :$MNT_POINT
> +		IS_MOUNTED="yes"
>  
>  		umount $MNT_POINT
>  		if [ $? -ne 0 ]; then
>  			tst_resm TFAIL "umount $MNT_POINT"
>  		fi
> +		IS_MOUNTED="no"

Looking at this part of code, is there chance that we get to cleanup
with IS_MOUNTED set to yes?

> +
> +		# Now tearing down the loopback device
> +		while /bin/true; do

Why the absolute path to true?

And perhaps we should limit the number of tries to some arbitrary limit
here 1000 or so.

> +			out=$(LC_ALL=C losetup -d "$loop_dev" 2>&1)
> +
> +			if echo "$out" | grep -q -i "No such device"; then
> +				break
> +			fi
> +		done
>  
>  		tst_resm TPASS "mount/umount with \"$mount_opt\" options"
>  	done

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
