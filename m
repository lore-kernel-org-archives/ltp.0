Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A380C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:05:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 025383CBC6D
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:05:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F379B3CBC9B
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6237E10009EC
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 163E321962;
 Wed, 30 Apr 2025 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UantvtoBa++XZHb8+U/oYwz+xazaWWxmFiXSTbfay/c=;
 b=x+F6lJaapmuxD3mvFEIOsUsqnLgpOBSEIbCJLnkjeyYKbbfEJ7KuC3etdReUI0KPaxN5oK
 KzsUAid4ITalIUr21ogJ4yk/L6Z+FB1mgPUPFqHvvkiiLRnyr9CtVkfnB2GzwmZdOs5kaO
 xLN2MOn/RFkAyMwFVo2V0A0UbL90mlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UantvtoBa++XZHb8+U/oYwz+xazaWWxmFiXSTbfay/c=;
 b=OYankp4h4E0v51RrfQUFOPvpOCCMi6oEubNGU/wqgIV7kOFu/ZFVv+m0iOTSbIz98PFW07
 ip2cgENP/NY09+Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UantvtoBa++XZHb8+U/oYwz+xazaWWxmFiXSTbfay/c=;
 b=x+F6lJaapmuxD3mvFEIOsUsqnLgpOBSEIbCJLnkjeyYKbbfEJ7KuC3etdReUI0KPaxN5oK
 KzsUAid4ITalIUr21ogJ4yk/L6Z+FB1mgPUPFqHvvkiiLRnyr9CtVkfnB2GzwmZdOs5kaO
 xLN2MOn/RFkAyMwFVo2V0A0UbL90mlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UantvtoBa++XZHb8+U/oYwz+xazaWWxmFiXSTbfay/c=;
 b=OYankp4h4E0v51RrfQUFOPvpOCCMi6oEubNGU/wqgIV7kOFu/ZFVv+m0iOTSbIz98PFW07
 ip2cgENP/NY09+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D464113A25;
 Wed, 30 Apr 2025 13:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CFJLMtUfEmhRawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Apr 2025 13:04:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:04:16 +0200
Message-ID: <20250430130417.43523-4-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] shell lib: Add basic support for test setup
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

This required to:

* Source tst_env.sh also in the tests before test/setup/cleanup functions,
  otherwise tst_res alias would not be found:
  tests/shell_loader_setup_cleanup.sh: 22: tst_res: not found

* Move sourcing tst_loader.sh at the end of the test (after
  test/setup/cleanup functions), otherwise test/setup/cleanup would not be found:
  tests/shell_loader_setup_cleanup.sh: 19: testcases/lib/tst_loader.sh: setup: not found
  tests/shell_loader_setup_cleanup.sh: 22: testcases/lib/tst_loader.sh: tst_test: not found

This solves the problem of the order the scripts are sourced. Before it was:

test.sh
  . tst_loader.sh
    tst_run_shell test.sh
      . tst_loader.sh
        . tst_env.sh <- at this point in the execution it haven't even started parsing
                        test.sh so it cannot run functions from there at all

Now:

test.sh
  . tst_env.sh
  . tst_loader.sh
    tst_run_shell test.sh
      . tst_env.sh
      . tst_loader.sh

There will be more improvements in the future, at least adding TST_CNT
support (will require changes in tst_test.c to handle timeouts).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/vma/vma05.sh                 |  4 ++--
 testcases/lib/tests/shell_loader.sh               |  4 ++--
 .../lib/tests/shell_loader_all_filesystems.sh     |  4 ++--
 testcases/lib/tests/shell_loader_brk_cleanup.sh   |  4 ++--
 testcases/lib/tests/shell_loader_c_child.sh       |  4 ++--
 testcases/lib/tests/shell_loader_cleanup.sh       |  4 ++--
 testcases/lib/tests/shell_loader_filesystems.sh   |  4 ++--
 testcases/lib/tests/shell_loader_invalid_block.sh |  4 ++--
 .../lib/tests/shell_loader_invalid_metadata.sh    |  4 ++--
 testcases/lib/tests/shell_loader_kconfigs.sh      |  4 ++--
 testcases/lib/tests/shell_loader_no_metadata.sh   |  4 ++--
 .../lib/tests/shell_loader_supported_archs.sh     |  4 ++--
 testcases/lib/tests/shell_loader_tags.sh          |  4 ++--
 testcases/lib/tests/shell_loader_tcnt.sh          |  4 ++--
 .../lib/tests/shell_loader_wrong_metadata.sh      |  4 ++--
 testcases/lib/tst_env.sh                          |  9 ---------
 testcases/lib/tst_loader.sh                       | 15 ++++++++++++---
 17 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 11d6b2ad86..e7780e8957 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -39,7 +39,7 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
@@ -71,4 +71,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
index 73812c3e23..01acf6d352 100755
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -14,7 +14,7 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
@@ -27,4 +27,4 @@ tst_test()
 	esac
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
index 33c73dfb41..1a54b2d81c 100755
--- a/testcases/lib/tests/shell_loader_all_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -12,7 +12,7 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
@@ -32,4 +32,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_brk_cleanup.sh b/testcases/lib/tests/shell_loader_brk_cleanup.sh
index ff33345ce3..95303d6409 100755
--- a/testcases/lib/tests/shell_loader_brk_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_brk_cleanup.sh
@@ -10,7 +10,7 @@
 
 TST_CLEANUP=cleanup
 
-. tst_loader.sh
+. tst_env.sh
 
 cleanup()
 {
@@ -22,4 +22,4 @@ tst_test()
 	tst_brk TBROK "Test exits"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_c_child.sh b/testcases/lib/tests/shell_loader_c_child.sh
index b2b8f3d057..c33decb1df 100755
--- a/testcases/lib/tests/shell_loader_c_child.sh
+++ b/testcases/lib/tests/shell_loader_c_child.sh
@@ -13,7 +13,7 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
@@ -25,4 +25,4 @@ tst_test()
 	shell_c_child
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_cleanup.sh b/testcases/lib/tests/shell_loader_cleanup.sh
index 684901b51f..4918df5ff2 100755
--- a/testcases/lib/tests/shell_loader_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_cleanup.sh
@@ -10,7 +10,7 @@
 
 TST_CLEANUP=do_cleanup
 
-. tst_loader.sh
+. tst_env.sh
 
 do_cleanup()
 {
@@ -22,4 +22,4 @@ tst_test()
 	tst_res TPASS "Test is executed"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
index b2c9d2f7d1..98466b918c 100755
--- a/testcases/lib/tests/shell_loader_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_filesystems.sh
@@ -22,7 +22,7 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
@@ -40,4 +40,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_invalid_block.sh b/testcases/lib/tests/shell_loader_invalid_block.sh
index 370c9043bc..d2f5dc564f 100755
--- a/testcases/lib/tests/shell_loader_invalid_block.sh
+++ b/testcases/lib/tests/shell_loader_invalid_block.sh
@@ -20,11 +20,11 @@
 # This is an invalid block that breaks the test.
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TPASS "This should pass!"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_invalid_metadata.sh b/testcases/lib/tests/shell_loader_invalid_metadata.sh
index 3834f1b9ed..52b3e69695 100755
--- a/testcases/lib/tests/shell_loader_invalid_metadata.sh
+++ b/testcases/lib/tests/shell_loader_invalid_metadata.sh
@@ -12,11 +12,11 @@
 # ---
 #
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_kconfigs.sh b/testcases/lib/tests/shell_loader_kconfigs.sh
index e1b6187554..61222ba115 100755
--- a/testcases/lib/tests/shell_loader_kconfigs.sh
+++ b/testcases/lib/tests/shell_loader_kconfigs.sh
@@ -9,11 +9,11 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TPASS "Shell loader works fine!"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_no_metadata.sh b/testcases/lib/tests/shell_loader_no_metadata.sh
index b664b48b57..77c4420964 100755
--- a/testcases/lib/tests/shell_loader_no_metadata.sh
+++ b/testcases/lib/tests/shell_loader_no_metadata.sh
@@ -5,11 +5,11 @@
 # This test has no metadata and should not be executed
 #
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_supported_archs.sh b/testcases/lib/tests/shell_loader_supported_archs.sh
index 9ad24f9c03..eda243003b 100755
--- a/testcases/lib/tests/shell_loader_supported_archs.sh
+++ b/testcases/lib/tests/shell_loader_supported_archs.sh
@@ -9,11 +9,11 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TPASS "We are running on supported architecture"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_tags.sh b/testcases/lib/tests/shell_loader_tags.sh
index c780a66c57..91e5a2ab2c 100755
--- a/testcases/lib/tests/shell_loader_tags.sh
+++ b/testcases/lib/tests/shell_loader_tags.sh
@@ -12,11 +12,11 @@
 # }
 # ---
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TFAIL "Fails the test so that tags are shown."
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_tcnt.sh b/testcases/lib/tests/shell_loader_tcnt.sh
index 93bd612ee2..bfdc6b7576 100755
--- a/testcases/lib/tests/shell_loader_tcnt.sh
+++ b/testcases/lib/tests/shell_loader_tcnt.sh
@@ -12,11 +12,11 @@
 # ---
 #
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TPASS "Iteration $1"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tests/shell_loader_wrong_metadata.sh b/testcases/lib/tests/shell_loader_wrong_metadata.sh
index 8f18741100..7ac4f348ee 100755
--- a/testcases/lib/tests/shell_loader_wrong_metadata.sh
+++ b/testcases/lib/tests/shell_loader_wrong_metadata.sh
@@ -12,11 +12,11 @@
 # ---
 #
 
-. tst_loader.sh
+. tst_env.sh
 
 tst_test()
 {
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_loader.sh
diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index b13bab37c3..585790a7d0 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -18,11 +18,6 @@ if [ -z "$LINENO" ]; then
 	LINENO=-1
 fi
 
-if [ -z "$LTP_IPC_PATH" ]; then
-	echo "This script has to be executed from a LTP loader!"
-	exit 1
-fi
-
 tst_brk_()
 {
 	tst_res_ "$@"
@@ -35,7 +30,3 @@ tst_brk_()
 
 alias tst_res="tst_res_ $tst_script_name \$LINENO"
 alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
-
-if [ -n "$TST_CLEANUP" ]; then
-	trap $TST_CLEANUP EXIT
-fi
diff --git a/testcases/lib/tst_loader.sh b/testcases/lib/tst_loader.sh
index 62c9cc6d8f..ba6961353c 100644
--- a/testcases/lib/tst_loader.sh
+++ b/testcases/lib/tst_loader.sh
@@ -3,11 +3,20 @@
 # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
 #
 # This is a loader for shell tests that use the C test library.
-#
 
 if [ -z "$LTP_IPC_PATH" ]; then
 	tst_run_shell $(basename "$0") "$@"
 	exit $?
-else
-	. tst_env.sh
 fi
+
+. tst_env.sh
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
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
