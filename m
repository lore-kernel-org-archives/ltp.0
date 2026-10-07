Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE54CA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 10:58:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 020BF3E6B17
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 12:58:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A84F43E9788
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 12:57:53 +0200 (CEST)
Received: from mta1.migadu.com (out-19.mta1.migadu.com
 [IPv6:2001:41d0:203:375::13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEDD410009E9
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 12:57:52 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=EYdPi1lK7T32mJFaa/g/x7d96cTi6/lT2qnyLXxgL10=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791370671; v=1; x=1791975471;
 b=X0leO2CuX9919adror9iKnCyTA0Idf03A455KWqj+aPzXS5Saf9Ng0G6luQEzcObsboXZHAR
 sQy4QJmv/fI52Yl9azMgWHWxjyOrVqX63j/aeP7paA4DwR2QXBUFXMYLj3HO9FyNHxGXEVs3cuW
 uXLtvTEwEz/nSgHXKF7vceGk=
X-Envelope-To: ltp@lists.linux.it
Received: by mta10.migadu.com with ESMTPS id a05e9c0aa8f8e387;
 Wed, 07 Oct 2026 10:57:51 +0000
X-Mizu-Trace-ID: a05e9c0aa8f8e387
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Wed,  7 Oct 2026 18:57:28 +0800
Message-ID: <20261007105730.94492-2-li.wang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007105730.94492-1-li.wang@linux.dev>
References: <20261007105730.94492-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_kconfig: load and unload kernel modules for
 CONFIG_*=m
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

Tests that depend on a config set to =m must currently load the
module themselves, and may fail with misleading errors when it is
not loaded, e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK when
vsock_loopback is missing.

Record the module for every config_module_maps[] entry seen as =m
during kconfig_parse_line(), load them in
tst_kconfig_module_load() via tst_modprobe(), and unload them in
reverse order from tst_kconfig_module_unload_all(), called by
do_test_cleanup(). Modules still in use are skipped without
aborting the test.

Loading and unloading are performed only as root; otherwise the
recorded list is left untouched.

Signed-off-by: Li Wang <li.wang@linux.dev>
---
 include/tst_kconfig.h | 28 +++++++++++++++++
 lib/tst_kconfig.c     | 70 +++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c        |  4 +++
 3 files changed, 102 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index c454f3467..540ae369c 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -105,4 +105,32 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
  */
 int tst_has_slow_kconfig(void);
 
+/*
+ * tst_kconfig_module_load() - Load kernel modules for CONFIG_*=m entries.
+ *
+ * Loads every module recorded during the last kernel config check, in
+ * the order they were discovered. The list is populated by
+ * kconfig_module_record() from kconfig_parse_line() for each CONFIG_*
+ * entry that is set to =m and has a matching entry in
+ * config_module_maps[].
+ *
+ * Loading is skipped when not running as root, and does nothing when
+ * the recorded list is empty.
+ */
+void tst_kconfig_module_load(void);
+
+/*
+ * tst_kconfig_module_unload_all() - Unload modules loaded by
+ *                                   tst_kconfig_module_load().
+ *
+ * Unloads every module recorded by tst_kconfig_module_load(), in
+ * reverse load order so that inter-module dependencies are respected.
+ * Modules still in use are skipped silently, leaving the system state
+ * as close as possible to what it was before the test started.
+ *
+ * Called from do_test_cleanup() so that the modules are released when
+ * the test finishes, regardless of the test result.
+ */
+void tst_kconfig_module_unload_all(void);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 49957e28d..7e3ee1fe8 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -16,8 +16,14 @@
 #include "tst_bool_expr.h"
 #include "tst_safe_stdio.h"
 
+#include "tst_module.h"
 #include "tst_kconfig_checks.h"
 
+#define MAX_LOADED_MODULES 16
+
+static const char *loaded_modules[MAX_LOADED_MODULES];
+static unsigned int loaded_module_count;
+
 static int kconfig_skip_check(void)
 {
 	char *skipped = getenv("KCONFIG_SKIP_CHECK");
@@ -189,6 +195,35 @@ static void kconfig_module_check(struct tst_kconfig_var *var)
 	}
 }
 
+static const char *module_name_for_config(const char *cfg)
+{
+	size_t i;
+
+	for (i = 0; config_module_maps[i].config; i++) {
+		if (!strcmp(config_module_maps[i].config, cfg))
+			return config_module_maps[i].module_name;
+	}
+
+	return NULL;
+}
+
+static void kconfig_module_record(const char *cfg)
+{
+	unsigned int i;
+	const char *mod = module_name_for_config(cfg);
+
+	if (!mod)
+		return;
+
+	for (i = 0; i < loaded_module_count; i++) {
+		if (!strcmp(loaded_modules[i], mod))
+			return;
+	}
+
+	if (loaded_module_count < MAX_LOADED_MODULES)
+		loaded_modules[loaded_module_count++] = mod;
+}
+
 static inline int kconfig_parse_line(const char *line,
                                      struct tst_kconfig_var *vars,
                                      unsigned int vars_len)
@@ -268,6 +303,8 @@ out:
 				vars[i].choice = 'm';
 				kconfig_runtime_check(&vars[i]);
 				kconfig_module_check(&vars[i]);
+				if (vars[i].choice == 'm')
+					kconfig_module_record(vars[i].id);
 				return 1;
 			}
 		}
@@ -300,6 +337,39 @@ exit:
 	close_kconfig(fp);
 }
 
+void tst_kconfig_module_load(void)
+{
+	unsigned int i;
+
+	if (geteuid() != 0)
+		return;
+
+	for (i = 0; i < loaded_module_count; i++) {
+		tst_res(TDEBUG, "Loading module '%s'", loaded_modules[i]);
+		tst_modprobe(loaded_modules[i], NULL);
+	}
+}
+
+void tst_kconfig_module_unload_all(void)
+{
+	unsigned int i;
+
+	if (!loaded_module_count)
+		return;
+
+	if (geteuid() != 0)
+		return;
+
+	for (i = loaded_module_count; i > 0; i--) {
+		const char *const argv[] = { "rmmod", loaded_modules[i - 1], NULL };
+
+		tst_res(TDEBUG, "Unloading module '%s'", loaded_modules[i - 1]);
+		tst_cmd(argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);
+	}
+
+	loaded_module_count = 0;
+}
+
 static size_t array_len(const char *const kconfigs[])
 {
 	size_t i = 0;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 10ff73397..04a85a781 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -425,6 +425,7 @@ static void do_test_cleanup(void)
 		tst_test->cleanup();
 
 	tst_free_all();
+	tst_kconfig_module_unload_all();
 
 	tst_brk_handler = tst_vbrk_;
 }
@@ -1474,6 +1475,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
+	if (tst_test->needs_kconfigs)
+		tst_kconfig_module_load();
+
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
