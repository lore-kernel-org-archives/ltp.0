Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N4xRo-0004KB-6B
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:52 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N4xRg-0005hu-J5
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 13:59:51 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA2DpP5w007070
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 08:51:25 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA2Dxc2N1122466
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 08:59:38 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA2Dxc9o032245
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Nov 2009 08:59:38 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910301649.n9UGnbHJ001240@e34.co.us.ibm.com>
References: <200910301649.n9UGnbHJ001240@e34.co.us.ibm.com>
Date: Mon, 02 Nov 2009 19:29:28 +0530
Message-Id: <1257170368.4977.61.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Other compiler warning fixes
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

Thanks. Just a small correction below:

On Wed, 2009-10-21 at 21:37 +0200, Jiri Palecek wrote: 
> Hello,
> 
> this is another chunk of compiler warning fixes in LTP tests, related to printf format strings. They have multiple causes:
> 
>  - most of them are caused by %d used for the TEST_RETURN variable (as in a previous patch)
> 
>  - off_t are cast to (int64_t) and PRId64 output specifier is used for them
> 
>  - other types are cast to (intmax_t) or (uintmax_t) and use the %jd or %ju (C99) output specifier. I've used this solution because it's generally correct, easy to use solution that is portable and (IMHO) more readable than using PRId64/PRIu64 and a cast (which you generally can't avoid). This way, there's only a cast.
> 
>  - in ioperm test, address should be declared as unsigned long (according to ioperm(2))
> 
>  - other little fixes (foo vs. *foo, %S vs. %s, %0 vs. %o)
> 
> Regards
>     Jiri Palecek
> 
> diff --git a/testcases/kernel/syscalls/socketcall/socketcall03.c b/testcases/kernel/syscalls/socketcall/socketcall03.c
> index 9cc2de4..de63784 100644
> --- a/testcases/kernel/syscalls/socketcall/socketcall03.c
> +++ b/testcases/kernel/syscalls/socketcall/socketcall03.c
> @@ -127,12 +127,12 @@ int main(int ac, char **av)
>  		/* check return code */
> 
>  		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "socketcall() Failed "
> -				 " with return=%d,errno=%d: %s",
> -				 TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
> +			tst_resm(TFAIL|TTERNO, "socketcall() Failed "

+ tst_resm(TFAIL|TERRNO, "socketcall() Failed "

Regards--
Subrata



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
