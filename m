Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YTSpC-0000Dz-88
	for ltp-list@lists.sourceforge.net; Thu, 05 Mar 2015 10:16:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YTSpA-0007XC-Co
	for ltp-list@lists.sourceforge.net; Thu, 05 Mar 2015 10:16:14 +0000
Message-ID: <54F82CE1.7000702@redhat.com>
Date: Thu, 05 Mar 2015 11:16:01 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1425369771-30604-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1425369771-30604-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] tst_virt: refactor the virt guest test code
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
Cc: LTP <ltp-list@lists.sourceforge.net>

On 03/03/2015 09:02 AM, Wanlong Gao wrote:
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  include/test.h |  6 ++--
>  lib/tst_virt.c | 99 +++++++++++++++++++++++++++++++++++++---------------------
>  2 files changed, 67 insertions(+), 38 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index f45bb36..abee23c 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -53,8 +53,10 @@
>  #include "tst_timer.h"
>  
>  /* virt types for tst_is_virt() */
> -#define VIRT_XEN	1	/* xen dom0/domU */
> -#define VIRT_KVM	2	/* only default virtual CPU */
> +#define VIRT_XEN	1
> +#define VIRT_KVM	2
> +#define VIRT_VMWARE	4
> +#define VIRT_ALL	7

Why do these resemble bit flags? Can any two of the technologies be
active at the same time while being detect-able (eg. not using nested
virt)? Or is it just for convenience when specifying flags to the
tst_virt() function?

Also, I intentionally didn't include VIRT_ALL, because it would be
confusing and wrong at least for the current use case (time-based test)
 - the use case disables a test on platform with unstable/unpredictable
scheduling delays, which - amongst all the vendor-provided HW power
thingies - includes *some* virt technologies. Specifically QEMU and xen,
possibly vmware, likely System-Z "virtualization", but probably not
CPU protected mode or IOMMU "virtualization".

Which kind of leads to the question of how we define "virtualization",
what should fall under VIRT_ALL and whether it can be some day reliably
used by tests - IMHO there can't be any VIRT_ALL, simply because there's
(currently) no criteria on what VIRT_* exactly means.

(note that this check is currently really just a best guess as the only
 test case using it can still work under virtualization while fail on
 physical hardware due to "power saving" or on System-Z due to hardware
 over-provisioning)

>  
>  /*
>   * Ensure that NUMSIGS is defined.
> diff --git a/lib/tst_virt.c b/lib/tst_virt.c
> index 87f73dc..ae40a3b 100644
> --- a/lib/tst_virt.c
> +++ b/lib/tst_virt.c
> @@ -22,55 +22,82 @@
>   * 02110-1301, USA.
>   */
>  
> -#include <unistd.h>
> +/* This program was suggested by Gleb Natapov and written by Paolo
> + * Bonzini, with a few modifications by Richard W.M. Jones.
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
>  #include "test.h"
> -#include "safe_macros.h"
>  
> -static int is_kvm(void)
> +#if defined(__i386__) || defined(__x86_64__)
> +
> +static unsigned int cpuid(unsigned int eax, char *sig)
>  {
> -	FILE *cpuinfo;
> -	char line[64];
> -	int found;
> -
> -	/* this doesn't work with custom -cpu values, since there's
> -	 * no easy, reasonable or reliable way to work around those */
> -	cpuinfo = SAFE_FOPEN(NULL, "/proc/cpuinfo", "r");
> -	found = 0;
> -	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
> -		if (strstr(line, "QEMU Virtual CPU")) {
> -			found = 1;
> -			break;
> -		}
> -	}
> +	unsigned int *sig32 = (unsigned int *)sig;
>  
> -	SAFE_FCLOSE(NULL, cpuinfo);
> -	return found;
> +	asm volatile (
> +	"xor %%ebx, %%ebx; cpuid"
> +	: "=a" (eax), "=b" (sig32[0]), "=c" (sig32[1]), "=d" (sig32[2])
> +	: "0" (eax));
> +	sig[12] = 0;
> +
> +	return eax;
>  }
>  
> -static int is_xen(void)
> +static char *cpu_sig(void)
>  {
> -	char hypervisor_type[3];
> +	char *sig = malloc(13);
> +	unsigned int base = 0x40000000, leaf = base;
> +	unsigned int max_entries;
>  
> -	if (access("/proc/xen", F_OK) == 0)
> -		return 1;
> +	memset(sig, 0, 13);
> +	max_entries = cpuid(leaf, sig);
>  
> -	if (access("/sys/hypervisor/type", F_OK) == 0) {
> -		SAFE_FILE_SCANF(NULL, "/sys/hypervisor/type", "%3s",
> -			hypervisor_type);
> -		return strncmp("xen", hypervisor_type,
> -			sizeof(hypervisor_type)) == 0;
> +	/* Most hypervisors only have information in leaf 0x40000000, but
> +	 * upstream Xen contains further leaf entries (in particular when
> +	 * used with Viridian [HyperV] extensions).  CPUID is supposed to
> +	 * return the maximum leaf offset in %eax, so that's what we use,
> +	 * but only if it looks sensible.
> +	 */
> +	if (max_entries > 3 && max_entries < 0x10000) {
> +		for (leaf = base + 0x100; leaf <= base + max_entries; leaf += 0x100) {
> +			memset(sig, 0, 13);
> +			cpuid(leaf, sig);
> +		}
>  	}
>  
> -	return 0;
> +	return sig;
>  }
>  
> +#else /* !i386, !x86_64 */
> +
> +static char *cpu_sig (void)
> +{
> +	/* nothing for other architectures */
> +	return NULL;

QEMU supports a boatload of host architectures and at least ARM is
supported by KVM accel (with possibly more in the future), xen seems
to support at least PowerPC (and others?) as well.

> +}
> +
> +#endif
> +
> +
>  int tst_is_virt(int virt_type)
>  {
> -	switch (virt_type) {
> -	case VIRT_XEN:
> -		return is_xen();
> -	case VIRT_KVM:
> -		return is_kvm();
> -	}
> -	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
> +	char *string;
> +	int virt = 0;
> +
> +	string = cpu_sig();
> +
> +	if (!string) return 0;
> +
> +	if (strncmp(string, "XenVMMXenVMM", 12) == 0)
> +		virt |= VIRT_XEN;
> +	else if (strncmp(string, "VMwareVMware", 12) == 0)
> +		virt |= VIRT_VMWARE;
> +	else if (strncmp(string, "KVMKVMKVM", 12) == 0)
> +		virt |= VIRT_KVM;
> +
> +	free(string);
> +
> +	return virt_type & virt;
>  }
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
