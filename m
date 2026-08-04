Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D3EC55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:22:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 872993E7169
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 11:22:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFF833CF428
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 11:22:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 114CD2000A0
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 11:22:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2436A3E32;
 Tue,  4 Aug 2026 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785835341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uvW11lj5un9IQNkqctyjtLKWV0L/4SnGfpHhpzAHjzk=;
 b=FVkyz3yhog6bszSANggloKYUhcuod/ypNR6VzqWVPeZ4DtMY9ZjCsULEoicnnJrhbFz40r
 5nd41upUy8FXsa3JynzrCCKvzLfJqIxAK6G4u2ZtvTIs9ZvPGCjtF5/4hy7GMTFCSCQKlU
 ChqzAw5tyurRPHr2WMCYoPcHpq8VZQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785835341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uvW11lj5un9IQNkqctyjtLKWV0L/4SnGfpHhpzAHjzk=;
 b=iqo2mjhiAqECsaA17fR5E2gn3bMcBWI7n9Wbg8miCFvnjLAEipwmXipTE+FaJfRAq7OyYl
 fEH9NYdRLXsmipAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MPhTgZDu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SHl8AxV0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785835337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uvW11lj5un9IQNkqctyjtLKWV0L/4SnGfpHhpzAHjzk=;
 b=MPhTgZDuX46MYkISRVNpYjcSS7l3A1fUstFHr8V2be9AwAueLF2j5qUU+jTrjCM7xXYRzq
 06mQAWsOwv0GR8tfwWbRuEVg3wGoaLUAwEjdygiMxRUXqOJnyNL1+NZpd4CPKKFyjf1YPT
 rq9tcms8sudOxhVKSDAmUrT2s3+AZWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785835337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uvW11lj5un9IQNkqctyjtLKWV0L/4SnGfpHhpzAHjzk=;
 b=SHl8AxV0E25mnh8DIJkAmFZn4caArTTSogzRCsqpsT7h2bDsSiWp2N3tjzsV5ZbS/wr3tH
 07nmPfm3O8r+WlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08DA2779BB;
 Tue,  4 Aug 2026 09:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fmh0AEmvcWpBEQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 04 Aug 2026 09:22:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 04 Aug 2026 11:22:11 +0200
MIME-Version: 1.0
Message-Id: <20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com>
X-B4-Tracking: v=1; b=H4sIAEKvcWoC/4XNQQ6CMBCF4auQWVvTThGqK+9hDCkwShOgpK2Nh
 nB3Cys2xuU/yftmBk/OkIdLNoOjaLyxYwp5yKDp9PgkZtrUgBwLXgrJfEd9X1k7VJOzgZqQBqx
 AFLpWeELkkKaTo4d5b+ztnrozPlj32b5EsV7/gFEwzupSIqkiL9U5v/qXp2NjB1i9iDtD8h8Gr
 gaJlrDWWsl2ZyzL8gU7PN2B+wAAAA==
X-Change-ID: 20260713-shell_oom_protection-6221ab825220
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785835336; l=5229;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1pvVwVo30nJppC9oHNPrfY5EhgEvrbARDd5czzkQPxg=;
 b=6dppSNnQr7kMvbbbk+kpHTGUm7dXRHA3g452mgqfXWWy7CUMvcKsUG23y44xU8VIHX70SBC8S
 cpnzJIbV+fyC37xtfvdrX8ScatiMajubdB8UsiN8CSzvvcZNAx3RAxw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2436A3E32
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] shell: enable OOM protection by default
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

Add TST_OOM_PROTECTION to activate/deactivate OOM protection in shell
tests. When enabled, the shell harness shields itself from the OOM
killer and runs the test in a child process, so it survives memory
pressure and can still report results (e.g. during memcg stress tests).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Under Li's idea, implement a OOM protection mechanism for the shell
tests so we can avoid OOM for memcg stress tests.
---
Changes in v3:
- simplify oom code
- enable OOM protection by default
- Link to v2: https://lore.kernel.org/20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com

Changes in v2:
- update shell OOM protection functional test
- Link to v1: https://lore.kernel.org/20260713-shell_oom_protection-v1-0-b732e8647894@suse.com
---
 doc/developers/writing_tests.rst             |  3 +++
 lib/newlib_tests/runtest.sh                  |  1 +
 lib/newlib_tests/shell/tst_oom_protection.sh | 31 ++++++++++++++++++++++++
 testcases/lib/tst_test.sh                    | 35 +++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 4db57898fcf08b83e68be996f666e91c418838fc..2d5bc294083fa2b89212714f0a6c5e5c3f22777a 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -549,6 +549,9 @@ LTP C And Shell Test API Comparison
     * - not applicable
       - TST_FS_TYPE
 
+    * - not applicable
+      - TST_OOM_PROTECTION
+
 .. list-table::
     :header-rows: 1
 
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b8d5545f52d6014bc070145f952915e9..7e2d0a2ac329fc1d825c2fe0b6f7c09d4f2b0064 100755
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
index 0000000000000000000000000000000000000000..22993511c64845712e4fa9fc942e9869121d7e0b
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_oom_protection.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+
+TST_TESTFUNC=do_test
+
+read_oom_score_adj() {
+	cat "/proc/$1/oom_score_adj" 2>/dev/null
+}
+
+do_test() {
+	local harness_score child_score
+
+	harness_score=$(read_oom_score_adj "$$")
+
+	if [ "$harness_score" = -1000 ]; then
+		tst_res TPASS "shell harness is protected from OOM by default"
+
+		child_score=$(tst_oom_unprotect read_oom_score_adj self)
+		if [ "$child_score" = 0 ]; then
+			tst_res TPASS "unprotected child process has oom_score_adj reset to 0"
+		else
+			tst_res TFAIL "unprotected child process oom_score_adj is $child_score, expected 0"
+		fi
+	else
+		tst_res TCONF "shell harness OOM protection unavailable"
+	fi
+}
+
+. tst_test.sh
+tst_run
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b3e7e29bbf7b52de4cb65665751005cb4df156a8..70fa19e4dadfdceb92821a02fbce7cf6686d9c4e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -15,6 +15,7 @@ export TST_CONF=0
 export TST_COUNT=1
 export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
+export TST_OOM_PROTECTION="${TST_OOM_PROTECTION:-1}"
 export TST_LIB_LOADED=1
 
 # see testcases/lib/tst_runas.c
@@ -28,6 +29,34 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
 trap "tst_brk TBROK 'test interrupted'" INT
 trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
+_tst_set_oom_score_adj()
+{
+	local value="$1"
+	local path="/proc/self/oom_score_adj"
+
+	[ -e "$path" ] || return 0
+
+	echo "$value" > "$path" 2>/dev/null || return 0
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
+tst_oom_unprotect()
+{
+	_tst_disable_oom_protection
+	if [ $# -gt 0 ]; then
+		"$@"
+	fi
+}
+
 _tst_do_cleanup()
 {
 	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
@@ -681,12 +710,16 @@ tst_run()
 	local _tst_pattern='[='\''"} \t\/:`$\;|].*'
 	local ret
 
+	if [ "$TST_OOM_PROTECTION" = 1 ]; then
+		_tst_enable_oom_protection
+	fi
+
 	if [ -n "$TST_TEST_PATH" ]; then
 		for _tst_i in $(grep '^[^#]*\<TST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
 			case "$_tst_i" in
 			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
-			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
+			OPTS|USAGE|PARSE_ARGS|POS_ARGS|OOM_PROTECTION);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;

---
base-commit: 51f722d233efa06304b1d178e24a01048cf80f10
change-id: 20260713-shell_oom_protection-6221ab825220

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
