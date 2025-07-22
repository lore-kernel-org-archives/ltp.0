Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866D6C83F1A
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7F03CCCCA
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:00:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B1E83CCCEE
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06B6E100045D
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 212C8219CF;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhfLv1U+N3fKynmUTJWCUrZdTPOoTYa+KTCqgNZCC9o=;
 b=na8UUK4FD7SU7hn65TouRu6ydjl6N/lDfshxu2Ut9XyeLUxW03+cX0TpWljOAPvawG4tDn
 9DBlfncTLlqyzfyY2gFzTxvn/Abx5fPWvZ9Eptiee2DTfUMgGZ/bXdQ6RlFUQJ3IwbzKDe
 OREnmD0u3dnBzq1vHT8j1GxUbgtE1AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhfLv1U+N3fKynmUTJWCUrZdTPOoTYa+KTCqgNZCC9o=;
 b=HqtIjW+rhwg1hmocGy2whxHev8w5hjMlXxhj0ZnP/oeQA3dNpvlVlHhGYk+H7aw5c0b/3h
 HwZCgEGYPhvtVlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhfLv1U+N3fKynmUTJWCUrZdTPOoTYa+KTCqgNZCC9o=;
 b=na8UUK4FD7SU7hn65TouRu6ydjl6N/lDfshxu2Ut9XyeLUxW03+cX0TpWljOAPvawG4tDn
 9DBlfncTLlqyzfyY2gFzTxvn/Abx5fPWvZ9Eptiee2DTfUMgGZ/bXdQ6RlFUQJ3IwbzKDe
 OREnmD0u3dnBzq1vHT8j1GxUbgtE1AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhfLv1U+N3fKynmUTJWCUrZdTPOoTYa+KTCqgNZCC9o=;
 b=HqtIjW+rhwg1hmocGy2whxHev8w5hjMlXxhj0ZnP/oeQA3dNpvlVlHhGYk+H7aw5c0b/3h
 HwZCgEGYPhvtVlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F25B113A73;
 Tue, 22 Jul 2025 12:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cDJVOi+Lf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:11 +0200
Message-ID: <20250722125916.74967-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722125916.74967-1-pvorel@suse.cz>
References: <20250722125916.74967-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/6] shell lib: Add support for test cleanup
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

From: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
The same as in v3.

 testcases/lib/run_tests.sh                    |  4 +++-
 .../lib/tests/shell_loader_brk_cleanup.sh     | 20 +++++++++++++++++++
 testcases/lib/tests/shell_loader_cleanup.sh   | 20 +++++++++++++++++++
 testcases/lib/tst_env.sh                      |  4 ++++
 4 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
 create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh

diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 321f74e5fe..128cee3377 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -9,6 +9,7 @@ shell_loader_filesystems.sh
 shell_loader_kconfigs.sh
 shell_loader_supported_archs.sh
 shell_loader_tcnt.sh
+shell_loader_cleanup.sh
 shell_test01
 shell_test02
 shell_test03
@@ -21,7 +22,8 @@ TESTS_TBROK="
 shell_loader_invalid_block.sh
 shell_loader_invalid_metadata.sh
 shell_loader_no_metadata.sh
-shell_loader_wrong_metadata.sh"
+shell_loader_wrong_metadata.sh
+shell_loader_brk_cleanup.sh"
 
 TESTS_TCONF="shell_test06"
 
diff --git a/testcases/lib/tests/shell_loader_brk_cleanup.sh b/testcases/lib/tests/shell_loader_brk_cleanup.sh
new file mode 100755
index 0000000000..8c704a5406
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_brk_cleanup.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
+#
+# ---
+# env
+# {
+# }
+# ---
+
+TST_CLEANUP=cleanup
+
+. tst_loader.sh
+
+cleanup()
+{
+	tst_res TINFO "Cleanup runs"
+}
+
+tst_brk TBROK "Test exits"
diff --git a/testcases/lib/tests/shell_loader_cleanup.sh b/testcases/lib/tests/shell_loader_cleanup.sh
new file mode 100755
index 0000000000..fb7bbdf5a9
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_cleanup.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
+#
+# ---
+# env
+# {
+# }
+# ---
+
+TST_CLEANUP=do_cleanup
+
+. tst_loader.sh
+
+do_cleanup()
+{
+	tst_res TINFO "Cleanup executed"
+}
+
+tst_res TPASS "Test is executed"
diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index 68f9a0daa9..b13bab37c3 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -35,3 +35,7 @@ tst_brk_()
 
 alias tst_res="tst_res_ $tst_script_name \$LINENO"
 alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
+
+if [ -n "$TST_CLEANUP" ]; then
+	trap $TST_CLEANUP EXIT
+fi
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
