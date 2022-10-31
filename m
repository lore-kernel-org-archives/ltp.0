Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48917FA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 11:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79F483CA9C1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 12:20:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6A93C1DB8
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:19:50 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 896B61000413
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:19:49 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VB06F7019682;
 Mon, 31 Oct 2022 11:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=6yPg+9Xk44GEmkRdGlab0t0ifTg4GHizv+DfoYi/piI=;
 b=C/Fd3c007TlbFEUjtQIyo2jYh6hKEdOAOuvJDqis5VCK1itSMmT7v4BYBhaYbNB1uWu6
 1zSR+dZBeH6SzFMPtIlBoJtUBZFiFLQ2vjri+Hlhht75zF3QZ2ZSfk6l/Noroz37EMFT
 6rcMwHs3ULY399r7nLsbchYMMzeSaqBpdx+wYbCgXWDFa6Py+ujgCfkES8oSOssAEb6L
 GxtpSMt0dEuRKYzHGIdDL0eaa9cF3oCujhy3NNHVRW8RCafeI4s/RCl/8Y3WMQhabqMB
 BlLMypXZ29fTSqWt29wYGdI0uwrr8664RoPQm853BEvs/AnW72g1vEedyp+76o0buIqh 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjb9040u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 11:19:46 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29V8uVpI024325;
 Mon, 31 Oct 2022 11:19:45 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjb9040t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 11:19:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29VB6Abd025054;
 Mon, 31 Oct 2022 11:19:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 3kgut8t364-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Oct 2022 11:19:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29VBJdqW197222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Oct 2022 11:19:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF5D111C04C;
 Mon, 31 Oct 2022 11:19:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 038BC11C04A;
 Mon, 31 Oct 2022 11:19:37 +0000 (GMT)
Received: from tarunpc (unknown [9.43.3.121])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 31 Oct 2022 11:19:36 +0000 (GMT)
Date: Mon, 31 Oct 2022 16:49:28 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <20221031111928.kreic4jn2jvjs2od@tarunpc>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-4-tsahu@linux.ibm.com>
 <CAEemH2eorzpq=duqXbNLy3C0Ysxjo6fe5Ne7XqgArDQuKZHB6w@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2eorzpq=duqXbNLy3C0Ysxjo6fe5Ne7XqgArDQuKZHB6w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3lK2yCQpfj1pWxPCYvdlWKuWJiSyWvsX
X-Proofpoint-GUID: O9vtSdNkJB1o3BsXsS7BptN-Ul66J5I5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310070
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] Hugetlb: Migrating libhugetlbfs
 chunk-overcommit
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Oct 31 2022, Li Wang wrote:
> On Sat, Oct 29, 2022 at 3:14 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:
> 
> > Migrating the libhugetlbfs/testcases/chunk-overcommit.c test
> >
> > Test Description: Some kernel versions after hugepage demand allocation was
> > added used a dubious heuristic to check if there was enough hugepage space
> > available for a given mapping.  The number of not-already-instantiated
> > pages in the mapping was compared against the total hugepage free pool. It
> > was very easy to confuse this heuristic into overcommitting by allocating
> > hugepage memory in chunks, each less than the total available pool size but
> > together more than available.  This would generally lead to OOM SIGKILLs of
> > one process or another when it tried to instantiate pages beyond the
> > available pool.
> >
> > Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  runtest/hugetlb                               |   1 +
> >  testcases/kernel/mem/.gitignore               |   1 +
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 144 ++++++++++++++++++
> >  3 files changed, 146 insertions(+)
> >  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> >
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index f7ff81cb3..664f18827 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -4,6 +4,7 @@ hugemmap04 hugemmap04
> >  hugemmap05 hugemmap05
> >  hugemmap06 hugemmap06
> >  hugemmap07 hugemmap07
> > +hugemmap08 hugemmap08
> >  hugemmap05_1 hugemmap05 -m
> >  hugemmap05_2 hugemmap05 -s
> >  hugemmap05_3 hugemmap05 -s -m
> > diff --git a/testcases/kernel/mem/.gitignore
> > b/testcases/kernel/mem/.gitignore
> > index df5256ec8..003ce422b 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -5,6 +5,7 @@
> >  /hugetlb/hugemmap/hugemmap05
> >  /hugetlb/hugemmap/hugemmap06
> >  /hugetlb/hugemmap/hugemmap07
> > +/hugetlb/hugemmap/hugemmap08
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > new file mode 100644
> > index 000000000..61db030d5
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Chunk Overcommit:
> > + * Some kernel versions after hugepage demand allocation was added used a
> > + * dubious heuristic to check if there was enough hugepage space available
> > + * for a given mapping.  The number of not-already-instantiated pages in
> > + * the mapping was compared against the total hugepage free pool. It was
> > + * very easy to confuse this heuristic into overcommitting by allocating
> > + * hugepage memory in chunks, each less than the total available pool size
> > + * but together more than available.  This would generally lead to OOM
> > + * SIGKILLs of one process or another when it tried to instantiate pages
> > + * beyond the available pool.
> > + *
> > + * HISTORY
> > + *
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/mount.h>
> > +#include <limits.h>
> > +#include <sys/param.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <signal.h>
> > +
> > +#include "hugetlb.h"
> > +
> > +#define PROC_OVERCOMMIT "/proc/sys/vm/nr_overcommit_hugepages"
> > +#define WITH_OVERCOMMIT 0
> > +#define WITHOUT_OVERCOMMIT 1
> > +
> > +static long hpage_size;
> > +
> > +static void test_chunk_overcommit(void)
> > +{
> > +       unsigned long totpages, chunk1, chunk2;
> > +       void *p, *q;
> > +       pid_t child;
> > +       int status;
> > +
> > +       totpages = SAFE_READ_MEMINFO("HugePages_Free:");
> > +
> > +       chunk1 = (totpages / 2) + 1;
> > +       chunk2 = totpages - chunk1 + 1;
> > +
> > +       tst_res(TINFO, "Free: %ld hugepages available: "
> > +              "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
> > +
> > +       p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE,
> > MAP_SHARED,
> > +                tst_hugetlb_fd, 0);
> > +
> > +       q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> > +                tst_hugetlb_fd, chunk1*hpage_size);
> > +       if (q == MAP_FAILED) {
> > +               if (errno != ENOMEM) {
> > +                       tst_res(TFAIL | TERRNO, "mmap() chunk2");
> > +                       goto cleanup1;
> > +               } else {
> > +                       tst_res(TPASS, "Successful without overcommit
> > pages");
> > +                       goto cleanup1;
> > +               }
> > +       }
> > +
> > +       tst_res(TINFO, "Looks like we've overcommitted, testing...");
> > +       /* Looks like we're overcommited, but we need to confirm that
> > +        * this is bad.  We touch it all in a child process because an
> > +        * overcommit will generally lead to a SIGKILL which we can't
> > +        * handle, of course.
> > +        */
> > +       child = SAFE_FORK();
> > +
> > +       if (child == 0) {
> > +               memset(p, 0, chunk1*hpage_size);
> > +               memset(q, 0, chunk2*hpage_size);
> > +               exit(0);
> > +       }
> > +
> > +       SAFE_WAITPID(child, &status, 0);
> > +
> > +       if (WIFSIGNALED(status)) {
> > +               tst_res(TFAIL, "Killed by signal '%s' due to overcommit",
> > +                    tst_strsig(WTERMSIG(status)));
> > +               goto cleanup2;
> > +       }
> > +
> > +       tst_res(TPASS, "Successful with overcommit pages");
> > +
> > +cleanup2:
> > +       SAFE_MUNMAP(q, chunk2*hpage_size);
> > +
> > +cleanup1:
> > +       SAFE_MUNMAP(p, chunk1*hpage_size);
> > +       SAFE_FTRUNCATE(tst_hugetlb_fd, 0);
> > +}
> > +
> > +static void run_test(unsigned int test_type)
> > +{
> > +       unsigned long saved_oc_hugepages;
> > +
> > +       SAFE_FILE_SCANF(PROC_OVERCOMMIT, "%ld", &saved_oc_hugepages);
> >
> 
> There is unnecessary to read PROC_OVERCOMMIT value again,
> we already save/restore it in struct tst_path_val[], so here we
> can set it directly to what we expected no matter if the original is 0 or 2.
> 
> static void run_test(unsigned int test_type)
> {
>         switch (test_type) {
>         case WITHOUT_OVERCOMMIT:
>                 tst_res(TINFO, "Without overcommit testing...");
>                 SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 0);
>                 break;
>         case WITH_OVERCOMMIT:
>                 tst_res(TINFO, "With overcommit testing...");
>                 SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 2);
>                 break;
>     }
>     test_chunk_overcommit();
> }
> 
Yeah, Missed it. Will update it.
> 
> 
> > +       switch (test_type) {
> > +       case WITHOUT_OVERCOMMIT:
> > +               tst_res(TINFO, "Without overcommit testing...");
> > +               if (saved_oc_hugepages > 0)
> > +                       SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 0);
> > +               break;
> > +       case WITH_OVERCOMMIT:
> > +               tst_res(TINFO, "With overcommit testing...");
> > +               if (saved_oc_hugepages == 0)
> > +                       SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 2);
> > +               break;
> > +       }
> > +       test_chunk_overcommit();
> > +}
> > +
> > +static void setup(void)
> > +{
> > +       hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> > +}
> > +
> > +static struct tst_test test = {
> > +       .needs_root = 1,
> > +       .needs_hugetlbfs = 1,
> > +       .needs_unlinked_hugetlb_file = 1,
> > +       .forks_child = 1,
> > +       .save_restore = (const struct tst_path_val[]) {
> > +               {PROC_OVERCOMMIT, NULL},
> > +               {}
> > +       },
> > +       .tcnt = 2,
> > +       .setup = setup,
> > +       .test = run_test,
> > +       .hugepages = {3, TST_NEEDS},
> > +};
> > +
> > --
> > 2.31.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
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
