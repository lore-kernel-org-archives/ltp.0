Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA21C79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FC0A3E72E7
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:05:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E0F3E72F0
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:05:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65A96200DAC
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:04:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 667FE1FB1F;
 Wed,  9 Sep 2026 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788948294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLXwsdDkE9vR17zO8bWKFWa1EwDb8EL3/wAWuZQ1OvU=;
 b=1dbwv/kXMfzju6S8Dcf33e8enF//g6bf+WfFF+3Q3kRmj/SEfEKfdUUDogPSsNRWorisEP
 54i5O71xRHVfGT759Zm/pOc8UpvG4DyiKPdE7w/Azk0H/ZTmCdEyhWHUpxrTwqjFC6Pga9
 DymmeYhilPReYYhg0pEcrgu7zy6P7iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788948294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLXwsdDkE9vR17zO8bWKFWa1EwDb8EL3/wAWuZQ1OvU=;
 b=OfON3yslE7dWzwRmhfAf1tz1bbG396iIKgTTeMS+BuGO1XdRJkf2sbeiyEEYyCWke6ZL8O
 oFUCnz8SvUZFBxCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PlU8zF4t;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UtdNQFcm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788948290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLXwsdDkE9vR17zO8bWKFWa1EwDb8EL3/wAWuZQ1OvU=;
 b=PlU8zF4t7IUmUDjDKBRTHlABswMqdplqnhSxpf/+G0mhdDWTitEG0LEoaGscwCPH2ZKJLa
 PEXtUx8HsP5dX8UUYjjOoI1buTcBEJhJPdaEDrwSp1ZM+DeiGgPO55Xp14OClz40dq+L+m
 FHqdaQpagNFsJ4MMJD6fzhVXy5BaZOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788948290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLXwsdDkE9vR17zO8bWKFWa1EwDb8EL3/wAWuZQ1OvU=;
 b=UtdNQFcm8JlWYlDWCezdE6rM3Lj+3Nxh2xG5wRKeAIKTmMTHvbJEonsg8NETy/dBrcWKDP
 o2GwcIoZJAuRu1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04C131365E;
 Wed,  9 Sep 2026 10:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mKfuOkEvoWpSFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Sep 2026 10:04:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Sep 2026 12:04:49 +0200
MIME-Version: 1.0
Message-Id: <20260909-coredump-v9-2-6b0ee752f57e@suse.com>
References: <20260909-coredump-v9-0-6b0ee752f57e@suse.com>
In-Reply-To: <20260909-coredump-v9-0-6b0ee752f57e@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788948289; l=10636;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bk3/cJYg6j1qDTWONuWNuIGkoSGfdeOidiODR6b2zSY=;
 b=uhL3MwCGuJct7JEyAGzTaKqwqLa/Kg4wCx8scBw9n+esH0Usf4TZ1YjbQtlRrLghgtEWyz2yC
 tl1K5UU6nz/BarnBUh8ZSz/92hsr7k1XK+bTVqW/PtHeM228ATMYug9
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 667FE1FB1F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,zram02.sh:url,linux.dev:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/3] coredump01: New core_pattern specifiers test
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                           |   1 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   2 +
 testcases/kernel/coredump/Makefile            |   7 ++
 testcases/kernel/coredump/coredump01.c        | 162 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++++++
 testcases/kernel/coredump/coredump_common.h   |  52 +++++++++
 7 files changed, 298 insertions(+)

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
index 000000000..c4fb92e4d
--- /dev/null
+++ b/testcases/kernel/coredump/coredump01.c
@@ -0,0 +1,162 @@
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
+static struct tcase {
+	void (*verify_fn)(void);
+	const char *desc;
+} tcases[] = {
+	{verify_file_pattern, "file core_pattern"},
+	{verify_pipe_pattern, "pipe core_pattern"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "Testing %s", tc->desc);
+	tc->verify_fn();
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
+	.tcnt = ARRAY_SIZE(tcases),
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
index 000000000..bccb4bcaa
--- /dev/null
+++ b/testcases/kernel/coredump/coredump_common.h
@@ -0,0 +1,52 @@
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
+static char cwd[PATH_MAX];
+
+static void set_pattern(const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	SAFE_FILE_VPRINTF(PATH_KERN_CORE_PATTERN, fmt, va);
+	va_end(va);
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
