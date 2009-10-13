Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxj8A-00026P-Vk
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 15:17:42 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxj83-0004NV-OS
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 15:17:42 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DF7qWe028443
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 11:07:52 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DFHUbv121978
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 11:17:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DFDPdp014784
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 11:14:04 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910050851.n958pjtn011127@e35.co.us.ibm.com>
References: <200910050851.n958pjtn011127@e35.co.us.ibm.com>
Date: Tue, 13 Oct 2009 20:14:18 +0530
Message-Id: <1255445058.8438.79.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Two fixes of the utimes01 test
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

On Sat, 2009-07-11 at 11:31 +0200, Jiri Palecek wrote: 
> - POSIX specifies utimes returns EPERM, not EACCESS, when there are
>    insufficient rights and times is not NULL
> 
>  - the timeval structures need to be initialized, because garbage in
>    the nanosecond part would cause EINVAL
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Some of your patches like this arrives with old dates and hence my mail
client pushed them down, sometimes remains un-noticible by me. Tried to
apply, but failed, probably because of the changes i did today:

patching file testcases/kernel/syscalls/utimes/utimes01.c
Hunk #1 succeeded at 193 with fuzz 1 (offset -16 lines).
Hunk #2 FAILED at 224.
1 out of 2 hunks FAILED -- saving rejects to file
testcases/kernel/syscalls/utimes/utimes01.c.rej

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/utimes/utimes01.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
> index 7705269..2fddb99 100644
> --- a/testcases/kernel/syscalls/utimes/utimes01.c
> +++ b/testcases/kernel/syscalls/utimes/utimes01.c
> @@ -209,7 +209,7 @@ static struct test_case tcase[] = {
>                  .m_sec          = 2000,
>                  .user           = "nobody",
>                  .ret            = -1,
> -                .err            = EACCES, // RHEL4U1 + 2.6.18 returns EPERM
> +                .err            = EPERM, // RHEL4U1 + 2.6.18 returns EPERM,
>          },
>          { // case03
>                  .ttype          = FILE_NOT_EXIST,
> @@ -240,7 +240,7 @@ static int do_test(struct test_case *tc)
>  {
>          int sys_ret;
>          int result = RESULT_OK;
> -	struct timeval tv[2];
> +        struct timeval tv[2] = { 0 };
>          const char *fpath = FNAME;
>          int rc, cmp_ok = 1;
>          struct stat st;


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
