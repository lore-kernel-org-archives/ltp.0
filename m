Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473FAC3DA59
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 15:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 961063D1AC2
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 17:34:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3C8D3D19B3
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 17:33:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79AE42079FA
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 17:33:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01AA91F8C5
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721144013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfDWjjIA/ooyt7QZK8sE/Tc7TIVW1dM5e7V38Mwju4Y=;
 b=W7R/IF6UCf7QzHIyg1P9cy7Uy2k1h+cbrRHg/UqjhELsF8IMf4bTe2Q6Rkx09UKoi/18NJ
 OyvPsNcIONdz6gaNIi/6w7XoEJhp3dLCm31qohfK5BIyfepnxXwLS4V7Dn1mVU3jT9o++e
 OBAevtnI/nnf3E2IHDGOFGd3FLPphew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721144013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfDWjjIA/ooyt7QZK8sE/Tc7TIVW1dM5e7V38Mwju4Y=;
 b=RbEQd8BSuwPeb5hPWricWAB4hia0ravdMnCJ9hHhbWGYdQoB42dDrn4Xm1c5SIc1A04g6W
 s2yQUdbPMYWQMTAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721144012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfDWjjIA/ooyt7QZK8sE/Tc7TIVW1dM5e7V38Mwju4Y=;
 b=giyqk/X1awTXK0r4F178xJLfkMxqP6VEmPKd4UKCfiF96HLGLu0ZJ5j+V7j5pQJJE1/Xhz
 hO09VA/fjkZtU5ItaAa2k6NueLa3qJkl6qfd5F9+kx9+89bpIvUIPF65iOwIewmQIFSkLi
 qfVWin358wAjFRvsSbDnRLDBU2Sjjcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721144012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfDWjjIA/ooyt7QZK8sE/Tc7TIVW1dM5e7V38Mwju4Y=;
 b=E18WOql0xUq77vE1YshJOHx7Xmw5nbZmdHMxLQI4fY5dAEKXLaiundCQlOF+VUvdgiD+NZ
 TQyLQDwHclFwJwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9C541398E
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 15:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a6wnNMuSlmaqFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 15:33:31 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 16 Jul 2024 17:36:04 +0200
Message-ID: <20240716153604.22984-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240716153604.22984-1-chrubis@suse.cz>
References: <20240716153604.22984-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,ltp_shell_test.sh:url,shell_loader_all_filesystems.sh:url,suse.cz:email,shell_loader.sh:url,tst_env.sh:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/2] testcaes/lib: Add shell loader
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

This commit implements a shell loader so that we don't have to write a C
loader for each LTP shell test. The idea is simple, the loader parses
the shell test and prepares the tst_test structure accordingly, then
runs the actual shell test. Only small subset of the flags is
implemented at the moment, since this is RFC, however it should be clear
where this is going.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  3 +-
 testcases/lib/run_tests.sh                    |  2 +
 testcases/lib/tests/shell_loader.sh           | 11 ++-
 .../lib/tests/shell_loader_all_filesystems.sh | 22 ++++++
 testcases/lib/tst_run_shell.c                 | 78 +++++++++++++++++++
 6 files changed, 114 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 testcases/lib/tests/shell_loader.sh
 create mode 100755 testcases/lib/tests/shell_loader_all_filesystems.sh
 create mode 100644 testcases/lib/tst_run_shell.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index d0dacf62a..385f3c3ca 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -24,3 +24,4 @@
 /tst_supported_fs
 /tst_timeout_kill
 /tst_res_
+/tst_run_shell
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 928d76d62..fef284e35 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -13,6 +13,7 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
 			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
-			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_
+			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
+			   tst_run_shell
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 88607b146..9637ae327 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -8,3 +8,5 @@ export PATH=$PATH:$PWD:$PWD/tests/
 ./tests/shell_test04
 ./tests/shell_test05
 ./tests/shell_test06
+./tst_run_shell shell_loader.sh
+./tst_run_shell shell_loader_all_filesystems.sh
diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
old mode 100644
new mode 100755
index c3b3cf5fd..1a255fdee
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -1,5 +1,12 @@
-#!/usr/bin/env tst_run_shell
+#!/bin/sh
+#
+# needs_tmpdir=1
 
 . tst_env.sh
 
-tst_res TPASS "Shell loader works fine!"
+case "$PWD" in
+	/tmp/*)
+	tst_res TPASS "We are running in temp directory in $PWD";;
+	*)
+	tst_res TFAIL "We are not running in temp directory but $PWD";;
+esac
diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
new file mode 100755
index 000000000..86d09d393
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# needs_root=1
+# mount_device=1
+# all_filesystems=1
+
+TST_MNTPOINT=ltp_mntpoint
+
+. tst_env.sh
+
+tst_res TINFO "IN shell"
+
+mounted=$(grep $TST_MNTPOINT /proc/mounts)
+
+if [ -n "$mounted" ]; then
+	device=$(echo $mounted |cut -d' ' -f 1)
+	path=$(echo $mounted |cut -d' ' -f 2)
+
+	tst_res TPASS "$device mounted at $path"
+else
+	tst_res TFAIL "Device not mounted!"
+fi
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
new file mode 100644
index 000000000..583807376
--- /dev/null
+++ b/testcases/lib/tst_run_shell.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+static char *shell_filename;
+
+static void run_shell(void)
+{
+	tst_run_shell(shell_filename, NULL);
+}
+
+struct tst_test test = {
+	.test_all = run_shell,
+	.runs_shell = 1,
+};
+
+static void print_help(void)
+{
+	printf("Usage: tst_shell_loader ltp_shell_test.sh ...");
+}
+
+#define FLAG_MATCH(str, name) (!strcmp(str, name "=1"))
+#define PARAM_MATCH(str, name) (!strncmp(str, name "=", sizeof(name)))
+#define PARAM_VAL(str, name) strdup(str + sizeof(name))
+
+static void prepare_test_struct(void)
+{
+	FILE *f;
+	char line[4096];
+	char path[4096];
+
+	if (tst_get_path(shell_filename, path, sizeof(path)) == -1)
+		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
+
+	f = SAFE_FOPEN(path, "r");
+
+	while (fscanf(f, "%4096s[^\n]", line) != EOF) {
+		if (FLAG_MATCH(line, "needs_tmpdir"))
+			test.needs_tmpdir = 1;
+		else if (FLAG_MATCH(line, "needs_root"))
+			test.needs_root = 1;
+		else if (FLAG_MATCH(line, "needs_device"))
+			test.needs_device = 1;
+		else if (FLAG_MATCH(line, "needs_checkpoints"))
+			test.needs_checkpoints = 1;
+		else if (FLAG_MATCH(line, "needs_overlay"))
+			test.needs_overlay = 1;
+		else if (FLAG_MATCH(line, "format_device"))
+			test.format_device = 1;
+		else if (FLAG_MATCH(line, "mount_device"))
+			test.mount_device = 1;
+		else if (PARAM_MATCH(line, "TST_MNTPOINT"))
+			test.mntpoint = PARAM_VAL(line, "TST_MNTPOINT");
+		else if (FLAG_MATCH(line, "all_filesystems"))
+			test.all_filesystems = 1;
+	}
+
+	fclose(f);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2)
+		goto help;
+
+	shell_filename = argv[1];
+
+	prepare_test_struct();
+
+	tst_run_tcases(argc - 1, argv + 1, &test);
+help:
+	print_help();
+	return 1;
+}
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
