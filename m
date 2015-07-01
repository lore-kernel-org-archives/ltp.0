Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZAAWU-0003rO-T1
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 05:25:26 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZAAWR-0001VR-MO
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 05:25:26 +0000
Message-ID: <559379A6.5040408@huawei.com>
Date: Wed, 1 Jul 2015 13:24:54 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1435727815-9484-1-git-send-email-sunyuan3@huawei.com>
In-Reply-To: <1435727815-9484-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] filecaps: Remove unnecessary c.c file.
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

I forgot to modify .gitignore file. Please see V2.
On 2015/7/1 13:16, Yuan Sun wrote:
> The c.c file is the same as check_simple_capset.c except config.h
> is included in check_simple_capset.c. Moreover, it is not correct
> to use HAVE_SYS_CAPABILITY_H without including config.h.
>
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>   testcases/kernel/security/filecaps/c.c | 47 ----------------------------------
>   1 file changed, 47 deletions(-)
>   delete mode 100644 testcases/kernel/security/filecaps/c.c
>
> diff --git a/testcases/kernel/security/filecaps/c.c b/testcases/kernel/security/filecaps/c.c
> deleted file mode 100644
> index 511e673..0000000
> --- a/testcases/kernel/security/filecaps/c.c
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -/******************************************************************************/
> -/*                                                                            */
> -/* Copyright (c) International Business Machines  Corp., 2008                 */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*                                                                            */
> -/******************************************************************************/
> -
> -#include <stdio.h>
> -#if HAVE_SYS_CAPABILITY_H
> -#include <linux/types.h>
> -#include <sys/capability.h>
> -#endif
> -
> -int main(void)
> -{
> -
> -#ifdef HAVE_LIBCAP
> -	cap_t caps, caps2;
> -	int ret;
> -
> -	caps = cap_from_text("cap_setpcap+ep");
> -	caps2 = cap_from_text("cap_setpcap+ep");
> -	ret = cap_set_proc(caps);
> -	ret = cap_compare(caps, caps2);
> -	printf("Caps were %sthe same\n", ret ? "not " : "");
> -
> -	cap_free(caps);
> -	cap_free(caps2);
> -	return ret;
> -#else
> -	printf("System doesn't support full POSIX capabilities.\n");
> -	return 1;
> -#endif
> -}


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
