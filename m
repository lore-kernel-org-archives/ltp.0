Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F907C433FE
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:48:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F80610A1
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F80610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 406E83C8618
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:48:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B6E83C176E
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:48:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 206F6601158
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:48:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52E281FD2F;
 Wed, 22 Sep 2021 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632304087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rsJPwfr/Fc4sm4cien9Zz/kJMFTCp5RO28Vorh2v6KU=;
 b=ER4VPjS2ncuRbf+WvWwRDLhdCzz8rhe06ZWweQZxigwHHfXyHPP29NrS1GGsyV+qOJ7SOA
 04XssW/mj8bnuOE7LYFtMRBdSsZZmEm3n6ungHk5oLVgi3Dj0EO51Yg4uc1PtUdzo8SWlC
 75T7mDrlu4fdH6urWrR36ukDSdekSS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632304087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rsJPwfr/Fc4sm4cien9Zz/kJMFTCp5RO28Vorh2v6KU=;
 b=whBBcCmqVUEwy8FM5qru4x1kCK+AY0hnDBD//ffZFooACLzHeMDM2bsibKJAXo8phhvwTO
 6QIy9tYkFtbvOpDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38CC213D6E;
 Wed, 22 Sep 2021 09:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3J+1DNf7SmHYPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Sep 2021 09:48:07 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Sep 2021 11:48:38 +0200
Message-Id: <20210922094838.21366-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] lib: shell: Fix timeout process races
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

There were actually several races in the shell library timeout handling.

This commit fixes hopefully all of them by:

* Reimplementing the backgroud timer in C

* Making sure that the timer has started before we leave test setup

The rewrite of the backround timer to C allows us to run all the timeout
logic in a single process, which simplifies the whole problem greatly
since previously we had chain of processes that estabilished signal
handlers to kill it's descendants, which in the end had a few races in
it.

The race that caused the problems is, as far as I can tell, in the way
how shell spawns it's children. I haven't checked the shell code, but I
guess that when shell runs a process in bacground it does vfork() +
exec(). My guess that signals are disabled between vfork() and exec()
and if the SIGTERM arrives at that point it gets lost.

That means that we created a race window in the shell library each time
we started a new process. The rewrite to C simplifies the code but we
still end up with a single place where this can happen and that is when
we execute the tst_timeout_kill binary. This is now fixed in the shell
library by waiting until the background process gets to a sleep state.

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/.gitignore         |  1 +
 testcases/lib/Makefile           |  2 +-
 testcases/lib/tst_test.sh        | 47 ++++++-------------
 testcases/lib/tst_timeout_kill.c | 79 ++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 35 deletions(-)
 create mode 100644 testcases/lib/tst_timeout_kill.c

v3:
	add setpgid(0, 0) to the tst_timeout_kill so that it does not
	kill itself when sending signal to the whole process group


diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 5a0e8cba2..9625d9043 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -14,3 +14,4 @@
 /tst_sleep
 /tst_supported_fs
 /tst_hexdump
+/tst_timeout_kill
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 179b47479..d6b4c7a91 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
-			   tst_get_median tst_hexdump tst_get_free_pids
+			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8f69b0551..2556b28f5 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -474,27 +474,6 @@ _tst_multiply_timeout()
 	return 0
 }
 
-_tst_kill_test()
-{
-	local i=10
-
-	trap '' TERM
-	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
-	kill -TERM -$pid
-	tst_sleep 100ms
-
-	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
-		tst_res TINFO "Test is still running, waiting ${i}s"
-		sleep 1
-		i=$((i-1))
-	done
-
-	if kill -0 $pid >/dev/null 2>&1; then
-		tst_res TBROK "Test still running, sending SIGKILL"
-		kill -KILL -$pid
-	fi
-}
-
 _tst_cleanup_timer()
 {
 	if [ -n "$_tst_setup_timer_pid" ]; then
@@ -503,18 +482,6 @@ _tst_cleanup_timer()
 	fi
 }
 
-_tst_timeout_process()
-{
-	local sleep_pid
-
-	sleep $sec &
-	sleep_pid=$!
-	trap "kill $sleep_pid; exit" TERM
-	wait $sleep_pid
-	trap - TERM
-	_tst_kill_test
-}
-
 _tst_setup_timer()
 {
 	TST_TIMEOUT=${TST_TIMEOUT:-300}
@@ -539,9 +506,21 @@ _tst_setup_timer()
 
 	_tst_cleanup_timer
 
-	_tst_timeout_process &
+	tst_timeout_kill $sec $pid &
 
 	_tst_setup_timer_pid=$!
+
+	while true; do
+		local state
+
+		state=$(cut -d' ' -f3 "/proc/$_tst_setup_timer_pid/stat")
+
+		if [ "$state" = "S" ]; then
+			break;
+		fi
+
+		tst_sleep 1ms
+	done
 }
 
 tst_require_root()
diff --git a/testcases/lib/tst_timeout_kill.c b/testcases/lib/tst_timeout_kill.c
new file mode 100644
index 000000000..3e57944bb
--- /dev/null
+++ b/testcases/lib/tst_timeout_kill.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+
+static void print_help(const char *name)
+{
+	fprintf(stderr, "usage: %s timeout pid\n", name);
+}
+
+#define print_msg(fmt, ...) fprintf(stderr, fmt "\n", ##__VA_ARGS__)
+
+int main(int argc, char *argv[])
+{
+	int timeout, pid, ret, i;
+
+	if (argc != 3) {
+		print_help(argv[0]);
+		return 1;
+	}
+
+	timeout = atoi(argv[1]);
+	pid = atoi(argv[2]);
+
+	if (timeout < 0) {
+		fprintf(stderr, "Invalid timeout '%s'\n", argv[1]);
+		print_help(argv[0]);
+		return 1;
+	}
+
+	if (pid <= 1) {
+		fprintf(stderr, "Invalid pid '%s'\n", argv[2]);
+		print_help(argv[0]);
+		return 1;
+	}
+
+	ret = setpgid(0, 0);
+	if (ret)
+		print_msg("setpgid() failed: %s", strerror(errno));
+
+	if (timeout)
+		sleep(timeout);
+
+	print_msg("Test timed out, sending SIGTERM!");
+	print_msg("If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1");
+
+	ret = kill(-pid, SIGTERM);
+	if (ret) {
+		print_msg("kill(%i) failed: %s", -pid, strerror(errno));
+		return 1;
+	}
+
+	usleep(100000);
+
+	i = 10;
+
+	while (!kill(-pid, 0) && i-- > 0) {
+		print_msg("Test is still running...");
+		sleep(1);
+	}
+
+	if (!kill(-pid, 0)) {
+		print_msg("Test is still running, sending SIGKILL");
+		ret = kill(-pid, SIGKILL);
+		if (ret) {
+			print_msg("kill(%i) failed: %s", -pid, strerror(errno));
+			return 1;
+		}
+	}
+
+	return 0;
+}
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
