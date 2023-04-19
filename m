Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85093C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 11:44:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B6D3CC015
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 13:44:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50D6A3C1DA6
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:44:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E479200B8B
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:44:13 +0200 (CEST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33JAaure018450; Wed, 19 Apr 2023 11:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=NOxmAmY0XShBjuPi3nCky3NB708+zbrJLpNq0YTDDJA=;
 b=sn0/MelN0vxVRGNMlgbIgUvtklRloAM3bkYR+nf6ywsRuQfBb/FW3/TzYdFUVY0pXRYm
 BdXue3XFGiuWAz61pbvfo+CtAdGktwkRbjTZSMg9wN1UEHEQDzxD4TqoAnGcYh3ol862
 b1J+RDgNnZziBZPv/z6Daq0U9md5UFQThiFcmuuwLV2kXO76dAp8Wi0t0H8nNJrKp6+7
 TjA1F6KJXWVzBomoDKSWR77lx7hl6etyQMRpzDDNLF6VtWVFma+cJ58Yb5Puf04+LanB
 JzoxZ5khgu7M4ohdTGNAk7tef6WY1gRsgK4yg6icTMc53PpPr1m6JztHVzXZEygtRXpL tw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q20sbydcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 11:44:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33IKe7R6019564;
 Wed, 19 Apr 2023 11:44:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pyk6fjq0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Apr 2023 11:44:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 33JBi6eJ28115508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Apr 2023 11:44:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BC1820040;
 Wed, 19 Apr 2023 11:44:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BD7820043;
 Wed, 19 Apr 2023 11:44:04 +0000 (GMT)
Received: from tarunpc (unknown [9.124.31.73])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Apr 2023 11:44:04 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <ZD0ZQOfKScJwZuVD@yuki>
References: <20230413122045.904933-1-tsahu@linux.ibm.com>
 <ZD0ZQOfKScJwZuVD@yuki>
Date: Wed, 19 Apr 2023 17:14:02 +0530
Message-ID: <87ttxct7ul.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0x1fCzNQZzA2UCiZZgsSTpS97xvB6nOc
X-Proofpoint-ORIG-GUID: 0x1fCzNQZzA2UCiZZgsSTpS97xvB6nOc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=921 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190103
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Hugetlb: Test to detect bug with freeing
 gigantic hugetlb pages
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

Thanks for looking at it.
I agree to your comments, sent the v3. Also second commit tag was wrong.
I changed it too.

~Tarun

> Hi!
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
>> +	if (FILE_PRINTF(g_hpage_path, "%d", 1))
>> +		tst_brk(TCONF, "Can't update the gigantic hugepages.");
>> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", 0);
>> +
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
>> +	unsigned long hpage_size;
>> +
>> +	dir = SAFE_OPENDIR(PATH_GIGANTIC_HUGEPAGE);
>                                  ^
> 				 This is very minor, but there is
> 				 nothing gigantic about the path, that's
> 				 just sysfs hugepates directory, so I
> 				 suppose that it should be just
> 				 PATH_HUGEPAGE
>
>> +	while ((ent = SAFE_READDIR(dir))) {
>> +		if (strstr(ent->d_name, "hugepages-") != NULL) {
>
> Isn't the strstr() here reduntant?
>
> I as far as I can tell if the line in sscanf() will not match the call
> will simply return 0.
>
>> +			if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
>> +				is_hugetlb_gigantic(hpage_size * 1024)) {
>> +				sprintf(g_hpage_path, "%s/%s/%s", PATH_GIGANTIC_HUGEPAGE,
>> +						ent->d_name, "nr_hugepages");
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	if (!g_hpage_path[0])
>> +		tst_brk(TCONF, "Gigantic hugepages not supported");
>> +
>> +	SAFE_CLOSEDIR(dir);
>> +	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (g_hpage_path[0])
>> +		SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tags = (struct tst_tag[]) {
>> +	    {"linux-git", "ba9c1201beaa"},
>> +	    {"linux-git", "7118fc2906e9"},
>                             ^
> 			    This has appears to be wrong. Shouldn't the
> 			    last digit be 2 instead of 9?
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
