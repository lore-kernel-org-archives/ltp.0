Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BF6EF4EC9
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 10:03:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B64953CE11D
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 12:03:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FF1D3C2B7E
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 12:03:21 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 09E0A600131
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 12:03:20 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635JP1Hq3413620
 for <ltp@lists.linux.it>; Mon, 6 Apr 2026 10:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=WFFV88/qt2KLnd7mp/4PpYQ/3GlG6ct9sk14FTV6s
 9c=; b=TNZb38nZ2i3dqHP9gWARQ22xPcW6p/JN2tVRCr5k02i3iUi1zv9eFEZJ6
 aDzhZ78uJ363TPOScfr7wrP4x29S2YaDIkUahB2OnlDFcytTlTwThoH2wkBcvWxn
 d0hwsR8yU/xz2ns9mxUdHwn61yDTLe8s+hx7wGArVoOC9V4R59OVIIDvfWJt+13Q
 8IsrnSwSzNIE4Uk8DMVt1ngzxie7b/6Dv6L8+8Ef+3akgqLsIR4fK3AjM+vLzXzq
 ahDiqSnHYVHnghFQ0yDWLtOSNWio7PHFnV749NOwBh83soEF6PHRzsD7GVm+edjv
 AJ6vZVDeMWXKIHKpY7s8TvBA4hVZA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2gdt4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 06 Apr 2026 10:03:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6366id1f014784
 for <ltp@lists.linux.it>; Mon, 6 Apr 2026 10:03:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbf6jv26u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 06 Apr 2026 10:03:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 636A3EVD29557432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2026 10:03:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A0922004D;
 Mon,  6 Apr 2026 10:03:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4EBE2004B;
 Mon,  6 Apr 2026 10:03:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.228.243])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2026 10:03:13 +0000 (GMT)
From: Abdulla <abdulla1@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  6 Apr 2026 15:33:11 +0530
Message-Id: <20260406100311.79619-1-abdulla1@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rh1c7wD0AtfMqwbAd0cYzfDb5STlW9jK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5NiBTYWx0ZWRfX0SUeGs7ayA5U
 aq0IoGxjwkfDYwvEOhxWX0PRm7AkVHKam940GYmcRW7u8jsXWyTUprOAL9PY8nfbV78hMgwQrc1
 9Y8jyyUkV3c2iKGJz45awrOnIOJL6HKSTOvyaPQ+tsBifK0Ok9y22xMF0Av7uIn7y6lzV6t4AsK
 FkIvrhrOBCDBVThlrSyyr3sARUdQ6BnbOwSvrTqgK1TG2Ev9L7xJWzhX0M4Sc3jYhHOFp4UOl+P
 9C5i8ZQbdNlvIDIG5CG19eiNTePsEZVJ10sLo/qNFyAbg8dAiE2hNUkswCKwzitJ1OTaTriPtpl
 +OlXdzTaM6WhyvhX0RRI3Qg2defIMSD2JjCGQmTZy6hCJs7HbKSnhrnV3svPtgWpONkbXvQjhY3
 Sz2zN3nT11sfeNTWwN0FCwUlLSAducCUR9eu1+Bzw3W85ZCHl57hmSmK9xVQ7xnSR6bg5fr2WU8
 AAmLHUT4TuDSUYZoWWg==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d384e7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=BqmSNwtJosOcRg9k20kA:9
X-Proofpoint-ORIG-GUID: rh1c7wD0AtfMqwbAd0cYzfDb5STlW9jK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060096
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/ioctl02: Move TTY discovery from shell to C
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test previously required a shell wrapper to discover and validate
TTY devices. This modernization moves all TTY discovery logic into C,
eliminating the shell dependency.

Key changes:
- Added is_valid_tty_name() for pattern matching tty[0-9]*
- Added is_valid_tty_device() for ioctl-based validation
- Added find_valid_ttys() for /dev directory scanning
- Made device parameter optional with auto-discovery mode
- Extracted test_single_device() for code reusability

The test now supports two modes:
1. Single device: ./ioctl02 -d /dev/tty1 (backward compatible)
2. Auto-discovery: ./ioctl02 (discovers all valid TTY devices)

Signed-off-by: Shaik Abdulla <abdulla1@linux.ibm.com>
---
 .../syscalls/ioctl/ioctl02_modernized.c       | 431 ++++++++++++++++++
 1 file changed, 431 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl02_modernized.c

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02_modernized.c b/testcases/kernel/syscalls/ioctl/ioctl02_modernized.c
new file mode 100644
index 000000000..44b43db19
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl02_modernized.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
+ * Copyright (c) 2026 Modernization - TTY discovery moved from shell to C
+ */
+
+/*\
+ * Test TCGETA/TCGETS and TCSETA/TCSETS ioctl implementations for tty driver.
+ *
+ * This test can operate in two modes:
+ * 1. Single device mode: Use -d option to test a specific TTY device
+ * 2. Auto-discovery mode: Automatically discovers and tests all valid /dev/tty[0-9]* devices
+ *
+ * In this test, the parent and child open the parentty and the childtty
+ * respectively.  After opening the childtty the child flushes the stream
+ * and wakes the parent (thereby asking it to continue its testing). The
+ * parent, then starts the testing. It issues a TCGETA/TCGETS ioctl to
+ * get all the tty parameters. It then changes them to known values by
+ * issuing a TCSETA/TCSETS ioctl. Then the parent issues a TCSETA/TCGETS
+ * ioctl again and compares the received values with what it had set
+ * earlier. The test fails if TCGETA/TCGETS or TCSETA/TCSETS fails, or if
+ * the received values don't match those that were set. The parent does
+ * all the testing, the requirement of the child process is to moniter
+ * the testing done by the parent, and hence the child just waits for the
+ * parent.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <asm/termbits.h>
+
+#include "lapi/ioctl.h"
+#include "tst_test.h"
+
+#define MAX_TTYS 100
+#define TTY_PATH_MAX 256
+
+static struct termio termio, termio_exp;
+static struct termios termios, termios_exp, termios_bak;
+
+static char *parenttty, *childtty;
+static int parentfd = -1;
+static int parentpid, childpid;
+
+/* TTY device list for auto-discovery mode */
+static char *tty_list[MAX_TTYS];
+static int tty_count = 0;
+
+static void do_child(void);
+static void prepare_termio(void);
+static void run_ptest(void);
+static void chk_tty_parms_termio(void);
+static void chk_tty_parms_termios(void);
+static void setup(void);
+static void cleanup(void);
+static void test_single_device(const char *dev);
+static void find_valid_ttys(void);
+static void free_tty_list(void);
+static int is_valid_tty_name(const char *name);
+static int is_valid_tty_device(const char *path);
+
+static char *device;
+
+static struct variant {
+	const char *name;
+	void *termio, *termio_exp, *termio_bak;
+	size_t termio_size;
+	void (*check)(void);
+	int tcget, tcset;
+} variants[] = {
+	{
+		.name = "termio",
+		.termio = &termio,
+		.termio_exp = &termio_exp,
+		.termio_size = sizeof(termio),
+		.check = &chk_tty_parms_termio,
+		.tcget = TCGETA,
+		.tcset = TCSETA,
+	},
+	{
+		.name = "termios",
+		.termio = &termios,
+		.termio_exp = &termios_exp,
+		.termio_size = sizeof(termios),
+		.check = &chk_tty_parms_termios,
+		.tcget = TCGETS,
+		.tcset = TCSETS,
+	},
+};
+
+/*
+ * is_valid_tty_name() - Check if device name matches tty[0-9] or tty[0-9][0-9]
+ */
+static int is_valid_tty_name(const char *name)
+{
+	const char *device_no;
+
+	/* Must start with "tty" */
+	if (strncmp(name, "tty", 3) != 0)
+		return 0;
+
+	device_no = name + 3;
+
+	/* Must have at least one digit */
+	if (!isdigit(device_no[0]))
+		return 0;
+
+	/* If there's a second character, it must be a digit */
+	if (device_no[1] != '\0' && !isdigit(device_no[1]))
+		return 0;
+
+	/* Must not have more than 2 digits */
+	if (device_no[1] != '\0' && device_no[2] != '\0')
+		return 0;
+
+	return 1;
+}
+
+/*
+ * is_valid_tty_device() - Validate TTY device by attempting ioctl
+ * This replaces the shell's "stty -F" validation
+ */
+static int is_valid_tty_device(const char *path)
+{
+	int fd;
+	struct termios t;
+	int ret;
+
+	/* Try to open device with non-blocking flag */
+	fd = open(path, O_RDWR | O_NONBLOCK);
+	if (fd < 0)
+		return 0;
+
+	/* Try to get terminal attributes - this validates it's a real TTY */
+	ret = ioctl(fd, TCGETS, &t);
+	close(fd);
+
+	return (ret == 0);
+}
+
+/*
+ * find_valid_ttys() - Discover all valid TTY devices in /dev
+ * This replaces the shell wrapper's "for tttype in `ls /dev/tty*`" logic
+ */
+static void find_valid_ttys(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+	char tty_path[TTY_PATH_MAX];
+
+	dir = opendir("/dev");
+	if (!dir)
+		tst_brk(TBROK | TERRNO, "Cannot open /dev directory");
+
+	tst_res(TINFO, "Scanning /dev for valid TTY devices...");
+
+	while ((entry = readdir(dir)) != NULL) {
+		/* Check if name matches tty[0-9] or tty[0-9][0-9] pattern */
+		if (!is_valid_tty_name(entry->d_name))
+			continue;
+
+		/* Build full path */
+		snprintf(tty_path, sizeof(tty_path), "/dev/%s", entry->d_name);
+
+		/* Validate it's a working TTY device */
+		if (!is_valid_tty_device(tty_path)) {
+			tst_res(TINFO, "Skipping %s (not a valid TTY)", tty_path);
+			continue;
+		}
+
+		/* Add to list if we have space */
+		if (tty_count >= MAX_TTYS) {
+			tst_res(TWARN, "Too many TTY devices found, skipping %s", tty_path);
+			continue;
+		}
+
+		tty_list[tty_count] = strdup(tty_path);
+		if (!tty_list[tty_count])
+			tst_brk(TBROK | TERRNO, "Failed to allocate memory for TTY path");
+
+		tst_res(TINFO, "Found valid TTY device: %s", tty_path);
+		tty_count++;
+	}
+
+	closedir(dir);
+
+	if (tty_count == 0)
+		tst_brk(TBROK, "No valid TTY devices found in /dev");
+
+	tst_res(TINFO, "Total valid TTY devices found: %d", tty_count);
+}
+
+/*
+ * free_tty_list() - Free allocated TTY device paths
+ */
+static void free_tty_list(void)
+{
+	int i;
+
+	for (i = 0; i < tty_count; i++) {
+		if (tty_list[i]) {
+			free(tty_list[i]);
+			tty_list[i] = NULL;
+		}
+	}
+	tty_count = 0;
+}
+
+/*
+ * test_single_device() - Test a single TTY device
+ * Extracted from verify_ioctl() to support both single and multi-device modes
+ */
+static void test_single_device(const char *dev)
+{
+	parenttty = childtty = (char *)dev;
+
+	parentpid = getpid();
+	childpid = SAFE_FORK();
+	if (!childpid) {
+		do_child();
+		exit(EXIT_SUCCESS);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	parentfd = SAFE_OPEN(parenttty, O_RDWR, 0777);
+	SAFE_IOCTL(parentfd, TCFLSH, TCIOFLUSH);
+
+	run_ptest();
+
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_CLOSE(parentfd);
+	parentfd = -1;
+}
+
+static void verify_ioctl(void)
+{
+	int i;
+
+	tst_res(TINFO, "Testing %s variant", variants[tst_variant].name);
+
+	if (device) {
+		/* Single device mode - test specified device only */
+		tst_res(TINFO, "Single device mode: testing %s", device);
+		test_single_device(device);
+	} else {
+		/* Auto-discovery mode - find and test all valid TTYs */
+		tst_res(TINFO, "Auto-discovery mode: scanning for TTY devices");
+		find_valid_ttys();
+
+		for (i = 0; i < tty_count; i++) {
+			tst_res(TINFO, "Testing device %d/%d: %s",
+				i + 1, tty_count, tty_list[i]);
+			test_single_device(tty_list[i]);
+		}
+
+		free_tty_list();
+	}
+}
+
+static void prepare_termio(void)
+{
+	/* Use "old" line discipline */
+	termios_exp.c_line = termio_exp.c_line = 0;
+
+	/* Set control modes */
+	termios_exp.c_cflag = termio_exp.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
+
+	/* Set control chars. */
+	for (int i = 0; i < NCC; i++)
+		termio_exp.c_cc[i] = CSTART;
+	for (int i = 0; i < VEOL2; i++)
+		termios_exp.c_cc[i] = CSTART;
+
+	/* Set local modes. */
+	termios_exp.c_lflag = termio_exp.c_lflag =
+	    ((unsigned short)(ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH));
+
+	/* Set input modes. */
+	termios_exp.c_iflag = termio_exp.c_iflag =
+	    BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY |
+	    IXOFF;
+
+	/* Set output modes. */
+	termios_exp.c_oflag = termio_exp.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
+}
+
+/*
+ * run_ptest() - setup the various termio/termios structure values and issue
+ * the TCSETA/TCSETS ioctl call with the TEST macro.
+ */
+static void run_ptest(void)
+{
+	struct variant *v = &variants[tst_variant];
+
+	/* Init termio/termios structures used to check if all params got set */
+	memset(v->termio, 0, v->termio_size);
+
+	SAFE_IOCTL(parentfd, v->tcset, v->termio_exp);
+
+	/* Get termio and see if all parameters actually got set */
+	SAFE_IOCTL(parentfd, v->tcget, v->termio);
+	v->check();
+}
+
+static int cmp_attr(unsigned long long exp, unsigned long long act, const char *attr)
+{
+	if (act == exp)
+		return 0;
+	tst_res(TFAIL, "%s has incorrect value %llu, expected %llu",
+		attr, act, exp);
+	return 1;
+}
+
+static int cmp_c_cc(unsigned char *exp_c_cc, unsigned char *act_c_cc, int ncc)
+{
+	int i, fails = 0;
+	char what[32];
+
+	for (i = 0; i < ncc; ++i) {
+		sprintf(what, "control char %d", i);
+		fails += cmp_attr(exp_c_cc[i], act_c_cc[i], what);
+	}
+	return fails;
+}
+
+#define CMP_ATTR(term_exp, term, attr, flag)				\
+({															\
+	flag += cmp_attr((term_exp).attr, (term).attr, #attr);	\
+	flag;                                                   \
+})
+
+#define CMP_C_CC(term_exp, term, flag)								\
+({																	\
+	flag += cmp_c_cc(term_exp.c_cc, term.c_cc, sizeof(term.c_cc));	\
+	flag;															\
+})
+
+static void chk_tty_parms_termio(void)
+{
+	int flag = 0;
+
+	flag = CMP_ATTR(termio_exp, termio, c_line, flag);
+	flag = CMP_C_CC(termio_exp, termio, flag);
+	flag = CMP_ATTR(termio_exp, termio, c_lflag, flag);
+	flag = CMP_ATTR(termio_exp, termio, c_iflag, flag);
+	flag = CMP_ATTR(termio_exp, termio, c_oflag, flag);
+
+	if (!flag)
+		tst_res(TPASS, "TCGETA/TCSETA tests");
+}
+
+static void chk_tty_parms_termios(void)
+{
+	int flag = 0;
+
+	flag = CMP_ATTR(termios_exp, termios, c_line, flag);
+	flag = CMP_C_CC(termios_exp, termios, flag);
+	flag = CMP_ATTR(termios_exp, termios, c_lflag, flag);
+	flag = CMP_ATTR(termios_exp, termios, c_iflag, flag);
+	flag = CMP_ATTR(termios_exp, termios, c_oflag, flag);
+
+	if (!flag)
+		tst_res(TPASS, "TCGETS/TCSETS tests");
+}
+
+static void do_child(void)
+{
+	int cfd = SAFE_OPEN(childtty, O_RDWR, 0777);
+
+	SAFE_IOCTL(cfd, TCFLSH, TCIOFLUSH);
+
+	/* tell the parent that we're done */
+	TST_CHECKPOINT_WAKE(0);
+
+	TST_CHECKPOINT_WAIT(0);
+	tst_res(TINFO, "child: parent has finished testing");
+	SAFE_CLOSE(cfd);
+}
+
+static void setup(void)
+{
+	int fd;
+
+	if (device) {
+		/* Single device mode - validate the specified device */
+		tst_res(TINFO, "Using specified device: %s", device);
+
+		fd = SAFE_OPEN(device, O_RDWR, 0777);
+		SAFE_IOCTL(fd, TCGETS, &termios_bak);
+		SAFE_CLOSE(fd);
+	} else {
+		/* Auto-discovery mode - will find devices during test */
+		tst_res(TINFO, "Auto-discovery mode enabled");
+	}
+
+	prepare_termio();
+}
+
+static void cleanup(void)
+{
+	if (parentfd >= 0) {
+		SAFE_IOCTL(parentfd, TCSETS, &termios_bak);
+		SAFE_CLOSE(parentfd);
+	}
+
+	/* Free any allocated TTY list */
+	free_tty_list();
+}
+
+static struct tst_test test = {
+	.timeout = 20,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ioctl,
+	.test_variants = 2,
+	.options = (struct tst_option[]) {
+		{"d:", &device, "TTY device to test (optional). If not specified, auto-discovers all /dev/tty[0-9]* devices. Example: /dev/tty1"},
+		{}
+	}
+};
+
-- 
2.39.5 (Apple Git-154)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
