Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A398C77B61
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 10:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922453CC4A6
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 12:50:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD8333CAD01
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 12:50:00 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C784C140051C
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 12:49:58 +0200 (CEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33D9xVw7014160; Thu, 13 Apr 2023 10:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=ljJdmZbAOsTU3oh98PL2f/SsGh5M7DVTphX2qASjQyY=;
 b=p6/i44UgYKBl0p6+ty+EjGpSSUa2VEVdy9d4+ooiGu/hG23bm6PHWRk+H0rgGaRSbnYQ
 vQ5qKv7DQ0HQziJCwhxdTOyH11NRRnW6/Fb6Au0KMSgpXglg8YnZ544HS8H1yv1nzVCr
 QftGNfOCeNAMHTcEL28gH0+EPJxahfGPdRGezasHRZVXyCwNPG+PY+n3a74KJFaBYOgk
 DtdwO4/yx/hro3lqwhsiMLmzj2jHa7oOsocAjkQfZSRWC7Qjjx7mySGoNcGEBBuLkeAn
 RD4qZ/8hGoA4xbANFlNyTseqDEd6i2bXsNG6XVQ7Vtw70rqsFPBAJ3JoLdkXGNfONa9z Cg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxckd1sjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 10:49:56 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33D26Tlt004482;
 Thu, 13 Apr 2023 10:49:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m1aygf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Apr 2023 10:49:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 33DAnpE148235048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Apr 2023 10:49:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AE5A20043;
 Thu, 13 Apr 2023 10:49:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042D620040;
 Thu, 13 Apr 2023 10:49:50 +0000 (GMT)
Received: from tarunpc (unknown [9.124.31.73])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 13 Apr 2023 10:49:49 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <ZDfJzRxVW4V7ctbc@yuki>
References: <20230413090753.883953-1-tsahu@linux.ibm.com>
 <ZDfJzRxVW4V7ctbc@yuki>
Date: Thu, 13 Apr 2023 16:19:48 +0530
Message-ID: <874jpkhx9v.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JhXmYFuLNKkdYUWC6ZjVqVjJBcDtuXN7
X-Proofpoint-GUID: JhXmYFuLNKkdYUWC6ZjVqVjJBcDtuXN7
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_06,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304130095
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Hugetlb: Test to detect bug with freeing gigantic
 hugetlb pages
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
Cc: piyushs@linux.ibm.com, aneesh.kumar@linux.ibm.com, rpalethorpe@suse.com,
 geetika@linux.ibm.com, jaypatel@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Cyril,
Thanks for reviewing. I posted my comments inline.
Will soon send v2.

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * Before kernel version 5.10-rc7, there was a bug that resulted in a "Bad Page
>> + * State" error when freeing gigantic hugepages. This happened because the
>> + * struct page entry compound_nr, which overlapped with page->mapping in the
>> + * first tail page, was not cleared, causing the error. To ensure that this
>> + * issue does not reoccur as struct page keeps changing and some fields are
>> + * managed by folio, this test checks that freeing gigantic hugepages does not
>> + * produce the above-mentioned error.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <dirent.h>
>> +
>> +#include <stdio.h>
>> +
>> +#include "hugetlb.h"
>> +
>> +#define PATH_GIGANTIC_HUGEPAGE "/sys/kernel/mm/hugepages"
>> +#define GIGANTIC_MIN_ORDER 10
>> +
>> +static int org_g_hpages;
>> +static char g_hpage_path[4096];
>> +
>> +static void run_test(void)
>> +{
>> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", 1);
>
> I suppose this may still fail if there is not enough memory or the
> memory is fragmented, right? I suppose that SAFE_FILE_PRINTF() will
> cause TBROK here, right?
>
> Maybe we should just use FILE_PRINTF() and ignore the errors.

 I understand that it doesn't sound good that test is broken, when system
 is not in state to allocate the gigantic pages, I will break it with
 TCONF.

I agree to below comments. I will update them in v2.


~ Tarun
>
>> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", 0);
>
>
>> +	if (tst_taint_check())
>> +		tst_res(TFAIL, "Freeing Gigantic pages resulted in Bad Page State bug.");
>> +	else
>> +		tst_res(TPASS, "Successfully freed the gigantic hugepages");
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	DIR *dir;
>> +	struct dirent *ent;
>> +	char *hpage_size_str;
>> +	unsigned long hpage_size;
>> +
>> +	dir = SAFE_OPENDIR(PATH_GIGANTIC_HUGEPAGE);
>> +	while ((ent = SAFE_READDIR(dir)) != NULL) {
>                                              ^
> 					     The != NULL is redundant
>
>> +		if (strstr(ent->d_name, "hugepages-") != NULL) {
>> +			hpage_size_str = ent->d_name + strlen("hugepages-");
>> +			hpage_size = atoi(hpage_size_str) * 1024;
>
> Can we just do:
>
> 	if ((sscanf(ent->d_name, "hugepages-%lu", &hpage_size) == 1) &&
> 	    is_hugetlb_gigantic(hpage_size * 1024)) {
> 		sprintf(...);
> 	}
>
>> +			if (is_hugetlb_gigantic(hpage_size)) {
>> +				sprintf(g_hpage_path, "%s/%s/%s",
>> +						PATH_GIGANTIC_HUGEPAGE, ent->d_name, "nr_hugepages");
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	SAFE_CLOSEDIR(dir);
>
> We should handle the case that there were no large hugepages found on
> the system. On one of my machines:
>
> # ls /sys/kernel/mm/hugepages/
> hugepages-2048kB
> #
>
> I suppose:
>
> 	if (!g_hpage_path[0])
> 		tst_brk(TCONF, "Gigantic hugepages not supported");
>
>
>> +	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tags = (struct tst_tag[]) {
>> +	    {"linux-git", "ba9c1201beaa"},
>> +	    {"linux-git", "7118fc2906e9"},
>> +	    {}
>> +	},
>> +	.needs_root = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run_test,
>> +	.taint_check = TST_TAINT_B,
>> +};
>> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
>> index 241dab708..34fe08c24 100644
>> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
>> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
>> @@ -39,6 +39,12 @@
>>  # endif
>>  #endif
>>  
>> +/* Check if hugetlb page is gigantic */
>> +static inline int is_hugetlb_gigantic(unsigned long hpage_size)
>> +{
>> +	return (hpage_size / getpagesize()) >> 11;
>> +}
>> +
>>  /*
>>   * to get the lower nine permission bits
>>   * from shmid_ds.ipc_perm.mode
>> -- 
>> 2.31.1
>> 
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
