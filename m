Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NpEJo-0008RW-OP
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:18:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NpEJn-0005ul-0S
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:18:52 +0000
Message-ID: <4B972BAC.5000704@cn.fujitsu.com>
Date: Wed, 10 Mar 2010 13:18:36 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <E1NpDZI-0002Ux-VZ@sfp-scmshell-2.v30.ch3.sourceforge.com>
In-Reply-To: <E1NpDZI-0002Ux-VZ@sfp-scmshell-2.v30.ch3.sourceforge.com>
Subject: Re: [LTP] [Git] ltp updated.
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi Rishikesh,

at 2010-3-10 12:30, Rishi kesh K Rajak wrote:
> The branch, master, has been updated
>        via  48c52fcd4e7668bc36bbe080f53462d410712b69 (commit)
>       from  c962f51674b971496e14ac4be0cc75da98b75fca (commit)
> 
> 
> - Log -----------------------------------------------------------------
> commit 48c52fcd4e7668bc36bbe080f53462d410712b69
> Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> Date:   Wed Mar 10 10:00:22 2010 +0530
> 
>     Instead of LIBS, it should be LDLIBS in container/Makefile
>     
>     Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> 
> -----------------------------------------------------------------------
> 
> Summary of changes:
>  testcases/kernel/containers/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>  
> diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
> index 26f1856..29394c3 100644
> --- a/testcases/kernel/containers/Makefile
> +++ b/testcases/kernel/containers/Makefile
> @@ -26,7 +26,7 @@ FILTER_OUT_DIRS		:= $(LIBDIR)
>  
>  LIB			:= $(LIBDIR)/libclone.a
>  
> -LIB			:= -ld
> +LDLIB			:= -ldl

make failed on my machine. should be LDLIBS ?

>  
>  INSTALL_TARGETS		:= *.sh 
>  
> 
> 
> hooks/post-receive

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
