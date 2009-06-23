Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7OK-0002hG-5E
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:54:32 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7OI-0002Na-EE
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:54:32 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEm9kX012056
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:48:09 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NEsTrv158206
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:54:29 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NEsTmn016276
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:54:29 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220102.n5M12lQI021373@e35.co.us.ibm.com>
References: <200906220102.n5M12lQI021373@e35.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:18:36 +0530
Message-Id: <1245768516.4860.58.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fixes of the tcore test
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-02-17 at 23:58 +0100, Jiri Palecek wrote: 
> Hello,
> 
> these are little fixes of the tcore.sh script
> 
>  - use $BIN_DIR for auxiliary files, and $TEST_DIR as temporary
>    directory
>  - don't run "cd -" if previous "cd something" failed
>  - fixup the value of core_pattern, to replace possibly customized
>    patterns using absolute paths or not using the name "core" for
>    corefiles
>  - don't hide error messages from expect
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks. But, arrived quite late.

Regards--
Subrata

> ---
>  testcases/misc/tcore_patch_test_suites/tcore.sh |   39 ++++++++++++++++-------
>  1 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/misc/tcore_patch_test_suites/tcore.sh b/testcases/misc/tcore_patch_test_suites/tcore.sh
> index d210fa5..f087fa7 100755
> --- a/testcases/misc/tcore_patch_test_suites/tcore.sh
> +++ b/testcases/misc/tcore_patch_test_suites/tcore.sh
> @@ -19,7 +19,8 @@
>  # Test suite for the t-core kernel patch 
>  export TCID=tcore01
>  PTHREAD_DIR="/lib/i686"
> -TEST_DIR="."
> +BIN_DIR=$LTPROOT/testcases/bin/
> +TEST_DIR=$(mktemp -dt)
>  OSTYPE="redhat"
>  # Do some preparation to generate the correct core dump
>  # files
> @@ -42,6 +43,14 @@ os_check()
>  	fi
>  }
> 
> +cleanup()
> +{
> +		rm -rf $TEST_DIR
> +		[ -f /proc/sys/kernel/core_dumps_threads ] && ! [ -z "$OLD_PATTERN" ] && 
> +		echo "$OLD_PATTERN" > /proc/sys/kernel/core_dumps_threads
> +		exit $1
> +}
> +
>  prepare_dump()
>  {
>  	ulimit -c 20000000 >/dev/null 2>&1
> @@ -52,18 +61,23 @@ prepare_dump()
>  			echo "1">/proc/sys/kernel/core_dumps_threads
>  		fi
>  	fi
> +	if [ -f /proc/sys/kernel/core_pattern ]; then
> +			OLD_PATTERN=$(cat /proc/sys/kernel/core_pattern)
> +			echo 'core.%p' > /proc/sys/kernel/core_pattern
> +	fi
>  	#Recover the lipthread.so.0 lib to generate the correct
>  	#core dump file
>  	os_check
>  	if [ $OSTYPE = "redhat" ];then
> -		cd $PTHREAD_DIR
> -		if [ -f libpthread.so.0.orig ];then
> -			test=`ls -l libpthread.so.0.orig|awk '{print $11}'`
> -			if [ $test = "libpthread-0.9.so"  ];then
> -				mv libpthread.so.0.orig libpthread.so.0
> +		cd $PTHREAD_DIR && {
> +			if [ -f libpthread.so.0.orig ];then
> +				test=`ls -l libpthread.so.0.orig|awk '{print $11}'`
> +					if [ $test = "libpthread-0.9.so"  ];then
> +						mv libpthread.so.0.orig libpthread.so.0
> +					fi
>  			fi
> -		fi
> -		cd -
> +			cd -
> +		}
>  	fi
>  }
>  #Prepare for the gdb dump 
> @@ -71,7 +85,7 @@ prepare_gdb()
>  {
>  	os_check
>  	if [ $OSTYPE = "redhat" ];then
> -		cd $PTHREAD_DIR
> +		cd $PTHREAD_DIR && {
>  		if [ -f libpthread.so.0 ];then
>  			test=`ls -l libpthread.so.0|awk '{print $11}'`
>  			if [ $test = "libpthread-0.9.so"  ];then
> @@ -80,6 +94,7 @@ prepare_gdb()
>  		fi
>  		ln -s /lib/libpthread.so.0 libpthread.so.0 >/dev/null 2>&1
>  		cd -
> +    }
>  	fi
>  }
>  #Test whether the system can generate the needed core files
> @@ -91,7 +106,7 @@ Test_gen_core()
>  	if [ -f core.* ];then
>  		rm -f core.*
>  	fi
> -	pid=`$TEST_DIR/tcore |grep "consumer pid"|awk '{print $2}'|cut -d = -f 2`
> +	pid=`$BIN_DIR/tcore |grep "consumer pid"|awk '{print $2}'|cut -d = -f 2`
>  	echo -e "Test whether we can generate the needed core file"
>  	if [ -f core.* ];then
>  		echo -e "PASS"
> @@ -110,7 +125,7 @@ Test_core_file()
>  	prepare_gdb
>  	mv -f $TEST_DIR/core.* $TEST_DIR/corefile >/dev/null 2>&1
>  	echo -e "Test whether the core support bt,fpu and threads commands "
> -	expect ./tcore.exp >/dev/null 2>&1
> +	expect $BIN_DIR/tcore.exp
>  	return=$?
>  	pass=`expr $pass + $return`
>  	fail=`expr 3 - $return + $fail`
> @@ -123,7 +138,7 @@ Test_core_file
>  echo "Linux Tcore test results" > results
>  echo "Total pass fail" >>  results
>  echo "  5	$pass	$fail" >> results
> -exit $fail 
> +cleanup $fail 
> 
>  	
>  	


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
