Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7YW-0000OL-JZ
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:05:04 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7YV-0003FO-HD
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:05:04 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NF0ViZ021157
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:00:31 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF51Cc198326
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:05:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF50qw031642
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:05:00 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220112.n5M1CMhv031610@e2.ny.us.ibm.com>
References: <200906220112.n5M1CMhv031610@e2.ny.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:49 +0530
Message-Id: <1245768589.4860.77.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix some compiler warnings
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

On Wed, 2009-06-17 at 17:06 +0200, Jiri Palecek > wrote: 
> Hello,
> 
> this patch fixes compiler warnings for implicit function declarations, particularly snprintf and usleep, in mq_notify and mq_timedreceive. Note that although the functions are used in common_j_c.h, the macros have to be defined in the c files that include it, before any other header
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/mq_notify/mq_notify01.c  |    1 +
>  .../syscalls/mq_timedreceive/mq_timedreceive01.c   |    1 +
>  testcases/kernel/syscalls/utils/common_j_h.c       |    1 -
>  3 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
> index 1cc1a6c..6004373 100644
> --- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
> +++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
> @@ -45,6 +45,7 @@
>  /* History:     Porting from Crackerjack to LTP is done by                    */
>  /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
>  /******************************************************************************/
> +#define _XOPEN_SOURCE 500
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> index 43f0d8b..dadc38d 100644
> --- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> +++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> @@ -45,6 +45,7 @@
>  /* History:     Porting from Crackerjack to LTP is done by                    */
>  /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
>  /******************************************************************************/
> +#define _XOPEN_SOURCE 500
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
> index e19d433..c56f6e2 100644
> --- a/testcases/kernel/syscalls/utils/common_j_h.c
> +++ b/testcases/kernel/syscalls/utils/common_j_h.c
> @@ -22,7 +22,6 @@
>   * $Id: common_j_h.c,v 1.2 2009/06/09 17:58:42 subrata_modak Exp $
>   *
>   */
> -//#define _GNU_SOURCE 1
>  #include <stdio.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
