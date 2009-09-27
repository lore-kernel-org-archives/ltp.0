Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryIO-0005mD-5z
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:28 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryIH-0007mW-IV
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:28 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RIFG1W003908
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:16 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIGFsG233242
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:16:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIGFWN026254
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:16:15 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1254005162-27353-4-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
	<1254005162-27353-2-git-send-email-avagin@gmail.com>
	<1254005162-27353-3-git-send-email-avagin@gmail.com>
	<1254005162-27353-4-git-send-email-avagin@gmail.com>
Date: Sun, 27 Sep 2009 23:45:33 +0530
Message-Id: <1254075334.10457.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 4/5] fsstress: fix memory leak in fread_d
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
> 1. check result from operation open before set flags
> 2. close descriptor and free path if set flags failed
> 
> valgrind --leak-check=full --show-reachable=yes ./fsstress -d /home/shpagin/git-archive/ltp/testcases/kernel/fs/fsstress/tmp -l 10 -n 100
> 
> ==23212== 1,134 bytes in 108 blocks are definitely lost in loss record 4 of 5
> ==23212==    at 0x4A0776F: realloc (vg_replace_malloc.c:429)
> ==23212==    by 0x401E6A: append_pathname (fsstress.c:528)
> ==23212==    by 0x4024E3: fent_to_name (fsstress.c:760)
> ==23212==    by 0x40284F: get_fname (fsstress.c:846)
> ==23212==    by 0x4041E0: dread_f (fsstress.c:1757)
> ==23212==    by 0x402368: doproc (fsstress.c:728)
> ==23212==    by 0x401CC1: main (fsstress.c:463)
> 
> Signed-off-by: Andrew Vagin <avagin@gmail.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/fs/fsstress/fsstress.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
> index 715c08d..cf7ba76 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -1764,10 +1764,6 @@ dread_f(int opno, long r)
>  	}
>  	fd = open_path(&f, O_RDONLY);
> 
> -	if (!setdirect(fd)) {
> -		return;
> -	}
> -
>  	e = fd < 0 ? errno : 0;
>  	check_cwd();
>  	if (fd < 0) {
> @@ -1777,6 +1773,13 @@ dread_f(int opno, long r)
>  		free_pathname(&f);
>  		return;
>  	}
> +
> +	if (!setdirect(fd)) {
> +		close(fd);
> +		free_pathname(&f);
> +		return;
> +	}
> +
>  	if (fstat64(fd, &stb) < 0) {
>  		if (v)
>  			printf("%d/%d: dread - fstat64 %s failed %d\n",
> @@ -1864,8 +1867,11 @@ dwrite_f(int opno, long r)
>  		return;
>  	}
> 
> -	if (!setdirect(fd))
> +	if (!setdirect(fd)) {
> +		close(fd);
> +		free_pathname(&f);
>  		return;
> +	}
>  	if (fstat64(fd, &stb) < 0) {
>  		if (v)
>  			printf("%d/%d: dwrite - fstat64 %s failed %d\n",


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
