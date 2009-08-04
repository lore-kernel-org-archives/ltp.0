Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIpL-0001Io-Uf
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:11 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIpF-0004qK-QS
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:09:11 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74C2xDk018030
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:02:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74C8wQ9245240
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:58 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74C8wjF014370
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:58 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
Date: Tue, 04 Aug 2009 17:38:34 +0530
Message-Id: <1249387714.15587.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/4] utimensat: Remove utimensat_user from script
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

On Mon, 2009-08-03 at 15:24 +0200, michal.simek@petalogix.com wrote: 
> From: Michal Simek <monstr@monstr.eu>
> 
> We can use nobody user instead of creating new one
> for this special test. Latest busybox source
> code not support userdel, useradd that's why
> is better to use user which exists.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>

Ok.

Regards--
Subrata

> ---
>  .../kernel/syscalls/utimensat/utimensat_tests.sh   |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> index 19c59c7..d0e940a 100644
> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> @@ -243,8 +243,7 @@ run_test()
>  }
>  #=====================================================================
> 
> -user_tester=utimensat_tester
> -useradd $user_tester
> +user_tester=nobody
>  sudo -u $user_tester mkdir -p $TEST_DIR
> 
>  chown root $LTPROOT/testcases/bin/$TEST_PROG
> @@ -434,7 +433,6 @@ echo "============================================================"
> 
>  echo
> 
> -userdel -r utimensat_tester
>  rm -rf $TEST_PROG
>  uname -a
>  date


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
