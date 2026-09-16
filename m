Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC70C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 08:48:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 466493E76BB
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 10:48:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 408793E16F1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 10:48:26 +0200 (CEST)
Received: from mta0.migadu.com (out-55.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::37])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF76C1A00357
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 10:48:24 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Ngus7RTQ+88STj5++aeWJ08R8vlRN6iSsRrX4TJetcc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789548503; v=1; x=1790153303;
 b=SWlouoUPSA9hFptTD9W7xE41GRVohT3799nHe5f9yeWxTcDCQiDHjxeEccCcapR6hq5gzj62
 raq9TNKMDpC+trRLQafJzz6IW3LUzc+Mq5Lf577mZdGaysWb+GV8OqVirLnCUz0MzJPQVRSBK0t
 wdZtLmHhmIhtU9cdMLyhxfZU=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 171027cb7dda3735;
 Wed, 16 Sep 2026 08:48:23 +0000
X-Mizu-Trace-ID: 171027cb7dda3735
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 16:48:20 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Message-ID: <aqpX1P1bNIEol4yt@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 tsahu@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
References: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap10: Account for memory policy in counter
 checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: tsahu@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Huaisheng,

This patch make sense, minor comments inline below:

>  .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 73 ++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> index 5b5577a0e..6d1cd6241 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> @@ -13,6 +13,9 @@
>   */
> 
>  #define _GNU_SOURCE
> +#include <errno.h>
> +#include <linux/mempolicy.h>
> +#include <stdlib.h>
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <sys/mount.h>
> @@ -21,8 +24,10 @@
>  #include <sys/types.h>
> 
>  #include "hugetlb.h"
> +#include "lapi/syscalls.h"
> 
>  #define MNTPOINT "hugetlbfs/"
> +#define ULONG_BITS (sizeof(unsigned long) * CHAR_BIT)
> 
>  static long hpage_size;
>  static int private_resv;
> @@ -48,6 +53,63 @@ static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
>  	*surp = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
>  }
> 
> +static int node_isset(unsigned long node, const unsigned long *nodemask)
> +{
> +	return nodemask[node / ULONG_BITS] & (1UL << (node % ULONG_BITS));
> +}
> +
> +static unsigned long read_allowed_free_hugepages(void)
> +{
> +	char path[PATH_MAX];
> +	size_t mask_size = getpagesize();
> +	unsigned long allowed_free = 0;
> +	unsigned long maxnode = mask_size * CHAR_BIT;
> +	unsigned long *policy_nodemask;
> +	unsigned long *cpuset_nodemask;
> +	unsigned long node, node_free;
> +	int mode;
> +
> +	policy_nodemask = SAFE_CALLOC(1, mask_size);
> +	cpuset_nodemask = SAFE_CALLOC(1, mask_size);
> +
> +	if (syscall(__NR_get_mempolicy, &mode, policy_nodemask,
> +		    maxnode, NULL, 0)) {
> +		if (errno == ENOSYS) {
> +			allowed_free = prev_free;
> +			goto out;
> +		}
> +		tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
> +	}
> +
> +	if (syscall(__NR_get_mempolicy, NULL, cpuset_nodemask,
> +		    maxnode, NULL, MPOL_F_MEMS_ALLOWED))
> +		tst_brk(TBROK | TERRNO,
> +			"get_mempolicy(MPOL_F_MEMS_ALLOWED) failed");
> +
> +	mode &= ~MPOL_MODE_FLAGS;
> +	for (node = 0; node < maxnode; node++) {
> +		if (!node_isset(node, cpuset_nodemask))
> +			continue;
> +		if (mode == MPOL_BIND && !node_isset(node, policy_nodemask))
> +			continue;
> +
> +		snprintf(path, sizeof(path),
> +			 "/sys/devices/system/node/node%lu/hugepages/"
> +			 "hugepages-%ldkB/free_hugepages",
> +			 node, hpage_size / 1024);
> +		if (access(path, R_OK))
> +			continue;
> +
> +		SAFE_FILE_SCANF(path, "%lu", &node_free);
> +		allowed_free += node_free;
> +	}
> +
> +out:
> +	free(policy_nodemask);
> +	free(cpuset_nodemask);
> +	return allowed_free;
> +}
> +
>  static int kernel_has_private_reservations(void)
>  {
>  	int fd;
> @@ -178,10 +240,14 @@ out:
> 
>  static int map_(int s, int hpages, int flags, char *desc, int line)
>  {
> +	unsigned long allowed_free = 0;
>  	long et, ef, er, es;

> +	int creates_reservation = (flags & MAP_SHARED) || private_resv;

Maybe we can move this definition into setup() and then replace all the
reservation syntax globally.

> 
>  	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0, 0600);
>  	map_size[s] = hpages * hpage_size;
> +	if (creates_reservation)
> +		allowed_free = read_allowed_free_hugepages();
>  	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
>  				map_fd[s], 0);
>  	touched[s] = 0;
> @@ -201,11 +267,16 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
>  	 * mappings behave like MAP_SHARED at mmap time.  Otherwise,
>  	 * no counter updates will occur.
>  	 */
> -	if ((flags & MAP_SHARED) || private_resv) {
> +	if (creates_reservation) {
>  		unsigned long shortfall = 0;
> 
>  		if (hpages + prev_resv > prev_free)
>  			shortfall = hpages - prev_free + prev_resv;
> +
> +		if ((unsigned long)hpages > allowed_free)
> +			shortfall = MAX(shortfall,
> +					(unsigned long)hpages - allowed_free);
> +
>  		et += shortfall;
>  		ef += shortfall;
>  		er += hpages;
> --
> 2.52.0

Aside from this patch, my test encountered new failures on a four-node system.
Without your patch, the surplus failure can be reproduced consistently, so I
suspect it's a different issue.

...
hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Total: expected 1, actual 2
hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Free: expected 1, actual 2
hugemmap10.c:402: TFAIL: While doing munmap shared after touch: Bad HugePages_Surp: expected 0, actual 1


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
