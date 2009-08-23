Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7Ve-0008HT-3a
	for Ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:02 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7VX-0001nZ-47
	for Ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:02 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7RRlY022768
	for <Ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:27:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7SlBR230160
	for <Ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:28:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7Ppvs013918
	for <Ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:25:51 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1250781918-23897-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1250781918-23897-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1250781918-23897-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1250781918-23897-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
Date: Sun, 23 Aug 2009 12:58:18 +0530
Message-Id: <1251012499.16822.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Spelling fixes: brok -> broke
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Ltp-list@lists.sourceforge.net

On Thu, 2009-08-20 at 17:25 +0200, Geert Uytterhoeven wrote: 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/commands/ade/file/file_test.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
> index 6f09f21..b4719fc 100755
> --- a/testcases/commands/ade/file/file_test.sh
> +++ b/testcases/commands/ade/file/file_test.sh
> @@ -532,7 +532,7 @@ fi
> 
>  if [ $RC -ne 0 ]
>  then
> -    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "mkdir: brok. Reason:"
> +    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "mkdir: broke. Reason:"
>  fi
> 
>  cat > $bDIR/SOURCES/cprog.c <<EOF
> @@ -552,7 +552,7 @@ fi
>  $bCMD --define "_topdir $bDIR" -bs  $LTPTMP/files.spec > $LTPTMP/file.out 2>&1
>  if [ $? -ne 0 ]
>  then
> -    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "rpm command brok. Reason:"
> +    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL "rpm command broke. Reason:"
>  fi
> 
>  file $bDIR/SRPMS/cprog-0.0.7-3.src.rpm > $LTPTMP/file.out 2>&1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
