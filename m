Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnwGL-0003FW-AA
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:41 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwGD-0000m6-4V
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:41 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GF8ZXg018100
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:08:35 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHPtm073716
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:17:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFHP1F015898
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:17:25 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0909151727490.29706@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151727490.29706@vixen.sonytel.be>
Date: Wed, 16 Sep 2009 20:47:15 +0530
Message-Id: <1253114235.6343.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] quotactl01: Fix tst_resm() format causing crash
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

On Tue, 2009-09-15 at 17:28 +0200, Geert Uytterhoeven wrote: 
> When the quotactl syscall fails, quotactl01 crashes with a segmentation fault
> due to an incorrect printf()-style format.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> --
> v2: Use TTERRNO
> 
>  testcases/kernel/syscalls/quotactl/quotactl01.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 6800a25..fe8df33 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -147,7 +147,7 @@ int main(int ac, char **av) {
>                  for (i = 0; i <= 7; i++){
>                          TEST(retval = syscall(__NR_quotactl, cmd[i], (const char *)NULL, id, (caddr_t)NULL));
>  			if(TEST_RETURN != 0){
> -                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s ...cmderror=%s", TCID, TEST_ERRNO, strerror(TEST_ERRNO),cmd[i]);
> +				tst_resm(TFAIL|TTERRNO, "%s failed, cmd=0x%x", TCID, cmd[i]);
>                          }else{
>          			tst_resm(TPASS, "quotactl call succeeded");
>                          }


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
