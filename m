Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A84DC79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:27:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 494C43E2B39
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:27:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD1B63E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:26:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34C491400C5E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:26:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C33EA219F7;
 Tue,  8 Sep 2026 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788848796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIcurNF2fy/4sVC9U8V9rRlKnFBTb+s+4NtJ95upOhA=;
 b=mkfjHM9phtVUjwmCfd3B/J65Hcpcksec+IKW1FhVm3aOe5b4E3yd6yYuJ+Oy92krHMfg7a
 x/oR0wm1D/Aa7e2e+I4HJqgim2jwwluzDxzu/JHdMWRUJDMYiPxGAf2mbXxOqak4J5f6EE
 vPTlbHe3V6Ngvh/CSpaCloplqm00gbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788848796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIcurNF2fy/4sVC9U8V9rRlKnFBTb+s+4NtJ95upOhA=;
 b=jhvhQ++GibMkNYVHyV1yUQ+lieWGeylZneazHZHwzs7j0doUum8+CoFnTC6l0Sa6TQrgAH
 +qYWl4Nyu97RPTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788848792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIcurNF2fy/4sVC9U8V9rRlKnFBTb+s+4NtJ95upOhA=;
 b=YhXZ6B9xPnP+XdM45NzMH99PwS1p1Ke+rINtgs7KoCAxhNHyMMKvSukSlvhdByB8Y5AxAi
 Mi33fuIQEp0zqjaMaqlB9VVcJck1wk3jobel5aFqok6m8c51W5Kg1QqAJjipThl6g76st/
 M+g+L5AozBGb5YA+zHnH/BIKcOnTHGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788848792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIcurNF2fy/4sVC9U8V9rRlKnFBTb+s+4NtJ95upOhA=;
 b=lryA6QHxtaWYsat4b6Qmd6ykZ/RU1kUGaIH1n3yG6iciXGKhyOdLDDXec0sxFgNLg0JvD9
 jUQojSec4bCvjQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E2511364A;
 Tue,  8 Sep 2026 06:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2HnQFJiqn2orJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Sep 2026 06:26:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Sep 2026 08:26:31 +0200
MIME-Version: 1.0
Message-Id: <20260908-coredump-v8-1-591f96004543@suse.com>
References: <20260908-coredump-v8-0-591f96004543@suse.com>
In-Reply-To: <20260908-coredump-v8-0-591f96004543@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848792; l=10999;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=18zLPEx1d8aRDmbfOVFu9g11sRBCOHGUrlb67JjYLVo=;
 b=eUbxWMCh0DFvoJYscv3kqS/gni8LW/li9SW9WzE1FA3OIkyOtYOW72drG1ZJUzeeW4DZf+i0w
 2NK4io4CDbfCxfd/dIQPrP3RF4MCJ65cUYP6+IHBBoM6B4dvG7QHAQK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, linux.dev:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 1/2] coredump01: New core_pattern specifiers test
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

LTP has no coverage for the core_pattern specifiers expansion, neither
for the pipe flavor of core_pattern, where the kernel spawns a user
space helper and writes the core dump into its standard input.

The new test verifies that %e, %p and %s are expanded both in the core
file name and in the arguments of a piped helper, checking also that
the helper really receives an ELF core dump.

Root is required to rewrite the system wide core_pattern, which is
restored by the test library on all exit paths.

Reviewed-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                           |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   2 +
 testcases/kernel/coredump/Makefile            |   7 ++
 testcases/kernel/coredump/coredump01.c        | 158 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++++++
 testcases/kernel/coredump/coredump_common.h   |  69 +++++++++++
 7 files changed, 311 insertions(+)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index cc3562cb7..ecf9ee2a2 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -17,3 +17,4 @@ zram02 zram02.sh
 zram03 zram03
 umip_basic_test umip_basic_test
 aslr01 aslr01
+coredump01 coredump01
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index ac816e4e8..6b303c14b 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -19,6 +19,7 @@ SUBDIRS			+= lib
 SUBDIRS			+= connectors \
 			   containers \
 			   controllers \
+			   coredump \
 			   crypto \
 			   device-drivers \
 			   firmware \
diff --git a/testcases/kernel/coredump/.gitignore b/testcases/kernel/coredump/.gitignore
new file mode 100644
index 000000000..cd0b51700
--- /dev/null
+++ b/testcases/kernel/coredump/.gitignore
@@ -0,0 +1,2 @@
+/coredump01
+/coredump01_helper
diff --git a/testcases/kernel/coredump/Makefile b/testcases/kernel/coredump/Makefile
new file mode 100644
index 000000000..951a3e976
--- /dev/null
+++ b/testcases/kernel/coredump/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/coredump/coredump01.c b/testcases/kernel/coredump/coredump01.c
new file mode 100644
index 000000000..ad690e95c
--- /dev/null
+++ b/testcases/kernel/coredump/coredump01.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Linux Test Project
+ */
+
+/*\
+ * Verify that the kernel expands the :manpage:`core(5)` specifiers %e
+ * (executable name), %p (PID) and %s (signal number) when it creates a
+ * core dump.
+ *
+ * Both flavors of ``/proc/sys/kernel/core_pattern`` are tested:
+ *
+ * - a plain file name, where the specifiers become part of the core file
+ *   name
+ * - a pipe to a user space helper, where the specifiers are expanded in
+ *   the helper arguments and the core dump is written to the helper
+ *   standard input
+ *
+ * The test needs root because it rewrites the system wide core_pattern.
+ * The original value is saved and restored by the test library on all
+ * exit paths.
+ *
+ * [Algorithm]
+ *
+ * - Point core_pattern into the test temporary directory
+ * - Fork a child which aborts itself to produce a core dump
+ * - For the file pattern check that ``core.<exe>.<pid>.<signal>`` was created
+ * - For the pipe pattern check the arguments the helper was called with
+ *   and that it received an ELF core dump on its standard input
+ */
+
+#include "coredump_common.h"
+#include "tst_kconfig.h"
+
+#define HELPER "coredump01_helper"
+#define HELPER_TIMEOUT 10
+
+static char helper_path[PATH_MAX];
+static int static_usermodehelper;
+
+/*
+ * e_ident[] and e_type live at the same file offset in ELF32 and ELF64,
+ * so we can validate both without picking a class.
+ */
+static void verify_elf_core(const char *path)
+{
+	unsigned char hdr[EI_NIDENT + sizeof(Elf32_Half)];
+	Elf32_Half e_type;
+	int fd;
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+	SAFE_READ(1, fd, hdr, sizeof(hdr));
+	SAFE_CLOSE(fd);
+
+	memcpy(&e_type, hdr + EI_NIDENT, sizeof(e_type));
+
+	TST_EXP_EXPR(!memcmp(hdr, ELFMAG, SELFMAG), "%s starts with ELF magic", path);
+	TST_EXP_EQ_LI(e_type, ET_CORE);
+}
+
+static void verify_file_pattern(void)
+{
+	char dump[PATH_MAX + 32];
+	pid_t pid;
+
+	tst_res(TINFO, "Testing file core_pattern");
+
+	set_pattern("%s/core.%%e.%%p.%%s", cwd);
+
+	pid = crash_child();
+
+	snprintf(dump, sizeof(dump), "%s/core.coredump01.%d.%d", cwd, pid, SIGABRT);
+
+	TST_EXP_PASS(access(dump, F_OK), "core.%%e.%%p.%%s expanded to core.coredump01.%d.%d",
+		     pid, SIGABRT);
+	if (!TST_PASS)
+		return;
+
+	verify_elf_core(dump);
+}
+
+static void verify_pipe_pattern(void)
+{
+	char res[PATH_MAX + 32], exe[PATH_MAX];
+	int pid_seen, sig_seen, elf, et_core;
+	long long bytes;
+	pid_t pid;
+
+	if (static_usermodehelper) {
+		tst_res(TCONF, "CONFIG_STATIC_USERMODEHELPER is enabled, skipping pipe core_pattern");
+		return;
+	}
+
+	tst_res(TINFO, "Testing pipe core_pattern");
+
+	set_pattern("|%s %%e %%p %%s %s/res.%%p", helper_path, cwd);
+
+	pid = crash_child();
+
+	snprintf(res, sizeof(res), "%s/res.%d", cwd, pid);
+
+	/* the kernel spawns the helper asynchronously */
+	if (TST_RETRY_FN_EXP_BACKOFF(access(res, F_OK), TST_RETVAL_EQ0, HELPER_TIMEOUT)) {
+		tst_res(TFAIL, "%s did not report any core dump", HELPER);
+		return;
+	}
+
+	SAFE_FILE_SCANF(res, "exe=%15s pid=%d sig=%d bytes=%lld elf=%d et_core=%d",
+			exe, &pid_seen, &sig_seen, &bytes, &elf, &et_core);
+
+	TST_EXP_EQ_STR(exe, "coredump01");
+	TST_EXP_EQ_LI(pid_seen, pid);
+	TST_EXP_EQ_LI(sig_seen, SIGABRT);
+	TST_EXP_EXPR(elf && bytes > 0, "%s read %lli bytes of ELF core dump", HELPER, bytes);
+	TST_EXP_EQ_LI(et_core, 1);
+}
+
+static void run(unsigned int n)
+{
+	if (n)
+		verify_pipe_pattern();
+	else
+		verify_file_pattern();
+}
+
+static void setup(void)
+{
+	char path[PATH_MAX];
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_STATIC_USERMODEHELPER");
+
+	coredump_setup();
+
+	tst_kconfig_read(&kconfig, 1);
+	static_usermodehelper = (kconfig.choice == 'y');
+
+	if (tst_get_path(HELPER, path, sizeof(path)))
+		tst_brk(TCONF, "'%s' not found in $PATH", HELPER);
+
+	if (!realpath(path, helper_path))
+		tst_brk(TBROK | TERRNO, "realpath(%s) failed", path);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char* []) {
+		"CONFIG_COREDUMP=y",
+		NULL,
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_KERN_CORE_PATTERN, NULL, TST_SR_TCONF},
+		{}
+	},
+};
diff --git a/testcases/kernel/coredump/coredump01_helper.c b/testcases/kernel/coredump/coredump01_helper.c
new file mode 100644
index 000000000..b454de476
--- /dev/null
+++ b/testcases/kernel/coredump/coredump01_helper.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Linux Test Project
+ */
+
+/*
+ * Core dump collector for the piped core_pattern tested by coredump01.
+ *
+ * Avoiding the LTP API here is correct, since the kernel spawns the helper
+ * through ``call_usermodehelper()`` without the LTP IPC environment.
+ *
+ * The helper is called as:
+ *
+ *	coredump01_helper <exe> <pid> <signal> <result file>
+ *
+ * and stores what it received in the result file, which is published with
+ * :manpage:`rename()` so that the polling test never reads a partial line.
+ */
+
+#include <elf.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+	unsigned char buf[4096], hdr[EI_NIDENT + sizeof(Elf32_Half)];
+	char tmp[PATH_MAX];
+	unsigned int hdr_len = 0;
+	long long bytes = 0;
+	ssize_t rval, i;
+	int fd, elf = 0, et_core = 0;
+	Elf32_Half e_type;
+
+	if (argc < 5)
+		return 1;
+
+	/*
+	 * The ELF header is only meaningful at the very beginning of the
+	 * stream. Collect enough bytes to read e_ident and e_type.
+	 */
+	while ((rval = read(STDIN_FILENO, buf, sizeof(buf))) > 0) {
+		for (i = 0; i < rval && hdr_len < sizeof(hdr); i++)
+			hdr[hdr_len++] = buf[i];
+
+		bytes += rval;
+	}
+
+	if (rval < 0)
+		return 1;
+
+	if (hdr_len >= sizeof(hdr)) {
+		if (!memcmp(hdr, ELFMAG, SELFMAG))
+			elf = 1;
+		memcpy(&e_type, hdr + EI_NIDENT, sizeof(e_type));
+		et_core = (e_type == ET_CORE);
+	}
+
+	snprintf(tmp, sizeof(tmp), "%s.tmp", argv[4]);
+
+	fd = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0)
+		return 1;
+
+	dprintf(fd, "exe=%s pid=%s sig=%s bytes=%lld elf=%d et_core=%d\n",
+		argv[1], argv[2], argv[3], bytes, elf, et_core);
+
+	close(fd);
+
+	return rename(tmp, argv[4]) ? 1 : 0;
+}
diff --git a/testcases/kernel/coredump/coredump_common.h b/testcases/kernel/coredump/coredump_common.h
new file mode 100644
index 000000000..7c04a659c
--- /dev/null
+++ b/testcases/kernel/coredump/coredump_common.h
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Linux Test Project
+ */
+
+#ifndef COREDUMP_COMMON_H
+#define COREDUMP_COMMON_H
+
+#include <elf.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "lapi/prctl.h"
+
+#define PATTERN_MAX 128
+
+static char cwd[PATH_MAX];
+
+static void set_pattern(const char *fmt, ...)
+{
+	char pattern[PATTERN_MAX];
+	char readback[PATTERN_MAX];
+	va_list va;
+	int len;
+
+	va_start(va, fmt);
+	len = vsnprintf(pattern, sizeof(pattern), fmt, va);
+	va_end(va);
+
+	if (len >= PATTERN_MAX)
+		tst_brk(TCONF, "core_pattern does not fit into %i bytes", PATTERN_MAX - 1);
+
+	SAFE_FILE_PRINTF(PATH_KERN_CORE_PATTERN, "%s", pattern);
+	SAFE_FILE_LINES_SCANF(PATH_KERN_CORE_PATTERN, "%127[^\n]", readback);
+
+	if (strcmp(pattern, readback))
+		tst_brk(TBROK, "core_pattern readback mismatch: wrote '%s', read '%s'",
+			pattern, readback);
+
+	tst_res(TINFO, "core_pattern is '%s'", pattern);
+}
+
+static pid_t crash_child(void)
+{
+	int status;
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		abort();
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (!WIFSIGNALED(status) || !WCOREDUMP(status))
+		tst_brk(TFAIL, "Child did not dump core");
+
+	return pid;
+}
+
+static void coredump_setup(void)
+{
+	struct rlimit rl = {RLIM_INFINITY, RLIM_INFINITY};
+
+	SAFE_SETRLIMIT(RLIMIT_CORE, &rl);
+	SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
+	SAFE_GETCWD(cwd, sizeof(cwd));
+}
+
+#endif /* COREDUMP_COMMON_H */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
