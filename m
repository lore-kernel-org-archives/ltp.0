Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2Sxm-0001GG-Al
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:02:34 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2Sxl-0007u1-DI
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 17:02:34 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9QGsLjA005270
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 12:54:21 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9QH2PQ7089790
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 13:02:25 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9Q73Jm7026805
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 03:03:19 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910041139.n94Bde05022152@e33.co.us.ibm.com>
References: <200910041139.n94Bde05022152@e33.co.us.ibm.com>
Date: Mon, 26 Oct 2009 22:32:21 +0530
Message-Id: <1256576541.4929.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix temporary file creation in mmapstress tests
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

On Sun, 2009-06-07 at 02:32 +0200, Jiri Palecek wrote: 
> Hello,
> 
> these are two little fixes of the mmapstress test.
> 
>  - the mkstemp() function returns -1 on error; the tests treat 0 as
>    error instead
> 
>  - mkstemp() returns a file descriptor; no need to open the file once
>    more later
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/mem/mmapstress/mmapstress02.c |    6 +-----
>  testcases/kernel/mem/mmapstress/mmapstress05.c |    6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress02.c b/testcases/kernel/mem/mmapstress/mmapstress02.c
> index a0f0693..f801a2e 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress02.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress02.c
> @@ -101,7 +101,7 @@ main(int argc, char *argv[]) {
>  		return 1;
>  	}
>  	(void)time(&t);
> -	if (!(fd = mkstemp(tmpname))) {
> +	if ((fd = mkstemp(tmpname)) == -1) {
>  		ERROR("mkstemp failed");
>  		anyfail();
>  	}
> @@ -114,10 +114,6 @@ main(int argc, char *argv[]) {
>          CATCH_SIG(SIGINT);
>          CATCH_SIG(SIGQUIT);
>          CATCH_SIG(SIGTERM);
> -	if ((fd = open(tmpname, O_CREAT|O_RDWR, 0777)) == -1) {
> -		ERROR("couldn't open temporary file");
> -		anyfail();
> -	}
>  	if (sbrk(2*pagesize - ((ulong)sbrk(0) & (pagesize-1))) == (char *)-1) {
>  		CLEANERROR("couldn't round up brk");
>  		anyfail();
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress05.c b/testcases/kernel/mem/mmapstress/mmapstress05.c
> index 9155834..4d25b8d 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress05.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress05.c
> @@ -133,7 +133,7 @@ main(int argc, char *argv[])
>  	-- sreeni
>  	*/
> 
> -	if (!(fd = mkstemp(tmpname))) {
> +	if ((fd = mkstemp(tmpname))==-1) {
>  		ERROR("mkstemp failed");
>  		anyfail();
>  	}
> @@ -146,10 +146,6 @@ main(int argc, char *argv[])
>  	CATCH_SIG(SIGINT);
>          CATCH_SIG(SIGQUIT);
>          CATCH_SIG(SIGTERM);
> -	if ((fd = open(tmpname, O_RDWR|O_CREAT, 0777)) == -1) {
> -		ERROR("open failed");
> -		anyfail();
> -	}
>  	for (i = 0; i < pagesize; i++)
>  		buf[i] = 'a';
>  	if (write(fd, buf, pagesize) != pagesize) {


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
