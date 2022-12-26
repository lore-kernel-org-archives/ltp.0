Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1736EC4167B
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 09:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AF1E3CB86F
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 10:41:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833E03C899B
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 10:41:45 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2E8011A0043B
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 10:41:43 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BQ9bhXw029210; Mon, 26 Dec 2022 09:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=V7qyO+j8w3EiztKGwjokW5ZW/hgfiadTB0cYjm4fVUs=;
 b=NSPD65sU/2Y+tKtL92UE449d3+G6rUfhp/3gHbUIVmdiTq6b039dzayHRyv2w8ty6V7+
 77VL3qrK/ectuYI2zHXl1RprlgCbfKV5tC5RLMy5Sk+Rhw5w5t0dBxQcVAIAGUky4hJu
 J5x477K+slLiQxTMFysC3shzZKe1Ze8KP1B6HMUXjtiZVi7gzeyZPhn1dQg/neuBXUIW
 ie/cpyokpL9DByaWIc4G0y+rlf+Gvy8ihcmnMwfKaScIiiA1usvmmYVjIty13SOi7rDP
 pz0oOsr7ZcDE/fAz2EilDwrzL9HKN5K1pK9Kj9oaAf9XwAm21MgARTps4MFxS42cYLHF ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mq8s1gj74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 09:41:41 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BQ9br50029827;
 Mon, 26 Dec 2022 09:41:41 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mq8s1gj5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 09:41:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPAEYwm030824;
 Mon, 26 Dec 2022 09:41:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mns26sk46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Dec 2022 09:41:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BQ9fZOw21889460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Dec 2022 09:41:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AC5F20043;
 Mon, 26 Dec 2022 09:41:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1033020040;
 Mon, 26 Dec 2022 09:41:32 +0000 (GMT)
Received: from tarunpc (unknown [9.43.13.185])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Dec 2022 09:41:31 +0000 (GMT)
Date: Mon, 26 Dec 2022 15:11:23 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221226094123.umeah6wnqrqj4nws@tarunpc>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-4-tsahu@linux.ibm.com>
 <CAEemH2cGvChng=31zyR+_U8DYeB_zZ9dCqqmuisB2QfVkxgw5w@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2cGvChng=31zyR+_U8DYeB_zZ9dCqqmuisB2QfVkxgw5w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uxn01-exPux2yY9xYcfLl-UmuGR6rNw_
X-Proofpoint-ORIG-GUID: 2GZW84gyadwvLyExarR03aFNlOz6mFwA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_06,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260083
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/13] Hugetlb: Migrating libhugetlbfs mmap-gettest
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
Thanks for reviewing it.
Will take care of suggestions in next revision.

Thanks
Tarun

On Dec 26 2022, Li Wang wrote:
> On Sun, Dec 25, 2022 at 11:42 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:
> 
> > Migrating the libhugetlbfs/testcases/mmap-gettest.c test
> >
> > Test Description: This baseline test validates that a mapping of a
> > certain size can be created, correctly.  Once created, all the pages are
> > filled with a pattern and rechecked to test for corruption. The mapping is
> > then released.  This process is repeated for a specified number of
> > iterations.
> >
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> >
> 
> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> > ---
> >  runtest/hugetlb                               |   1 +
> >  testcases/kernel/mem/.gitignore               |   1 +
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 104 ++++++++++++++++++
> >  3 files changed, 106 insertions(+)
> >  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> >
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index 71b4d57e4..8e80db140 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -23,6 +23,7 @@ hugemmap18 hugemmap18
> >  hugemmap19 hugemmap19
> >  hugemmap20 hugemmap20
> >  hugemmap21 hugemmap21
> > +hugemmap22 hugemmap22
> >  hugemmap05_1 hugemmap05 -m
> >  hugemmap05_2 hugemmap05 -s
> >  hugemmap05_3 hugemmap05 -s -m
> > diff --git a/testcases/kernel/mem/.gitignore
> > b/testcases/kernel/mem/.gitignore
> > index 74edfa392..0fd01dbce 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -22,6 +22,7 @@
> >  /hugetlb/hugemmap/hugemmap19
> >  /hugetlb/hugemmap/hugemmap20
> >  /hugetlb/hugemmap/hugemmap21
> > +/hugetlb/hugemmap/hugemmap22
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> > b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> > new file mode 100644
> > index 000000000..50addbe62
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (C) 2005-2006 IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * This baseline test validates that a mapping of a certain size can be
> > + * created, correctly.  Once created, all the pages are filled with a
> > + * pattern and rechecked to test for corruption. The mapping is then
> > + * released. This process is repeated for a specified number of
> > + * iterations.
> > + */
> > +
> > +#include <stdio.h>
> > +#include <sys/mount.h>
> > +#include <unistd.h>
> > +#include <unistd.h>
> > +
> > +#include "hugetlb.h"
> > +
> > +#define ITERATIONS 10
> >
> 
> I don't think we need too many iterations, it will cost too
> much time and easily timed out on a slower machine,
> so at most cycling up two times should be enough.
> 
> 
> 
> > +#define NR_HUGEPAGES 2
> > +#define MNTPOINT "hugetlbfs/"
> > +
> > +static unsigned long hpage_size;
> > +static int fd = -1;
> > +
> > +static void test_per_iteration(size_t size, int iter)
> > +{
> > +       char *m;
> > +       size_t i, j;
> > +       char pattern = 'A';
> > +
> > +       fd = tst_creat_unlinked(MNTPOINT, 0);
> > +       m = SAFE_MMAP(NULL, size, (PROT_READ|PROT_WRITE), MAP_SHARED, fd,
> > 0);
> > +
> > +       for (i = 0; i < NR_HUGEPAGES; i++) {
> > +               for (j = 0; j < hpage_size; j++) {
> > +                       if (*(m+(i*hpage_size)+j) != 0) {
> > +                               tst_res(TFAIL, "Iter %d: Verifying the
> > mmap area failed. "
> > +                                    "Got %c, expected 0", iter,
> > +                                    *(m+(i*hpage_size)+j));
> > +                               goto cleanup;
> > +                       }
> > +               }
> > +       }
> > +       for (i = 0; i < NR_HUGEPAGES; i++) {
> > +               pattern = 65+(i%26);
> > +               memset(m+(i*hpage_size), pattern, hpage_size);
> > +       }
> > +
> > +       for (i = 0; i < NR_HUGEPAGES; i++) {
> > +               pattern = 65+(i%26);
> > +               for (j = 0; j < hpage_size; j++) {
> > +                       if (*(m+(i*hpage_size)+j) != pattern) {
> > +                               tst_res(TFAIL, "Verifying the mmap area
> > failed. "
> > +                                    "got: %c, expected: %c",
> > +                                    *(m+(i*hpage_size)+j), pattern);
> > +                               goto cleanup;
> > +                       }
> > +               }
> > +       }
> > +
> > +cleanup:
> > +       SAFE_MUNMAP(m, size);
> > +       SAFE_CLOSE(fd);
> > +}
> > +
> > +static void run_test(void)
> > +{
> > +       size_t size;
> > +       int i;
> > +
> > +       size = NR_HUGEPAGES * hpage_size;
> > +       for (i = 0; i < ITERATIONS; i++)
> > +               test_per_iteration(size, i);
> > +
> > +       tst_res(TPASS, "Successfully verified the mmap area.");
> > +}
> > +
> > +static void setup(void)
> > +{
> > +       hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> >
> 
> hpage_size = tst_get_hugepage_size();
> 
> +}
> > +
> > +static void cleanup(void)
> > +{
> > +       if (fd >= 0)
> > +               SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test = {
> > +       .needs_root = 1,
> > +       .mntpoint = MNTPOINT,
> > +       .needs_hugetlbfs = 1,
> > +       .needs_tmpdir = 1,
> > +       .setup = setup,
> > +       .cleanup = cleanup,
> > +       .test_all = run_test,
> > +       .hugepages = {NR_HUGEPAGES, TST_NEEDS},
> > +};
> > --
> > 2.31.1
> >
> >
> 
> -- 
> Regards,
> Li Wang
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
