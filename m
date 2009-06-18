Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTU-0003nR-QB
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:32 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTS-0006gT-PP
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:32 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHLnAp018037
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:21:49 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHWUx5243944
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:32:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHWTE4001897
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:32:29 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090617.235414.789903209098431159.yamato@redhat.com>
References: <20090617.235414.789903209098431159.yamato@redhat.com>
Date: Thu, 18 Jun 2009 23:01:53 +0530
Message-Id: <1245346313.5041.41.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] build failure of aio02 test case
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
To: Masatake YAMATO <yamato@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-06-17 at 23:54 +0900, Masatake YAMATO wrote: 
> Hi,
> 
> 
> --static for gcc is really needed? I cannot find strong reason for
> it.
> 
> 
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Fine. The only issue is the patch is not based from LTPROOT.

Regards--
Subrata

> 
> 
> Index: aio/aio02/Makefile
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/aio/aio02/Makefile,v
> retrieving revision 1.5
> diff -u -r1.5 Makefile
> --- aio/aio02/Makefile	23 Feb 2009 11:08:04 -0000	1.5
> +++ aio/aio02/Makefile	17 Jun 2009 14:51:57 -0000
> @@ -5,12 +5,12 @@
>  HARNESS_SRCS:=main.c
>  # io_queue.c
> 
> -CFLAGS+=--static -Wall  -g -O -I../../../../../include -Wall
> +CFLAGS+=-Wall  -g -O -I../../../../../include -Wall
>  LDFLAGS+=-L../../../../../lib -lltp $(AIO_LIBS)
>  #-lpthread -lrt
>  all: $(PROGS)
> 
> -$(PROGS): %: %.c $(HARNESS_SRCS)
> +$(PROGS): %: %.c $(HARNESS_SRCS) Makefile
>  	$(CC) $(CFLAGS) -DTEST_NAME=\"$<\" -o $@ main.c $(LDFLAGS)
> 
>  clean:
> Index: aio/aio02/main.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/aio/aio02/main.c,v
> retrieving revision 1.4
> diff -u -r1.4 main.c
> --- aio/aio02/main.c	26 Feb 2009 12:02:22 -0000	1.4
> +++ aio/aio02/main.c	17 Jun 2009 14:51:57 -0000
> @@ -35,6 +35,7 @@
>  int main(void)
>  {
>    tst_brkm(TCONF, tst_exit, "libaio missing");
> +  return 0;
>  }
> 
>  #endif
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
