Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnwTM-0006K8-DT
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:31:08 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwTH-0005VD-Fm
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:31:08 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GF7dZb015436
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:07:39 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHUts109400
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:31 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFHUqb009454
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:30 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0909151729110.29751@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151729110.29751@vixen.sonytel.be>
Date: Wed, 16 Sep 2009 20:47:21 +0530
Message-Id: <1253114241.6343.33.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Spelling fixes: inclue -> include
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

On Tue, 2009-09-15 at 17:29 +0200, Geert Uytterhoeven wrote: 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  .../kernel/syscalls/utimensat/utimensat_tests.sh   |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> index d0e940a..a5321af 100644
> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> @@ -182,7 +182,7 @@ run_test()
>      # a) pathname (pathname != NULL)
>      # b) readable file descriptor (pathname == NULL, dirfd opened O_RDONLY)
>      # c) writable file descriptor (pathname == NULL, dirfd opened O_RDWR).
> -    #    For this case we also inclue O_APPEND in open flags, since that
> +    #    For this case we also include O_APPEND in open flags, since that
>      #    is needed if testing with a file that has the Append-only
>      #    attribute enabled.
>  


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
