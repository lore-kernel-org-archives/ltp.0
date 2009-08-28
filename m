Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mguen-0003xp-49
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 06:09:53 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgueg-0001I7-KK
	for Ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 06:09:53 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7S67c1p022015
	for <Ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:07:38 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S69d4H225894
	for <Ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:09:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7S69cg4001402
	for <Ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:09:38 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908271336370.28293@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908271336370.28293@vixen.sonytel.be>
Date: Fri, 28 Aug 2009 11:39:15 +0530
Message-Id: <1251439758.9081.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] file: Autodetect RPM topdir
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
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Thu, 2009-08-27 at 13:38 +0200, Geert Uytterhoeven wrote: 
> Query RPM for the location of the RPM topdir, instead of guessing,
> which failed on YDEL6 (/usr/src/yellowdog) and Debian/Ubuntu (/usr/src/rpm)
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Ok. Thanks.

Regards--
Subrata

> ---
>  testcases/commands/ade/file/file_test.sh |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
> index f59b0c6..5fa287b 100755
> --- a/testcases/commands/ade/file/file_test.sh
> +++ b/testcases/commands/ade/file/file_test.sh
> @@ -474,13 +474,8 @@ export TST_COUNT=9
>  $LTPBIN/tst_resm TINFO "TEST #9: file command recognizes RPM files"
>  `type rpm &> /dev/null`
>  if [ $? = 0 ]; then
> -if [ -f /etc/redhat-release ]; then
> -	bDIR=/usr/src/redhat
> -	bCMD=rpmbuild
> -else
> -	bDIR=/usr/src/packages
> -	bCMD=rpmbuild
> -fi
> +bDIR=$(rpm --eval "%{_topdir}")
> +bCMD=rpmbuild
>  
>  rpmversion=`rpm --version | awk -F ' ' '{print $3}' | cut -d '.' -f1 `
>  


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
