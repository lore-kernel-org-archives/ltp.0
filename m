Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E9606A324
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XZpPrh2H
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C95833C70AB
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AEC23C6F70
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:57:33 +0100 (CET)
Received: from mta0.migadu.com (out-232.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 252AF10008EC
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:57:32 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=An5LpLPtE0nEyytqswbQIjfMx10/KBWiU15oRJEzMNM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793692652; v=1; x=1794297452;
 b=XZpPrh2HURoLsb3acnesj355gQDAeKS9hthaDQUHCnbLO2ILtsAqn2q59GDLcGllsZyM3+WE
 XaITviWWHcRQq1WSnQ7/fDYz4W/tVFBxvMnrw8NR3q/lNbcgwa/hY7zeKbsWB6jt4r0jk9Pc/5T
 pmNj5onvqmsmAF9TnzL4vvjs=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id d30af1db0e96c0c9;
 Tue, 03 Nov 2026 07:57:32 +0000
X-Mizu-Trace-ID: d30af1db0e96c0c9
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue,  3 Nov 2026 15:57:20 +0800
Message-ID: <20261103075722.181317-3-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075722.181317-1-li.wang@linux.dev>
References: <20261103075722.181317-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/4] tst_kconfig: load and unload kernel modules
 for CONFIG_*=m
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests that depend on a config set to =m must currently load the
module themselves, and may fail with misleading errors when it is
not loaded, e.g. bind() returning EADDRNOTAVAIL for AF_VSOCK when
vsock_loopback is missing.

Record the module for every config_module_maps[] entry seen as =m
and not already loaded while parsing the kernel config. When
needs_kconfigs is set, load them via tst_modprobe() after a
successful tst_kconfig_check(), and unload them in reverse order
from do_cleanup(). Only modules that were actually loaded are
unloaded; modules still in use are skipped. Dependencies pulled in
by modprobe are not unloaded.

Modules are only loaded when running as root.

Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 include/tst_kconfig.h | 21 ++++++++++
 lib/tst_kconfig.c     | 89 +++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c        | 13 +++++--
 3 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index c454f3467..d603919d9 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -105,4 +105,25 @@ void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
  */
 int tst_has_slow_kconfig(void);
 
+/**
+ * tst_kconfig_module_load() - Load kernel modules for CONFIG_*=m entries.
+ *
+ * Loads the modules for CONFIG_* options found as =m in the kernel config
+ * that are not already loaded, in the order they were found.
+ * Does nothing when not running as root.
+ */
+void tst_kconfig_module_load(void);
+
+/**
+ * tst_kconfig_module_unload() - Unload modules loaded by
+ *                               tst_kconfig_module_load().
+ *
+ * Unloads, in reverse order, only the modules that were actually loaded.
+ * Modules still in use are skipped silently. Dependencies pulled in by
+ * modprobe are not unloaded.
+ *
+ * Called from do_cleanup(), so it runs regardless of the test result.
+ */
+void tst_kconfig_module_unload(void);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index f055c2e5f..1b5fa104a 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -16,8 +16,16 @@
 #include "tst_bool_expr.h"
 #include "tst_safe_stdio.h"
 
+#include "lapi/syscalls.h"
+#include "tst_module.h"
 #include "tst_kconfig_checks.h"
 
+#define MAX_LOADED_MODULES 32
+
+static const char *loaded_modules[MAX_LOADED_MODULES];
+static unsigned int module_count;
+static unsigned int loaded_module_count;
+
 static int kconfig_skip_check(void)
 {
 	char *skipped = getenv("KCONFIG_SKIP_CHECK");
@@ -189,6 +197,38 @@ static void kconfig_module_check(struct tst_kconfig_var *var)
 	}
 }
 
+static void kconfig_module_record(struct tst_kconfig_var *var)
+{
+	unsigned int i;
+	const char *mod = NULL;
+
+	if (var->choice != 'm')
+		return;
+
+	for (i = 0; config_module_maps[i].config; i++) {
+		if (!strcmp(config_module_maps[i].config, var->id)) {
+			mod = config_module_maps[i].module_name;
+			break;
+		}
+	}
+
+	if (!mod)
+		return;
+
+	if (tst_module_is_loaded(mod))
+		return;
+
+	for (i = 0; i < module_count; i++) {
+		if (!strcmp(loaded_modules[i], mod))
+			return;
+	}
+
+	if (module_count >= MAX_LOADED_MODULES)
+		tst_brk(TBROK, "Too many modules, increase MAX_LOADED_MODULES");
+
+	loaded_modules[module_count++] = mod;
+}
+
 static inline int kconfig_parse_line(const char *line,
                                      struct tst_kconfig_var *vars,
                                      unsigned int vars_len)
@@ -268,6 +308,7 @@ out:
 				vars[i].choice = 'm';
 				kconfig_runtime_check(&vars[i]);
 				kconfig_module_check(&vars[i]);
+				kconfig_module_record(&vars[i]);
 				return 1;
 			}
 		}
@@ -300,6 +341,54 @@ exit:
 	close_kconfig(fp);
 }
 
+void tst_kconfig_module_load(void)
+{
+	unsigned int i;
+
+	if (geteuid() != 0)
+		return;
+
+	for (i = 0; i < module_count; i++) {
+		tst_res(TDEBUG, "Loading module '%s'", loaded_modules[i]);
+		tst_modprobe(loaded_modules[i], NULL);
+
+		loaded_module_count++;
+	}
+}
+
+void tst_kconfig_module_unload(void)
+{
+	char name[64], *p;
+
+	if (!loaded_module_count)
+		return;
+
+	while (loaded_module_count > 0) {
+		snprintf(name, sizeof(name), "%s",
+			 loaded_modules[--loaded_module_count]);
+
+		for (p = name; (p = strchr(p, '-')); )
+			*p = '_';
+
+		tst_res(TDEBUG, "Unloading module '%s'", name);
+
+		if (!syscall(__NR_delete_module, name, O_NONBLOCK))
+			continue;
+
+		switch (errno) {
+		case ENOENT:		/* already unloaded */
+		case EWOULDBLOCK:	/* in use */
+		case EBUSY:		/* still loading or unloading */
+		case ENOSYS:		/* no CONFIG_MODULE_UNLOAD */
+			break;
+		default:
+			tst_res(TWARN | TERRNO, "Failed to unload module '%s'", name);
+		}
+	}
+
+	loaded_module_count = 0;
+}
+
 static size_t array_len(const char *const kconfigs[])
 {
 	size_t i = 0;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 10ff73397..a9e679bee 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1471,12 +1471,16 @@ static void do_setup(int argc, char *argv[])
 
 	check_supported_kver();
 
-	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
-		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
-
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
+	if (tst_test->needs_kconfigs) {
+		if (tst_kconfig_check(tst_test->needs_kconfigs))
+			tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
+
+		tst_kconfig_module_load();
+	}
+
 	if (tst_test->min_kver)
 		check_kver(tst_test->min_kver, 1);
 
@@ -1690,6 +1694,9 @@ static void do_cleanup(void)
 	if (tst_test->restore_wallclock)
 		tst_wallclock_restore();
 
+	if (tst_test->needs_kconfigs)
+		tst_kconfig_module_unload();
+
 	cleanup_ipc();
 }
 
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
