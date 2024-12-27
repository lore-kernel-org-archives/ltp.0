Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F964E7718F
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 16:01:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1017B3EF54F
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 17:01:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B0973EF542
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:00:58 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 94FB010005A6
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:00:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECD571FB77;
 Fri, 27 Dec 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B981413985;
 Fri, 27 Dec 2024 16:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wM0PKzfPbmfrIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 16:00:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Dec 2024 17:00:42 +0100
Message-ID: <20241227160042.363309-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227160042.363309-1-pvorel@suse.cz>
References: <20241227160042.363309-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: ECD571FB77
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] device-drivers: *module: Use helpers for module
 signature enforcement
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
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>,
 "Ricardo B . Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/device-drivers/acpi/ltp_acpi.c       | 11 +----------
 .../device-drivers/block/block_dev_user/block_dev.c   |  9 +--------
 testcases/kernel/device-drivers/pci/tpci_user/tpci.c  | 11 +----------
 testcases/kernel/device-drivers/uaccess/uaccess.c     | 11 +----------
 testcases/kernel/firmware/fw_load_user/fw_load.c      | 10 +---------
 .../kernel/syscalls/delete_module/delete_module01.c   |  9 +--------
 .../kernel/syscalls/delete_module/delete_module03.c   |  9 +--------
 .../kernel/syscalls/finit_module/finit_module01.c     | 11 +----------
 .../kernel/syscalls/finit_module/finit_module02.c     |  7 +------
 testcases/kernel/syscalls/init_module/init_module01.c |  8 +-------
 testcases/kernel/syscalls/init_module/init_module02.c |  7 +------
 11 files changed, 11 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
index c674b20321..eb5e197239 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
@@ -22,7 +22,6 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "tst_kconfig.h"
 #include "old_module.h"
 #include "safe_macros.h"
 
@@ -129,20 +128,12 @@ static void test_run(void)
 int main(int argc, char *argv[])
 {
 	int acpi_disabled;
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
 	tst_parse_opts(argc, argv, NULL, NULL);
-
 	tst_require_root();
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_check_module_signature_enforced();
 	tst_module_load(NULL, module_name, NULL);
 	module_loaded = 1;
 
diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
index 2c3ffd9203..98b786a90b 100644
--- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -17,7 +17,6 @@
 #include <unistd.h>
 #include <string.h>
 
-#include "tst_kconfig.h"
 #include "tst_test.h"
 #include "tst_module.h"
 
@@ -42,13 +41,7 @@ static void cleanup(void)
 
 static void run(unsigned int n)
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brk(TCONF, "module signature is enforced, skip test");
+	tst_check_module_signature_enforced();
 
 	/*
 	 * test-cases #8 and #9 can crash the kernel.
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index aa07fdb427..1bcc68c23c 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -27,7 +27,6 @@
 #include <errno.h>
 
 #include "test.h"
-#include "tst_kconfig.h"
 #include "safe_macros.h"
 #include "old_module.h"
 
@@ -50,16 +49,8 @@ static void cleanup(void)
 
 void setup(void)
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
 	tst_require_root();
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
-
+	tst_check_module_signature_enforced();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 }
 
diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
index c6dfeb8456..58bef13ef3 100644
--- a/testcases/kernel/device-drivers/uaccess/uaccess.c
+++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
@@ -27,7 +27,6 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "tst_kconfig.h"
 #include "old_module.h"
 #include "safe_macros.h"
 
@@ -93,20 +92,12 @@ static void tc_write_userspace(void)
 
 int main(int argc, char *argv[])
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	tst_require_root();
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_check_module_signature_enforced();
 	tst_module_load(NULL, module_name, NULL);
 	module_loaded = 1;
 
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index b34b56fae5..7ebb2cc8ed 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -29,7 +29,6 @@
 #include <string.h>
 
 #include "test.h"
-#include "tst_kconfig.h"
 #include "safe_macros.h"
 #include "old_module.h"
 
@@ -103,9 +102,6 @@ static void help(void)
 
 void setup(int argc, char *argv[])
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
 	tst_parse_opts(argc, argv, options, help);
 
 	if (nflag) {
@@ -116,11 +112,7 @@ void setup(int argc, char *argv[])
 	}
 
 	tst_require_root();
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
+	tst_check_module_signature_enforced();
 
 	char fw_size_param[19];
 	snprintf(fw_size_param, 19, "fw_size=%d", fw_size);
diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index 5ccbe6fd5b..48b324309f 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -17,7 +17,6 @@
 #include <stdlib.h>
 #include "tst_test.h"
 #include "tst_module.h"
-#include "tst_kconfig.h"
 #include "lapi/syscalls.h"
 
 #define MODULE_NAME	"dummy_del_mod"
@@ -27,13 +26,7 @@ static int module_loaded;
 
 static void do_delete_module(void)
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brk(TCONF, "module signature is enforced, skip test");
+	tst_check_module_signature_enforced();
 
 	if (!module_loaded) {
 		tst_module_load(MODULE_NAME_KO, NULL);
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index 76ccfb1e25..be358381ef 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include "tst_test.h"
 #include "tst_module.h"
-#include "tst_kconfig.h"
 #include "lapi/syscalls.h"
 
 #define DUMMY_MOD		"dummy_del_mod"
@@ -52,13 +51,7 @@ static void do_delete_module(void)
 
 static void setup(void)
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		tst_brk(TCONF, "module signature is enforced, skip test");
+	tst_check_module_signature_enforced();
 
 	/* Load first kernel module */
 	tst_module_load(DUMMY_MOD_KO, NULL);
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index d75e5e4753..0ed68c7372 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include "lapi/init_module.h"
 #include "tst_module.h"
-#include "tst_kconfig.h"
 
 #define MODULE_NAME	"finit_module.ko"
 
@@ -27,14 +26,7 @@ static char *mod_path;
 
 static void setup(void)
 {
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
-
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
-		sig_enforce = 1;
-
+	tst_check_module_signature_enforced();
 	tst_module_exists(MODULE_NAME, &mod_path);
 
 	fd = SAFE_OPEN(mod_path, O_RDONLY|O_CLOEXEC);
@@ -43,7 +35,6 @@ static void setup(void)
 static void run(void)
 {
 	if (sig_enforce == 1) {
-		tst_res(TINFO, "module signature is enforced");
 		TST_EXP_FAIL(finit_module(fd, "status=valid", 0), EKEYREJECTED);
 		return;
 	}
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index dc81ae727d..e16164ee25 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include "lapi/init_module.h"
 #include "tst_module.h"
-#include "tst_kconfig.h"
 #include "tst_capability.h"
 
 #define MODULE_NAME	"finit_module.ko"
@@ -77,12 +76,8 @@ static struct tcase tcases[] = {
 static void setup(void)
 {
 	unsigned long int i;
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
+	if (tst_module_signature_enforced())
 		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, &mod_path);
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index d7ed08b143..850f826e62 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include "lapi/init_module.h"
 #include "tst_module.h"
-#include "tst_kconfig.h"
 
 #define MODULE_NAME	"init_module.ko"
 
@@ -28,12 +27,8 @@ static int sig_enforce;
 static void setup(void)
 {
 	int fd;
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
+	if (tst_module_signature_enforced())
 		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, NULL);
@@ -47,7 +42,6 @@ static void setup(void)
 static void run(void)
 {
 	if (sig_enforce == 1) {
-		tst_res(TINFO, "module signature is enforced");
 		TST_EXP_FAIL(init_module(buf, sb.st_size, "status=valid"), EKEYREJECTED);
 		return;
 	}
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index 3eb99574d9..c3979c08aa 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -17,7 +17,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include "lapi/init_module.h"
-#include "tst_kconfig.h"
 #include "tst_module.h"
 #include "tst_capability.h"
 
@@ -53,12 +52,8 @@ static void setup(void)
 {
 	struct stat sb;
 	int fd;
-	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
-	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
 
-	tst_kcmdline_parse(&params, 1);
-	tst_kconfig_read(&kconfig, 1);
-	if (params.found || kconfig.choice == 'y')
+	if (tst_module_signature_enforced())
 		sig_enforce = 1;
 
 	tst_module_exists(MODULE_NAME, NULL);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
