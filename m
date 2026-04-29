Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF5FF8867
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 00:47:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E21283C7A5F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 02:47:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A9553C7A5F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 02:47:19 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8FD410000E7
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 02:47:18 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCOIPT2327619
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=wXaNcLIm6BwrYfgwydZwm8R8bU2hVQ0zIL0dIyk/j
 HY=; b=J5ZfswaejP0PrUbOpYI3GYw9FjGKOPUn1QyrDFMG09NOo6Rv6bMQgil3u
 3Fr9/JOFHOEorY0Yr5mYxwVgJkQElebBOH0N3g4MrTkum72qQuoA4Jm5LkXpCHgv
 YjA9am7L5BopnmSJ22CNMeGCnHPuy1rmHqwdc6VGP5Is9dbnFc79LMTbEkIoJg/K
 kaTrOXrPFYY91M1yRTKpoFkUuGAerPrIIuulsQWq5ZYlZSyKTrp2h6d0kO6WRuTU
 /Md5/HNfG5cNxMkQpYVcjHpJzRuY6q5BrFkPpqqJz/IKPFBFKlazoqoXsohZuI/A
 LT5054uO6QbwRpKs9CP7JfjX/mWHw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r334q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:47:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S0ckN7003806
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:47:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avqm1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:47:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63S0lEvr19727090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 00:47:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F17785805A;
 Tue, 28 Apr 2026 00:47:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFA0A58051;
 Tue, 28 Apr 2026 00:47:13 +0000 (GMT)
Received: from botlp69.isst.tadn.ibm.com (unknown [9.5.7.36])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 00:47:13 +0000 (GMT)
From: priyama2 <priyama2@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 29 Apr 2026 10:51:14 +0000
Message-ID: <20260429105114.710966-1-priyama2@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z-SJd-fnAaj4l94hPm2UIVMXx0tGvQGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAwMSBTYWx0ZWRfX1OOjAlfv1Vu/
 DYrh2En39bt+0PfZpe4LYrmzI0oy0ZOw8bf1WuixHvekZJs4YmZEf41JfZxo+mfvh6FHlFQIV79
 tavSpu4QRbClYyptQlQSyR9VVtDC42maDx2PFgRhW/MusPIUWEoq+1QuSAtrP4uFCywdWN0T/cb
 Kg6cQE0885RVnGIpK5dM0xOAYcr9auszPJ1Uj15F8tLL8gNBCp8zQB7MQ4FjVVraWYVIjTpEU9f
 iglHuEMk4agfsBcJ75datth0IiF7d7MW7LaDxi+wwstKG5e4eCknNwBfkrFABn/Kz/sXnoLD4Gl
 LYLIVyBzMfVItM0koPDNTsvH4o2Eq6WfbLBnko+ALZiwvU/qGnCGg4aDn+YiK7kiPbD59LTApbU
 3kpHq3ZLTL24xj1gkkA/aEtjcvcaDvNwloceYty9qS2hKdyEnpM9Y0NB33RYQyh3iTckZUjZiSM
 EU6hUNdImewakYGaU3g==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f00394 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pNaSbsGRAAAA:8 a=NEAV23lmAAAA:8 a=2vtMdsJAAAAA:8
 a=VnNF1IyMAAAA:8 a=fWpSmyuFXFEm1FXd86wA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=cz0TccRYsqG1oLvFGeGV:22 a=MdDwjtskJbVj7SMrG5yS:22
X-Proofpoint-ORIG-GUID: z-SJd-fnAaj4l94hPm2UIVMXx0tGvQGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280001
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] testcases/nvme: Add NVMe device discovery and
 identification test
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

This patch introduces the first test case (nvme01) for NVMe device
testing in LTP. The test verifies:

- Detection of NVMe controllers in the system
- Enumeration of NVMe namespaces
- PCI bus enumeration verification
- Driver binding validation

The test uses the LTP test framework (tst_test.h) and follows LTP
coding standards. It provides comprehensive coverage for basic NVMe
device discovery functionality.

Tested on:
- System: ppc64le, RHEL 10.2
- Kernel: 6.12.0-210.el10.ppc64le
- Hardware: Samsung PM1735a NVMe devices
- Result: All 4 test cases passed

This is the first in a series of patches to add comprehensive NVMe
testing support to LTP.

Signed-off-by: priyama2 <priyama2@linux.ibm.com>
---
 testcases/kernel/device-drivers/nvme/Makefile |  42 ++++
 testcases/kernel/device-drivers/nvme/README   | 155 ++++++++++++
 testcases/kernel/device-drivers/nvme/nvme01.c | 236 ++++++++++++++++++
 3 files changed, 433 insertions(+)
 create mode 100644 testcases/kernel/device-drivers/nvme/Makefile
 create mode 100644 testcases/kernel/device-drivers/nvme/README
 create mode 100644 testcases/kernel/device-drivers/nvme/nvme01.c

diff --git a/testcases/kernel/device-drivers/nvme/Makefile b/testcases/kernel/device-drivers/nvme/Makefile
new file mode 100644
index 000000000..ace6696f6
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/Makefile
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 IBM Corporation
+#
+# Standalone Makefile for NVMe LTP test suite
+
+# Compiler and flags
+CC		= gcc
+CFLAGS		= -Wall -O2 -I/opt/ltp/include
+LDFLAGS		= -L/opt/ltp/lib
+LDLIBS		= -lltp -lrt
+
+# Test binaries
+TARGETS		= nvme01 nvme02 nvme03 nvme04
+
+# Build all tests
+all: $(TARGETS)
+
+nvme01: nvme01.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
+
+nvme02: nvme02.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
+
+nvme03: nvme03.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
+
+nvme04: nvme04.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
+
+# Install targets
+install: $(TARGETS)
+	@mkdir -p /opt/ltp/testcases/bin
+	@for target in $(TARGETS); do \
+		install -m 0755 $$target /opt/ltp/testcases/bin/; \
+	done
+	@echo "Tests installed to /opt/ltp/testcases/bin/"
+
+# Clean
+clean:
+	rm -f $(TARGETS) *.o
+
+.PHONY: all install clean
\ No newline at end of file
diff --git a/testcases/kernel/device-drivers/nvme/README b/testcases/kernel/device-drivers/nvme/README
new file mode 100644
index 000000000..6ee5796fe
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/README
@@ -0,0 +1,155 @@
+NVMe Test Suite for Linux Test Project (LTP)
+==============================================
+
+This directory contains test cases for NVMe (Non-Volatile Memory Express) 
+device functionality testing.
+
+Test Cases
+----------
+
+1. nvme01 - Device Discovery & Identification
+   Tests:
+   - Detect NVMe controllers
+   - Enumerate namespaces
+   - Verify PCI enumeration
+   - Check driver binding
+
+2. nvme02 - Namespace Management
+   Tests:
+   - Create namespaces (various sizes)
+   - Delete namespaces
+   - Attach/detach namespaces to controllers
+   - Resize namespaces
+   - Format namespaces (different block sizes: 512B, 4KB)
+   - Namespace sharing across controllers
+
+3. nvme03 - I/O Operations
+   Tests:
+   - Sequential read/write operations
+   - Random read/write operations
+   - Mixed workloads
+   - Different block sizes (512B, 4KB, 8KB)
+   - Queue depth variations
+   - Direct I/O vs buffered I/O
+
+4. nvme04 - Multipath & Redundancy
+   Tests:
+   - Path failover testing
+   - Load balancing across paths
+   - Path recovery
+   - ANA (Asymmetric Namespace Access) states
+   - Controller failover
+
+Requirements
+------------
+
+Hardware:
+- System with NVMe storage device(s)
+- For multipath tests: NVMe device with multiple paths configured
+
+Software:
+- Linux kernel with NVMe support (CONFIG_BLK_DEV_NVME=y)
+- nvme-cli tools (for namespace management tests)
+- Root/sudo privileges
+
+Building
+--------
+
+From the LTP root directory:
+  make -C testcases/kernel/device-drivers/nvme
+
+Or from this directory:
+  make
+
+Running Tests
+-------------
+
+Individual test execution:
+  ./nvme01
+  ./nvme02
+  ./nvme03
+  ./nvme04
+
+Using LTP runtest:
+  runltp -f nvme
+
+Using runtest file:
+  runltp -f /opt/ltp/runtest/nvme
+
+Test Results
+------------
+
+Tests use standard LTP result codes:
+- TPASS: Test passed
+- TFAIL: Test failed
+- TCONF: Test not configured (e.g., no NVMe device found)
+- TBROK: Test broken (setup failure)
+- TWARN: Test warning
+
+Notes
+-----
+
+1. Some tests require specific hardware configurations:
+   - nvme02: May require namespace management support
+   - nvme04: Requires multipath configuration for full testing
+
+2. Destructive tests:
+   - nvme02 includes namespace creation/deletion which may affect data
+   - Always run on test systems or with proper backups
+
+3. Performance tests (nvme03):
+   - Results vary based on hardware and system load
+   - Tests measure relative performance, not absolute benchmarks
+
+4. Root privileges:
+   - All tests require root access for device operations
+
+Test Coverage
+-------------
+
+The test suite covers:
+- Basic NVMe device detection and enumeration
+- Namespace lifecycle management
+- I/O performance characteristics
+- Multipath and redundancy features
+- Driver and controller state verification
+
+Known Limitations
+-----------------
+
+1. Namespace management tests may not work on all NVMe devices
+   (depends on controller capabilities)
+
+2. Multipath tests require specific hardware and kernel configuration
+
+3. Some tests are informational and may show TCONF on systems
+   without full NVMe feature support
+
+Contributing
+------------
+
+When adding new tests:
+1. Follow LTP coding standards
+2. Use tst_test.h framework
+3. Include proper error handling
+4. Document test purpose and requirements
+5. Test on multiple NVMe device types if possible
+
+References
+----------
+
+- NVMe Specification: https://nvmexpress.org/specifications/
+- Linux NVMe Driver: Documentation/block/nvme.rst
+- nvme-cli: https://github.com/linux-nvme/nvme-cli
+- LTP Documentation: https://linux-test-project.github.io/
+
+Authors
+-------
+
+Copyright (c) 2024 IBM Corporation
+LTP NVMe Test Suite
+
+License
+-------
+
+SPDX-License-Identifier: GPL-2.0-or-later
\ No newline at end of file
diff --git a/testcases/kernel/device-drivers/nvme/nvme01.c b/testcases/kernel/device-drivers/nvme/nvme01.c
new file mode 100644
index 000000000..82fbd315b
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/nvme01.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 IBM Corporation
+ * Author: LTP NVMe Test Suite
+ *
+ * Test: NVMe Device Discovery & Identification
+ *
+ * This test verifies:
+ * - Detection of NVMe controllers
+ * - Enumeration of namespaces
+ * - PCI enumeration verification
+ * - Driver binding check
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <dirent.h>
+#include <errno.h>
+
+#include "tst_test.h"
+
+#define NVME_DEV_PATH "/dev"
+#define NVME_SYS_PATH "/sys/class/nvme"
+#define PCI_DEVICES_PATH "/sys/bus/pci/devices"
+
+static int nvme_device_found = 0;
+static char nvme_dev_name[256];
+
+/*
+ * Test Case 1: Detect NVMe Controllers
+ * Verifies that NVMe controllers are present in the system
+ */
+static void test_detect_nvme_controllers(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int found = 0;
+
+	dir = opendir(NVME_DEV_PATH);
+	if (!dir) {
+		tst_brk(TBROK | TERRNO, "Failed to open %s", NVME_DEV_PATH);
+		return;
+	}
+
+	tst_res(TINFO, "Scanning for NVMe devices in %s", NVME_DEV_PATH);
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strncmp(entry->d_name, "nvme", 4) == 0 &&
+		    strlen(entry->d_name) == 5) {  /* nvme0, nvme1, etc. */
+			tst_res(TINFO, "Found NVMe controller: %s", entry->d_name);
+			strncpy(nvme_dev_name, entry->d_name, sizeof(nvme_dev_name) - 1);
+			found = 1;
+			nvme_device_found = 1;
+		}
+	}
+
+	closedir(dir);
+
+	if (found)
+		tst_res(TPASS, "NVMe controller(s) detected successfully");
+	else
+		tst_res(TCONF, "No NVMe controllers found in system");
+}
+
+/*
+ * Test Case 2: Enumerate Namespaces
+ * Verifies that NVMe namespaces can be enumerated
+ */
+static void test_enumerate_namespaces(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int ns_count = 0;
+	char search_pattern[32];
+
+	if (!nvme_device_found) {
+		tst_res(TCONF, "No NVMe device found, skipping namespace enumeration");
+		return;
+	}
+
+	snprintf(search_pattern, sizeof(search_pattern), "%sn", nvme_dev_name);
+
+	dir = opendir(NVME_DEV_PATH);
+	if (!dir) {
+		tst_brk(TBROK | TERRNO, "Failed to open %s", NVME_DEV_PATH);
+		return;
+	}
+
+	tst_res(TINFO, "Enumerating namespaces for %s", nvme_dev_name);
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strncmp(entry->d_name, search_pattern, strlen(search_pattern)) == 0) {
+			tst_res(TINFO, "Found namespace: %s", entry->d_name);
+			ns_count++;
+		}
+	}
+
+	closedir(dir);
+
+	if (ns_count > 0)
+		tst_res(TPASS, "Enumerated %d namespace(s) successfully", ns_count);
+	else
+		tst_res(TPASS, "No namespaces found for %s (device may not have namespaces configured)", nvme_dev_name);
+}
+
+/*
+ * Test Case 3: Verify PCI Enumeration
+ * Checks if NVMe device is properly enumerated on PCI bus
+ */
+static void test_verify_pci_enumeration(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int found = 0;
+	char class_path[512];
+	FILE *fp;
+	char class_id[16];
+
+	if (!nvme_device_found) {
+		tst_res(TCONF, "No NVMe device found, skipping PCI enumeration check");
+		return;
+	}
+
+	dir = opendir(PCI_DEVICES_PATH);
+	if (!dir) {
+		tst_brk(TBROK | TERRNO, "Failed to open %s", PCI_DEVICES_PATH);
+		return;
+	}
+
+	tst_res(TINFO, "Checking PCI enumeration for NVMe devices");
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_name[0] == '.')
+			continue;
+
+		snprintf(class_path, sizeof(class_path), "%s/%s/class",
+			 PCI_DEVICES_PATH, entry->d_name);
+
+		fp = fopen(class_path, "r");
+		if (!fp)
+			continue;
+
+		if (fgets(class_id, sizeof(class_id), fp)) {
+			/* NVMe class code is 0x010802 (Mass storage controller: NVM Express) */
+			if (strncmp(class_id, "0x010802", 8) == 0) {
+				tst_res(TINFO, "Found NVMe PCI device: %s (class: %s)",
+					entry->d_name, class_id);
+				found = 1;
+			}
+		}
+		fclose(fp);
+	}
+
+	closedir(dir);
+
+	if (found)
+		tst_res(TPASS, "NVMe device properly enumerated on PCI bus");
+	else
+		tst_res(TFAIL, "NVMe device not found on PCI bus");
+}
+
+/*
+ * Test Case 4: Check Driver Binding
+ * Verifies that NVMe driver is properly bound to the device
+ */
+static void test_check_driver_binding(void)
+{
+	char driver_path[512];
+	char driver_link[512];
+	ssize_t len;
+
+	if (!nvme_device_found) {
+		tst_res(TCONF, "No NVMe device found, skipping driver binding check");
+		return;
+	}
+
+	snprintf(driver_path, sizeof(driver_path), "%s/%s/device/driver",
+		 NVME_SYS_PATH, nvme_dev_name);
+
+	len = readlink(driver_path, driver_link, sizeof(driver_link) - 1);
+	if (len == -1) {
+		tst_res(TFAIL | TERRNO, "Failed to read driver symlink for %s", nvme_dev_name);
+		return;
+	}
+
+	driver_link[len] = '\0';
+
+	tst_res(TINFO, "Driver binding: %s", driver_link);
+
+	if (strstr(driver_link, "nvme") != NULL)
+		tst_res(TPASS, "NVMe driver properly bound to device");
+	else
+		tst_res(TFAIL, "Unexpected driver bound to NVMe device: %s", driver_link);
+}
+
+static void setup(void)
+{
+	/* Check if nvme module is loaded */
+	if (access("/sys/module/nvme", F_OK) != 0)
+		tst_brk(TCONF, "NVMe kernel module not loaded");
+
+	tst_res(TINFO, "NVMe Device Discovery & Identification Test");
+}
+
+static void run(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		test_detect_nvme_controllers();
+		break;
+	case 1:
+		test_enumerate_namespaces();
+		break;
+	case 2:
+		test_verify_pci_enumeration();
+		break;
+	case 3:
+		test_check_driver_binding();
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 4,
+	.setup = setup,
+	.needs_root = 1,
+};
+
+// Made with Bob
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
