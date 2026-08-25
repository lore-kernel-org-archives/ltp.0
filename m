Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF1EC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:39:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F7043C55EA
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:39:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 176F83C71FD
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3C2FD1400BD9
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BAA91F7E3
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhsbMQ9QUpJd4xRKUThatOe3bcyWiiCju8v0k169uyk=;
 b=G4mkLdLpdI1rcnaQV6mwCmsoH1hgP8wNp0rUVPH37pis5e0qa5LL13wiSx/M6VgWXRizUK
 x+blLeVVmVMA5Zx3xYYzil/Rn4xhTFQOzB3oiY7d3ZA7MH2c7hsGhrewCDr/3p6kexoEGy
 AQZSflo0YlYN+bdUoQWcEMq5K26cXlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhsbMQ9QUpJd4xRKUThatOe3bcyWiiCju8v0k169uyk=;
 b=SghHya6oagM8YneY+mS4YkAjJj68P053hyF/wqpM6eZlzpJQSByG3LaJRws3aSiYlFmh8K
 ojx+d3yKrlesWABA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhsbMQ9QUpJd4xRKUThatOe3bcyWiiCju8v0k169uyk=;
 b=OxdTendrTN9WpcnXc8JDvKxOFub1Ge6Yt1WBzSeWWW/AICmEK4VwbNRIq3sjncoAXYW8YS
 MiAqgoXymBCEMoElFiGL+hj2y0T5yHg0jxMIWEWaSdo01OmRGqlvEcF2ziw6ASazmm0V1r
 0Vr6c+0IXJtWyOFvTc7ztflLA54DjDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhsbMQ9QUpJd4xRKUThatOe3bcyWiiCju8v0k169uyk=;
 b=Rnf5uqEagxwjatlzHUts03bnFIcUgeiufC1H3ZXEg184TdVc0EPl7nklr80W5VPZRadSOc
 I3FSWsrH9APJRQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44DB13432
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +g7aMjp+jWo1SAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:03 +0200
Message-ID: <20260825113625.1624134-10-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 09/31] testcases: sysfs: Add sys_cpu_smt01
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
 runtest/sysfs                                 |  1 +
 .../sysfs/devices/system/cpu/.gitignore       |  1 +
 .../sysfs/devices/system/cpu/sys_cpu_smt01.c  | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c

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
index 000000000..770b68bb4
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the SMT (simultaneous multithreading) control exported
+ * under /sys/devices/system/cpu/smt/.
+ *
+ * The test verifies that:
+ *
+ * - active is a boolean (0 or 1)
+ * - control is one of the known states (on, off, forceoff, notsupported,
+ *   notimplemented) or, on architectures that support a partial SMT level
+ *   (CONFIG_SMT_NUM_THREADS_DYNAMIC), a positive integer greater than one
+ *   that denotes the number of active threads per core
+ * - when SMT is not usable (control is notsupported or notimplemented) active
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
+
+#define SMT "/sys/devices/system/cpu/smt"
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
+	if (access(SMT, F_OK)) {
+		tst_res(TCONF, SMT " is not available");
+		return;
+	}
+
+	TST_SYSFS_ASSERT_BOOL(SMT "/active");
+
+	if (!TST_SYSFS_READ_STR(control, sizeof(control), SMT "/control")) {
+		tst_res(TCONF, SMT "/control file not present");
+		return;
+	}
+
+	if (is_number(control)) {
+		long threads = SAFE_STRTOL(control, 1, LONG_MAX);
+
+		if (threads > 1) {
+			tst_res(TPASS,
+				SMT "/control = '%s' (%ld threads per core)",
+				control, threads);
+		} else {
+			tst_res(TFAIL,
+				SMT "/control = '%s' is not a valid thread count",
+				control);
+		}
+	} else {
+		TST_SYSFS_ASSERT_ONEOF(control_allowed, SMT "/control");
+	}
+
+	active = TST_SYSFS_READ_LI(SMT "/active");
+
+	if (!strcmp(control, "notsupported") ||
+	    !strcmp(control, "notimplemented")) {
+		if (active == 0) {
+			tst_res(TPASS,
+				"active is 0 while SMT control is '%s'", control);
+		} else {
+			tst_res(TFAIL,
+				"active is %ld while SMT control is '%s'",
+				active, control);
+		}
+	}
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
