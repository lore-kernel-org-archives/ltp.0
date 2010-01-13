Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NV44b-0003BX-Ab
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:49 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NV44Z-0005gS-0o
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:49 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0DE9l1S004681
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:09:47 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0DEJfx02125954
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:19:41 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0DEJeV8012435
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:19:40 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B4B0575.1090501@cn.fujitsu.com>
References: <4B4B0575.1090501@cn.fujitsu.com>
Date: Wed, 13 Jan 2010 19:49:27 +0530
Message-Id: <1263392367.5591.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] cpuset_syscall_test: delete '0x' from hex string
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, 2010-01-11 at 19:03 +0800, Shi Weihua wrote: 
> By the latest ltp version, the following fail message outputted on my x86_64 box.
> ------------
> TEST 5: CPUSET CONTROLLER TESTING
> TEST STARTED: Please avoid using system while this test executes
> ...
> cpuset05    8  TFAIL  :  Result(/proc/<pid>/status) = "", expect = "0")
> cpuset05    9  TFAIL  :  Result(/proc/<pid>/status) = "", expect = "1")
> cpuset05   10  TFAIL  :  Result(/proc/<pid>/status) = "", expect = "default")
> ------------
> 
> The reason is:
> 1, '0x' wasn't deleted from a hex string's head.
>    e.g. 7f343c900000 is expected ,but 0x7f343c900000 outputted.
> 2, a wrong '\b' was used in a grep command.
> 
> This patch fix the upper problem. Now the message is:
> ------------
> cpuset05    7  TPASS  :  Cpuset vs systemcall test succeeded.
> cpuset05    8  TPASS  :  Cpuset vs systemcall test succeeded.
> cpuset05    9  TPASS  :  Cpuset vs systemcall test succeeded.
> cpuset05   10  TPASS  :  Cpuset vs systemcall test succeeded.
> ------------
> 
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
> diff -urpN ltp-full-20091231.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh ltp-full-20091231/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> --- ltp-full-20091231.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh	2009-06-23 10:09:11.000000000 -0400
> +++ ltp-full-20091231/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh	2010-01-11 18:42:59.000000000 -0500
> @@ -178,7 +178,8 @@ test7()
>  {
>  	do_syscall_test 0 0 --mbind=1 0 || return 1
>  	memory_addr="$(cat $TEST_OUTPUT)"
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
> +	memory_addr=${memory_addr##*0x}
> +	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "0" || return 1
> @@ -193,7 +194,8 @@ test8()
>  {
>  	do_syscall_test 0 0-1 --mbind=1 0 || return 1
>  	memory_addr="$(cat $TEST_OUTPUT)"
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
> +	memory_addr=${memory_addr##*0x}
> +	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "0"
> @@ -208,7 +210,8 @@ test9()
>  {
>  	do_syscall_test 0 0-1 --mbind=6 0 || return 1
>  	memory_addr="$(cat $TEST_OUTPUT)"
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
> +	memory_addr=${memory_addr##*0x}
> +	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "1"
> @@ -223,7 +226,8 @@ test10()
>  {
>  	do_syscall_test 0 0 --mbind=6 1 || return 1
>  	memory_addr="$(cat $TEST_OUTPUT)"
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "\b$memory_addr" | \
> +	memory_addr=${memory_addr##*0x}
> +	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "default"
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
