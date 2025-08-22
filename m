Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF731CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:52:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 444973CCCCC
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:52:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 394ED3C246E
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:52:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 46A241A00252
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:52:03 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHcgn7011826;
 Fri, 22 Aug 2025 05:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fG98vg
 Dxf8m8eRiYtuBx5d9exx/lWnw9IOWAUuFd414=; b=s13E8ib9C4Lxn6CUa0/MJ0
 Pr2NBPvs5jWGYjz/XInts2K+sPxoW9AObQhvXuJL3IKA6DZM4TbfzVqBxcAohw6d
 0I9t0J1qFr7I5e2vExlvZZbj8WCe+U7zwH3HF4d09DWaSoRMpSlP7LYCHHtlU7Q7
 YSY9YfGNaT4eom1D/WG8Tp29GP+1AgIQJV88iUrD78f5oV8ydQbmvPARm6OrU+cS
 74141aUfXbaTF3j+RuqKDCuQPfQnrKIJmFCqj9ya9Iq/PAJIzGmbs/dbvVB3mdvk
 sdin9rdUucRNazwy/CrS9P/85WnF0Pjg15ra3+IPiltereFZrW0dmy9/CFgdIDog
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vvjpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:52:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M3oSv3016018;
 Fri, 22 Aug 2025 05:51:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42bvbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:51:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57M5pak451184040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 05:51:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E23020049;
 Fri, 22 Aug 2025 05:51:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93B4820040;
 Fri, 22 Aug 2025 05:51:34 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown
 [9.43.109.165]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Aug 2025 05:51:34 +0000 (GMT)
Message-ID: <bbfe5f76e09600aee1783eff010630bfbdc2fd2b.camel@linux.ibm.com>
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Aug 2025 11:21:31 +0530
In-Reply-To: <ZnlfGVAO9-53sQ8z@yuki>
References: <20240416091107.783352-1-shirisha@linux.ibm.com>
 <ZnlfGVAO9-53sQ8z@yuki>
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXzdzXxAPusZDV
 3A0kMzH2T65x0+Vr3xPdsjSHnn0xHYF+iqtAqQ+A094+Yf9O6B9DLJ6xbVzjrJV77n5q2BEsOpW
 pM1BdibnD/+KrpWi/0MnU90efzBXa9efnUUsCR7lgHvApmJRDAl16M9uTp7F2qwgrtlwTeg+FJN
 EEXuGcUN0eEclf5YQP6p++wZuutl0N+A8uk1rFjB1YfRfhLlYmOSXy/PZsRNWOoKOMzbIAHbNZ6
 LI4MTe0pA3rBDCXqvb/m01thlsaSTcEeDlJ/aHJhk93cJfySo+1inX/+sIMOEL3kYOproFXHa+E
 2Ci0VJpnN0JQTdeJzm9ZXBt4NI1TBgsV0HdgqajMuLG08UxVJGQUKfTpwAwH2H3a9pbv4Kuj3yS
 v2I6pdwhvU7Yh2oTiXctmhal5B8eew==
X-Proofpoint-ORIG-GUID: e0Y8xfVGIq2_-sgljcahObtD_etZVQug
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a80582 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0Ni6rV8TAAAA:8 a=FKdjCG9k83LPYxVrS8AA:9
 a=QEXdDO2ut3YA:10 a=MEv8DOuCJPEGjlO0Qob3:22
X-Proofpoint-GUID: e0Y8xfVGIq2_-sgljcahObtD_etZVQug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/slbpacaflush.c test
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

On Mon, 2024-06-24 at 13:57 +0200, Cyril Hrubis wrote:
> Hi!
> > +#define _GNU_SOURCE
> > +#define SYSFS_CPU_ONLINE_FMT
> > "/sys/devices/system/cpu/cpu%d/online"
> > +#define MNTPOINT "hugetlbfs/"
> > +#define SINGLE_CPU (CPU_SETSIZE/8)
> > +#include "hugetlb.h"
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
> 
> All these should be static.
will take care in V3
> 
> > +void check_online_cpus(int online_cpus[], int nr_cpus_needed)
> > +{
> > +	char cpu_state, path_buf[64];
> > +	int cpu_idx, fd, ret, i;
> > +
> > +	cpu_idx = 0;
> > +
> > +	if (get_nprocs() < nr_cpus_needed)
> > +		tst_brk(TCONF, "minimum  %d online cpus are required",
> > nr_cpus_needed);
> > +
> > +	for (i = 0; i < get_nprocs_conf() && cpu_idx < nr_cpus_needed;
> > i++) {
> > +		errno = 0;
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
> > +				tst_res(TFAIL | TERRNO, "Unable to open
> > %s", path_buf);
> > +			}
> > +		}
> > +
> > +		ret = read(fd, &cpu_state, 1);
> > +		if (ret < 1)
> > +			tst_res(TFAIL | TERRNO, "Unable to read %s",
> > path_buf);
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
> > +		tst_brk(TCONF, "minimum %d online cpus were not found",
> > nr_cpus_needed);
> > +}
> 
> There seems to be an easier method, recently we needed to find online
> CPU for the startvation tests and all you need to do is to get the
> current thread affinity and then look for non-zero bits in that, see
> commit:
> 
> commit 1800e635783b69cacdce9f654ecd730a8f30915b
> Author: Edward Liaw via ltp <ltp@lists.linux.it>
> Date:   Wed Jun 19 16:28:07 2024 +0000
> 
> And I suppose that it would make sense to put this function in the
> test
> library so taht we do not have to repeat it over in tests, but we
> would
> have to make it return the actual number of CPUs found and do the
> tst_brk(TCONF, ...) in the tests instead, so we would add:
> 
> unsigned int tst_get_online_cpus(int online_cpus[], unsigned int
> online_cpus_cnt);
> 
> And the test would do:
> 
> 	if (tst_get_online_cpus(online_cpus, 2) != 2)
> 		tst_brK(TCONF, "Require at least 2 online CPUs.");
will take care in V3
> 
> > +static void run_test(void)
> > +{
> > +	check_online_cpus(online_cpus, 2);
> > +	CPU_ZERO(&cpu0);
> > +	CPU_SET(online_cpus[0], &cpu0);
> > +	CPU_ZERO(&cpu1);
> > +	CPU_SET(online_cpus[1], &cpu1);
> > +
> > +	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu0);
> > +	if (err != 0)
> > +		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)",
> > online_cpus[0]);
> > +
> > +	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu1);
> > +
> > +	if (err != 0)
> > +		tst_res(TFAIL | TERRNO, "sched_setaffinity(cpu%d)",
> > online_cpus[1]);
> > +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE,
> > MAP_SHARED, fd, 0);
> > +
> > +	err = sched_setaffinity(getpid(), SINGLE_CPU, &cpu0);
> > +	if (err != 0)
> > +		tst_res(TFAIL, "sched_setaffinity(cpu%d)",
> > online_cpus[0]);
> > +	q = (volatile unsigned long *)(p + getpagesize());
> > +	*q = 0xdeadbeef;
> 
> I suppose that the test crashes here, when the entries are not
> propagated, right?
> 
> > +	tst_res(TPASS, "Test Passed inconclusive");
> 
> We usually print something as tst_res(TPASS, "Nothing bad happend,
> probably");
> in the case that we haven't managed to crash the system.
> 
> Also we have to unmap the p here so that the test works properly with
> -i
> parameter.
sure. will take care in v3
> 
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
> > -- 
> > 2.39.3
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
