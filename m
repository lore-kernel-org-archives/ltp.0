Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME60y-0003ye-75
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:40 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME60x-0001bP-BV
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:40 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59IOxpW027543
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:24:59 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IPc3c259988
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IPcet032582
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:38 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081322.58916.jpalecek@web.de>
References: <200906081322.58916.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:55:00 +0530
Message-Id: <1244571902.5497.22.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Don't create the message queue in mq_open01
	when	the test specifies O_CREAT flag
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

On Mon, 2009-06-08 at 13:22 +0200, Jiri Palecek wrote: 
> The tests need to create the message queue themselves to specify the
>  creation attributes
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/mq_open/mq_open01.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
> index 205de66..f9c2f08 100644
> --- a/testcases/kernel/syscalls/mq_open/mq_open01.c
> +++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
> @@ -315,7 +315,7 @@ static int do_test(struct test_case *tc)
>           * Execute system call
>           */
> 
> -	if (tc->ttype != NO_SPACE) {
> +	if (tc->ttype != NO_SPACE && !(tc->oflag & O_CREAT)) {
>                  errno = 0;
>                  TEST(sys_ret = mq_open(QUEUE_NAME, O_CREAT|O_EXCL|O_RDWR, S_IRWXU, NULL));
>                  sys_errno = errno;


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
