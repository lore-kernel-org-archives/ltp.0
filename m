Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S4SsI-0001S4-DP
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 08:02:30 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S4SsH-0004Yx-3c
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 08:02:30 +0000
Received: by pbbrp12 with SMTP id rp12so4378436pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Mar 2012 00:02:23 -0800 (PST)
Message-ID: <4F5472D7.20109@casparzhang.com>
Date: Mon, 05 Mar 2012 16:01:27 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <76754072b02d384e53bff8c46b248377fb38c71c.1330687921.git.zliu@redhat.com>
In-Reply-To: <76754072b02d384e53bff8c46b248377fb38c71c.1330687921.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH] numa/numa_node_size: removed HAS_NUMA_H macro
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 03/02/2012 07:32 PM, Zhouping Liu wrote:
> HAS_NUMA_H should be HAVE_NUMA_H, and HAVE_NUMA_H is defined
> in config.h, so added the header file.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/numa/numa_node_size.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/numa/numa_node_size.c b/testcases/kernel/numa/numa_node_size.c
> index 3d71ff2..5992f56 100644
> --- a/testcases/kernel/numa/numa_node_size.c
> +++ b/testcases/kernel/numa/numa_node_size.c
> @@ -31,9 +31,12 @@
>  /*                                                                            */
>  /******************************************************************************/
>  
> +#include "config.h"
> +

no need to put a new line here ...

>  #include <stdio.h>
>  #include <stdlib.h>
> -#if HAS_NUMA_H
> +

here as well.

Anyway, I committed this patch with removing the 2 blank lines.

Thanks,
Caspar

> +#if HAVE_NUMA_H
>  #include <numa.h>
>  #endif
>  
> @@ -48,7 +51,7 @@ char *fmt_mem(unsigned long long mem, char *buf)
>  }
>  void hardware(void)
>  {
> -#if HAS_NUMA_H
> +#if HAVE_NUMA_H
>          int i;
>          int maxnode = numa_max_node();
>          printf("available: %d nodes (0-%d)\n", 1+maxnode, maxnode);
> @@ -64,7 +67,7 @@ void hardware(void)
>  }
>  int main()
>  {
> -#if HAS_NUMA_H
> +#if HAVE_NUMA_H
>          nodemask_t nodemask;
>          void hardware();
>          if (numa_available() < 0)
> @@ -83,4 +86,4 @@ int main()
>          printf("NUMA is not available\n");
>          return 1;
>  #endif
> -}
> \ No newline at end of file
> +}


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
