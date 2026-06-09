Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEA4CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 064153E6F34
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 16:32:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8795A3C537D
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 16:32:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 941D260079B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 16:32:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 602CB75C5C;
 Tue,  9 Jun 2026 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781015559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3EntVLVmprW4/OLD0dKg/pTzj8klB7nrO+r4B0dbYOU=;
 b=aeStm7k8cM/wUjkV4+l569BF2CtiAylCRFDYpaMTyr+xXPBK9qjuhqBmz+ARDShopG3dwy
 UqV1lDiZ2SSu6HqeVUAq9De6DzdehnxBy3jp9OQz17px8t8umNgvxUAaEIemR0lGRqe3DN
 /myCSrEdHTjPC8gxWh7gHXoDiIJPqH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781015559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3EntVLVmprW4/OLD0dKg/pTzj8klB7nrO+r4B0dbYOU=;
 b=3uTOmBmlXGiJ/juMqrBSQ20Kx6aiPdK+rFAK04yzgZFyoUirbwrAm8d5DVWCEEdDRWgHWH
 Boih6q8Vx/JPu9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781015559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3EntVLVmprW4/OLD0dKg/pTzj8klB7nrO+r4B0dbYOU=;
 b=aeStm7k8cM/wUjkV4+l569BF2CtiAylCRFDYpaMTyr+xXPBK9qjuhqBmz+ARDShopG3dwy
 UqV1lDiZ2SSu6HqeVUAq9De6DzdehnxBy3jp9OQz17px8t8umNgvxUAaEIemR0lGRqe3DN
 /myCSrEdHTjPC8gxWh7gHXoDiIJPqH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781015559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3EntVLVmprW4/OLD0dKg/pTzj8klB7nrO+r4B0dbYOU=;
 b=3uTOmBmlXGiJ/juMqrBSQ20Kx6aiPdK+rFAK04yzgZFyoUirbwrAm8d5DVWCEEdDRWgHWH
 Boih6q8Vx/JPu9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ED31779A7;
 Tue,  9 Jun 2026 14:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0hWPEQckKGrTUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jun 2026 14:32:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Jun 2026 16:32:37 +0200
Message-ID: <20260609143237.1246776-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid, intel.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test: Add needs_cpu_vendor to struct tst_test
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

This adds a generic implementaiton of needs_cpu_vendor to the tst_test
structure that is based on parsing /proc/cpuinfo. It does not likely
work for non-x86 CPUs since the /proc/cpuinfo format is different, but
we do not care at the moment. For arm we would have to look at the
implementer field instead, we will add that if/once needed.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Piotr Kubaj <piotr.kubaj@intel.com>
---
 include/tst_cpu.h                  |  9 +++++++++
 include/tst_test.h                 |  5 +++++
 lib/newlib_tests/.gitignore        |  1 +
 lib/newlib_tests/test_cpu_vendor.c | 16 ++++++++++++++++
 lib/tst_cpu.c                      | 18 ++++++++++++++++++
 lib/tst_test.c                     |  5 +++++
 6 files changed, 54 insertions(+)
 create mode 100644 lib/newlib_tests/test_cpu_vendor.c

diff --git a/include/tst_cpu.h b/include/tst_cpu.h
index 0724975f0..31222a3e1 100644
--- a/include/tst_cpu.h
+++ b/include/tst_cpu.h
@@ -10,6 +10,13 @@ long tst_ncpus_conf(void);
 long tst_ncpus_max(void);
 long tst_ncpus_available(void);
 
+/**
+ * tst_cpu_vendor() - Returns CPU vendor.
+ *
+ * Return: A CPU vendor e.g. "GenuineIntel" or "AuthenticAMD".
+ */
+const char *tst_cpu_vendor(void);
+
 #define VIRT_ANY	0	/* catch-all argument for tst_is_virt() */
 #define VIRT_XEN	1	/* xen dom0/domU */
 #define VIRT_KVM	2	/* only default virtual CPU */
@@ -21,4 +28,6 @@ long tst_ncpus_available(void);
 
 int tst_is_virt(int virt_type);
 
+
+
 #endif	/* TST_CPU_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 9bc67cf6a..c69362485 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -391,6 +391,9 @@ struct tst_fs {
  *
  * @min_cpus: Minimal number of online CPUs the test needs to run.
  *
+ * @needs_cpu_vendor: The test needs a specific CPU vendor e.g. "GenuineIntel"
+ *                    or "AuthenticAMD".
+ *
  * @min_mem_avail: Minimal amount of available RAM memory in megabytes required
  *                 for the test to run.
  *
@@ -581,6 +584,8 @@ struct tst_fs {
 	const char *const *skip_filesystems;
 
 	unsigned long min_cpus;
+	const char *needs_cpu_vendor;
+
 	unsigned long min_mem_avail;
 	unsigned long min_swap_avail;
 
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 1586e0ad6..b85163824 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -71,3 +71,4 @@ test_brk_parent
 test_brk_pass
 test_brk_variant
 test_fail_variant
+test_cpu_vendor
diff --git a/lib/newlib_tests/test_cpu_vendor.c b/lib/newlib_tests/test_cpu_vendor.c
new file mode 100644
index 000000000..10b473b7e
--- /dev/null
+++ b/lib/newlib_tests/test_cpu_vendor.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Test passed!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_cpu_vendor = "Nonexistent",
+};
diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index faffcba91..177661c82 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "tso_safe_macros.h"
+#include "tso_safe_file_ops.h"
 
 long tst_ncpus(void)
 {
@@ -97,3 +98,20 @@ long tst_ncpus_available(void)
 	return tst_ncpus();
 #endif
 }
+
+const char *tst_cpu_vendor(void)
+{
+	static char cpu_vendor[16];
+	int ret;
+
+	if (cpu_vendor[0])
+		return cpu_vendor;
+
+	ret = FILE_LINES_SCANF(NULL, "/proc/cpuinfo", "vendor_id : %16s[^\n]", cpu_vendor);
+	if (ret)
+		strcpy(cpu_vendor, "Unknown");
+
+	tst_resm(TDEBUG, "CPU vendor '%s'", cpu_vendor);
+
+	return cpu_vendor;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0bebb0a3e..5f7156403 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1416,6 +1416,11 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
 
+	if (tst_test->needs_cpu_vendor && strcmp(tst_test->needs_cpu_vendor, tst_cpu_vendor())) {
+		tst_brk(TCONF, "Tests needs '%s' CPU to continue have '%s'",
+			tst_test->needs_cpu_vendor, tst_cpu_vendor());
+	}
+
 	if (tst_test->sample)
 		tst_test = tst_timer_test_setup(tst_test);
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
