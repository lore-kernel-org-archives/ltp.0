Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A82C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 236323D666E
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:24:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B00503D75B8
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 33A4B200962
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A71521954
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIx7MHk9tYQ8yp/eDSfW4nMpNWzJI6+KbnK3b79FLY8=;
 b=aNPoKafNut/BJUf9Zoe+qzIwNQ6axzkgC21wWqEMDk/gGaUPNda4I2Cz+xS4+PpfyydttV
 9W1Lm55IDtYnOmMVB9KwFIKQCO8qiF/QqaerfW6MgWIpf71Cajl0eaoJ6Sg6gqzmc4MvRa
 mZ5aBwYmuYLs1cANS8gXrnrzrxJHt+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIx7MHk9tYQ8yp/eDSfW4nMpNWzJI6+KbnK3b79FLY8=;
 b=hZelpbPh/UQobmVv4vX1f44BiH4zZk4mOjdF4NreWupCtSVVxsuU3/g7nET1AElKyVyBM2
 r+Gzp9lqfcQEpgDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ahjnJhma;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jxWQbjU+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIx7MHk9tYQ8yp/eDSfW4nMpNWzJI6+KbnK3b79FLY8=;
 b=ahjnJhmay3ZPyUTUG5R0Htea/7pdXB9IOVASctv2XIAmnGgF7/vPcewG3OQCHVymz/QHoy
 tQc6d8KMyxFKBNfbg7IHnjQOKjWc3It2ZtPzz3Y5fueGr70D9W2LDR12rBky/rh4LXrGf+
 yMVlA4uI/1c5XFARlzxdfHGLP/dH/lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIx7MHk9tYQ8yp/eDSfW4nMpNWzJI6+KbnK3b79FLY8=;
 b=jxWQbjU+unUAMu777/jvJ09E3DPouuT2wJ/2MePsMtEsix/jsNQLH53hH7fVXHp8N7/kpa
 yJoJVqQUoP359UDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1C9D1368F
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jFCMLdsdkGpZawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:35 +0200
Message-ID: <20260827112157.1748734-10-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A71521954
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 09/31] testcases: sysfs: Add sys_cpu_smt01
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

A test for /sys/devices/system/cpu/smt/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_path_defs.h                       |  1 +
 runtest/sysfs                                 |  1 +
 .../sysfs/devices/system/cpu/.gitignore       |  1 +
 .../sysfs/devices/system/cpu/sys_cpu_smt01.c  | 98 +++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 31581482d..6bc0d65e1 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -95,6 +95,7 @@
 /* SYSFS DEVICES */
 #define PATH_SYS_CLOCKSOURCE			"/sys/devices/system/clocksource"
 #define PATH_SYS_CPU				"/sys/devices/system/cpu"
+#define PATH_SYS_CPU_SMT			"/sys/devices/system/cpu/smt"
 #define PATH_SYS_CPU_VULN			"/sys/devices/system/cpu/vulnerabilities"
 #define PATH_SYS_NODE				"/sys/devices/system/node"
 
diff --git a/runtest/sysfs b/runtest/sysfs
index 663c1d203..4cc2360c6 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -5,3 +5,4 @@ sys_node01 sys_node01
 sys_cpu_topology01 sys_cpu_topology01
 sys_cpu_topology02 sys_cpu_topology02
 sys_cpu_vulnerabilities01 sys_cpu_vulnerabilities01
+sys_cpu_smt01 sys_cpu_smt01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/.gitignore b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
index 3ae5f494f..d0f8a6dab 100644
--- a/testcases/kernel/sysfs/devices/system/cpu/.gitignore
+++ b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
@@ -1,3 +1,4 @@
 /sys_cpu_topology01
 /sys_cpu_topology02
 /sys_cpu_vulnerabilities01
+/sys_cpu_smt01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c
new file mode 100644
index 000000000..6b753a911
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the PATH_SYS_CPU_SMT (simultaneous multithreading) control exported
+ * under /sys/devices/system/cpu/smt/.
+ *
+ * The test verifies that:
+ *
+ * - active is a boolean (0 or 1)
+ * - control is one of the known states (on, off, forceoff, notsupported,
+ *   notimplemented) or, on architectures that support a partial PATH_SYS_CPU_SMT level
+ *   (CONFIG_SMT_NUM_THREADS_DYNAMIC), a positive integer greater than one
+ *   that denotes the number of active threads per core
+ * - when PATH_SYS_CPU_SMT is not usable (control is notsupported or notimplemented) active
+ *   reads back as 0
+ *
+ * The test skips with TCONF when the smt directory is not present.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static const char *const control_allowed[] = {
+	"on", "off", "forceoff", "notsupported", "notimplemented", NULL
+};
+
+static int is_number(const char *str)
+{
+	if (!*str)
+		return 0;
+
+	for (; *str; str++) {
+		if (!isdigit(*str))
+			return 0;
+	}
+
+	return 1;
+}
+
+static void do_test(void)
+{
+	char control[32];
+	long active;
+
+	if (access(PATH_SYS_CPU_SMT, F_OK)) {
+		tst_res(TCONF, PATH_SYS_CPU_SMT " is not available");
+		return;
+	}
+
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_CPU_SMT "/active");
+
+	if (!TST_SYSFS_READ_STR(control, sizeof(control), PATH_SYS_CPU_SMT "/control")) {
+		tst_res(TCONF, PATH_SYS_CPU_SMT "/control file not present");
+		return;
+	}
+
+	if (is_number(control)) {
+		long threads = SAFE_STRTOL(control, 1, LONG_MAX);
+
+		if (threads > 1) {
+			tst_res(TPASS,
+				PATH_SYS_CPU_SMT "/control = '%s' (%ld threads per core)",
+				control, threads);
+		} else {
+			tst_res(TFAIL,
+				PATH_SYS_CPU_SMT "/control = '%s' is not a valid thread count",
+				control);
+		}
+	} else {
+		TST_SYSFS_ASSERT_ONEOF(control_allowed, PATH_SYS_CPU_SMT "/control");
+	}
+
+	active = TST_SYSFS_READ_LI(PATH_SYS_CPU_SMT "/active");
+
+	if (!strcmp(control, "notsupported") ||
+	    !strcmp(control, "notimplemented")) {
+		if (active == 0) {
+			tst_res(TPASS,
+				"active is 0 while PATH_SYS_CPU_SMT control is '%s'", control);
+		} else {
+			tst_res(TFAIL,
+				"active is %ld while PATH_SYS_CPU_SMT control is '%s'",
+				active, control);
+		}
+	}
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
