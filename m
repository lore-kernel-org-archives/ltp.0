Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAAAC5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:13:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E9B93CF67C
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:13:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71FB43CE39B
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:13:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6357314004EB
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:13:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7511A80870;
 Mon, 10 Aug 2026 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786360403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uszaWjf7Ol1ahevzBvWMfxkexXO7v7+uQAGFOJiY1lg=;
 b=BlIHkxwkJMsjnVyozWjx7hfRwwldKWG+BfbhMKdeeI1BSHjMhP5PL5aBVnayP+9YjPlpiC
 SPYNclANA0IzYT1tTyx8p8G6eJdfG9X3OTV5fQz/eq2Tf5UADocuIP0zKSpnRhSNT2lAsY
 uScsAG1Z76v2P+R30PhTnL8w4jwMNHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786360403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uszaWjf7Ol1ahevzBvWMfxkexXO7v7+uQAGFOJiY1lg=;
 b=CgN1+q/44IFsqreXEsaiL/Y9vhIhF2IISO0eHQWxsPcG/Q2Afgo87luBDt+Shg9tVoyAFD
 6G9xwVAtADGkN9Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y+lVTUi/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FidQ9qNa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786360399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uszaWjf7Ol1ahevzBvWMfxkexXO7v7+uQAGFOJiY1lg=;
 b=y+lVTUi/mT/23TvEpzAzh/JPbDxc5VXZFzwE+KEqpOwGrGb/iNECXYzk1376vUKGZ2e82D
 d4hmTDNx4uaTyg8NCj/7oyntq/nbbFxPvYQfMBJgGEJu6bLvwbZFOx822KaUMGBK5SFsHm
 T2OAgRELJp7ch42FKqBJ7C3LMjCb+JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786360399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uszaWjf7Ol1ahevzBvWMfxkexXO7v7+uQAGFOJiY1lg=;
 b=FidQ9qNaLVxLWhX2LyvaeWWt5cXszCucVaqnb/sukzF/6VVn+KXNH8mzxH8aTVwjFREyJd
 yNwM+pqi9D0BocDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37B4E779B6;
 Mon, 10 Aug 2026 11:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xoyRCk+yeWpsEQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Aug 2026 11:13:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Aug 2026 13:13:14 +0200
MIME-Version: 1.0
Message-Id: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
X-B4-Tracking: v=1; b=H4sIAEmyeWoC/4XN0QqCMBTG8VeJXbfYzqaurnqPCJl6zIE62WwU4
 rs3vUkC6fJ/4PudiXh0Bj25HCbiMBhvbB9DHg+kbHT/QGqq2AQYpCzjgvoG2za3tssHZ0csxzi
 gKQDXhYIEgJE4HRzW5rWyt3vsxvjRuvf6JfDl+gcMnDJaZAJQpTJTZ3n1T4+n0nZk8QJsDMF2D
 FgM5BVCobUS1Y8hvoZicscQlNMaJRQ8qZiQ5caY5/kD6I7B0D8BAAA=
X-Change-ID: 20260713-shell_oom_protection-6221ab825220
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786360399; l=5753;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=oX120LvkpMCghM6IBUnV+WK9aKdb/ByFb2hMG5746vQ=;
 b=JMpr+jWBNhPMlQHtemsTACA7JfCuLMkWBAgCBfO1eUkwZJMCvAPqZLTynxcUYuWMan8clQmk8
 /76kZVodjyzBrNqRWvVMggkr1nuMtFVui7YJRCHToqXFjFYL363bUrO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7511A80870
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] shell: enable OOM protection by default
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

The shell harness shields itself from the OOM killer and runs the
test in a child process, so it survives memory pressure and can
still report results (e.g. during memcg stress tests).

Suggested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Under Li's idea, implement a OOM protection mechanism for the shell
tests so we can avoid OOM for memcg stress tests.
---
Changes in v4:
- fix with Petr suggestions
- fix with AI agent suggestions
- Link to v3: https://lore.kernel.org/20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com

Changes in v3:
- simplify oom code
- enable OOM protection by default
- Link to v2: https://lore.kernel.org/20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com

Changes in v2:
- update shell OOM protection functional test
- Link to v1: https://lore.kernel.org/20260713-shell_oom_protection-v1-0-b732e8647894@suse.com

To: Linux Test Project <ltp@lists.linux.it>
---
 lib/newlib_tests/runtest.sh                  |  1 +
 lib/newlib_tests/shell/tst_oom_protection.sh | 34 +++++++++++
 testcases/lib/tst_test.sh                    | 84 ++++++++++++++++++++++++++--
 3 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b..7e2d0a2ac 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -44,6 +44,7 @@ shell/tst_check_driver.sh
 shell/tst_check_kconfig0[1-5].sh
 shell/tst_mount_device.sh
 shell/tst_mount_device_tmpfs.sh
+shell/tst_oom_protection.sh
 shell/tst_skip_filesystems.sh
 shell/net/*.sh}"
 
diff --git a/lib/newlib_tests/shell/tst_oom_protection.sh b/lib/newlib_tests/shell/tst_oom_protection.sh
new file mode 100755
index 000000000..564680700
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_oom_protection.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+
+TST_TESTFUNC=do_test
+
+read_oom_score_adj() {
+	cat "/proc/$1/oom_score_adj"
+}
+
+do_test() {
+	local harness_score body_score
+
+	# $$ points to the protected harness, while /proc/self is the
+	# unprotected child that actually runs the test body.
+	harness_score=$(read_oom_score_adj "$$")
+	body_score=$(read_oom_score_adj self)
+
+	if [ "$harness_score" != -1000 ]; then
+		tst_res TCONF "shell harness OOM protection unavailable"
+		return
+	fi
+
+	tst_res TPASS "shell harness is protected from OOM by default"
+
+	if [ "$body_score" = 0 ]; then
+		tst_res TPASS "test body runs in an unprotected child (oom_score_adj=0)"
+	else
+		tst_res TFAIL "test body oom_score_adj is $body_score, expected 0"
+	fi
+}
+
+. tst_test.sh
+tst_run
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b3e7e29bb..e42e562f5 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,6 +28,48 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
 trap "tst_brk TBROK 'test interrupted'" INT
 trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
+_tst_set_oom_score_adj()
+{
+	local value="$1"
+	local path="/proc/self/oom_score_adj"
+
+	if [ ! -e "$path" ]; then
+		tst_res TINFO "oom_score_adj does not exist, skipping the adjustment"
+		return
+	fi
+
+	if ! echo "$value" > "$path"; then
+		tst_res TWARN "Can't adjust score"
+	fi
+}
+
+_tst_enable_oom_protection()
+{
+	_tst_set_oom_score_adj -1000
+}
+
+_tst_disable_oom_protection()
+{
+	_tst_set_oom_score_adj 0
+}
+
+_tst_write_results()
+{
+	[ "$TST_CHILD" = 1 ] || return 0
+	[ -n "$TST_RESULTS_FILE" ] || return 0
+
+	echo "$TST_PASS $TST_FAIL $TST_BROK $TST_WARN $TST_CONF $TST_COUNT" \
+		> "$TST_RESULTS_FILE"
+}
+
+_tst_read_results()
+{
+	[ -s "$TST_RESULTS_FILE" ] || return 0
+
+	read TST_PASS TST_FAIL TST_BROK TST_WARN TST_CONF TST_COUNT \
+		< "$TST_RESULTS_FILE"
+}
+
 _tst_do_cleanup()
 {
 	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
@@ -48,6 +90,15 @@ _tst_do_exit()
 
 	_tst_do_cleanup
 
+	# When running as the unprotected test child, only propagate the
+	# results back to the protected harness which does the teardown and
+	# prints the summary.
+	if [ "$TST_CHILD" = 1 ]; then
+		_tst_cleanup_timer
+		_tst_write_results
+		exit 0
+	fi
+
 	cd "$LTPROOT"
 	[ "$TST_MOUNT_FLAG" = 1 ] && tst_umount
 
@@ -788,10 +839,34 @@ tst_run()
 
 	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
 
-	if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
-		_tst_run_tcases_per_fs
-	else
-		_tst_run_iterations
+	# Protect the harness so it survives memory pressure and can
+	# still report results, then run the test body in a child that
+	# resets OOM protection. This way workloads forked by the test
+	# remain killable, mirroring the C test harness.
+	_tst_enable_oom_protection
+
+	TST_RESULTS_FILE=$(mktemp "${TMPDIR:-/tmp}/ltp_${TST_ID}_res.XXXXXX")
+
+	(
+		TST_CHILD=1
+		_tst_disable_oom_protection
+		trap '_tst_cleanup_timer; _tst_write_results' EXIT
+
+		if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
+			_tst_run_tcases_per_fs
+		else
+			_tst_run_iterations
+		fi
+	) &
+
+	wait $!
+	ret=$?
+
+	_tst_read_results
+	rm -f "$TST_RESULTS_FILE"
+
+	if [ $ret -gt 128 ]; then
+		tst_res TBROK "Test killed by signal $((ret - 128))!"
 	fi
 
 	_tst_do_exit
@@ -865,6 +940,7 @@ _tst_run_test()
 	$_tst_fnc "$@"
 	_tst_rescmp "$_tst_res"
 	TST_COUNT=$((TST_COUNT+1))
+	_tst_write_results
 }
 
 export LC_ALL=C

---
base-commit: ee945bb71ba7015dace7d983cf98a530b3eb53a4
change-id: 20260713-shell_oom_protection-6221ab825220

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
