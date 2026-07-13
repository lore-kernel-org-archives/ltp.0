Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9436DC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:02:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027D03E9692
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:02:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72B63E65CC
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:01:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E3C6A600068
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:01:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 364783E11;
 Mon, 13 Jul 2026 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783951303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsnOXcPcmtqtktP4A0QLf3MRAFd/l4yDuhK+MIDVsgQ=;
 b=HYl/tDdxXKx/RF8Ct66K0hJyWoOD6LkPtQ3X1Mjut/xcvqzn8OwDk4jGsCC8tT4VjvIKlh
 MDueso/xe8M8OFt5Tg+qEsPsKhwf8udgp44PNBzcdT0r9yEfyZcvXONvDnED5TVvZJFHYj
 1m2iJtmxkroERerGhFVHvOyCRqop/C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783951303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsnOXcPcmtqtktP4A0QLf3MRAFd/l4yDuhK+MIDVsgQ=;
 b=JI8ulPKeKnRrve+XtVM/+HLg11HSUKgndJ0R7Ar0QMVSlkVoEk6PuHxAoIWZiJYUM/p3vt
 cPORovdBStxiYnDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nIVQl0BS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1CG/aFz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783951298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsnOXcPcmtqtktP4A0QLf3MRAFd/l4yDuhK+MIDVsgQ=;
 b=nIVQl0BS5Y2szKFUAzYdRjneRRSQ+oATkzm0D/ENXqNmaTPg7ZK0UFrhD6n1wmgQPUB8NX
 GNQUePgW3I1d/zWhiK15K/qgH7EKvNuxyw65MpCws073eCTLn5GJBnWg4FKPBYEJDpBZbV
 W931xQj3KWVMk5uFAMSt4GXyYA5zdc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783951298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsnOXcPcmtqtktP4A0QLf3MRAFd/l4yDuhK+MIDVsgQ=;
 b=1CG/aFz8i9AFHc7jhvOLxXhe8KWF5EZLr+tPpUdSiqmQlB5aBJpGUPVVeoIu/d6fBStwbQ
 BXMEbwvvPaCXUrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C0F8779AF;
 Mon, 13 Jul 2026 14:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mAEqBcLvVGpaEQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jul 2026 14:01:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 16:01:29 +0200
MIME-Version: 1.0
Message-Id: <20260713-shell_oom_protection-v1-1-b732e8647894@suse.com>
References: <20260713-shell_oom_protection-v1-0-b732e8647894@suse.com>
In-Reply-To: <20260713-shell_oom_protection-v1-0-b732e8647894@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783951297; l=4478;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pByNMsBAS7rZONW64M1JZhKsDAdyOrTq/nmhcjjr+Ts=;
 b=kPFGL2W1q8NRUz9rhNBC9NPpBtkJQXq2Zd9JqzOpmccJ2qJ8pIc7NIny14lYeWQywSxQSHd7M
 QJfcv3vtfSACyipBQ3PgeZIvNB7j5mXw/ivruVgVC/f8viH3IiJZwQ9
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 364783E11
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:email, suse.com:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] shell: add optional OOM protection
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
 testcases/lib/tests/shell_oom_protection.sh | 34 +++++++++++++++++
 testcases/lib/tst_test.sh                   | 57 ++++++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..a37ec51d2955e176c3b54297b8ca73ffbf2999f6
--- /dev/null
+++ b/testcases/lib/tests/shell_oom_protection.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Linux Test Project
+
+TST_TESTFUNC=test
+TST_OOM_PROTECTION=1
+
+read_oom_score_adj()
+{
+	cat "/proc/$1/oom_score_adj" 2>/dev/null
+}
+
+test()
+{
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
