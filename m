Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N4xRe-0004ze-06
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:42 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N4xRX-0000fJ-BT
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:41 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA2DpGqO006821
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 08:51:16 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA2DxT9Z1470682
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 08:59:29 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA23wsdN013273
	for <ltp-list@lists.sourceforge.net>; Sun, 1 Nov 2009 22:58:54 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910302350.n9UNonlf017587@e2.ny.us.ibm.com>
References: <200910302350.n9UNonlf017587@e2.ny.us.ibm.com>
Date: Mon, 02 Nov 2009 19:29:22 +0530
Message-Id: <1257170362.4977.59.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix expected output in ar01 testcase
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

On Wed, 2009-10-21 at 02:02 +0200, Jiri Palecek wrote: 
> Hello,
> 
>  According to POSIX, the verbose output of "ar -tv" should not contain
>  the leading zero in day-of-month (its format should be equivalent to
>  %e specifier of date) [source: man(1posix)]
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/commands/ade/ar/ar01 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
> index 926be1c..c8f85eb 100755
> --- a/testcases/commands/ade/ar/ar01
> +++ b/testcases/commands/ade/ar/ar01
> @@ -573,7 +573,7 @@ rm -rf $TCtmp/lib.a;cd $TCdat $TCtmp/lib.a.exp *out
>  ar -cr $TCtmp/lib.a file1.in file2.in file3.in
>  crtest
> 
> -ls -ln --time-style=+%b" "%d" "%H:%M file1.in file2.in file3.in |
> +ls -ln --time-style=+%b" "%e" "%H:%M file1.in file2.in file3.in |
>  while
>  read permissions link uid gid size month day time file_name
>  do


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
