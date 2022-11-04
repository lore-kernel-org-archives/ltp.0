Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC2C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C5353CAE5A
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 14:16:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4AF43C93D0
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 14:16:34 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B6D3600468
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 14:16:31 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Bk3Kb014302;
 Fri, 4 Nov 2022 13:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=an6SzMjZNvGr2RMY2gVJo6QVax1llvEriXmVJzyUCzo=;
 b=Nm8ll+jEXjkOqMz40k9M/kkA/5/r1QmbCrVoPaHBXwqCBfBIHl897DKTfejILl/8kykr
 l+gwE0aua/xmbXw+KqLwWv1HQYE9kU7I6rSCqmholHeEZn2PN9LPM/aRg8iP0n5Tljs6
 +riBlVEC6+AHIqKLtJpfZj01bXRsK2zK3mexE6UOpi3vOMYi0IwWuS/shP6cbESlkzXQ
 J6JMqdXK8zj2tWeKXQlYdKggc5wLzRwA7VTnJojfeCx+257E3h9nbjJPwM1hcY7M0iv7
 oZSMWSKnnTfRhb/VSNNWWIBmIEukA4FHC5pVeZcBqvxBvxPuyXgkUUzcDRYUR89LsrC2 hQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphfq0eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 13:16:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4D6liT030613;
 Fri, 4 Nov 2022 13:16:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3kgut9adh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 13:16:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A4DGMb443581920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 13:16:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8E114C040;
 Fri,  4 Nov 2022 13:16:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A29B64C044;
 Fri,  4 Nov 2022 13:16:19 +0000 (GMT)
Received: from tarunpc (unknown [9.43.111.144])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri,  4 Nov 2022 13:16:19 +0000 (GMT)
Date: Fri, 4 Nov 2022 18:46:15 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221104131615.dac6oo3tt2f56xi3@tarunpc>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
 <20221104062716.615021-4-tsahu@linux.ibm.com>
 <Y2TdNaxOzpaaCaPL@rei>
Content-Disposition: inline
In-Reply-To: <Y2TdNaxOzpaaCaPL@rei>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2XaYPKI43ZpLnX_ZeI_bjIaD5piLvzkP
X-Proofpoint-ORIG-GUID: 2XaYPKI43ZpLnX_ZeI_bjIaD5piLvzkP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040084
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/4] Hugetlb: Migrating libhugetlbfs
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Nov 04 2022, Cyril Hrubis wrote:
> Hi!
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > new file mode 100644
> > index 000000000..3efabc4aa
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
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
> 
> This looks like a leftover.
Ok.
> 
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
> > +#define MNTPOINT "hugetlbfs/"
> > +#define WITH_OVERCOMMIT 0
> > +#define WITHOUT_OVERCOMMIT 1
> > +
> > +static long hpage_size;
> > +static int huge_fd = -1;
> > +
> > +static void test_chunk_overcommit(void)
> > +{
> > +	unsigned long totpages, chunk1, chunk2;
> > +	void *p, *q;
> > +	pid_t child;
> > +	int status;
> > +
> > +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> > +
> > +	chunk1 = (totpages / 2) + 1;
> > +	chunk2 = totpages - chunk1 + 1;
> > +
> > +	tst_res(TINFO, "Free: %ld hugepages available: "
> > +	       "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
> > +
> > +	p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> > +		 huge_fd, 0);
> > +
> > +	q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> > +		 huge_fd, chunk1*hpage_size);
> > +	if (q == MAP_FAILED) {
> > +		if (errno != ENOMEM) {
> > +			tst_res(TFAIL | TERRNO, "mmap() chunk2");
> > +			goto cleanup1;
> > +		} else {
> > +			tst_res(TPASS, "Successful without overcommit pages");
> > +			goto cleanup1;
> > +		}
> > +	}
> > +
> > +	tst_res(TINFO, "Looks like we've overcommitted, testing...");
> > +	/* Looks like we're overcommited, but we need to confirm that
> > +	 * this is bad.  We touch it all in a child process because an
> > +	 * overcommit will generally lead to a SIGKILL which we can't
> > +	 * handle, of course.
> > +	 */
> > +	child = SAFE_FORK();
> > +
> > +	if (child == 0) {
> > +		memset(p, 0, chunk1*hpage_size);
> > +		memset(q, 0, chunk2*hpage_size);
> > +		exit(0);
> > +	}
> > +
> > +	SAFE_WAITPID(child, &status, 0);
> > +
> > +	if (WIFSIGNALED(status)) {
> > +		tst_res(TFAIL, "Killed by signal '%s' due to overcommit",
> > +		     tst_strsig(WTERMSIG(status)));
> > +		goto cleanup2;
> > +	}
> > +
> > +	tst_res(TPASS, "Successful with overcommit pages");
> > +
> > +cleanup2:
> > +	SAFE_MUNMAP(q, chunk2*hpage_size);
> > +
> > +cleanup1:
> > +	SAFE_MUNMAP(p, chunk1*hpage_size);
> > +	SAFE_FTRUNCATE(huge_fd, 0);
> > +}
> > +
> > +static void run_test(unsigned int test_type)
> > +{
> > +	switch (test_type) {
> > +	case WITHOUT_OVERCOMMIT:
> > +		tst_res(TINFO, "Without overcommit testing...");
> > +		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 0);
> > +		break;
> > +	case WITH_OVERCOMMIT:
> > +		tst_res(TINFO, "With overcommit testing...");
> > +		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 2);
> > +		break;
> > +	}
> > +	test_chunk_overcommit();
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> > +	huge_fd = tst_creat_unlinked(MNTPOINT);
> 
> Shouldn't we open a file under the MNTPOINT?
> 
> Something as:
> 
> #define HUGEFILE MNTPOINT "hugefile"
> 
> ...
> 	huge_fd = tst_creat_unlinked(HUGEFILE);
> ...
> 
This function creat a file with random name, so that one test
can call this function multiple times to creat multple files
whenever required. So it will just take the path inside which it will creat
all these files. To keep hugetlb test file with ditinguisable name, the path
is sufficient, no need to take hugefile as argument. 

So file is: hugetlbfs/ltp_xxxxxx_<tid>

> 
> The rest looks good to me.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
