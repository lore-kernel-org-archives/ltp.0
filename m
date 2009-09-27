Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryHk-0006pO-4a
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:48 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryHZ-0001Pp-4Z
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:43 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RI9IUW013594
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:09:18 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIFV15108868
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIFV5g012221
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:31 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200909241422.n8OEMjhq024716@e4.ny.us.ibm.com>
References: <200909241422.n8OEMjhq024716@e4.ny.us.ibm.com>
Date: Sun, 27 Sep 2009 23:45:06 +0530
Message-Id: <1254075308.10457.22.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Make sure some Crackerjack tests are
	running	under	root
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

On Thu, 2009-07-09 at 01:46 +0200, Jiri Palecek wrote: 
> The tests need to run under root to change their EUID
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/mq_unlink/mq_unlink01.c |    1 +
>  testcases/kernel/syscalls/utimes/utimes01.c       |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
> index 067656c..85baa2b 100644
> --- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
> +++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
> @@ -123,6 +123,7 @@ extern void cleanup() {
>  /*                                                                            */
>  /******************************************************************************/
>  void setup() {
> +        tst_require_root(tst_exit);
>          /* Capture signals if any */
>          /* Create temporary directories */
>          TEST_PAUSE;
> diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
> index e52495b..7705269 100644
> --- a/testcases/kernel/syscalls/utimes/utimes01.c
> +++ b/testcases/kernel/syscalls/utimes/utimes01.c
> @@ -130,6 +130,8 @@ extern void cleanup() {
>  /*                                                                            */
>  /******************************************************************************/
>  void setup() {
> +        tst_require_root(tst_exit);
> +
>          /* Capture signals if any */
>          /* Create temporary directories */
>          TEST_PAUSE;


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
