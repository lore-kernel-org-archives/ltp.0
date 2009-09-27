Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryIG-0005kv-Ax
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:20 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryI8-0001YI-Fu
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:20 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RIDkMN010754
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:13:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIG7kP223692
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:16:07 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIG694005503
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:16:06 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1254005162-27353-3-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
	<1254005162-27353-2-git-send-email-avagin@gmail.com>
	<1254005162-27353-3-git-send-email-avagin@gmail.com>
Date: Sun, 27 Sep 2009 23:45:29 +0530
Message-Id: <1254075331.10457.26.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 3/5] fsstress: fix memory leaks
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
To: Andrew Vagin <avagin@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, 2009-09-27 at 02:46 +0400, Andrew Vagin wrote: 
> ==11424== 156 bytes in 1 blocks are definitely lost in loss record 2 of 2
> ==11424==    at 0x4A0763E: malloc (vg_replace_malloc.c:207)
> ==11424==    by 0x402E4C: make_freq_table (fsstress.c:986)
> ==11424==    by 0x401C26: main (fsstress.c:410)
> 
> make_freq_table is executed on each iterations, but freq_table is not
> changed during test, so this patch moves it from the loop
> 
> Signed-off-by: Andrew Vagin <avagin@gmail.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/fs/fsstress/fsstress.c |   28 +++++++++++++++-------------
>  1 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
> index 5ada3d8..715c08d 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -375,21 +375,24 @@ int main(int argc, char **argv)
>  			break;
>  		}
>  	}
> -	while ( (loopcntr <= loops) || (loops == 0) )
> -	{
> -		if (no_xfs && errtag) {
> -			fprintf(stderr, "error injection only works on XFS\n");
> -			exit(1);
> -		}
> 
> -		if (no_xfs) {
> -			int i;
> -			for (i = 0; ops+i < ops_end; ++i) {
> -				if (ops[i].isxfs)
> -					ops[i].freq = 0;
> -			}
> +	if (no_xfs && errtag) {
> +		fprintf(stderr, "error injection only works on XFS\n");
> +		exit(1);
> +	}
> +
> +	if (no_xfs) {
> +		int i;
> +		for (i = 0; ops+i < ops_end; ++i) {
> +			if (ops[i].isxfs)
> +				ops[i].freq = 0;
>  		}
> +	}
> 
> +	make_freq_table();
> +
> +	while ( (loopcntr <= loops) || (loops == 0) )
> +	{
>  		if (!dirname) {
>  			/* no directory specified */
>  			if (!nousage) usage();
> @@ -407,7 +410,6 @@ int main(int argc, char **argv)
>  			maxfsize = (off64_t)MAXFSIZE32;
>  		else
>  			maxfsize = (off64_t)MAXFSIZE;
> -		make_freq_table();
>  		dcache_init();
>  		setlinebuf(stdout);
>  		if (!seed) {


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
