Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WLZrM-0005No-Kg
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 15:05:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLZrJ-0008QP-7O
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 15:05:20 +0000
Date: Thu, 6 Mar 2014 10:05:08 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <115590897.213936.1394118308156.JavaMail.zimbra@redhat.com>
In-Reply-To: <1394117640-14933-1-git-send-email-liuhangbin@gmail.com>
References: <1394117640-14933-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] containers/netns: fix header file path
	for	check_netns_enabled.c
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Hangbin Liu" <liuhangbin@gmail.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 6 March, 2014 3:54:00 PM
> Subject: [LTP] [PATCH] containers/netns: fix header file path for	check_netns_enabled.c
> 
> CLONE_NEWNET and CLONE_NEWNS are defined in linux/sched.h, not sched.h

/usr/include/bits/sched.h:# define CLONE_NEWNS   0x00020000 /* Set to create new namespace.  */
sched.h includes bits/sched.h

Where (distro, glibc version) do you see this fail when you include only sched.h?

Regards,
Jan

> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/kernel/containers/netns/check_netns_enabled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c
> b/testcases/kernel/containers/netns/check_netns_enabled.c
> index ab8ee2f..7bb2324 100644
> --- a/testcases/kernel/containers/netns/check_netns_enabled.c
> +++ b/testcases/kernel/containers/netns/check_netns_enabled.c
> @@ -20,7 +20,7 @@
>  * when trying to use CLONE_NEWNET and CLONE_NEWNS.
>  ***************************************************************************/
>  #include <stdio.h>
> -#include <sched.h>
> +#include <linux/sched.h>
>  #include "config.h"
>  #include "libclone.h"
>  #include "linux_syscall_numbers.h"
> --
> 1.8.1.4
> 
> 
> ------------------------------------------------------------------------------
> Subversion Kills Productivity. Get off Subversion & Make the Move to
> Perforce.
> With Perforce, you get hassle-free workflows. Merge that actually works.
> Faster operations. Version large binaries.  Built-in WAN optimization and the
> freedom to use Git, Perforce or both. Make the move to Perforce.
> http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
