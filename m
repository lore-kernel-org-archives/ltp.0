Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F13FF886F
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 05:10:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5C8C3E24FE
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 07:10:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 743143E0E7A
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 07:10:22 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9AAE9600749
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 07:10:21 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63THKaJR2036575; Thu, 30 Apr 2026 05:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=en6c89Ng9NQdeXySa
 gZOxmvAHvFEo+srAzzrw4eNqyY=; b=p80o3jaeZPpQ4WS2yPwCcoKEij4WOFV1J
 SqaXhBY8rIF4hidLHzYPyST92jSPR8SCQtg9nzg3yV1NLrSF2DWQjVk0yfaTCcID
 OK+prKfi8C9qKokFA3Hu1Hr0bqh9kQRoIqE4huu58K3uVHSPaZaqwiGcHRPMLmiD
 QKZY97Knxuwm+OtCN2u8N1YDLnh2GFIQMC+qHAwx0jZbXwcMBC3L0Yrub2oq89nG
 DtELR7HsH+kEn3u/PxZOb/kQOWoOEHpVjkL2p2mTAcnp2uLafyER4T9cl1NL4JBO
 2NFQgEJ41h96tEDW7EC62rUpCSvMBQmKCsFCfZwJd0qOb7JqEIXaA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jvgpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 05:10:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U58w8l013487;
 Thu, 30 Apr 2026 05:10:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyh8c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 05:10:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63U5AH8e64749908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 05:10:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84C9058043;
 Thu, 30 Apr 2026 05:10:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A63658053;
 Thu, 30 Apr 2026 05:10:17 +0000 (GMT)
Received: from botlp69.isst.tadn.ibm.com (unknown [9.5.7.36])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 05:10:17 +0000 (GMT)
From: priyama2@linux.ibm.com
To: ltp@lists.linux.it
Date: Fri,  1 May 2026 15:14:20 +0000
Message-ID: <20260501151420.1042995-1-priyama2@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA0NSBTYWx0ZWRfX2/JDwTnLiYZ9
 8VrOnpu9sdkIhUVNbbq/mUeA9tj7NLFMWS85C4LfrRuk9QSUQZJsfHDzXZ3P9kpIqknnWDtncKC
 gxUQ4tfSmkE+b94IBS6gWEs6JT18mXN45PF/JF7eaCvtYH0z89vS0BClhpDaRtW/tVZuuDrmY5U
 SOeYKXh68v8BPiDrFrCIMekYc+rpGR7UGoG/hwfFC5scrOmjGYhZh4heEQO/rG/H2wHg1nF4emh
 VorIsyKhXXVwDDNtQXsI1vJS5GBGhIYkoDH2YJQ3zWx6qArAwItwk9aW8qBEHVXBbYzet+G+pNb
 L32mfxwfB5zZ5BM/XX1TNn7cfNSgrMFju0jTqAi9AdPJOJU2JyxzWILtUmqLOSqdEtwto601l95
 Z/5tSJpPB3neySZ2kqSr/HgM/aFN1ItCAXVULtUXJPeHo3n7y1CW66WRQE5ss75ELNSBi3bvqbC
 ItspFgcBvjIc1K6W3mQ==
X-Proofpoint-GUID: 9zi4XND94uTnvnPs2xcZxblBp3M2vF_8
X-Proofpoint-ORIG-GUID: 9zi4XND94uTnvnPs2xcZxblBp3M2vF_8
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f2e43b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_TXCIjpbKOfXyxnRZMsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300045
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
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

From: priyama2 <priyama2@linux.ibm.com>

This test fills a gap in NVMe test coverage by validating basic device
enumeration and driver binding, which are fundamental prerequisites for
any NVMe functionality testing.

The test verifies:
- Detection of NVMe controllers in /dev
- Enumeration of namespaces for detected controllers
- PCI enumeration (class code 0x010802)
- NVMe driver binding

Changes in v3:
- Fix subject prefix to match directory path
- Update copyright year to 2026
- Add nvme to SUBDIRS in testcases/kernel/device-drivers/Makefile
- Reset static variables at start of run() for -i support
- Remove .needs_root (all operations are world-readable)
- Use SAFE_FOPEN/SAFE_FCLOSE for PCI class file access
- Use SAFE_READLINK for driver symlink reading
- Add .gitignore entry for nvme01 binary
- Add runtest/device-drivers entry for nvme01
- Fix author field to use priyama2

Changes in v2:
- Use LTP buildsystem instead of standalone Makefile
- Remove README file (use doc comments instead)
- Add proper LTP documentation comment format
- Use SAFE_OPENDIR() and SAFE_CLOSEDIR() macros
- Remove obvious and redundant comments
- Code cleanup and style improvements

Signed-off-by: priyama2 <priyama2@linux.ibm.com>
---
 runtest/device-drivers                        |   1 +
 testcases/kernel/device-drivers/Makefile      |   1 +
 .../kernel/device-drivers/nvme/.gitignore     |   1 +
 testcases/kernel/device-drivers/nvme/Makefile |   7 +
 testcases/kernel/device-drivers/nvme/nvme01.c | 205 ++++++++++++++++++
 5 files changed, 215 insertions(+)
 create mode 100644 runtest/device-drivers
 create mode 100644 testcases/kernel/device-drivers/nvme/.gitignore
 create mode 100644 testcases/kernel/device-drivers/nvme/Makefile
 create mode 100644 testcases/kernel/device-drivers/nvme/nvme01.c

diff --git a/runtest/device-drivers b/runtest/device-drivers
new file mode 100644
index 000000000..a7295584e
--- /dev/null
+++ b/runtest/device-drivers
@@ -0,0 +1 @@
+nvme01 nvme01
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 229a50683..664f4cd18 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -9,6 +9,7 @@ SUBDIRS		:= acpi \
 		   block \
 		   cpufreq \
 		   locking \
+		   nvme \
 		   pci \
 		   rcu \
 		   rtc \
diff --git a/testcases/kernel/device-drivers/nvme/.gitignore b/testcases/kernel/device-drivers/nvme/.gitignore
new file mode 100644
index 000000000..c60bc210c
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/.gitignore
@@ -0,0 +1 @@
+nvme01
diff --git a/testcases/kernel/device-drivers/nvme/Makefile b/testcases/kernel/device-drivers/nvme/Makefile
new file mode 100644
index 000000000..d47e99e6a
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 IBM Corporation
+
+top_srcdir	?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/nvme/nvme01.c b/testcases/kernel/device-drivers/nvme/nvme01.c
new file mode 100644
index 000000000..3c3cb92ce
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/nvme01.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 IBM Corporation
+ * Author: priyama2 <priyama2@linux.ibm.com>
+ */
+
+/* * [Description]
+ *
+ * Verify NVMe device discovery and identification.
+ *
+ * This test fills a gap in NVMe test coverage by validating basic device
+ * enumeration and driver binding, which are fundamental prerequisites for
+ * any NVMe functionality testing.
+ *
+ * - Detect NVMe controllers in /dev
+ * - Enumerate namespaces for detected controllers
+ * - Verify PCI enumeration (class code 0x010802)
+ * - Check NVMe driver binding
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
+#include "tst_safe_stdio.h"
+
+#define NVME_DEV_PATH "/dev"
+#define NVME_SYS_PATH "/sys/class/nvme"
+#define PCI_DEVICES_PATH "/sys/bus/pci/devices"
+
+static int nvme_device_found;
+static char nvme_dev_name[256];
+
+static void test_detect_nvme_controllers(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int found = 0;
+
+	dir = SAFE_OPENDIR(NVME_DEV_PATH);
+
+	tst_res(TINFO, "Scanning for NVMe devices in %s", NVME_DEV_PATH);
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strncmp(entry->d_name, "nvme", 4) == 0 &&
+		    strlen(entry->d_name) == 5) {
+			tst_res(TINFO, "Found NVMe controller: %s", entry->d_name);
+			strncpy(nvme_dev_name, entry->d_name, sizeof(nvme_dev_name) - 1);
+			found = 1;
+			nvme_device_found = 1;
+		}
+	}
+
+	SAFE_CLOSEDIR(dir);
+
+	if (found)
+		tst_res(TPASS, "NVMe controller(s) detected successfully");
+	else
+		tst_res(TCONF, "No NVMe controllers found in system");
+}
+
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
+	dir = SAFE_OPENDIR(NVME_DEV_PATH);
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
+	SAFE_CLOSEDIR(dir);
+
+	if (ns_count > 0)
+		tst_res(TPASS, "Enumerated %d namespace(s) successfully", ns_count);
+	else
+		tst_res(TPASS, "No namespaces found for %s (device may not have namespaces configured)", nvme_dev_name);
+}
+
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
+	dir = SAFE_OPENDIR(PCI_DEVICES_PATH);
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
+		fp = SAFE_FOPEN(class_path, "r");
+
+		if (fgets(class_id, sizeof(class_id), fp)) {
+			if (strncmp(class_id, "0x010802", 8) == 0) {
+				tst_res(TINFO, "Found NVMe PCI device: %s (class: %s)",
+					entry->d_name, class_id);
+				found = 1;
+			}
+		}
+		SAFE_FCLOSE(fp);
+	}
+
+	SAFE_CLOSEDIR(dir);
+
+	if (found)
+		tst_res(TPASS, "NVMe device properly enumerated on PCI bus");
+	else
+		tst_res(TFAIL, "NVMe device not found on PCI bus");
+}
+
+static void test_check_driver_binding(void)
+{
+	char driver_path[512];
+	char driver_link[512];
+
+	if (!nvme_device_found) {
+		tst_res(TCONF, "No NVMe device found, skipping driver binding check");
+		return;
+	}
+
+	snprintf(driver_path, sizeof(driver_path), "%s/%s/device/driver",
+		 NVME_SYS_PATH, nvme_dev_name);
+
+	SAFE_READLINK(driver_path, driver_link, sizeof(driver_link));
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
+	if (access("/sys/module/nvme", F_OK) != 0)
+		tst_brk(TCONF, "NVMe kernel module not loaded");
+
+	tst_res(TINFO, "NVMe Device Discovery & Identification Test");
+}
+
+static void run(unsigned int n)
+{
+	/* Reset state for each iteration */
+	nvme_device_found = 0;
+	memset(nvme_dev_name, 0, sizeof(nvme_dev_name));
+
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
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
