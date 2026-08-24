Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5AAC5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 08:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1130A3D0713
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:58:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECEAF3CFAFA
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:58:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D80660074F
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:58:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 953471F45E;
 Mon, 24 Aug 2026 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787561899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AYr6MSh5VXR+VD+riqfxXjBSwU++lzCnrTKAUUn7cx4=;
 b=FN2THhNXxKNc7e7atz8/wY+Cb6McspLk+8uPRHjRerCr3D5tcpsBhbXy4RqWJLFSm+zOpV
 j8nR9siCXh8R9q6Lbuw7LDwGhUxjWfWY4LbfeE3RpALnB5SCeGd6rIL6KEejQuaer5unGT
 6tOhS6iAhU8CcGWn21+15OWbSDddxO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787561899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AYr6MSh5VXR+VD+riqfxXjBSwU++lzCnrTKAUUn7cx4=;
 b=Ler+x2hB8o3supEBcrosllihibl269VcXJZNvuNcOUprXO9F/5v/Jx0P9XS18bO3sIPILu
 0ncYzby/2Tg8LLCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H26HSkzE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bxsN6UOD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787561895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AYr6MSh5VXR+VD+riqfxXjBSwU++lzCnrTKAUUn7cx4=;
 b=H26HSkzE7BQFrU8BZRbZTICjYr3TeZCVC2qPiShKPNxFbcFyCEXaI7ZpMMPJJb/yKvRYJJ
 QloasxgnVQ1q7zzzpJjRVj6wz0L9BqwyfSlOq9bprR7HCLTnZyKseESeVox1glo9XBjmzO
 teYtt71Vd7uICz2fnHDi4uV5KgsduMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787561895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AYr6MSh5VXR+VD+riqfxXjBSwU++lzCnrTKAUUn7cx4=;
 b=bxsN6UODJ20oCPSLBxIK+hppQOT7zR2GMSzMnS2SwxbXN1rioiYhABPDhKZQqHdRHOcRM5
 /+EaIUOFPt5vUMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79EC213332;
 Mon, 24 Aug 2026 08:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dLAVHKcHjGrbSQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 24 Aug 2026 08:58:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 24 Aug 2026 10:58:15 +0200
MIME-Version: 1.0
Message-Id: <20260824-coredump-v3-1-6429da674718@suse.com>
X-B4-Tracking: v=1; b=H4sIAKYHjGoC/22Nyw6CMBBFf4V0bU07POPK/zAuYJhKTbCkA42G8
 O+2uGHh8iT3nLsKJm+JxSVbhadg2bpXhPyUCRza14Ok7SMLUFCpBpRE56lfxkkCGKxz3fWkGhH
 nkydj33vqdv8xL92TcE5+WgyWZ+c/+1fQafcnG7TUskYqdaVyJNNdeWE6oxtFqgY4esXBg+gVU
 EDToilBVwdv27YvPej6xekAAAA=
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787561895; l=11210;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=9MXtIg5k+3pjjWeExdIKkSbGwPKQU1q6ktVbPQdYWSc=;
 b=BfjuNkBobw8VMbEVE9BSXUhi7zvTltHRPpJR4J1Udpur6qGeQxg8wJxyyZ+EdCs3e48knnyGF
 gsPV/x5IeKeBLHd6stokZBiC18vOgvOsqRaTKsp0qpdcBtVF41J+JYn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 953471F45E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,zram02.sh:url];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] coredump01: New core_pattern specifiers test
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
Changes in v3:
- check for CONFIG_COREDUMP=y
- Link to v2: https://lore.kernel.org/20260824-coredump-v2-1-42428acf5216@suse.com

Changes in v2:
- fix CI agent spotted errors
- Link to v1: https://lore.kernel.org/20260820-coredump-v1-1-7ce51603cefb@suse.com
---
 runtest/kernel_misc                           |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   2 +
 testcases/kernel/coredump/Makefile            |   7 +
 testcases/kernel/coredump/coredump01.c        | 225 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  66 ++++++++
 6 files changed, 302 insertions(+)

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
index 000000000..96a7252da
--- /dev/null
+++ b/testcases/kernel/coredump/coredump01.c
@@ -0,0 +1,225 @@
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
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "tst_test.h"
+#include "tst_kconfig.h"
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
+/* PID 2 is kthreadd only if we can see the initial PID namespace */
+static int have_init_pid_ns(void)
+{
+	char comm[16] = {0};
+	int fd, len;
+
+	fd = open("/proc/2/comm", O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = SAFE_READ(0, fd, comm, sizeof(comm) - 1);
+	SAFE_CLOSE(fd);
+
+	return len > 0 && !strncmp(comm, "kthreadd\n", 9);
+}
+
+/*
+ * The kernel resolves @path the way /proc/2/root (kthreadd lives in the
+ * initial namespaces) resolves it.
+ */
+static int same_in_init_mnt_ns(const char *path)
+{
+	char init_path[PATH_MAX + 32];
+	struct stat our_st, init_st;
+
+	SAFE_STAT(path, &our_st);
+
+	snprintf(init_path, sizeof(init_path), "/proc/2/root%s", path);
+
+	if (stat(init_path, &init_st))
+		return 0;
+
+	return init_st.st_dev == our_st.st_dev && init_st.st_ino == our_st.st_ino;
+}
+
+static void verify_pipe_pattern(void)
+{
+	char res[PATH_MAX + 32], exe[PATH_MAX], helper[PATH_MAX + 32];
+	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_STATIC_USERMODEHELPER");
+	int pid_seen, sig_seen, elf;
+	long long bytes;
+	pid_t pid;
+
+	tst_kconfig_read(&kconfig, 1);
+	if (kconfig.choice == 'y') {
+		tst_res(TCONF, "CONFIG_STATIC_USERMODEHELPER is enabled, skipping pipe core_pattern");
+		return;
+	}
+
+	snprintf(helper, sizeof(helper), "%s/%s", helper_dir, HELPER);
+
+	/*
+	 * The kernel always execs the pipe helper in the initial mount
+	 * namespace (core(5)), no matter where the crashing process lives.
+	 * Skip unless both the helper and the result directory are the very
+	 * same objects there, otherwise the kernel would not find them and
+	 * the test would fail spuriously, e.g. inside a container.
+	 */
+	if (!have_init_pid_ns() || !same_in_init_mnt_ns(helper) ||
+	    !same_in_init_mnt_ns(cwd)) {
+		tst_res(TCONF, "Pipe helper or result dir not visible in the initial mount namespace");
+		return;
+	}
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
+	SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
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
index 000000000..41091b428
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
+	int fd, elf = 0;
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
