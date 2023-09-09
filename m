Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A0EE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 08:16:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE0393CB659
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 10:16:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4F133CB527
 for <ltp@lists.linux.it>; Sat,  9 Sep 2023 05:29:34 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B8C4420013B
 for <ltp@lists.linux.it>; Sat,  9 Sep 2023 05:29:32 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3893HOYl001723 for <ltp@lists.linux.it>; Sat, 9 Sep 2023 03:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7mZb5JoH2rJdNz71lIVlufAvPZe6H2Mo0LBHofrk1/g=;
 b=p8i8d3k1A9mAXuaAgNjRlG674oQjKnGJxmYyMIch7tt0ZFMagQsDXiG3X8fwvTTM01XD
 O6ROQ8m7RxqXsCNgqOU3ACTKjt5VpHNgPmWf/4z5A1fdcuWxCu6OC4l6hj1BVvfkt+1d
 sM0+0Rghbeuj9YptfK5TZqRCMX9i3bfe+lR9evaQK+ClIUGZV3Lupll7MTUyWH/4mg2W
 S7nNMTw2hew+UzNBA+b82pmxvg32rfZcMFuYSdBlFSDERfZVeT0fk/wB0Nl2BCLekeuk
 OKdgs7Y2fOdf+H4BQWko4ONSViXn4ZZN21HnlZX16mOtqPWItFGCMJRd83tOvw8XAbVe dQ== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0gnu04qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 09 Sep 2023 03:29:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38939prT011145 for <ltp@lists.linux.it>; Sat, 9 Sep 2023 03:29:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj32g6n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 09 Sep 2023 03:29:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3893TRoe22676048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 Sep 2023 03:29:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 713D620043;
 Sat,  9 Sep 2023 03:29:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0FF52004B;
 Sat,  9 Sep 2023 03:29:26 +0000 (GMT)
Received: from [9.43.119.39] (unknown [9.43.119.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  9 Sep 2023 03:29:26 +0000 (GMT)
Message-ID: <6536e4fa-b73a-88c6-d4f7-f5374095003f@linux.ibm.com>
Date: Sat, 9 Sep 2023 08:59:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Content-Language: en-US
To: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>, ltp@lists.linux.it
References: <20230908121135.245296-1-sachinpb@linux.vnet.ibm.com>
From: Geetika M <geetika@linux.ibm.com>
In-Reply-To: <20230908121135.245296-1-sachinpb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L5zfxh2t-o-rSvbJfebTWlxRz-GN7-4a
X-Proofpoint-ORIG-GUID: L5zfxh2t-o-rSvbJfebTWlxRz-GN7-4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090026
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 11 Sep 2023 10:16:11 +0200
Subject: Re: [LTP] [PATCH] Migrating the
 libhugetlbfs/testcases/shm-gettest.c test
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


Hello Sachin!

I think it is more fitting to add this testcase to testcases/kernel/mem/hugetlb/hugeshmget instead of /kernel/mem/hugetlb/hugemmap.

> Test Description: This testcase creates shared memory segments
> backed by hugepages, writes  specific patterns to each segment,
> verifies pattern and detaches a shared memory segments in a loop.
>
> This looping test was added to verify the functionality of
> large page backed shared memory segments. A segment is created,
> written, verified, and detached a specified number of times.
>
> Signed-off-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> ---
>   runtest/hugetlb                               |  1 +
>   testcases/kernel/mem/.gitignore               |  1 +
>   .../kernel/mem/hugetlb/hugemmap/hugepage35.c  | 93 +++++++++++++++++++
>   3 files changed, 95 insertions(+)
>   create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 299c07ac9..6bebc706c 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>   hugemmap30 hugemmap30
>   hugemmap31 hugemmap31
>   hugemmap32 hugemmap32
> +hugemmap35 hugemmap35
>   hugemmap05_1 hugemmap05 -m
>   hugemmap05_2 hugemmap05 -s
>   hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 7258489ed..bbc029716 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -34,6 +34,7 @@
>   /hugetlb/hugemmap/hugemmap30
>   /hugetlb/hugemmap/hugemmap31
>   /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap35
>   /hugetlb/hugeshmat/hugeshmat01
>   /hugetlb/hugeshmat/hugeshmat02
>   /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c b/testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c
> new file mode 100644
> index 000000000..fb603b4ef
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugepage35.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test Name: shm-gettest.c
> + *
> + * This testcase creates shared memory segments backed by hugepages,
> + * writes specific patterns to each segment, verifies pattern,
> + * and detaches a shared memory segments in a loop.
> + * It ensures that the hugepage backed shared memory functionalities
> + * works correctly by validating the data written to segment.
> + */
> +
> +#include "hugetlb.h"
> +#include "tst_safe_sysv_ipc.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define NR_HUGEPAGES 4
> +
> +static long hpage_size;
> +static unsigned int iter;
> +static int shmid = -1, key = -1;
> +
> +static void do_shmtest(size_t size) {
> +        size_t i, j;
> +        char pattern;
> +        char *shmaddr;
> +
> +        shmid = SAFE_SHMGET(key, size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
> +        tst_res(TINFO, "shmid: 0x%x\n", shmid);
> +
> +        shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
> +        tst_res(TINFO, "shmaddr: %p\n", shmaddr);
> +
> +        for (i = 0; i < NR_HUGEPAGES; i++) {
> +                pattern = 65 + (i % 26);
> +                tst_res(TINFO, "Touching %p with %c\n",
> +                                shmaddr + (i * hpage_size), pattern);
> +                memset(shmaddr + (i * hpage_size), pattern, hpage_size);
> +        }
> +
> +        for (i = 0; i < NR_HUGEPAGES; i++) {
> +                pattern = 65 + (i % 26);
> +                tst_res(TINFO, "Verifying %p\n", (shmaddr + (i * hpage_size)));
> +                for (j = 0; j < (size_t)hpage_size; j++)
> +                        if (*(shmaddr + (i * hpage_size) + j) != pattern)
> +                                tst_res(TFAIL, "Verifying the segment failed."
> +                                        "Got %c, expected %c",
> +                                        *(shmaddr + (i * hpage_size) + j),
> +                                        pattern);
> +        }
> +        SAFE_SHMDT((const void *)shmaddr);
> +}
> +
> +static void run_test(void)
> +{
> +        int i;
> +        iter = 2;
> +        size_t size;
> +        size = NR_HUGEPAGES * hpage_size;
> +        for (i=0; i < (int)iter; i++)
> +                do_shmtest(size);
> +        tst_res(TPASS, "Successfully tested shared memory segment operations "
> +                        "backed by hugepages");
> +}
> +
> +static void setup(void)
> +{
> +        hpage_size = tst_get_hugepage_size();
> +        tst_res(TINFO, "hugepage size is  %ld", hpage_size);
> +}
> +
> +static void cleanup(void)
> +{
> +        if (shmid >= 0)
> +                // Remove the shared memory segment
> +                SAFE_SHMCTL(shmid, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +        .needs_root = 1,
> +        .mntpoint = MNTPOINT,
> +        .needs_hugetlbfs = 1,
> +        .setup = setup,
> +        .cleanup = cleanup,
> +        .test_all = run_test,
> +        .hugepages = {NR_HUGEPAGES, TST_NEEDS},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
