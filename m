Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2714EC55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:05:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66D9D3E722B
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:05:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C5153CD529
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:05:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CED72200922
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:05:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB338409A;
 Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785416728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yajcVijXp7AKdyK9orjnu2Uy8dk4Y4gcd58Hg5KhmG0=;
 b=lUsztnpILANlb3+/SO3a8KzVISBJlfLiGtwd6JTi3DquN2p5n/kzKYHaZ5tB7KnTTmiJ3Y
 219mMDphVzLr3l1VBVsMTKDhnBHftKUBbBGyp8y2cwvXTjvt62FNGica6LSquIckxzVuKR
 98NnFyXXDKGUlj29Mnv/P1+BScO12Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785416728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yajcVijXp7AKdyK9orjnu2Uy8dk4Y4gcd58Hg5KhmG0=;
 b=qNMwc3zKC25LctPe0hQArrW7K05GdPcHNBzYIZvC/c36hdoEhWi1MqZn92R7rbG2Brp2b3
 TIUzoPxEMZI/RyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785416723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yajcVijXp7AKdyK9orjnu2Uy8dk4Y4gcd58Hg5KhmG0=;
 b=qE0w6GZYbykFRNfVcGjI4KnNy7pRB1F+cj8VzmMC0fuezwSESAGHowrmhastAD3LTRqZ6s
 RsXnHQ6kgGd4YJ34BNYrhFlCEejz3KVzrDCwfwaMhd2TcPdshmkZK16iACPw2JYKrCXkm6
 TFSmX6Y3FiaGTxQXmcico4ea7hU7ZBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785416723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yajcVijXp7AKdyK9orjnu2Uy8dk4Y4gcd58Hg5KhmG0=;
 b=dhIyHuPJA0syHvbait+RP0qN1gJ/Ebf6tkyR54yVGqOk7SWfFEA0UWgpCs0K6HLGcY7DQ/
 SZaA6r9m7jDDgvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2B3D779CD;
 Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJvhMRNMa2qATQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Jul 2026 13:05:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Jul 2026 15:05:23 +0200
MIME-Version: 1.0
Message-Id: <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
References: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
In-Reply-To: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785416723; l=4670;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=w2AhoP/D9fjjD+D0BFbswXrv8+9Be7/pX9puzSdj2t4=;
 b=9U84eLAv5NUIdw2c8AoqExKBRYODGeEdPFeNKZRI1T2ruGn3VLFvqHAPhImx0sNhmQkNpadPs
 WoXCbPSBDLzDhlDhT8cQnVGbmlzhOGGsYod/NF4NDe35dOQSSZYd9HR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] shell: add optional OOM protection
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

Add TST_OOM_PROTECTION to activate OOM protection in shell tests. When
enabled, the shell harness shields itself from the OOM killer and runs
the test in a child process, so it survives memory pressure and can
still report results (e.g. during memcg stress tests).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/writing_tests.rst            |  3 ++
 testcases/lib/tests/shell_oom_protection.sh | 42 +++++++++++++++++++++
 testcases/lib/tst_test.sh                   | 57 ++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 1 deletion(-)

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
 
diff --git a/testcases/lib/tests/shell_oom_protection.sh b/testcases/lib/tests/shell_oom_protection.sh
new file mode 100755
index 0000000000000000000000000000000000000000..aeab36816ee7d8eeae9366d2199a0aabde73e25a
--- /dev/null
+++ b/testcases/lib/tests/shell_oom_protection.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+#
+# doc
+# Verify that TST_OOM_PROTECTION shields the shell harness from the OOM
+# killer and resets the test process oom_score_adj to 0.
+#
+# ---
+# env
+# {
+# }
+# ---
+
+TST_TESTFUNC=do_test
+TST_OOM_PROTECTION=1
+
+read_oom_score_adj() {
+	cat "/proc/$1/oom_score_adj" 2>/dev/null
+}
+
+do_test() {
+	local self_score harness_score
+
+	self_score=$(read_oom_score_adj self)
+	harness_score=$(read_oom_score_adj "$$")
+
+	if [ "$self_score" = 0 ]; then
+		tst_res TPASS "test process has oom_score_adj reset to 0"
+	else
+		tst_res TFAIL "test process oom_score_adj is $self_score, expected 0"
+	fi
+
+	if [ "$harness_score" = -1000 ]; then
+		tst_res TPASS "shell harness is protected from OOM"
+	else
+		tst_res TCONF "shell harness OOM protection unavailable"
+	fi
+}
+
+. tst_test.sh
+tst_run
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8701bb3903889b009f88ba98bac47534608cdd0a..48dacb432b953295ae4ad710e4f27ed87ac0a7e5 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,6 +28,57 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
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
+_tst_run_oom_protected()
+{
+	local _tst_pid
+	local _tst_ret
+
+	# Shield the harness from the OOM killer and run the test in a child.
+	# The child keeps the default oom_score_adj so that it, and any process
+	# it spawns, stay killable under memory pressure while the harness
+	# survives to report results.
+	_tst_enable_oom_protection
+
+	(
+		_tst_disable_oom_protection
+		_TST_OOM_PROTECTION=0
+		export _TST_OOM_PROTECTION
+		tst_run "$@"
+	) &
+	_tst_pid=$!
+
+	wait "$_tst_pid"
+	_tst_ret=$?
+
+	if [ "$_tst_ret" -eq 137 ]; then
+		tst_res TINFO "Test was SIGKILLed: OOM killer or timeout?"
+		tst_res TINFO "On a slow machine try exporting LTP_TIMEOUT_MUL > 1"
+		tst_brk TBROK "Test killed!"
+	fi
+
+	exit "$_tst_ret"
+}
+
 _tst_do_cleanup()
 {
 	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
@@ -680,12 +731,16 @@ tst_run()
 	local _tst_pattern='[='\''"} \t\/:`$\;|].*'
 	local ret
 
+	if [ "$TST_OOM_PROTECTION" = 1 -a "$_TST_OOM_PROTECTION" != 0 ]; then
+		_tst_run_oom_protected "$@"
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

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
