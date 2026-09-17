Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3887EC982D0
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 08:40:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 115293E74E1
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 10:40:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2986B3E259F
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 10:40:29 +0200 (CEST)
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com
 [115.124.28.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF7B0600A43
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 10:40:25 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.148744-0.0249691-0.826287;
 FP=12056836429288166905|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037022039; MF=yehuaisheng@open-hieco.net; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.jFk-bLp_1789634418; 
Received: from 172.18.22.180(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jFk-bLp_1789634418 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 17 Sep 2026 16:40:21 +0800
Message-ID: <7e1e36aa-397a-40fc-a208-8ff9b19c6540@open-hieco.net>
Date: Thu, 17 Sep 2026 16:40:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tsahu@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it, li.wang@linux.dev
References: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
 <aqpX1P1bNIEol4yt@linux.dev>
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
In-Reply-To: <aqpX1P1bNIEol4yt@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 9/16/2026 16:48, Li Wang wrote:
> Hi Huaisheng,
>
> This patch make sense, minor comments inline below:
>
>>   .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 73 ++++++++++++++++++-
>>   1 file changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
>> index 5b5577a0e..6d1cd6241 100644
>> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
>> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
>> @@ -13,6 +13,9 @@
>>    */
>>
>>   #define _GNU_SOURCE
>> +#include <errno.h>
>> +#include <linux/mempolicy.h>
>> +#include <stdlib.h>
>>   #include <unistd.h>
>>   #include <stdio.h>
>>   #include <sys/mount.h>
>> @@ -21,8 +24,10 @@
>>   #include <sys/types.h>
>>
>>   #include "hugetlb.h"
>> +#include "lapi/syscalls.h"
>>
>>   #define MNTPOINT "hugetlbfs/"
>> +#define ULONG_BITS (sizeof(unsigned long) * CHAR_BIT)
>>
>>   static long hpage_size;
>>   static int private_resv;
>> @@ -48,6 +53,63 @@ static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
>>   	*surp = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
>>   }
>>
>> +static int node_isset(unsigned long node, const unsigned long *nodemask)
>> +{
>> +	return nodemask[node / ULONG_BITS] & (1UL << (node % ULONG_BITS));
>> +}
>> +
>> +static unsigned long read_allowed_free_hugepages(void)
>> +{
>> +	char path[PATH_MAX];
>> +	size_t mask_size = getpagesize();
>> +	unsigned long allowed_free = 0;
>> +	unsigned long maxnode = mask_size * CHAR_BIT;
>> +	unsigned long *policy_nodemask;
>> +	unsigned long *cpuset_nodemask;
>> +	unsigned long node, node_free;
>> +	int mode;
>> +
>> +	policy_nodemask = SAFE_CALLOC(1, mask_size);
>> +	cpuset_nodemask = SAFE_CALLOC(1, mask_size);
>> +
>> +	if (syscall(__NR_get_mempolicy, &mode, policy_nodemask,
>> +		    maxnode, NULL, 0)) {
>> +		if (errno == ENOSYS) {
>> +			allowed_free = prev_free;
>> +			goto out;
>> +		}
>> +		tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
>> +	}
>> +
>> +	if (syscall(__NR_get_mempolicy, NULL, cpuset_nodemask,
>> +		    maxnode, NULL, MPOL_F_MEMS_ALLOWED))
>> +		tst_brk(TBROK | TERRNO,
>> +			"get_mempolicy(MPOL_F_MEMS_ALLOWED) failed");
>> +
>> +	mode &= ~MPOL_MODE_FLAGS;
>> +	for (node = 0; node < maxnode; node++) {
>> +		if (!node_isset(node, cpuset_nodemask))
>> +			continue;
>> +		if (mode == MPOL_BIND && !node_isset(node, policy_nodemask))
>> +			continue;
>> +
>> +		snprintf(path, sizeof(path),
>> +			 "/sys/devices/system/node/node%lu/hugepages/"
>> +			 "hugepages-%ldkB/free_hugepages",
>> +			 node, hpage_size / 1024);
>> +		if (access(path, R_OK))
>> +			continue;
>> +
>> +		SAFE_FILE_SCANF(path, "%lu", &node_free);
>> +		allowed_free += node_free;
>> +	}
>> +
>> +out:
>> +	free(policy_nodemask);
>> +	free(cpuset_nodemask);
>> +	return allowed_free;
>> +}
>> +
>>   static int kernel_has_private_reservations(void)
>>   {
>>   	int fd;
>> @@ -178,10 +240,14 @@ out:
>>
>>   static int map_(int s, int hpages, int flags, char *desc, int line)
>>   {
>> +	unsigned long allowed_free = 0;
>>   	long et, ef, er, es;
>> +	int creates_reservation = (flags & MAP_SHARED) || private_resv;
> Maybe we can move this definition into setup() and then replace all the
> reservation syntax globally.

Many thanks for comments.
Good suggestion, I will resend V2 later.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
