Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F07C282D0
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 17:26:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A5D3C9E9D
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:26:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00CD93C9EA3
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:24:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E9CF14060C8
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:24:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 934D31F38F;
 Fri, 28 Feb 2025 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740763484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UT6zn3/HINsyjFjxgDFUD/i3rmSgrGwHCZDlZ6CI8ns=;
 b=x7ie+sTP8eb8jyWbe0s9L/YT1r/U7ATGb+2U/RKYiYHbpP0JDcvilID1dVWUMYL2UUV7Th
 sSgu7VYgWjzs+mDV4gkQzNSAeAwlqkoepYKNtBTv89krfGNG+BpkEbT20I9xk6x2Tdytka
 C2MLte2kj/61lkFulLSk+dgUQ6G+3aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740763484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UT6zn3/HINsyjFjxgDFUD/i3rmSgrGwHCZDlZ6CI8ns=;
 b=v8pfOIgw8K/oTNjyttw65L4kTvl/ptnJsd7ay8DySaDow8OjY7+215oNYMaeXhtAncra83
 iw5JNl/BER9W87BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740763484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UT6zn3/HINsyjFjxgDFUD/i3rmSgrGwHCZDlZ6CI8ns=;
 b=x7ie+sTP8eb8jyWbe0s9L/YT1r/U7ATGb+2U/RKYiYHbpP0JDcvilID1dVWUMYL2UUV7Th
 sSgu7VYgWjzs+mDV4gkQzNSAeAwlqkoepYKNtBTv89krfGNG+BpkEbT20I9xk6x2Tdytka
 C2MLte2kj/61lkFulLSk+dgUQ6G+3aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740763484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UT6zn3/HINsyjFjxgDFUD/i3rmSgrGwHCZDlZ6CI8ns=;
 b=v8pfOIgw8K/oTNjyttw65L4kTvl/ptnJsd7ay8DySaDow8OjY7+215oNYMaeXhtAncra83
 iw5JNl/BER9W87BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E2DF13A82;
 Fri, 28 Feb 2025 17:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OCCbEVzxwWeQcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 17:24:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Feb 2025 18:24:37 +0100
Message-ID: <20250228172439.3276777-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228172439.3276777-1-pvorel@suse.cz>
References: <20250228172439.3276777-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 4/5] shell lib: Add basic support for test cleanup
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

Add basic support for test cleanup in shell loader.

This solves the problem of the order the scripts are sourced. Before it
was:

    test.sh
     . tst_loader.sh
      tst_run_shell test.sh
       . tst_loader.sh
	. tst_env.sh <- at this point in the execution you haven't even started
			parsing test.sh so you cannot run functions from there
			at all

Now new script tst_exec.sh is used to load load the test (loaded itself
by tst_run_shell):

    test.sh
     . tst_loader.sh
     tst_run_shell tst_exec.sh test.sh
      . test.sh
	. tst_env.sh

'. tst_loader.sh' (loading a script) was moved to the end, calling test
function (now forced to be tst_test) and tst_env.sh was moved to
tst_exec.sh.

There will be more improvements in the future, at least adding TST_CNT
support (will require changes in tst_test.c to handle timeouts).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Maybe variables in tst_run_shell.c could be renamed?

 testcases/kernel/mem/vma/vma05.sh             |  4 +---
 testcases/lib/tests/shell_loader.sh           |  4 +---
 .../lib/tests/shell_loader_all_filesystems.sh |  4 +---
 .../lib/tests/shell_loader_brk_cleanup.sh     |  4 +---
 testcases/lib/tests/shell_loader_c_child.sh   |  4 +---
 testcases/lib/tests/shell_loader_cleanup.sh   |  4 +---
 .../lib/tests/shell_loader_filesystems.sh     |  4 +---
 .../lib/tests/shell_loader_invalid_block.sh   |  4 +---
 .../tests/shell_loader_invalid_metadata.sh    |  4 +---
 testcases/lib/tests/shell_loader_kconfigs.sh  |  4 +---
 .../lib/tests/shell_loader_no_metadata.sh     |  4 +---
 .../lib/tests/shell_loader_supported_archs.sh |  4 +---
 testcases/lib/tests/shell_loader_tags.sh      |  4 +---
 testcases/lib/tests/shell_loader_tcnt.sh      |  4 +---
 .../lib/tests/shell_loader_wrong_metadata.sh  |  4 +---
 testcases/lib/tst_env.sh                      |  4 ----
 testcases/lib/tst_exec.sh                     | 19 +++++++++++++++++++
 testcases/lib/tst_loader.sh                   |  5 +----
 testcases/lib/tst_run_shell.c                 | 16 +++++++++++-----
 19 files changed, 46 insertions(+), 58 deletions(-)
 create mode 100755 testcases/lib/tst_exec.sh

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 11d6b2ad86..5f8940581b 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -39,8 +39,6 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	ulimit -c unlimited
@@ -71,4 +69,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
index 73812c3e23..eeed122c1e 100755
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -14,8 +14,6 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TPASS "Shell loader works fine!"
@@ -27,4 +25,4 @@ tst_test()
 	esac
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
index 33c73dfb41..caa4c75ff4 100755
--- a/testcases/lib/tests/shell_loader_all_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -12,8 +12,6 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	local mntpath=$(realpath ltp_mntpoint)
@@ -32,4 +30,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_brk_cleanup.sh b/testcases/lib/tests/shell_loader_brk_cleanup.sh
index ff33345ce3..c6286176c5 100755
--- a/testcases/lib/tests/shell_loader_brk_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_brk_cleanup.sh
@@ -10,8 +10,6 @@
 
 TST_CLEANUP=cleanup
 
-. tst_loader.sh
-
 cleanup()
 {
 	tst_res TINFO "Cleanup runs"
@@ -22,4 +20,4 @@ tst_test()
 	tst_brk TBROK "Test exits"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_c_child.sh b/testcases/lib/tests/shell_loader_c_child.sh
index b2b8f3d057..9acc212145 100755
--- a/testcases/lib/tests/shell_loader_c_child.sh
+++ b/testcases/lib/tests/shell_loader_c_child.sh
@@ -13,8 +13,6 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	if [ -n "LTP_IPC_PATH" ]; then
@@ -25,4 +23,4 @@ tst_test()
 	shell_c_child
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_cleanup.sh b/testcases/lib/tests/shell_loader_cleanup.sh
index 684901b51f..a59301a15b 100755
--- a/testcases/lib/tests/shell_loader_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_cleanup.sh
@@ -10,8 +10,6 @@
 
 TST_CLEANUP=do_cleanup
 
-. tst_loader.sh
-
 do_cleanup()
 {
 	tst_res TINFO "Cleanup executed"
@@ -22,4 +20,4 @@ tst_test()
 	tst_res TPASS "Test is executed"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
index 155cc4d9f6..c23590d26a 100755
--- a/testcases/lib/tests/shell_loader_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_filesystems.sh
@@ -19,8 +19,6 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TINFO "In shell"
@@ -37,4 +35,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_invalid_block.sh b/testcases/lib/tests/shell_loader_invalid_block.sh
index 370c9043bc..7df25c95dd 100755
--- a/testcases/lib/tests/shell_loader_invalid_block.sh
+++ b/testcases/lib/tests/shell_loader_invalid_block.sh
@@ -20,11 +20,9 @@
 # This is an invalid block that breaks the test.
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TPASS "This should pass!"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_invalid_metadata.sh b/testcases/lib/tests/shell_loader_invalid_metadata.sh
index 3834f1b9ed..2b7f86c5b5 100755
--- a/testcases/lib/tests/shell_loader_invalid_metadata.sh
+++ b/testcases/lib/tests/shell_loader_invalid_metadata.sh
@@ -12,11 +12,9 @@
 # ---
 #
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_kconfigs.sh b/testcases/lib/tests/shell_loader_kconfigs.sh
index e1b6187554..8fdf3e16c5 100755
--- a/testcases/lib/tests/shell_loader_kconfigs.sh
+++ b/testcases/lib/tests/shell_loader_kconfigs.sh
@@ -9,11 +9,9 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TPASS "Shell loader works fine!"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_no_metadata.sh b/testcases/lib/tests/shell_loader_no_metadata.sh
index b664b48b57..4c55afabfe 100755
--- a/testcases/lib/tests/shell_loader_no_metadata.sh
+++ b/testcases/lib/tests/shell_loader_no_metadata.sh
@@ -5,11 +5,9 @@
 # This test has no metadata and should not be executed
 #
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_supported_archs.sh b/testcases/lib/tests/shell_loader_supported_archs.sh
index 9ad24f9c03..99c387d248 100755
--- a/testcases/lib/tests/shell_loader_supported_archs.sh
+++ b/testcases/lib/tests/shell_loader_supported_archs.sh
@@ -9,11 +9,9 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TPASS "We are running on supported architecture"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_tags.sh b/testcases/lib/tests/shell_loader_tags.sh
index c780a66c57..b8f78b61b4 100755
--- a/testcases/lib/tests/shell_loader_tags.sh
+++ b/testcases/lib/tests/shell_loader_tags.sh
@@ -12,11 +12,9 @@
 # }
 # ---
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TFAIL "Fails the test so that tags are shown."
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_tcnt.sh b/testcases/lib/tests/shell_loader_tcnt.sh
index 93bd612ee2..c29c0558d2 100755
--- a/testcases/lib/tests/shell_loader_tcnt.sh
+++ b/testcases/lib/tests/shell_loader_tcnt.sh
@@ -12,11 +12,9 @@
 # ---
 #
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TPASS "Iteration $1"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_wrong_metadata.sh b/testcases/lib/tests/shell_loader_wrong_metadata.sh
index 8f18741100..cf5e577947 100755
--- a/testcases/lib/tests/shell_loader_wrong_metadata.sh
+++ b/testcases/lib/tests/shell_loader_wrong_metadata.sh
@@ -12,11 +12,9 @@
 # ---
 #
 
-. tst_loader.sh
-
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index b13bab37c3..68f9a0daa9 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -35,7 +35,3 @@ tst_brk_()
 
 alias tst_res="tst_res_ $tst_script_name \$LINENO"
 alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
-
-if [ -n "$TST_CLEANUP" ]; then
-	trap $TST_CLEANUP EXIT
-fi
diff --git a/testcases/lib/tst_exec.sh b/testcases/lib/tst_exec.sh
new file mode 100755
index 0000000000..dcf40fd5bb
--- /dev/null
+++ b/testcases/lib/tst_exec.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+
+. tst_env.sh
+
+. "$1"
+
+if [ -n "$TST_CLEANUP" ]; then
+	trap $TST_CLEANUP EXIT
+fi
+
+if [ -n "$TST_SETUP" ]; then
+    $TST_SETUP
+fi
+
+tst_test
+
+# vim: set ft=sh ts=4 sts=4 sw=4 expandtab :
diff --git a/testcases/lib/tst_loader.sh b/testcases/lib/tst_loader.sh
index 62c9cc6d8f..e2d1bd7daf 100644
--- a/testcases/lib/tst_loader.sh
+++ b/testcases/lib/tst_loader.sh
@@ -3,11 +3,8 @@
 # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
 #
 # This is a loader for shell tests that use the C test library.
-#
 
 if [ -z "$LTP_IPC_PATH" ]; then
-	tst_run_shell $(basename "$0") "$@"
+	tst_run_shell tst_exec.sh $(basename "$0") "$@"
 	exit $?
-else
-	. tst_env.sh
 fi
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 7a446e0040..96e9bee4f5 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -9,30 +9,35 @@
 #include "tst_safe_stdio.h"
 #include "ujson.h"
 
+static char *shell_loader;
+
+/* shell test filename */
 static char *shell_filename;
 
 static void run_shell(void)
 {
-	tst_run_script(shell_filename, NULL);
+	char *const params[] = {shell_filename, NULL};
+	tst_run_script(shell_loader, params);
 }
 
 static void run_shell_tcnt(unsigned int n)
 {
 	char buf[128];
-	char *const params[] = {buf, NULL};
+	char *const params[] = {shell_filename, buf, NULL};
 
 	snprintf(buf, sizeof(buf), "%u", n);
 
-	tst_run_script(shell_filename, params);
+	tst_run_script(shell_loader, params);
 }
 
 static struct tst_test test = {
 	.runs_script = 1,
+	.pos_args = 1,
 };
 
 static void print_help(void)
 {
-	printf("Usage: tst_shell_loader ltp_shell_test.sh ...\n");
+	printf("Usage: tst_run_shell tst_exec.sh ltp_shell_test.sh ...\n");
 }
 
 static char *metadata;
@@ -589,7 +594,8 @@ int main(int argc, char *argv[])
 	if (argc < 2)
 		goto help;
 
-	shell_filename = argv[1];
+	shell_loader = argv[1];
+	shell_filename = argv[2];
 
 	prepare_test_struct();
 
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
