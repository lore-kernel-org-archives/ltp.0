Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E18606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AnXX62yx
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B00373E9BE5
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:46:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1D83E2553
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:45:03 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D566200B73
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:45:01 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAEBms1465775; Fri, 23 Oct 2026 13:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=259jkROJK//GzIPSX
 P9InKn20P7IxN5LKpfdYojvsro=; b=AnXX62yxKX0JgJPPF3ck09I3z9BT2rlvs
 eVfVZP9ptcquCZLFIBkDTHmyUmST1j4ZhhhwiT86UyKDzrZyCoqi+6quZQusCv5/
 cfvNYbvr92lYVVeQEgoxIj8IB2VyUD9TfFYaprltnvAufxAv9s8L3gIPEMnla2sQ
 d0nv0txf6yFKjik7RMaA1slL+lcRJXM82ptqsZIu0GoAFgvgqwjbPYz8NA2UEJIp
 ss9Vrp9fnI/fgaAHNR9KwnSfY9a5rvcY5yUPYu0w6Sld6faGaxQVK1I/f13LInW+
 H04gkR49jC6GyNPiLpyah9FOcthXgUJvu9xS04rt567H8eVN5ZEBQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58msxh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:45:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAKC4G2010293; Fri, 23 Oct 2026 13:44:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck5pwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NDiueN30540156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 13:44:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF93020043;
 Fri, 23 Oct 2026 13:44:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1404820040;
 Fri, 23 Oct 2026 13:44:55 +0000 (GMT)
Received: from ltcden9-lp5.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 13:44:54 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 24 Oct 2026 04:30:44 +0200
Message-ID: <20261024023044.80055-5-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024023044.80055-1-samir@linux.ibm.com>
References: <20261024023044.80055-1-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX4bjGQ8WLEzI9
 WqyZZbe4qxhsaZ1j1tvgMN9Ce/oJjmdvOQdhR5gPCbv6iubcmeexzoXcjMPoWoeS1k7IeCKapAs
 mjQi26n9kAS4b4+dO6/PMZ7zSc4Sbrs=
X-Proofpoint-GUID: l-b4cyy8CZhqcAY-twCABV7dpTA31oR6
X-Proofpoint-ORIG-GUID: l-b4cyy8CZhqcAY-twCABV7dpTA31oR6
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb64dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ho0BCI3GSHJLwM05t74A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX4cYvOlRObekl
 H/5ntY4selfYWbH/8cabyeJkEmcGs/cepiF9dUqk4bzlQCIf6PCD6Wk2+r9TX2N+M17hEgFrF0E
 qDm/+SxjB0CDBk+VdFpEWnzNO6ELhzLuUjMBYK5qoCh+DJgVP0UIR7wsXZQgapJALh48Pr3kPvx
 gdqBFbNl0h9UbjMQ2mT7ZpQFDPXbusJUFWbEY+87e47Eh3HMxKGiPTgqllc7TeUcV4b8Fukefeb
 Ps6MAUlTwF1TzJFurxWDnjuEFy6r5CFc03AquQ5cjMcntCw7bQSihKImWe5Dnfvb1TclNAbnYfq
 tKMESP7OaBX4GmSLaf7xEfxqzNSESpw2ziBhsGdALW47evki+3D9I9pdxXHn0btzSBMPqnjD5CD
 Ggil15UJcTphmKaHCK0zESccStkAW1qAQU9pk2RXmc9Dnxds20Kn7d07j9/018vJr741db7a4qW
 DA8mHPDNaMS3YQyc51A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230053
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_12_24,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 4/4] sched/psi: Add psi_accounting01 test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test case to verify that PSI correctly records stall time when
tasks experience CPU, memory, and I/O pressure.

The test creates a cgroup v2 to isolate the workload and checks that:
- Running two CPU-heavy tasks on a single CPU increases cpu "some" total.
- Touching memory above memory.high triggers reclaim and increases
  memory "some" total.
- Doing synchronous O_DIRECT writes to a block device increases io "some"
  total.

If the system cannot create enough memory or I/O pressure (for example, on
very fast storage or systems without a test block device), the test cleanly
reports TCONF instead of failing.

The test requires cgroup v2 with memory controller enabled.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
 runtest/sched                                 |   1 +
 testcases/kernel/sched/psi/.gitignore         |   1 +
 testcases/kernel/sched/psi/psi_accounting01.c | 356 ++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 testcases/kernel/sched/psi/psi_accounting01.c

diff --git a/runtest/sched b/runtest/sched
index 0651fafd9..b6021411c 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -24,3 +24,4 @@ sched_football sched_football
 psi_invalid_trigger01 psi_invalid_trigger01
 psi_multiple_trigger01 psi_multiple_trigger01
 psi_proc_format01 psi_proc_format01
+psi_accounting01 psi_accounting01
diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
index 8d1083ff2..67407cc1c 100644
--- a/testcases/kernel/sched/psi/.gitignore
+++ b/testcases/kernel/sched/psi/.gitignore
@@ -1,3 +1,4 @@
 /psi_invalid_trigger01
 /psi_multiple_trigger01
 /psi_proc_format01
+/psi_accounting01
diff --git a/testcases/kernel/sched/psi/psi_accounting01.c b/testcases/kernel/sched/psi/psi_accounting01.c
new file mode 100644
index 000000000..8b08f5a14
--- /dev/null
+++ b/testcases/kernel/sched/psi/psi_accounting01.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corp.
+ * Author: Samir Mulani <samir@linux.ibm.com>
+ */
+
+/*\
+ * Verify that the PSI counters of a cgroup grow when its tasks are stalled.
+ *
+ * The test reads cpu.pressure, memory.pressure and io.pressure of a cgroup of
+ * its own, so load generated by the rest of the system does not influence the
+ * result. For every resource a workload is run by tasks inside the cgroup and
+ * the "some" total is expected to grow:
+ *
+ * - cpu: two busy tasks are pinned to the same CPU, so one of them is always
+ *   runnable but not running. The total has to grow by at least 50ms.
+ * - memory: a task keeps touching fresh anonymous pages above memory.high of
+ *   the cgroup, which makes it reclaim and get throttled. If memory.events
+ *   does not show any new "high" event the workload did not create the stall
+ *   and the test reports TCONF. Otherwise the task has been accounted as
+ *   stalled, so the total has to grow.
+ * - io: a task does O_DIRECT writes to a block device and has to wait for
+ *   their completion. If the writes did not block long enough the test reports
+ *   TCONF. Otherwise the total has to grow by a quarter of the time that the
+ *   writes were blocked.
+ *
+ * The format of the files in /proc/pressure/ is checked by psi_proc_format01.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <string.h>
+#include <sched.h>
+#include <sys/mman.h>
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_clocks.h"
+#include "tst_safe_file_at.h"
+#include "lapi/cpuset.h"
+
+#define PSI_PROBE "/proc/pressure/cpu"
+#define MNTPOINT "mntpoint"
+#define IO_FILE MNTPOINT "/psi_io"
+
+#define WORK_MS 2000
+#define CPU_MIN_DELTA_US 50000ULL
+#define MIN_IO_WAIT_US 200000LL
+/* Share of the measured IO wait that has to show up in io.pressure */
+#define IO_DELTA_DIVISOR 4
+
+#define MEM_HIGH (16 * 1024 * 1024)
+#define MEM_REGION (24 * 1024 * 1024)
+/*
+ * Memory above memory.high is throttled for up to two seconds after every
+ * batch of 64 pages (256KB), so the clock has to be checked after each one.
+ */
+#define MEM_STEP (256 * 1024)
+
+#define IO_SIZE (256 * 1024)
+
+static struct tst_cg_group *cg_psi;
+static int cg_fd = -1;
+static int pin_cpu;
+static long long *io_wait_us;
+
+static char io_buf[IO_SIZE] __attribute__((aligned(4096)));
+
+static unsigned long long read_some_total(const char *file)
+{
+	char buf[256];
+	unsigned long long total;
+
+	SAFE_FILE_READAT(cg_fd, file, buf, sizeof(buf));
+
+	if (sscanf(buf, "some avg10=%*f avg60=%*f avg300=%*f total=%llu",
+		   &total) != 1)
+		tst_brk(TBROK, "Cannot parse %s: '%s'", file, buf);
+
+	return total;
+}
+
+static void check_delta(const char *file, unsigned long long before,
+			unsigned long long min_delta)
+{
+	unsigned long long after = read_some_total(file);
+
+	if (after < before) {
+		tst_res(TFAIL, "%s some total decreased: %llu -> %llu",
+			file, before, after);
+		return;
+	}
+
+	if (after - before >= min_delta) {
+		tst_res(TPASS, "%s some total grew by %llu us",
+			file, after - before);
+	} else {
+		tst_res(TFAIL,
+			"%s some total grew only by %llu us, expected at least %llu us",
+			file, after - before, min_delta);
+	}
+}
+
+static void pin_to_cpu(int cpu)
+{
+	long ncpus = tst_ncpus_max();
+	size_t size = CPU_ALLOC_SIZE(ncpus);
+	cpu_set_t *mask = CPU_ALLOC(ncpus);
+
+	if (!mask)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+
+	CPU_ZERO_S(size, mask);
+	CPU_SET_S(cpu, size, mask);
+
+	if (sched_setaffinity(0, size, mask))
+		tst_brk(TBROK | TERRNO, "sched_setaffinity(%d) failed", cpu);
+
+	CPU_FREE(mask);
+}
+
+static void join_cgroup(void)
+{
+	SAFE_CG_PRINTF(cg_psi, "cgroup.procs", "%d", getpid());
+}
+
+static void verify_cpu(void)
+{
+	unsigned long long before = read_some_total("cpu.pressure");
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (!SAFE_FORK()) {
+			join_cgroup();
+			pin_to_cpu(pin_cpu);
+
+			tst_timer_start(CLOCK_MONOTONIC);
+			while (!tst_timer_expired_ms(WORK_MS))
+				;
+
+			exit(0);
+		}
+	}
+
+	tst_reap_children();
+	check_delta("cpu.pressure", before, CPU_MIN_DELTA_US);
+}
+
+static void verify_memory(void)
+{
+	unsigned long long before = read_some_total("memory.pressure");
+	long high_before, high_after;
+
+	/* The limit is only wanted here, it would throttle the other tests */
+	SAFE_CG_PRINTF(cg_psi, "memory.high", "%d", MEM_HIGH);
+	SAFE_CG_LINES_SCANF(cg_psi, "memory.events", "high %ld", &high_before);
+
+	if (!SAFE_FORK()) {
+		size_t off;
+		char *ptr;
+
+		join_cgroup();
+
+		ptr = SAFE_MMAP(NULL, MEM_REGION, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+		tst_timer_start(CLOCK_MONOTONIC);
+
+		while (!tst_timer_expired_ms(WORK_MS)) {
+			for (off = 0; off < MEM_REGION; off += MEM_STEP) {
+				memset(ptr + off, 0xab, MEM_STEP);
+
+				if (tst_timer_expired_ms(WORK_MS))
+					break;
+			}
+
+			/* Drop the pages so that they have to be charged again */
+			if (madvise(ptr, MEM_REGION, MADV_DONTNEED))
+				tst_brk(TBROK | TERRNO, "madvise() failed");
+		}
+
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	SAFE_CG_LINES_SCANF(cg_psi, "memory.events", "high %ld", &high_after);
+	SAFE_CG_PRINT(cg_psi, "memory.high", "max");
+
+	if (high_after <= high_before) {
+		tst_res(TCONF, "Workload did not exceed memory.high (high=%ld)",
+			high_after);
+		return;
+	}
+
+	/*
+	 * A "high" event is raised right before the task enters the memory
+	 * stall accounting, so any growth is enough at this point.
+	 */
+	check_delta("memory.pressure", before, 1);
+}
+
+static void verify_io(void)
+{
+	unsigned long long before = read_some_total("io.pressure");
+
+	*io_wait_us = 0;
+
+	if (!SAFE_FORK()) {
+		struct timespec start, end;
+		int fd;
+
+		join_cgroup();
+
+		memset(io_buf, 0xcd, sizeof(io_buf));
+		fd = SAFE_OPEN(IO_FILE, O_WRONLY | O_CREAT | O_DIRECT, 0600);
+
+		tst_timer_start(CLOCK_MONOTONIC);
+
+		while (!tst_timer_expired_ms(WORK_MS)) {
+			tst_clock_gettime(CLOCK_MONOTONIC, &start);
+
+			if (pwrite(fd, io_buf, IO_SIZE, 0) != IO_SIZE)
+				tst_brk(TBROK | TERRNO, "pwrite() failed");
+
+			tst_clock_gettime(CLOCK_MONOTONIC, &end);
+			*io_wait_us += tst_timespec_diff_us(end, start);
+		}
+
+		SAFE_CLOSE(fd);
+		SAFE_UNLINK(IO_FILE);
+		exit(0);
+	}
+
+	tst_reap_children();
+
+	if (*io_wait_us < MIN_IO_WAIT_US) {
+		tst_res(TCONF, "The workload was blocked on IO for only %lld us",
+			*io_wait_us);
+		return;
+	}
+
+	check_delta("io.pressure", before, *io_wait_us / IO_DELTA_DIVISOR);
+}
+
+static void (*const tests[])(void) = {
+	verify_cpu,
+	verify_memory,
+	verify_io,
+};
+
+static void run(unsigned int n)
+{
+	tests[n]();
+}
+
+static void check_pressure_file(const char *file)
+{
+	if (faccessat(cg_fd, file, R_OK, 0))
+		tst_brk(TCONF | TERRNO, "%s is not available in the cgroup", file);
+}
+
+static void setup(void)
+{
+	char buf[64];
+	long i, ncpus = tst_ncpus_max();
+	size_t size = CPU_ALLOC_SIZE(ncpus);
+	cpu_set_t *mask = CPU_ALLOC(ncpus);
+	int fd;
+
+	if (!mask)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+
+	fd = SAFE_OPEN(PSI_PROBE, O_RDONLY);
+
+	/* psi=0 on the kernel command line makes the interface return EOPNOTSUPP */
+	if (read(fd, buf, sizeof(buf)) < 0) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "PSI is disabled (psi=0 on kernel command line)");
+
+		tst_brk(TBROK | TERRNO, "read(%s) failed", PSI_PROBE);
+	}
+
+	SAFE_CLOSE(fd);
+
+	/* Pin the busy tasks to a CPU we are actually allowed to use */
+	if (sched_getaffinity(0, size, mask))
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	for (i = 0; i < ncpus; i++) {
+		if (CPU_ISSET_S(i, size, mask))
+			break;
+	}
+
+	if (i == ncpus)
+		tst_brk(TBROK, "No usable CPU found");
+
+	pin_cpu = i;
+	CPU_FREE(mask);
+
+	cg_psi = tst_cg_group_mk(tst_cg, "psi");
+	cg_fd = tst_cg_group_unified_dir_fd(cg_psi);
+
+	if (cg_fd < 0)
+		tst_brk(TBROK, "Cannot get the directory of the cgroup");
+
+	check_pressure_file("cpu.pressure");
+	check_pressure_file("memory.pressure");
+	check_pressure_file("io.pressure");
+
+	/* Not every filesystem supports O_DIRECT */
+	fd = open(IO_FILE, O_WRONLY | O_CREAT | O_DIRECT, 0600);
+	if (fd < 0) {
+		if (errno == EINVAL)
+			tst_brk(TCONF, "O_DIRECT is not supported by the filesystem");
+
+		tst_brk(TBROK | TERRNO, "open(%s) failed", IO_FILE);
+	}
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(IO_FILE);
+
+	io_wait_us = SAFE_MMAP(NULL, sizeof(*io_wait_us), PROT_READ | PROT_WRITE,
+			       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (io_wait_us)
+		SAFE_MUNMAP(io_wait_us, sizeof(*io_wait_us));
+
+	if (cg_psi)
+		cg_psi = tst_cg_group_rm(cg_psi);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tests),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.timeout = 60,
+	.min_kver = "4.20",
+	.min_mem_avail = 256,
+	.needs_device = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const[]) {"memory", NULL},
+	.needs_kconfigs = (const char *const[]) {
+		"CONFIG_PSI=y",
+		NULL
+	},
+};
+
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
