Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FAFE7718D
	for <ltp@archiver.kernel.org>; Thu, 26 Dec 2024 05:10:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C60953EEC27
	for <ltp@archiver.kernel.org>; Thu, 26 Dec 2024 06:10:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D13C63EE6C1
 for <ltp@lists.linux.it>; Thu, 26 Dec 2024 06:10:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 25F701BC1604
 for <ltp@lists.linux.it>; Thu, 26 Dec 2024 06:10:41 +0100 (CET)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AEA8E3FB7E; 
 Thu, 26 Dec 2024 05:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735189840;
 bh=xuXth6qiM3gxB9MSQ7pgf+PtYvkMIpphJf99LNEmj7I=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Jy+bHaNXsXcN3Lc4US0Q40uNvhjZ42mRbyPNWiH8VbuipbVFtCr1nSsI+pBgAXaGw
 D/NIldtI3NU7Pd0ICgocdv9D9SlFjuGHKLA+qH2KQL8WZrWXF5grg3c5sOAOl/M+B3
 eFP3Vkp/7RYO6ABwhOrOMNiiO0XAcJBCQXk5Bt5H4Sj+kGE5zjo/iYbKcIm/0O0tvG
 q5WawXyzUE9ZSyL7Jk4ZEZiZFMvBBy7VCP/nUSH84FkxIG64IVflHzouapfc8BACgQ
 Wks+ks0kcTnLPY9kc6l3nErApVsn421uj2ZS9vbtDwgl067LCRyBMNYJSm/RDtBZ5d
 0YS3kWPFdBgFg==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 26 Dec 2024 13:10:20 +0800
Message-Id: <20241226051020.160636-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] testcases: add module signature enforcement check
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
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CONFIG_MODULE_SIG_FORCE kernel config and the module.sig_enforce in
/proc/cmdline can prevent tests from inserting their test modules.
Those tests will either fail with:
  'insmod exited with a non-zero code 1 at tst_cmd.c:121
Or:
  insmod: ERROR: could not insert module ltp_insmod01.ko: Key was
  rejected by service.

Add an extra check like what we did for syscall tests.

Patch tested against a kernel with CONFIG_MODULE_SIG_FORCE=y, and
another with module.sig_enforce added to /proc/cmdline. It's working
as expected.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/commands/insmod/insmod01.sh                  |  5 +++++
 testcases/kernel/device-drivers/acpi/ltp_acpi.c        |  8 ++++++++
 .../device-drivers/block/block_dev_user/block_dev.c    | 10 ++++++++++
 testcases/kernel/device-drivers/pci/tpci_user/tpci.c   |  9 +++++++++
 testcases/kernel/device-drivers/uaccess/uaccess.c      |  9 +++++++++
 testcases/kernel/firmware/fw_load_user/fw_load.c       | 10 +++++++++-
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
index 992b4a05a..00aa632cf 100755
--- a/testcases/commands/insmod/insmod01.sh
+++ b/testcases/commands/insmod/insmod01.sh
@@ -30,6 +30,11 @@ cleanup()
 
 do_test()
 {
+	tst_check_kconfigs "CONFIG_MODULE_SIG_FORCE=y"
+	if [ $? -eq 0 ] || grep module.sig_enforce -qw /proc/cmdline ; then
+		tst_brk TCONF "module signature is enforced, skipping test"
+	fi
+
 	insmod "$TST_MODPATH"
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "insmod failed"
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
index 7dba04552..c674b2032 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 
 #include "test.h"
+#include "tst_kconfig.h"
 #include "old_module.h"
 #include "safe_macros.h"
 
@@ -128,11 +129,18 @@ static void test_run(void)
 int main(int argc, char *argv[])
 {
 	int acpi_disabled;
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	tst_require_root();
 
+	tst_kcmdline_parse(&params, 1);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_module_load(NULL, module_name, NULL);
diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
index b6e30eb7e..237c23256 100644
--- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <string.h>
 
+#include "tst_kconfig.h"
 #include "tst_test.h"
 #include "tst_module.h"
 
@@ -47,6 +48,15 @@ static void run(unsigned int n)
 	 * unregister_blkdev() checks the input device name parameter
 	 * against NULL pointer.
 	 */
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
+
+	tst_kcmdline_parse(&params, 1);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		tst_brk(TCONF, "module signature is enforced, skip test");
+
+
 	n++;
 	if (!run_all_testcases && (n == 8 || n == 9)) {
 		tst_res(TCONF, "Skipped n = %d", n);
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index 96018f18c..aa07fdb42 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "tst_kconfig.h"
 #include "safe_macros.h"
 #include "old_module.h"
 
@@ -49,8 +50,16 @@ static void cleanup(void)
 
 void setup(void)
 {
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
+
 	tst_require_root();
 
+	tst_kcmdline_parse(&params, 1);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 }
 
diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
index f682ff7f6..c6dfeb845 100644
--- a/testcases/kernel/device-drivers/uaccess/uaccess.c
+++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
@@ -27,6 +27,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "tst_kconfig.h"
 #include "old_module.h"
 #include "safe_macros.h"
 
@@ -92,10 +93,18 @@ static void tc_write_userspace(void)
 
 int main(int argc, char *argv[])
 {
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
+
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	tst_require_root();
 
+	tst_kcmdline_parse(&params, 1);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_module_load(NULL, module_name, NULL);
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index 83648b625..b34b56fae 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -29,6 +29,7 @@
 #include <string.h>
 
 #include "test.h"
+#include "tst_kconfig.h"
 #include "safe_macros.h"
 #include "old_module.h"
 
@@ -102,7 +103,9 @@ static void help(void)
 
 void setup(int argc, char *argv[])
 {
-	
+	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
+
 	tst_parse_opts(argc, argv, options, help);
 
 	if (nflag) {
@@ -114,6 +117,11 @@ void setup(int argc, char *argv[])
 
 	tst_require_root();
 
+	tst_kcmdline_parse(&params, 1);
+	tst_kconfig_read(&kconfig, 1);
+	if (params.found || kconfig.choice == 'y')
+		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
+
 	char fw_size_param[19];
 	snprintf(fw_size_param, 19, "fw_size=%d", fw_size);
 	char *const mod_params[2] = { fw_size_param, NULL };
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
