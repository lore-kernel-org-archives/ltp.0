Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10003E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 04:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB1BB3F02AD
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 05:37:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 935313F0282
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 05:37:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F83B1423DF9
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 05:37:26 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1E57E40290; 
 Tue, 31 Dec 2024 04:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735619845;
 bh=wbNrBSvds9cU95UWxFVAW6Q3iW3EXoxGZcGhTWiWPQk=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=UrQsMfmanE93Rn8PBY5aFutr6ITgJcEGsqb98RA59JrKOaCi0rfpHzlfVYzl9oWMc
 YKTnMAFBsZ+E2urxxM6iHPvNDFfINkAj11T8Oec70kyliaxAo4Cyb6L2JR4utIYJ8+
 hnk9CKqDk6/mLoO+ReodfrQmJPiOpbyrBEqRKglJOHL10saulcO8xHZNuW+iRnMO0q
 YtmidIUGZLtle0oksjl1xE5SErxkhdqw548UeHiaNxokL1dDfMyoXFFEX9pGv3ZTPy
 g0nFF7ehrEPt9qSCmmqn1tdCds2tf1AEVk+ZNEd0ohW9Zm2As8geYK1gJvM+OkpnSm
 IEXijM5B+7Nyg==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Tue, 31 Dec 2024 12:34:57 +0800
Message-Id: <20241231043457.270557-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227160042.363309-1-pvorel@suse.cz>
References: <20241227160042.363309-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Cc: po-hsu.lin@canonical.com, rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On Sat, 28 Dec 2024 at 00:00, Petr Vorel <pvorel@suse.cz> wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/device-drivers/acpi/ltp_acpi.c       | 11 +----------
>  .../device-drivers/block/block_dev_user/block_dev.c   |  9 +--------
>  testcases/kernel/device-drivers/pci/tpci_user/tpci.c  | 11 +----------
>  testcases/kernel/device-drivers/uaccess/uaccess.c     | 11 +----------
>  testcases/kernel/firmware/fw_load_user/fw_load.c      | 10 +---------
>  .../kernel/syscalls/delete_module/delete_module01.c   |  9 +--------
>  .../kernel/syscalls/delete_module/delete_module03.c   |  9 +--------
>  .../kernel/syscalls/finit_module/finit_module01.c     | 11 +----------
>  .../kernel/syscalls/finit_module/finit_module02.c     |  7 +------
>  testcases/kernel/syscalls/init_module/init_module01.c |  8 +-------
>  testcases/kernel/syscalls/init_module/init_module02.c |  7 +------
>  11 files changed, 11 insertions(+), 92 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
> index c674b20321..eb5e197239 100644
> --- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
> @@ -22,7 +22,6 @@
>  #include <stdlib.h>
>
>  #include "test.h"
> -#include "tst_kconfig.h"
>  #include "old_module.h"
>  #include "safe_macros.h"
>
> @@ -129,20 +128,12 @@ static void test_run(void)
>  int main(int argc, char *argv[])
>  {
>  	int acpi_disabled;
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
>
>  	tst_parse_opts(argc, argv, NULL, NULL);
> -
>  	tst_require_root();
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
> -
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>
> +	tst_check_module_signature_enforced();

One question, should we put this tst_check_module_signature_enforced()
before or after tst_sig()? Asking because it's different in tpci.c

>  	tst_module_load(NULL, module_name, NULL);
>  	module_loaded = 1;
>
> diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> index 2c3ffd9203..98b786a90b 100644
> --- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> +++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> @@ -17,7 +17,6 @@
>  #include <unistd.h>
>  #include <string.h>
>  
> -#include "tst_kconfig.h"
>  #include "tst_test.h"
>  #include "tst_module.h"
>  
> @@ -42,13 +41,7 @@ static void cleanup(void)
>  
>  static void run(unsigned int n)
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brk(TCONF, "module signature is enforced, skip test");
> +	tst_check_module_signature_enforced();
>  
>  	/*
>  	 * test-cases #8 and #9 can crash the kernel.
> diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
> index aa07fdb427..1bcc68c23c 100644
> --- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
> +++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
> @@ -27,7 +27,6 @@
>  #include <errno.h>
>  
>  #include "test.h"
> -#include "tst_kconfig.h"
>  #include "safe_macros.h"
>  #include "old_module.h"
>  
> @@ -50,16 +49,8 @@ static void cleanup(void)
>  
>  void setup(void)
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
>  	tst_require_root();
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
> -
> +	tst_check_module_signature_enforced();
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  }
>  
> diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
> index c6dfeb8456..58bef13ef3 100644
> --- a/testcases/kernel/device-drivers/uaccess/uaccess.c
> +++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
> @@ -27,7 +27,6 @@
>  #include <unistd.h>
>  
>  #include "test.h"
> -#include "tst_kconfig.h"
>  #include "old_module.h"
>  #include "safe_macros.h"
>  
> @@ -93,20 +92,12 @@ static void tc_write_userspace(void)
>  
>  int main(int argc, char *argv[])
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
>  	tst_parse_opts(argc, argv, NULL, NULL);
>  
>  	tst_require_root();
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
> -
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
> +	tst_check_module_signature_enforced();
>  	tst_module_load(NULL, module_name, NULL);
>  	module_loaded = 1;
>  
> diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
> index b34b56fae5..7ebb2cc8ed 100644
> --- a/testcases/kernel/firmware/fw_load_user/fw_load.c
> +++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
> @@ -29,7 +29,6 @@
>  #include <string.h>
>  
>  #include "test.h"
> -#include "tst_kconfig.h"
>  #include "safe_macros.h"
>  #include "old_module.h"
>  
> @@ -103,9 +102,6 @@ static void help(void)
>  
>  void setup(int argc, char *argv[])
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
>  	tst_parse_opts(argc, argv, options, help);
>  
>  	if (nflag) {
> @@ -116,11 +112,7 @@ void setup(int argc, char *argv[])
>  	}
>  
>  	tst_require_root();
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brkm(TCONF, tst_exit, "module signature is enforced, skip test");
> +	tst_check_module_signature_enforced();
>  
>  	char fw_size_param[19];
>  	snprintf(fw_size_param, 19, "fw_size=%d", fw_size);
> diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
> index 5ccbe6fd5b..48b324309f 100644
> --- a/testcases/kernel/syscalls/delete_module/delete_module01.c
> +++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
> @@ -17,7 +17,6 @@
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "tst_module.h"
> -#include "tst_kconfig.h"
>  #include "lapi/syscalls.h"
>  
>  #define MODULE_NAME	"dummy_del_mod"
> @@ -27,13 +26,7 @@ static int module_loaded;
>  
>  static void do_delete_module(void)
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brk(TCONF, "module signature is enforced, skip test");
> +	tst_check_module_signature_enforced();
>  
>  	if (!module_loaded) {
>  		tst_module_load(MODULE_NAME_KO, NULL);
> diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
> index 76ccfb1e25..be358381ef 100644
> --- a/testcases/kernel/syscalls/delete_module/delete_module03.c
> +++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
> @@ -16,7 +16,6 @@
>  #include <errno.h>
>  #include "tst_test.h"
>  #include "tst_module.h"
> -#include "tst_kconfig.h"
>  #include "lapi/syscalls.h"
>  
>  #define DUMMY_MOD		"dummy_del_mod"
> @@ -52,13 +51,7 @@ static void do_delete_module(void)
>  
>  static void setup(void)
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		tst_brk(TCONF, "module signature is enforced, skip test");
> +	tst_check_module_signature_enforced();
>  
>  	/* Load first kernel module */
>  	tst_module_load(DUMMY_MOD_KO, NULL);
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
> index d75e5e4753..0ed68c7372 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module01.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
> @@ -17,7 +17,6 @@
>  #include <errno.h>
>  #include "lapi/init_module.h"
>  #include "tst_module.h"
> -#include "tst_kconfig.h"
>  
>  #define MODULE_NAME	"finit_module.ko"
>  
> @@ -27,14 +26,7 @@ static char *mod_path;
>  
>  static void setup(void)
>  {
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
> -
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> -		sig_enforce = 1;

This test will expect an EKEYREJECTED error if the module signature is
enforced. So I think:

if (tst_module_signature_enforced())
	sig_enforce = 1;

And remove tst_check_module_signature_enforced() below, otherwise the
test will be skipped.

> -
> +	tst_check_module_signature_enforced();
>  	tst_module_exists(MODULE_NAME, &mod_path);
>  
>  	fd = SAFE_OPEN(mod_path, O_RDONLY|O_CLOEXEC);
> @@ -43,7 +35,6 @@ static void setup(void)
>  static void run(void)
>  {
>  	if (sig_enforce == 1) {
> -		tst_res(TINFO, "module signature is enforced");
>  		TST_EXP_FAIL(finit_module(fd, "status=valid", 0), EKEYREJECTED);
>  		return;
>  	}
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> index dc81ae727d..e16164ee25 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> @@ -18,7 +18,6 @@
>  #include <errno.h>
>  #include "lapi/init_module.h"
>  #include "tst_module.h"
> -#include "tst_kconfig.h"
>  #include "tst_capability.h"
>  
>  #define MODULE_NAME	"finit_module.ko"
> @@ -77,12 +76,8 @@ static struct tcase tcases[] = {
>  static void setup(void)
>  {
>  	unsigned long int i;
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
>  
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> +	if (tst_module_signature_enforced())
>  		sig_enforce = 1;
>  
>  	tst_module_exists(MODULE_NAME, &mod_path);
> diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
> index d7ed08b143..850f826e62 100644
> --- a/testcases/kernel/syscalls/init_module/init_module01.c
> +++ b/testcases/kernel/syscalls/init_module/init_module01.c
> @@ -17,7 +17,6 @@
>  #include <errno.h>
>  #include "lapi/init_module.h"
>  #include "tst_module.h"
> -#include "tst_kconfig.h"
>  
>  #define MODULE_NAME	"init_module.ko"
>  
> @@ -28,12 +27,8 @@ static int sig_enforce;
>  static void setup(void)
>  {
>  	int fd;
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
>  
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> +	if (tst_module_signature_enforced())
>  		sig_enforce = 1;
>  
>  	tst_module_exists(MODULE_NAME, NULL);
> @@ -47,7 +42,6 @@ static void setup(void)
>  static void run(void)
>  {
>  	if (sig_enforce == 1) {
> -		tst_res(TINFO, "module signature is enforced");
>  		TST_EXP_FAIL(init_module(buf, sb.st_size, "status=valid"), EKEYREJECTED);
>  		return;
>  	}
> diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
> index 3eb99574d9..c3979c08aa 100644
> --- a/testcases/kernel/syscalls/init_module/init_module02.c
> +++ b/testcases/kernel/syscalls/init_module/init_module02.c
> @@ -17,7 +17,6 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include "lapi/init_module.h"
> -#include "tst_kconfig.h"
>  #include "tst_module.h"
>  #include "tst_capability.h"
>  
> @@ -53,12 +52,8 @@ static void setup(void)
>  {
>  	struct stat sb;
>  	int fd;
> -	struct tst_kcmdline_var params = TST_KCMDLINE_INIT("module.sig_enforce");
> -	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_MODULE_SIG_FORCE");
>  
> -	tst_kcmdline_parse(&params, 1);
> -	tst_kconfig_read(&kconfig, 1);
> -	if (params.found || kconfig.choice == 'y')
> +	if (tst_module_signature_enforced())
>  		sig_enforce = 1;
>  
>  	tst_module_exists(MODULE_NAME, NULL);
> -- 
> 2.45.2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
