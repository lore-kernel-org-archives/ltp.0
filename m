Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SWOL1-0000MB-Ix
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 08:51:35 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SWOKv-0007hY-Nb
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 08:51:35 +0000
Received: by pbbrq2 with SMTP id rq2so6837658pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 May 2012 01:51:23 -0700 (PDT)
Message-ID: <4FBA01CE.5000407@casparzhang.com>
Date: Mon, 21 May 2012 16:50:22 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1337589516-9731-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1337589516-9731-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] getcpu: remove the useless and improper kernel
 version check
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 05/21/2012 04:38 PM, Wanlong Gao wrote:
> Now, kernel version up to 3.x, check for 2.6.x is useless.

The fix makes sense, however, "checking for 2.6.x" is still valid for
old kernels (does LTP still support 2.4.x? I'm not sure...)

Anyway,

Acked-by: Caspar Zhang <caspar@casparzhang.com>

> Additionally, we already checked the kernel version in the
> program itself.
> Meanwhile, check the kernel version at compiling time is wrong,
> we may not do testing on the same machine as compiling.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/getcpu/Makefile |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getcpu/Makefile b/testcases/kernel/syscalls/getcpu/Makefile
> index b8bf68b..7a1a87a 100644
> --- a/testcases/kernel/syscalls/getcpu/Makefile
> +++ b/testcases/kernel/syscalls/getcpu/Makefile
> @@ -19,18 +19,4 @@
>  top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -
> -ifneq ($(shell uname -r | grep -c "^2\.6\.*"), 1)
> -
> -MAKE_TARGETS		:=
> -
> -.PHONY: no-all-install
> -
> -all install: no-all-install
> -
> -no-all-install:
> -	@echo "Warning: Kernel doesn't support this test case"
> -
> -endif
> -
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
