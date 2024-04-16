Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1755CC4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 08:30:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EACF3CFAA9
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 10:30:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D0483CFA81
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:30:16 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B7D9601BAC
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:30:14 +0200 (CEST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G8Rads027044; Tue, 16 Apr 2024 08:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=o8xHtTxhMTQESjvEYA64bNjv4xsRFmkzDIc8PdkVSs4=;
 b=qp3Tyc/XaSTR95IsHkckt2UY+ZGfGBu5nNpJ4GFrPndUXKQB8xNBtiW7KHdGDJf9Btjb
 GLCgfVHPU1w+BqZJtyyR3ffncjuKT2W7FFHbUOL+BdTDTbbxvx3nEHv9N1WpmUeCERRd
 Xi0q5SUlZmw7h3UchNydKeNU65bnOBBPYrwEd+raGYdbjxsWNNL+ckC6kE/cQVoBMHCL
 s8tADxq6T9ZhkKI7P5jzXN64/7DM8HQcR564tXIyx3R/DDc5MwwmQOd5RRXo6IHK91ur
 oNS531k0O92B94GB4UHERYM685YS/hZTO8kFa3NSaAmzEOvDydUtUYTolfD0Wt1Ya5gL VQ== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhnu6r046-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 08:30:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G7ChCQ011111; Tue, 16 Apr 2024 08:30:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg732ck4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 08:30:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G8U7VN33817210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 08:30:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3E9A20063;
 Tue, 16 Apr 2024 08:30:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F54F20040;
 Tue, 16 Apr 2024 08:30:07 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown
 [9.199.152.158])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 08:30:06 +0000 (GMT)
Message-ID: <aa89d429ac7351195c4e1411c81ed77bd978da17.camel@linux.ibm.com>
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Apr 2024 14:00:06 +0530
In-Reply-To: <20240219221047.GB1067220@pevik>
References: <20231213084753.61762-1-shirisha@linux.ibm.com>
 <20240219221047.GB1067220@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jKncciOgW72LmVjMn8cHkXiBuk4iLip3
X-Proofpoint-ORIG-GUID: jKncciOgW72LmVjMn8cHkXiBuk4iLip3
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_06,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160051
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add hugemmap41(Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test)
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 2024-02-19 at 23:10 +0100, Petr Vorel wrote:
> Hi Shirisha,
> 
> > We are verifying ppc64 kernels prior to 2.6.15-rc5 exhibit a bug in
> > the
> Test is from 2005, for 2.6.15-rc5. Is it really relevant now?
yes
> 
> > hugepage SLB flushing path. When opening new hugetlb areas,
> > updating masks
> > in the thread_struct and copying to the PACA only occurs on the CPU
> > where
> > segments are opened, leading to potential stale copies in other
> > CPUs.
> > This bug can be triggered by multiple threads sharing the mm or a
> > single thread
> > migrating between CPUs, particularly evident in a close-to-idle
> > system,
> > as other processes may flush the SLB and prevent the bug from
> > manifesting.
> 
> Please run  make check-hugemmap41 in the test directory and fix
> formatting.
will take care in V2
> 
> > Original test originates from 
> > https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/slbpacaflush.c
> > Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
> > ---
> >  runtest/hugetlb                               |   1 +
> >  testcases/kernel/mem/.gitignore               |   1 +
> >  .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 144
> > ++++++++++++++++++
> >  3 files changed, 146 insertions(+)
> >  create mode 100644
> > testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index 299c07ac9..d956866ac 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
> >  hugemmap30 hugemmap30
> >  hugemmap31 hugemmap31
> >  hugemmap32 hugemmap32
> > +hugemmap41 hugemmap41
> nit: Any reason why not add it as hugemmap33? You don't want to clash
> with other
> sent test, right?
yes
> 
> >  hugemmap05_1 hugemmap05 -m
> >  hugemmap05_2 hugemmap05 -s
> >  hugemmap05_3 hugemmap05 -s -m
> > diff --git a/testcases/kernel/mem/.gitignore
> > b/testcases/kernel/mem/.gitignore
> > index c96fe8bfc..b7e108956 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -34,6 +34,7 @@
> >  /hugetlb/hugemmap/hugemmap30
> >  /hugetlb/hugemmap/hugemmap31
> >  /hugetlb/hugemmap/hugemmap32
> > +/hugetlb/hugemmap/hugemmap41
> >  /hugetlb/hugeshmat/hugeshmat01
> >  /hugetlb/hugeshmat/hugeshmat02
> >  /hugetlb/hugeshmat/hugeshmat03
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> > b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> > new file mode 100644
> > index 000000000..3b3388c68
> > --- /dev/null
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2005-2006 IBM Corporation.
> > + * Author: David Gibson & Adam Litke
> > + */
> > +/*\
> > + * [Description]
> > + *
> > + * ppc64 kernels (prior to 2.6.15-rc5) have a bug in the hugepage
> > SLB
> > + * flushing path.  After opening new hugetlb areas, we update the
> > + * masks in the thread_struct, copy to the PACA, then do slbies on
> > + * each CPU.  The trouble is we only copy to the PACA on the CPU
> > where
> > + * we're opening the segments, which can leave a stale copy in the
> > + * PACAs on other CPUs.
> > + *
> > + * This can be triggered either with multiple threads sharing the
> > mm,
> > + * or with a single thread which is migrated from one CPU, to
> > another
> > + * (where the mapping occurs), then back again (where we touch the
> > + * stale SLB).  We use the second method in this test, since it's
> > + * easier to force (using sched_setaffinity).  However it relies
> > on a
> > + * close-to-idle system, if any process other than a kernel thread
> > + * runs on the first CPU between runs of the test process, the SLB
> > + * will be flushed and we won't trigger the bug, hence the
> > + * PASS_INCONCLUSIVE().  Obviously, this test won't work on a 1-
> > cpu
> > + * system (should get CONFIG() on the sched_setaffinity)
> > + *
> > + */
> > +#define _GNU_SOURCE
> > +#include "hugetlb.h"
> > +#define SYSFS_CPU_ONLINE_FMT	"/sys/devices/system/cpu/cpu%d/
> > online"
> > +#define MNTPOINT "hugetlbfs/"
> Could you please have these 2 #define above _GNU_SOURCE?
> (readablility)
will take care in V2
> > +
> > +
> > +#include <stdio.h>
> > +#include <sched.h>
> > +
> > +
> > +long hpage_size;
> > +int fd;
> > +void *p;
> > +volatile unsigned long *q;
> > +int online_cpus[2], err;
> > +cpu_set_t cpu0, cpu1;
> > +
> > +
> > +
> Please remove these blank lines above.
Sure.will take care in V2
> 
> > +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> > +{
> > +	char cpu_state, path_buf[64];
> > +	int total_cpus, cpu_idx, fd, ret, i;
> > +
> > +	total_cpus = get_nprocs_conf();
> > +	cpu_idx = 0;
> > +
> > +	if (get_nprocs() < nr_cpus_needed)
> > +		tst_res(TFAIL, "Atleast online %d cpus are required",
> > nr_cpus_needed);
> > +
> > +	for (i = 0; i < total_cpus && cpu_idx < nr_cpus_needed; i++) {
> nit: Maybe just use get_nprocs_conf() directly?
Sure.
> 
> > +		errno = 0;
> Is it errno reset really needed?
Since based on the error number we are failing the testcase so need it
> 
> > +		sprintf(path_buf, SYSFS_CPU_ONLINE_FMT, i);
> > +		fd = open(path_buf, O_RDONLY);
> > +		if (fd < 0) {
> > +			/* If 'online' is absent, the cpu cannot be
> > offlined */
> > +			if (errno == ENOENT) {
> > +				online_cpus[cpu_idx] = i;
> > +				cpu_idx++;
> > +				continue;
> > +			} else {
> > +				tst_res(TFAIL, "Unable to open %s: %s",
> > path_buf,
> > +				     strerror(errno));
> We have TERRNO:
> 				tst_res(TFAIL | TERRNO, "Unable to open
> %s: %s", path_buf);
will take care in V2
> > +			}
> > +		}
> > +
> > +		ret = read(fd, &cpu_state, 1);
> > +		if (ret < 1)
> > +			tst_res(TFAIL, "Unable to read %s: %s",
> > path_buf,
> > +			     strerror(errno));
> Maybe use SAFE_READ() ?
Am using read here because unable to read may potentially indicate a
test failure
> > +
> > +		if (cpu_state == '1') {
> > +			online_cpus[cpu_idx] = i;
> > +			cpu_idx++;
> > +		}
> > +
> > +		if (fd >= 0)
> > +			SAFE_CLOSE(fd);
> > +	}
> > +
> > +	if (cpu_idx < nr_cpus_needed)
> > +		tst_res(TFAIL, "Atleast %d online cpus were not found",
> > nr_cpus_needed);
> > +}
> > +
> > +
> > +static void run_test(void)
> > +{
> > +	check_online_cpus(online_cpus, 2);
> > +	CPU_ZERO(&cpu0);
> > +	CPU_SET(online_cpus[0], &cpu0);
> > +	CPU_ZERO(&cpu1);
> > +	CPU_SET(online_cpus[1], &cpu1);
> > +
> > +	err = sched_setaffinity(getpid(), CPU_SETSIZE/8, &cpu0);
> > +	if (err != 0)
> > +		tst_res(TFAIL, "sched_setaffinity(cpu%d): %s",
> > online_cpus[0],
> > +				strerror(errno));
> Again, please use TTERRNO.
Sure. will take care in V2
> > +
> > +	err = sched_setaffinity(getpid(), CPU_SETSIZE/8, &cpu1);
> Maybe define CPU_SETSIZE/8 at the top?
Sure.will take care in V2
> > +
> > +	if (err != 0)
> > +		tst_res(TFAIL, "sched_setaffinity(cpu%d): %s",
> > online_cpus[1],
> > +				strerror(errno));
> > +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE,
> > MAP_SHARED, fd, 0);
> > +
> > +	err = sched_setaffinity(getpid(), CPU_SETSIZE/8, &cpu0);
> > +	if (err != 0)
> > +		tst_res(TFAIL, "sched_setaffinity(cpu%d): %s",
> > online_cpus[0],
> > +				strerror(errno));
> > +	q = (volatile unsigned long *)(p + getpagesize());
> > +	*q = 0xdeadbeef;
> Why to set the address before end of testing? (yes, the original does
> it, but
> why?). Wouldn't be better to use guarded buffers instead?
> 
> https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers
We are trying to access and write into a memory location within the
mapped segment by adding the huge page size to the mapped address and
casting it to a volatile unsigned long pointer to ensure things work
fine.
> 
> Kind regards,
> Petr
> 
> > +
> > +	tst_res(TPASS, "Test Passed inconclusive");
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	hpage_size = tst_get_hugepage_size();
> > +	fd = tst_creat_unlinked(MNTPOINT, 0);
> > +}
> > +
> > +void cleanup(void)
> > +{
> > +	if (fd > 0)
> > +		SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.needs_hugetlbfs = 1,
> > +	.needs_tmpdir = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {1, TST_NEEDS},
> > +};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
