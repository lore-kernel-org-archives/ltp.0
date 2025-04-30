Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA3DC369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B5033CBCA1
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:04:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71963CAAF4
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3E8231A00981
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41CB91F7E4;
 Wed, 30 Apr 2025 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hC1WLCKuLbarIKARXhsHnw4RXPN03WQ0vsSorDFI6ZY=;
 b=v4+8iNy9RcEhcWTW9qltKYLcbPuZ3NJxrY16z2yy+/heZ8MYwrjlBZD556FB8qBDz5WLdG
 NLCVTEyUbsHBMqvnR8v9xbNVPT6dscuGFIL8Du4Ck94eCvcIUEHOYtpJisnvrzTqR+i91/
 VjLBNcs55ZUf7+3RtyRVWny8vuVFw4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hC1WLCKuLbarIKARXhsHnw4RXPN03WQ0vsSorDFI6ZY=;
 b=/gXYgR4FHKva/O0xqXhJNtNx+7v05zkklpZXIs0H6v0i8t5BEqKEBp8ZPritOVlU0RYXTp
 LaQE1JLgN2FFsUAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hC1WLCKuLbarIKARXhsHnw4RXPN03WQ0vsSorDFI6ZY=;
 b=v4+8iNy9RcEhcWTW9qltKYLcbPuZ3NJxrY16z2yy+/heZ8MYwrjlBZD556FB8qBDz5WLdG
 NLCVTEyUbsHBMqvnR8v9xbNVPT6dscuGFIL8Du4Ck94eCvcIUEHOYtpJisnvrzTqR+i91/
 VjLBNcs55ZUf7+3RtyRVWny8vuVFw4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hC1WLCKuLbarIKARXhsHnw4RXPN03WQ0vsSorDFI6ZY=;
 b=/gXYgR4FHKva/O0xqXhJNtNx+7v05zkklpZXIs0H6v0i8t5BEqKEBp8ZPritOVlU0RYXTp
 LaQE1JLgN2FFsUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A99FD13ABF;
 Wed, 30 Apr 2025 13:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cLcxJNQfEmhRawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Apr 2025 13:04:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:04:14 +0200
Message-ID: <20250430130417.43523-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430130417.43523-1-pvorel@suse.cz>
References: <20250430130417.43523-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] shell lib: Add support for test cleanup
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
