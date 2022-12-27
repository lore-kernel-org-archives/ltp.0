Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59752C4332F
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 16:01:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D34103CB83A
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 17:01:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E21BB3CB80A
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 17:01:13 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C2C36006E0
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 17:01:10 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BRFu9kO040042; Tue, 27 Dec 2022 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=SBlp7/bUlMn/Fo6IoijzYA3NOq9j2Pgux7DL/XHx42M=;
 b=ibjm97QAjCjgTvOgI1p4zNmNWSuc21uHTYu0FmiyOPaIliGXh9s9iqV0JklCEYUDCzUn
 IfP0XrSMdhDJeyB848F1MWLZOxt/Tsixv96E0KiKSGHjQMGzqTsRolTm2MT7YUDILyYL
 /9vri4qU5gW1LWAq60rd55pFuiP+WHjZljrsoonE1gxwq5RLrnkNQHWvKZxLs3JKKECg
 YsYkaFsFu/rs0lHrWtJW6wRdQzEMKL6B2xMa5HurW/3XOdl+E/7LHHz8IgQwSEIMOZFt
 mAM4BBNj2lK1CuTtuUZ5coGCIRnGB41xwj7XLIYQQb51vpuuQAKb7TvMSOa9595xBQZM xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mr3skr2wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 16:01:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BRG0QJR013847;
 Tue, 27 Dec 2022 16:01:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mr3skr2vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 16:01:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRCBF7m003970;
 Tue, 27 Dec 2022 16:01:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mnrpfkrh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 16:01:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BRG11rK39780834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Dec 2022 16:01:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7684120040;
 Tue, 27 Dec 2022 16:01:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54D1F2004D;
 Tue, 27 Dec 2022 16:00:58 +0000 (GMT)
Received: from tarunpc (unknown [9.43.41.141])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 27 Dec 2022 16:00:58 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
In-Reply-To: <CAEemH2eXzTP4m0v8bFjkA4ShKwzMppJzh1aa43QsZbp5NUf6Fw@mail.gmail.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-5-tsahu@linux.ibm.com>
 <CAEemH2eXzTP4m0v8bFjkA4ShKwzMppJzh1aa43QsZbp5NUf6Fw@mail.gmail.com>
Date: Tue, 27 Dec 2022 21:30:54 +0530
Message-ID: <87cz84kf9l.fsf@tarunpc.mail-host-address-is-not-set>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t-LA67RKgGmGybZz6RHQ65ImQz60yY78
X-Proofpoint-GUID: GkV7f53bUqr42CfZq5oW7v5yomjQkpFg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_11,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270127
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/13] Hugetlb: Migrating libhugetlbfs mprotect
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,
Thanks for reviewing this patch.
I will rework on this.

Li Wang <liwang@redhat.com> writes:

> Hi Tarun,
>
> This test itself is no problem but looks a bit messy in code organization.
> At least we need to do some refactored work to improve the readability and
> reduce the (long-term) maintenance workload.
>
>
> Tarun Sahu <tsahu@linux.ibm.com> wrote:
>
> Migrating the libhugetlbfs/testcases/mprotect.c test
>>
>> Test Description: This test uses mprotect to change protection of
>> hugepage mapping and perform read/write operation. It checks if the
>> operation results in expected behaviour as per the protection.
>>
>> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>> ---
>>  runtest/hugetlb                               |   1 +
>>  testcases/kernel/mem/.gitignore               |   1 +
>>  .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 244 ++++++++++++++++++
>>  3 files changed, 246 insertions(+)
>>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
>>
>> diff --git a/runtest/hugetlb b/runtest/hugetlb
>> index 8e80db140..8ade3c9ec 100644
>> --- a/runtest/hugetlb
>> +++ b/runtest/hugetlb
>> @@ -24,6 +24,7 @@ hugemmap19 hugemmap19
>>  hugemmap20 hugemmap20
>>  hugemmap21 hugemmap21
>>  hugemmap22 hugemmap22
>> +hugemmap23 hugemmap23
>>  hugemmap05_1 hugemmap05 -m
>>  hugemmap05_2 hugemmap05 -s
>>  hugemmap05_3 hugemmap05 -s -m
>> diff --git a/testcases/kernel/mem/.gitignore
>> b/testcases/kernel/mem/.gitignore
>> index 0fd01dbce..ffd831f2e 100644
>> --- a/testcases/kernel/mem/.gitignore
>> +++ b/testcases/kernel/mem/.gitignore
>> @@ -23,6 +23,7 @@
>>  /hugetlb/hugemmap/hugemmap20
>>  /hugetlb/hugemmap/hugemmap21
>>  /hugetlb/hugemmap/hugemmap22
>> +/hugetlb/hugemmap/hugemmap23
>>  /hugetlb/hugeshmat/hugeshmat01
>>  /hugetlb/hugeshmat/hugeshmat02
>>  /hugetlb/hugeshmat/hugeshmat03
>> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
>> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
>> new file mode 100644
>> index 000000000..687b192ae
>> --- /dev/null
>> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
>> @@ -0,0 +1,244 @@
>> +// SPDX-License-Identifier: LGPL-2.1-or-later
>> +/*
>> + * Copyright (C) 2005-2006 IBM Corporation.
>> + * Author: David Gibson & Adam Litke
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test uses mprotect to change protection of hugepage mapping and
>> + * perform read/write operation. It checks if the operation results in
>> + * expected behaviour as per the protection.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <sys/mount.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +#include <setjmp.h>
>> +#include <signal.h>
>> +
>> +#include "hugetlb.h"
>> +
>> +#ifndef barrier
>> +# ifdef mb
>> +       /* Redefining the mb() */
>> +#   define barrier() mb()
>> +# else
>> +#   define barrier() __asm__ __volatile__ ("" : : : "memory")
>> +# endif
>> +#endif
>> +
>> +#define MNTPOINT "hugetlbfs/"
>> +#define RANDOM_CONSTANT        0x1234ABCD
>>
>
> Avoid mixing tab and spaces in the macro definition.
>
>
>
>> +
>> +static int  fd = -1;
>>
>
> ^ one space is enough.
>
>
>
>> +static sigjmp_buf sig_escape;
>> +static void *sig_expected = MAP_FAILED;
>> +static long hpage_size;
>> +
>> +static void sig_handler(int signum, siginfo_t *si, void *uc)
>> +{
>> +       (void)uc;
>> +       if (signum == SIGSEGV) {
>> +               tst_res(TINFO, "SIGSEGV at %p (sig_expected=%p)",
>> si->si_addr,
>> +                      sig_expected);
>> +               if (si->si_addr == sig_expected)
>> +                       siglongjmp(sig_escape, 1);
>> +               tst_res(TFAIL, "SIGSEGV somewhere unexpected");
>> +       } else
>> +               tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
>> +}
>> +
>> +static int test_read(void *p)
>> +{
>> +       volatile unsigned long *pl = p;
>> +       unsigned long x;
>> +
>> +       if (sigsetjmp(sig_escape, 1)) {
>> +               /* We got a SEGV */
>> +               sig_expected = MAP_FAILED;
>> +               return -1;
>> +       }
>> +
>> +       sig_expected = p;
>> +       barrier();
>> +       x = *pl;
>> +       tst_res(TINFO, "Read back %lu", x);
>> +       barrier();
>> +       sig_expected = MAP_FAILED;
>> +       return 0;
>> +}
>> +
>> +static int test_write(void *p, unsigned long val)
>> +{
>> +       volatile unsigned long *pl = p;
>> +       unsigned long x;
>> +
>> +       if (sigsetjmp(sig_escape, 1)) {
>> +               /* We got a SEGV */
>> +               sig_expected = MAP_FAILED;
>> +               return -1;
>> +       }
>> +
>> +       sig_expected = p;
>> +       barrier();
>> +       *pl = val;
>> +       x = *pl;
>> +       barrier();
>> +       sig_expected = MAP_FAILED;
>> +
>> +       return (x != val);
>> +}
>> +
>> +static int test_prot(void *p, int prot, char *prot_str)
>> +{
>> +       int r, w;
>> +
>> +       r = test_read(p);
>> +       tst_res(TINFO, "On Read: %d", r);
>> +       w = test_write(p, RANDOM_CONSTANT);
>> +       tst_res(TINFO, "On Write: %d", w);
>> +
>> +       if (prot & PROT_READ) {
>> +               if (r != 0) {
>> +                       tst_res(TFAIL, "read failed on mmap(prot %s)",
>> prot_str);
>> +                       return -1;
>> +               }
>> +
>> +       } else {
>> +               if (r != -1) {
>> +                       tst_res(TFAIL, "read succeeded on mmap(prot %s)",
>> prot_str);
>> +                       return -1;
>> +               }
>> +       }
>> +
>> +       if (prot & PROT_WRITE) {
>> +               switch (w) {
>> +               case -1:
>> +                       tst_res(TFAIL, "write failed on mmap(prot %s)",
>> prot_str);
>> +                       return -1;
>> +               case 0:
>> +                       break;
>> +               case 1:
>> +                       tst_res(TFAIL, "write mismatch on mmap(prot %s)",
>> prot_str);
>> +                       return -1;
>> +               default:
>> +                       tst_res(TWARN, "Bug in test");
>> +                       return -1;
>> +               }
>> +       } else {
>> +               switch (w) {
>> +               case -1:
>> +                       break;
>> +               case 0:
>> +                       tst_res(TFAIL, "write succeeded on mmap(prot %s)",
>> prot_str);
>> +                       return -1;
>> +               case 1:
>> +                       tst_res(TFAIL, "write mismatch on mmap(prot %s)",
>> prot_str);
>> +                       return -1;
>> +               default:
>> +                       tst_res(TWARN, "Bug in test");
>> +                       break;
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int test_mprotect(int fd, char *testname,
>> +                         unsigned long len1, int prot1, char *prot1_str,
>> +                         unsigned long len2, int prot2, char *prot2_str)
>> +{
>> +       void *p;
>> +       int ret;
>> +
>> +       tst_res(TINFO, "Testing %s", testname);
>> +       tst_res(TINFO, "Mapping with prot %s", prot1_str);
>> +       p = SAFE_MMAP(NULL, len1, prot1, MAP_SHARED, fd, 0);
>> +
>> +       ret = test_prot(p, prot1, prot1_str);
>> +       if (ret)
>> +               goto cleanup;
>> +       tst_res(TINFO, "mprotect()ing to prot %s", prot2_str);
>> +       ret = mprotect(p, len2, prot2);
>> +       if (ret != 0) {
>> +               tst_res(TFAIL|TERRNO, "%s: mprotect(prot %s)", testname,
>> prot2_str);
>> +               goto cleanup;
>> +       }
>> +
>> +       ret = test_prot(p, prot2, prot2_str);
>> +       if (ret)
>> +               goto cleanup;
>> +       if (len2 < len1)
>> +               ret = test_prot(p + len2, prot1, prot1_str);
>> +
>> +cleanup:
>> +       SAFE_MUNMAP(p, len1);
>> +       return ret;
>> +}
>> +
>> +static void run_test(void)
>> +{
>> +       void *p;
>> +
>>
>
>
>> +       struct sigaction sa = {
>> +               .sa_sigaction = sig_handler,
>> +               .sa_flags = SA_SIGINFO,
>> +       };
>> +
>> +       SAFE_SIGACTION(SIGSEGV, &sa, NULL);
>> +
>> +       fd = tst_creat_unlinked(MNTPOINT, 0);
>> +       p = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE,
>> MAP_SHARED, fd, 0);
>> +       memset(p, 0, hpage_size);
>> +       SAFE_MUNMAP(p, hpage_size);
>>
>
> I guess moving those preparation work into setup() is better.
>
>
>> +
>> +       if (test_mprotect(fd, "R->RW", hpage_size, PROT_READ, "PROT_READ",
>> +                     hpage_size, PROT_READ|PROT_WRITE,
>> "PROT_READ|PROT_WRITE"))
>> +               goto cleanup;
>> +       if (test_mprotect(fd, "RW->R", hpage_size, PROT_READ|PROT_WRITE,
>> +                    "PROT_READ|PROT_WRITE", hpage_size, PROT_READ,
>> "PROT_READ"))
>> +               goto cleanup;
>> +
>> +       if (test_mprotect(fd, "R->RW 1/2", 2*hpage_size, PROT_READ,
>> "PROT_READ",
>> +                     hpage_size, PROT_READ|PROT_WRITE,
>> "PROT_READ|PROT_WRITE"))
>> +               goto cleanup;
>> +       if (test_mprotect(fd, "RW->R 1/2", 2*hpage_size,
>> PROT_READ|PROT_WRITE,
>> +                     "PROT_READ|PROT_WRITE", hpage_size, PROT_READ,
>> "PROT_READ"))
>> +               goto cleanup;
>> +
>> +       if (test_mprotect(fd, "NONE->R", hpage_size, PROT_NONE,
>> "PROT_NONE",
>> +                     hpage_size, PROT_READ, "PROT_READ"))
>> +               goto cleanup;
>> +       if (test_mprotect(fd, "NONE->RW", hpage_size, PROT_NONE,
>> "PROT_NONE",
>> +                     hpage_size, PROT_READ|PROT_WRITE,
>> "PROT_READ|PROT_WRITE"))
>> +               goto cleanup;
>>
>
> Can we reorg those test options just into one structure for reducing
> the duplicated code? Something maybe like:
>
> static struct mprotect_param {
>         char *tname;
>         int pg_num;
>         int prot1;
>         char *prot1_str;
>         int prot2;
>         char *prot2_str;
> } mprotect_params[] = {
>         {"R->RW", 1,
>                 PROT_READ, "PROT_READ",
>                 PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"},
>
>         {"RW->R", 1,
>                 PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE",
>                 PROT_READ, "PROT_READ"},
>
>         {"R->RW 1/2", 2,
>                 PROT_READ, "PROT_READ",
>                 PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"},
>
>         {"RW->R 1/2", 2,
>                 PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE",
>                 PROT_READ, "PROT_READ"},
>
>         {"NONE->R", 1,
>                 PROT_NONE, "PROT_NONE",
>                 PROT_READ, "PROT_READ"},
>
>         {"NONE->RW", 1,
>                 PROT_NONE, "PROT_NONE",
>                 PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"},
> };
>
> static void run_test(unsigned int i)
> {
>         struct mprotect_param *mpt = &mprotect_params[i];
>
>         if (test_mprotect(fd, mpt->tname,
>                         hpage_size * mpt->pg_num, mpt->prot1,
> mpt->prot1_str,
>                         hpage_size, mpt->prot2, mpt->prot2_str))
>                 return;
>
>         tst_res(TPASS, "Successfully tested mprotect with hugetlb area\n");
> }
>
> static void setup(void)
> {
>         struct sigaction sa = {
>                 .sa_sigaction = sig_handler,
>                 .sa_flags = SA_SIGINFO,
>         };
>
>         SAFE_SIGACTION(SIGSEGV, &sa, NULL);
>
>         hpage_size = tst_get_hugepage_size();
>
>         fd = tst_creat_unlinked(MNTPOINT, 0);
>         p = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> fd, 0);
>
>         memset(p, 0, hpage_size);
>         SAFE_MUNMAP(p, hpage_size);
> }
>
> static void cleanup(void)
> {
>         SAFE_MUNMAP(p+hpage_size, hpage_size);
>
>         if (fd >= 0)
>                 SAFE_CLOSE(fd);
> }
>
> static struct tst_test test = {
>         .tcnt = ARRAY_SIZE(mprotect_params),
>         .needs_root = 1,
>         .mntpoint = MNTPOINT,
>         .needs_hugetlbfs = 1,
>         .needs_tmpdir = 1,
>         .setup = setup,
>         .cleanup = cleanup,
>         .test = run_test,
>         .hugepages = {2, TST_NEEDS},
> };
>
>
>
>> +
>> +       tst_res(TPASS, "Successfully tested mprotect with hugetlb area");
>>
>
>
>
>> +cleanup:
>> +       SAFE_MUNMAP(p+hpage_size, hpage_size);
>> +       SAFE_CLOSE(fd);
>>
>
> we can move this into cleanup() function as well.
>
>
>
>> +}
>> +
>> +static void setup(void)
>> +{
>> +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +       if (fd >= 0)
>> +               SAFE_CLOSE(fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +       .needs_root = 1,
>> +       .mntpoint = MNTPOINT,
>> +       .needs_hugetlbfs = 1,
>> +       .needs_tmpdir = 1,
>> +       .setup = setup,
>> +       .cleanup = cleanup,
>> +       .test_all = run_test,
>> +       .hugepages = {2, TST_NEEDS},
>> +};
>> --
>> 2.31.1
>>
>>
>
> -- 
> Regards,
> Li Wang
>
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
