Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A2FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 05:49:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8C43E2107
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:49:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10C8A3E1A9F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:48:43 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E8F5F1000977
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:48:42 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SJIRuN3583678; Wed, 29 Apr 2026 05:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TUv8NfLu4NFS+bR2F
 uvjaEPwubJUTBFUPdIbqPeeoBg=; b=UvuKudCEyOYZHcfHTKGClj9z7OOqHQFXM
 wGuXQ65YVWCRd4UhwVNPcwvkmGRYB1yTThSkZTxx1tqplLMjhuWgDN86Yutjn4RB
 WJs317et5lvHNGXkkxWOi88YJ+Lp1E736vY/LV+jgmLYQzjidi0B2194Vl+kAG40
 SI8LwJqJOJHYJM0O3iVRsAmeAIMpIG4XcoIBuu/2h94xYDRS33lAW6DRJXikB+fB
 OXWca1YIj4xarhl4URPl9ffgfftp5e5Sgqtd3nTHFcoEevsXpbc7qjRj3kkKerjI
 B9jBGRZNT8yjcGt6sIOe+zHcHnB094agkzxGvo8HCBjpx+IypVlCA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44s206-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 05:48:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63T5coCP016260;
 Wed, 29 Apr 2026 05:48:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk50tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 05:48:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63T5mcVj14287576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 05:48:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 740FB58056;
 Wed, 29 Apr 2026 05:48:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39D7A58052;
 Wed, 29 Apr 2026 05:48:38 +0000 (GMT)
Received: from botlp69.isst.tadn.ibm.com (unknown [9.5.7.36])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 05:48:38 +0000 (GMT)
From: priyama2@linux.ibm.com
To: ltp@lists.linux.it
Date: Thu, 30 Apr 2026 15:52:41 +0000
Message-ID: <20260430155241.897024-1-priyama2@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 66Ei08qr6-DLFuesq2XLoboPWEHlgxXb
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f19bb8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HKdTNp9lvr2wyx0tH1cA:9
X-Proofpoint-GUID: 66Ei08qr6-DLFuesq2XLoboPWEHlgxXb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA1NCBTYWx0ZWRfX6InkOaEaQcI/
 OvEzU86m8r4WQYmZ2/6RhyWYgmjCvdzAyZzsZCWKptQBNslNsaO9WxQh8YzIUmnd8p0ywe2JrK0
 oG6A6IoR+Mva1crCuw7kv0ynsjBUKrKRTUU/zVd0Rjnvw8kyR9NfOg7VOcPUdCdJ15yvRtPyT5W
 SMOlRn+QwOw+JF7q4BR2r83eiqK7pqMgYmb4B1ZDq2+I0As115D1cL/ZmkzeR+0EWBjg7V3PK/1
 YUoxDWXz5cRdHXIzPKB6y3BPBf3A34aktnzLN1L0qkYvwrXeqCf2zpAwdLyTi62QEuYf0bHaqjn
 hdiZpeuzbbKFUCwB1oNFk4ILmhB/WYN5jBZIfRGT7MHSn2hGcuy7d2HYsBODsL75Qr+Nm7/wyuI
 +98Gi2xxBxOgaU32HDqOuCEOAuKSCsiLCnwLDTatYQMXAx9V/kJ+zREA/Tzh/Z6Vvn/K42UMA5F
 SyxOfflipBKhWDK9C2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290054
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] testcases/nvme: Add NVMe device discovery and
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

From: priyama2 <priyama2@linux.ibm.com>

This test verifies NVMe device discovery and identification by:
- Detecting NVMe controllers in /dev
- Enumerating namespaces for detected controllers
- Verifying PCI enumeration (class code 0x010802)
- Checking NVMe driver binding

Changes in v2:
- Use LTP buildsystem instead of standalone Makefile
- Remove README file (use doc comments instead)
- Fix author attribution
- Add proper LTP documentation comment format
- Use SAFE_OPENDIR() and SAFE_CLOSEDIR() macros
- Remove obvious and redundant comments
- Code cleanup and style improvements

Signed-off-by: priyama2 <priyama2@linux.ibm.com>
---
 testcases/kernel/device-drivers/nvme/Makefile |   7 +
 testcases/kernel/device-drivers/nvme/nvme01.c | 208 ++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 testcases/kernel/device-drivers/nvme/Makefile
 create mode 100644 testcases/kernel/device-drivers/nvme/nvme01.c

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
index 000000000..f448e7e5c
--- /dev/null
+++ b/testcases/kernel/device-drivers/nvme/nvme01.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 IBM Corporation
+ * Author: Priya Gopinath <priyama2@linux.ibm.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify NVMe device discovery and identification:
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
+		fp = fopen(class_path, "r");
+		if (!fp)
+			continue;
+
+		if (fgets(class_id, sizeof(class_id), fp)) {
+			if (strncmp(class_id, "0x010802", 8) == 0) {
+				tst_res(TINFO, "Found NVMe PCI device: %s (class: %s)",
+					entry->d_name, class_id);
+				found = 1;
+			}
+		}
+		fclose(fp);
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
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
