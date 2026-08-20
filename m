Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B15C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 18:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 785413CF202
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 20:48:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6D613C2953
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:48:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10027600691
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:48:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 863F485249;
 Thu, 20 Aug 2026 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787251687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AzPgemSCxMH58gfNHK17m2YM51jRSznE3YStoWeGSBQ=;
 b=X3oeyZ9zwxsa4BhJJIZULHKgzT8CryD7FgdRdtI5SO6SneQmmD1dmwIWKM05M04qB2EfXy
 zeQG9lBP2gpSVOPVpII40u7BGWAwM/VgdOHUy5PImTrLJFE6Yx0AxOGE95NKOp7VXfijfb
 8qRLBq+w8DAOVfzH9cQRWY3xswDBnWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787251687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AzPgemSCxMH58gfNHK17m2YM51jRSznE3YStoWeGSBQ=;
 b=Ode6c+QXlIgpL043RMCWXZ4mdPVjDPlH0L/GcL6ofYrGa/6Ul29MgrMpmqIEzn+vuqTyQj
 6SiZYxIt6V/IApDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787251683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AzPgemSCxMH58gfNHK17m2YM51jRSznE3YStoWeGSBQ=;
 b=HXoFf6HwrdnWZyqudpLHpjBR6+8Yx4EnglLv4hgF3ygfx7Ns1OsRW0rf69mDkII/CSZ/rM
 wHMXvYq8tlWBLxrcBbulgAbNfHPgrZYnn5PZkqEO/2TBpCEg4zVGquRQgo0eVJC1OZp/z+
 doqQARjZ9ogT+sOT4u3vO4rrr4jvEGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787251683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AzPgemSCxMH58gfNHK17m2YM51jRSznE3YStoWeGSBQ=;
 b=F6nvuk7+6vpAyWse4H2M0KXKtSXk725PCNuMV1Dlrms/fxpmmx2miLfhbBz4cSY2FQ7pVU
 9h7OIlagoKU0gpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3121C27A8;
 Thu, 20 Aug 2026 18:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lpziBeNLh2pGaQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 18:48:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 20:47:47 +0200
MIME-Version: 1.0
Message-Id: <20260820-coredump-v1-1-7ce51603cefb@suse.com>
X-B4-Tracking: v=1; b=H4sIANJLh2oC/yXM0QpAMBTG8VfRubaao1heRS7YzjgKa0NqeXfD5
 a/+3xchkGcK0GQRPJ0ceFsTijwDPfXrSIJNMqDESiqUQm+ezLE4gWh1XRaDIakg5c6T5eu7arv
 f4Rhm0vu7h/t+AF+djQRsAAAA
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787251683; l=9020;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=817rpfO6sX85r82fonYuKSXspuPiYrexQOx3vb5PW3I=;
 b=JpfINRTXXmPOKA/9+4Ouziu269WMTwLsQFozKBVoIdMgBmK2Voqb2BPiymnvY2cTgRq0/j6Dn
 fba2GBcYF7vAL3J7SuJXGD9TSO6uikaP/hjDJNGX9TfG+46RGy8CCx3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] coredump01: New core_pattern specifiers test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Add a simple coredump01 test that simulate a coredump and verify that it
actually works. This is a small coverage that is missing inside LTP
testing suite.
---
 runtest/kernel_misc                           |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   2 +
 testcases/kernel/coredump/Makefile            |   7 ++
 testcases/kernel/coredump/coredump01.c        | 161 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  66 +++++++++++
 6 files changed, 238 insertions(+)

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
index 000000000..a6003ba10
--- /dev/null
+++ b/testcases/kernel/coredump/coredump01.c
@@ -0,0 +1,161 @@
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
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "lapi/prctl.h"
+
+#define PATTERN_MAX 128
+#define HELPER "coredump01_helper"
+#define HELPER_TIMEOUT 10
+
+static char helper_dir[PATH_MAX];
+static char cwd[PATH_MAX];
+
+static void set_pattern(const char *fmt, ...)
+{
+	char pattern[PATTERN_MAX];
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
+}
+
+static void verify_pipe_pattern(void)
+{
+	char res[PATH_MAX + 32], exe[PATH_MAX];
+	int pid_seen, sig_seen, elf;
+	long long bytes;
+	pid_t pid;
+
+	tst_res(TINFO, "Testing pipe core_pattern");
+
+	set_pattern("|%s/%s %%e %%p %%s %s/res.%%p", helper_dir, HELPER, cwd);
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
+	SAFE_FILE_SCANF(res, "exe=%15s pid=%d sig=%d bytes=%lld elf=%d",
+			exe, &pid_seen, &sig_seen, &bytes, &elf);
+
+	TST_EXP_EQ_STR(exe, "coredump01");
+	TST_EXP_EQ_LI(pid_seen, pid);
+	TST_EXP_EQ_LI(sig_seen, SIGABRT);
+	TST_EXP_EXPR(elf && bytes > 0, "%s read %lli bytes of ELF core dump", HELPER, bytes);
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
+	struct rlimit rl = {RLIM_INFINITY, RLIM_INFINITY};
+	ssize_t len;
+
+	SAFE_SETRLIMIT(RLIMIT_CORE, &rl);
+
+	SAFE_PRCTL(PR_GET_DUMPABLE, 1, 0, 0, 0);
+
+	SAFE_GETCWD(cwd, sizeof(cwd));
+
+	len = SAFE_READLINK("/proc/self/exe", helper_dir, sizeof(helper_dir) - 1);
+	helper_dir[len] = '\0';
+	*strrchr(helper_dir, '/') = '\0';
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_KERN_CORE_PATTERN, NULL, TST_SR_TCONF},
+		{}
+	},
+};
diff --git a/testcases/kernel/coredump/coredump01_helper.c b/testcases/kernel/coredump/coredump01_helper.c
new file mode 100644
index 000000000..a993e2ef7
--- /dev/null
+++ b/testcases/kernel/coredump/coredump01_helper.c
@@ -0,0 +1,66 @@
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
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+	char buf[4096], tmp[PATH_MAX], magic[4];
+	long long bytes = 0;
+	ssize_t rval, i;
+	int fd, elf;
+
+	if (argc < 5)
+		return 1;
+
+	/*
+	 * A core dump embeds the ELF images it has mapped, so the magic is
+	 * only meaningful at the very beginning of the stream. Collect it
+	 * across reads, since a pipe read can return less than 4 bytes.
+	 */
+	while ((rval = read(STDIN_FILENO, buf, sizeof(buf))) > 0) {
+		for (i = 0; i < rval && bytes + i < 4; i++)
+			magic[bytes + i] = buf[i];
+
+		bytes += rval;
+	}
+
+	if (rval < 0)
+		return 1;
+
+	if (bytes >= 4 && !memcmp(magic, "\177ELF", 4))
+		elf = 1;
+
+	snprintf(tmp, sizeof(tmp), "%s.tmp", argv[4]);
+
+	fd = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0)
+		return 1;
+
+	dprintf(fd, "exe=%s pid=%s sig=%s bytes=%lld elf=%d\n",
+		argv[1], argv[2], argv[3], bytes, elf);
+
+	close(fd);
+
+	return rename(tmp, argv[4]) ? 1 : 0;
+}

---
base-commit: e62b1a4731f9c458d65c2659d2f8bb58b93e6d6d
change-id: 20260820-coredump-22fc731bde08

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
