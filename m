Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB62DC55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:46:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53EE43E5A20
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:46:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AABA13E2DB0
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:45:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65E14600878
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:45:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 018617FD41;
 Wed,  5 Aug 2026 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785923106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1ajf8VllCpoqRk9wIvMtGtVl1faf5XzKHvrLYriYT0=;
 b=gS3tdoH96tqaekE1Q+qhXpdUyVx2erbhlfDFtgrzb8DweP+eIIHxP8oPcFbFOU+nKh5M8p
 bE5zg8E4CAaTG5nyvcF/vU2UQdgTOHGn7cg3RRhyk+9DLmHFSmiQfIN+tLmOL8hwqc9z9l
 nRboZviyC6ObdNB9VNl7e2LEWlCyEJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785923106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1ajf8VllCpoqRk9wIvMtGtVl1faf5XzKHvrLYriYT0=;
 b=vj8fgVo4/iPSK0jsIz4L+C8pNqOtejDAZ3Nxbvv1oZVkd98ZpyEpxArK8AsYbPrqm3Lzo4
 MHfu04W7JOieqpCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rxNyWzzS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Iv6KOvrp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785923102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1ajf8VllCpoqRk9wIvMtGtVl1faf5XzKHvrLYriYT0=;
 b=rxNyWzzS77L1dQVnk6+Apexv4hDdBKmYCsVhBl5hoJ0lMBT2+r764MCCz46Lx/KtATT+oj
 iA1ghS/i+5QB7AvQam4uSjWxPly6yBGUuOjB1aYVZks7PUcgB5HaAZlXMestQLN5RRIJlb
 vQFx6TZ0/UivSf/sQm4JJXCkCus6Wz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785923102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1ajf8VllCpoqRk9wIvMtGtVl1faf5XzKHvrLYriYT0=;
 b=Iv6KOvrpm/9ERHLBPH/DcHxAVtetghizHVkTKN39ZjpvMVF9sdjT5qI6V+IBbt7/2g95VT
 G2DCivTSRiuzz6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C733C779EB;
 Wed,  5 Aug 2026 09:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IOnbLh0Gc2pzRAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 05 Aug 2026 09:45:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 05 Aug 2026 11:44:58 +0200
MIME-Version: 1.0
Message-Id: <20260805-tpci_refactoring-v1-2-4ca8d84f8a95@suse.com>
References: <20260805-tpci_refactoring-v1-0-4ca8d84f8a95@suse.com>
In-Reply-To: <20260805-tpci_refactoring-v1-0-4ca8d84f8a95@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923101; l=14709;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=CxDMmXo06SPGJ9ViRslDQkKG9i+FZOU/C3fSXyWnayA=;
 b=EpbHRwyog/XmoamRKFXaZtbrVXdJSBCZFSP+3Q9PbmstfrTl/Sb/rK5S6USuUvIze4iN1c0Zb
 /5h8g1NsJjaDboTvA1jf5oU/h7xmZfCLta8cWEAAzxlhNIfM/umDJtg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 018617FD41
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tcpi: refactor test using new API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Merge kernel module with the current test inside the same folder and
refactor tpci test using new API.

Now test has a -d option to select device for operating destructive
tests on target.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../pci/{tpci_kernel => tpci}/.gitignore           |   3 +-
 testcases/kernel/device-drivers/pci/tpci/Makefile  |  22 +++
 .../pci/{tpci_kernel => tpci}/ltp_tpci.c           |   4 +-
 testcases/kernel/device-drivers/pci/tpci/tpci.c    | 156 +++++++++++++++++++++
 .../pci/{tpci_kernel => tpci}/tpci.h               |   0
 .../kernel/device-drivers/pci/tpci_kernel/Makefile |  35 -----
 .../kernel/device-drivers/pci/tpci_user/.gitignore |   1 -
 .../kernel/device-drivers/pci/tpci_user/Makefile   |  20 ---
 .../kernel/device-drivers/pci/tpci_user/tpci.c     | 115 ---------------
 9 files changed, 182 insertions(+), 174 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore b/testcases/kernel/device-drivers/pci/tpci/.gitignore
similarity index 76%
rename from testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
rename to testcases/kernel/device-drivers/pci/tpci/.gitignore
index ed4712e3adc194b8921e4daba28f8f5c9a8f94df..ec0d18ab921bf6a33e6495a596c1b19b48bbc66d 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/.gitignore
+++ b/testcases/kernel/device-drivers/pci/tpci/.gitignore
@@ -1,3 +1,4 @@
+/tpci
 /ltp_tpci.ko
 /*.mod.c
 /modules.order
@@ -5,4 +6,4 @@
 /.*.ko
 /.*.cmd
 /Module.symvers
-modules.livepatch
+/modules.livepatch
diff --git a/testcases/kernel/device-drivers/pci/tpci/Makefile b/testcases/kernel/device-drivers/pci/tpci/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..ae80dec86e4731df3d0d994c21bf8cf87ceaf767
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m := ltp_tpci.o
+
+else
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
+
+MAKE_TARGETS		:= tpci ltp_tpci.ko
+
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci/ltp_tpci.c
similarity index 99%
rename from testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
rename to testcases/kernel/device-drivers/pci/tpci/ltp_tpci.c
index 033ac1f0008e358d1afd0240bf1a9855ec32e1fd..1a7a09661d2ad42d4bfec8dc53dce5ec34b30ff6 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci/ltp_tpci.c
@@ -12,8 +12,8 @@
  * driven through various sysfs interactions in a user-space program.
  *
  * For the functions of this module to work correctly, there must be a
- * PCI / PCI-Express device somewhere in the system. The tests do not need
- * a specific device; the first PCI device available will be grabbed.
+ * PCI / PCI-Express device somewhere in the system. The user-space test
+ * selects each device through the bus_slot sysfs file.
  *
  * The following test cases can be called from user-space:
  *
diff --git a/testcases/kernel/device-drivers/pci/tpci/tpci.c b/testcases/kernel/device-drivers/pci/tpci/tpci.c
new file mode 100644
index 0000000000000000000000000000000000000000..b2285119660d350c92b6c604f3d3734482789105
--- /dev/null
+++ b/testcases/kernel/device-drivers/pci/tpci/tpci.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *  Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test various PCI and PCI-Express APIs using the ltp_tpci.ko kernel module.
+ *
+ * [Algorithm]
+ *
+ * - Loads the ltp_tpci.ko kernel module.
+ * - Iterates over all possible PCI buses (0-255) and slots (0-255).
+ * - Attempts to select each device by writing to the module's bus_slot sysfs file.
+ * - For each existing device, executes the available test cases.
+ *   Safe test cases are executed on all devices.
+ *   Destructive test cases are only executed on a target device specified via -d.
+ * - Reads the result from the result sysfs file and reports it using tst_res().
+ */
+
+#include "tst_test.h"
+#include "tst_module.h"
+#include "tpci.h"
+
+#define MODULE_NAME	PCI_DEVICE_NAME ".ko"
+#define DEV_RESULT	"/sys/devices/" PCI_DEVICE_NAME "/result"
+#define DEV_TCASE	"/sys/devices/" PCI_DEVICE_NAME "/tcase"
+#define DEV_BUSSLOT	"/sys/devices/" PCI_DEVICE_NAME "/bus_slot"
+
+static int module_loaded;
+static int devices_found;
+static char *target_device;
+static unsigned int target_bus;
+static unsigned int target_devfn;
+
+static int is_destructive_test(int tc)
+{
+	switch (tc) {
+	case FIND_BUS:
+	case FIND_CLASS:
+	case FIND_DEVICE:
+	case FIND_SUBSYS:
+	case MATCH_DEVICE:
+	case FIND_CAP:
+	case PCI_EXP_CAP_CONFIG:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void run_pci_testcases(const unsigned int bus, const unsigned int slot)
+{
+	int res;
+	int is_target = 0;
+
+	if (target_device && bus == target_bus && slot == target_devfn)
+		is_target = 1;
+
+	for (int i = 0; i < PCI_TCASES_NUM; ++i) {
+		if (!is_target && is_destructive_test(i))
+			continue;
+
+		SAFE_FILE_PRINTF(DEV_TCASE, "%d", i);
+		SAFE_FILE_SCANF(DEV_RESULT, "%d", &res);
+
+		switch (res) {
+		case 0:
+			tst_res(TPASS, "PCI bus %02x slot %02x : Test-case '%d'",
+				bus, slot, i);
+			break;
+		case 1:
+			tst_res(TFAIL, "PCI bus %02x slot %02x : Test-case '%d'",
+				bus, slot, i);
+			break;
+		case 32:
+			tst_res(TCONF, "PCI bus %02x slot %02x : Test-case '%d'",
+				bus, slot, i);
+			break;
+		default:
+			tst_brk(TBROK, "unexpected result code %d from kernel module",
+				res);
+		}
+	}
+}
+
+static void run(void)
+{
+	char buf[16];
+	int fd, count;
+
+	devices_found = 0;
+
+	for (int i = 0; i < MAX_BUS; ++i) {
+		for (int j = 0; j < MAX_DEVFN; ++j) {
+			/* set pci device for the test */
+			fd = SAFE_OPEN(DEV_BUSSLOT, O_WRONLY);
+			count = snprintf(buf, sizeof(buf), "%u", i << 8 | j);
+
+			if (write(fd, buf, count) < 0) {
+				if (errno == ENODEV) {
+					SAFE_CLOSE(fd);
+					continue;
+				}
+				SAFE_CLOSE(fd);
+				tst_brk(TBROK | TERRNO, "write to '%s' failed", DEV_BUSSLOT);
+			}
+			SAFE_CLOSE(fd);
+
+			devices_found++;
+			run_pci_testcases(i, j);
+		}
+	}
+
+	if (!devices_found)
+		tst_brk(TCONF, "no PCI device found on the system");
+}
+
+static void cleanup(void)
+{
+	if (module_loaded)
+		tst_module_unload(MODULE_NAME);
+}
+
+static void setup(void)
+{
+	if (target_device) {
+		char tail;
+
+		if (sscanf(target_device, "%x:%x%c", &target_bus, &target_devfn, &tail) != 2 ||
+				target_bus > 0xff || target_devfn > 0xff) {
+			tst_brk(TBROK, "Invalid PCI device '%s', expected bus:devfn",
+				target_device);
+		}
+	}
+
+	tst_requires_module_signature_disabled();
+
+	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
+		tst_brk(TCONF, "Cannot load unsigned modules in Lockdown/Secure Boot");
+
+	tst_module_load(MODULE_NAME, NULL);
+	module_loaded = 1;
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.options = (struct tst_option[]) {
+		{"d:", &target_device, "Target PCI device for destructive tests (e.g. 00:28)"},
+		{}
+	},
+};
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h b/testcases/kernel/device-drivers/pci/tpci/tpci.h
similarity index 100%
rename from testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
rename to testcases/kernel/device-drivers/pci/tpci/tpci.h
diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
deleted file mode 100644
index 6e1284d6cf53f078b610f175f2b2d899e6de8be5..0000000000000000000000000000000000000000
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
+++ /dev/null
@@ -1,35 +0,0 @@
-# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-ifneq ($(KERNELRELEASE),)
-
-obj-m := ltp_tpci.o
-
-else
-
-top_srcdir	?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-REQ_VERSION_MAJOR := 2
-REQ_VERSION_PATCH := 6
-
-MAKE_TARGETS := ltp_tpci.ko
-
-include $(top_srcdir)/include/mk/module.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
-
-endif
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/.gitignore b/testcases/kernel/device-drivers/pci/tpci_user/.gitignore
deleted file mode 100644
index b1817e5fba323c996651324b0879359fd941a43a..0000000000000000000000000000000000000000
--- a/testcases/kernel/device-drivers/pci/tpci_user/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/tpci
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/Makefile b/testcases/kernel/device-drivers/pci/tpci_user/Makefile
deleted file mode 100644
index 6ba346520e199cfe1673548179684c5c606e6e4b..0000000000000000000000000000000000000000
--- a/testcases/kernel/device-drivers/pci/tpci_user/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
deleted file mode 100644
index 687d2a62b0bccc2fa84bb401b61f7e467a630a41..0000000000000000000000000000000000000000
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
- *
- */
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-
-#include "test.h"
-#include "tso_safe_macros.h"
-#include "tso_module.h"
-#include "tst_security.h"
-
-#include "../tpci_kernel/tpci.h"
-
-char *TCID = "test_pci";
-int TST_TOTAL = PCI_TCASES_NUM;
-
-static const char module_name[]	= PCI_DEVICE_NAME ".ko";
-static const char dev_result[]	= "/sys/devices/" PCI_DEVICE_NAME "/result";
-static const char dev_tcase[]	= "/sys/devices/" PCI_DEVICE_NAME "/tcase";
-static const char dev_busslot[]	= "/sys/devices/" PCI_DEVICE_NAME "/bus_slot";
-static int module_loaded;
-
-static void cleanup(void)
-{
-	if (module_loaded)
-		tst_module_unload(NULL, module_name);
-}
-
-void setup(void)
-{
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	tst_requires_module_signature_disabled();
-	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
-		tst_brkm(TCONF, NULL, "Cannot load unsigned modules in Lockdown/Secure Boot");
-}
-
-static void run_pci_testcases(int bus, int slot)
-{
-	int i, res;
-	for (i = 0; i < TST_TOTAL; ++i) {
-		/* skip pci disable test-case, it is manual */
-		if (i == PCI_DISABLE)
-			continue;
-
-		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
-		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
-
-		tst_resm(res, "PCI bus %02x slot %02x : Test-case '%d'",
-			bus, slot, i);
-	}
-}
-
-static void test_run(void)
-{
-	tst_module_load(cleanup, module_name, NULL);
-	module_loaded = 1;
-
-	char buf[6];
-	int i, j, fd, count;
-
-	for (i = 0; i < MAX_BUS; ++i) {
-		for (j = 0; j < MAX_DEVFN; ++j) {
-			/* set pci device for the test */
-			fd = SAFE_OPEN(cleanup, dev_busslot, O_WRONLY);
-			count = snprintf(buf, 6, "%u", i << 8 | j);
-			errno = 0;
-			if (write(fd, buf, count) < 0) {
-				if (errno == ENODEV) {
-					SAFE_CLOSE(cleanup, fd);
-					continue;
-				}
-				tst_brkm(TBROK | TERRNO, cleanup,
-					"write to '%s' failed", dev_busslot);
-			}
-			SAFE_CLOSE(cleanup, fd);
-
-			run_pci_testcases(i, j);
-
-		}
-	}
-}
-
-int main(void)
-{
-	setup();
-
-	test_run();
-
-	cleanup();
-
-	tst_exit();
-}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
