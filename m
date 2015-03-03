Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1YSc6M-0002Ez-BW
	for ltp-list@lists.sourceforge.net; Tue, 03 Mar 2015 01:58:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YSc6K-0003Sp-W8
	for ltp-list@lists.sourceforge.net; Tue, 03 Mar 2015 01:58:26 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t231vP7d013069
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Mar 2015 09:57:25 +0800
Message-ID: <54F51500.7030004@cn.fujitsu.com>
Date: Tue, 3 Mar 2015 09:57:20 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1425346506-2271-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1425346506-2271-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_virt: rename is_kvm to is_qemu
Reply-To: gaowanlong@cn.fujitsu.com
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 03/03/2015 09:35 AM, Wei,Jiangang wrote:
> KVM guest is on top of QEMU, and KVM is used by QEMU to
> provide hardware-accelerated virtualization.
> Although there is an association between them,
> difference is very obvious.
> 
> The function named is_kvm() is only can be applied to
> determine QEMU, which couldn't distinguish QEMU and QEMU-KVM.
> In other words,
> Its' name doesn't match its' content and function.
> so is_qemu() more reasonable.

NACK, KVM is the name in the same stand of Xen, while qemu
is just a client program. You are making wrong sense to others.

Thanks,
Wanlong Gao

> 
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  include/test.h                                    | 2 +-
>  lib/tst_virt.c                                    | 6 +++---
>  testcases/kernel/syscalls/getrusage/getrusage04.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index f45bb36..12f913b 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -54,7 +54,7 @@
>  
>  /* virt types for tst_is_virt() */
>  #define VIRT_XEN	1	/* xen dom0/domU */
> -#define VIRT_KVM	2	/* only default virtual CPU */
> +#define VIRT_QEMU	2	/* only default virtual CPU */
>  
>  /*
>   * Ensure that NUMSIGS is defined.
> diff --git a/lib/tst_virt.c b/lib/tst_virt.c
> index 87f73dc..d0d701e 100644
> --- a/lib/tst_virt.c
> +++ b/lib/tst_virt.c
> @@ -26,7 +26,7 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  
> -static int is_kvm(void)
> +static int is_qemu(void)
>  {
>  	FILE *cpuinfo;
>  	char line[64];
> @@ -69,8 +69,8 @@ int tst_is_virt(int virt_type)
>  	switch (virt_type) {
>  	case VIRT_XEN:
>  		return is_xen();
> -	case VIRT_KVM:
> -		return is_kvm();
> +	case VIRT_QEMU:
> +		return is_qemu();
>  	}
>  	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
>  }
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
> index c2f34f4..f34f0c1 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage04.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
> @@ -200,7 +200,7 @@ static void setup(void)
>  {
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> -	if (tst_is_virt(VIRT_XEN) || tst_is_virt(VIRT_KVM))
> +	if (tst_is_virt(VIRT_XEN) || tst_is_virt(VIRT_QEMU))
>  		tst_brkm(TCONF, NULL, "This testcase is not supported on this"
>  		        " virtual machine.");
>  
> 


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
