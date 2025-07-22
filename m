Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C45FC83F1A
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:01:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 268543CCD08
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:01:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 362193CCD0C
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9E451400BDD
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE4B11F78B;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMmbWp/F/TAI7aXXv1Kud+PLXiiLRqgJbD19KtXMUZw=;
 b=oaw0mjcZ11MeNIvVRvzHAvjgj94+Be6vFh/BquA6tjyLDZviAWP/q9rPxYTLCQ6BVGga+2
 /CCS+vPFh6tQT+43F6RW9OGVuC1TXcxknHXppIpLV6ZUaIJEycM5fHiXwbRLJC0v/q4woh
 sjJOtIkC03z2+YGILzLUT5iK83MfFAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMmbWp/F/TAI7aXXv1Kud+PLXiiLRqgJbD19KtXMUZw=;
 b=K1f9XeMRapkuITZO3fSxfkiewSbDULG/QYAY3EByBqRFNUMKuXg4Ao+0+UQ/gX7aseB0gq
 aW1cJF9+9KTjukBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BR6x6+CJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MAeMbG9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMmbWp/F/TAI7aXXv1Kud+PLXiiLRqgJbD19KtXMUZw=;
 b=BR6x6+CJNxnwvufGLT/uCm7mePKYNvU0HYhb9YOmZ/ycj7PmAm7TTnlwjwEZFZ2EFui9Tn
 ps3Z68CTZPyiExQcS3vzcZJe2b7O9u+OBgHSpq/uBdsaPfEELiG5dQAGc+lgokBq7tOafq
 ERpvHFLMYXIC2oBAVCrQ1ve8RL4UMbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMmbWp/F/TAI7aXXv1Kud+PLXiiLRqgJbD19KtXMUZw=;
 b=MAeMbG9R16/o34rLQmg8IrNJdZenx3DS2qRAT2wkvMBRYIuClfkbLqhcDj3kQLYsBdIXk8
 qZgnNTu+uEwFsxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E3D132EA;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oAC8KjCLf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:15 +0200
Message-ID: <20250722125916.74967-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722125916.74967-1-pvorel@suse.cz>
References: <20250722125916.74967-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: DE4B11F78B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/6] shell lib: Add basic support for test setup
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

* Add tst_run.sh
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
  . tst_loader.sh
    tst_run_shell test.sh
    . tst_loader.sh
      . tst_env.sh
    . tst_run.sh

There will be more improvements in the future, at least adding TST_CNT
support (will require changes in tst_test.c to handle timeouts).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
* Add checks for $TST_SETUP and $TST_CLEANUP (Li)
NOTE: I decided to use TWARN for $TST_CLEANUP as usually test could run
without it.

 testcases/kernel/mem/vma/vma05.sh             |  2 +-
 testcases/lib/tests/shell_loader.sh           |  2 +-
 .../lib/tests/shell_loader_all_filesystems.sh |  2 +-
 .../lib/tests/shell_loader_brk_cleanup.sh     |  2 +-
 testcases/lib/tests/shell_loader_c_child.sh   |  2 +-
 testcases/lib/tests/shell_loader_cleanup.sh   |  2 +-
 .../lib/tests/shell_loader_filesystems.sh     |  2 +-
 .../lib/tests/shell_loader_invalid_block.sh   |  2 +-
 .../tests/shell_loader_invalid_metadata.sh    |  2 +-
 testcases/lib/tests/shell_loader_kconfigs.sh  |  2 +-
 .../lib/tests/shell_loader_no_metadata.sh     |  2 +-
 .../lib/tests/shell_loader_supported_archs.sh |  2 +-
 testcases/lib/tests/shell_loader_tags.sh      |  2 +-
 testcases/lib/tests/shell_loader_tcnt.sh      |  2 +-
 .../lib/tests/shell_loader_wrong_metadata.sh  |  2 +-
 testcases/lib/tst_env.sh                      |  9 -------
 testcases/lib/tst_run.sh                      | 24 +++++++++++++++++++
 17 files changed, 39 insertions(+), 24 deletions(-)
 create mode 100644 testcases/lib/tst_run.sh

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 11d6b2ad86..c560eecbcd 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -71,4 +71,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
index 73812c3e23..78dba06b25 100755
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -27,4 +27,4 @@ tst_test()
 	esac
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
index 8fe3809a5e..3c3978f51c 100755
--- a/testcases/lib/tests/shell_loader_all_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -32,4 +32,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_brk_cleanup.sh b/testcases/lib/tests/shell_loader_brk_cleanup.sh
index ff33345ce3..4e8ce4f737 100755
--- a/testcases/lib/tests/shell_loader_brk_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_brk_cleanup.sh
@@ -22,4 +22,4 @@ tst_test()
 	tst_brk TBROK "Test exits"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_c_child.sh b/testcases/lib/tests/shell_loader_c_child.sh
index b2b8f3d057..13480968f9 100755
--- a/testcases/lib/tests/shell_loader_c_child.sh
+++ b/testcases/lib/tests/shell_loader_c_child.sh
@@ -25,4 +25,4 @@ tst_test()
 	shell_c_child
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_cleanup.sh b/testcases/lib/tests/shell_loader_cleanup.sh
index 684901b51f..91071a5a75 100755
--- a/testcases/lib/tests/shell_loader_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_cleanup.sh
@@ -22,4 +22,4 @@ tst_test()
 	tst_res TPASS "Test is executed"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
index b2c9d2f7d1..d584503adb 100755
--- a/testcases/lib/tests/shell_loader_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_filesystems.sh
@@ -40,4 +40,4 @@ tst_test()
 	fi
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_invalid_block.sh b/testcases/lib/tests/shell_loader_invalid_block.sh
index 370c9043bc..be45303d79 100755
--- a/testcases/lib/tests/shell_loader_invalid_block.sh
+++ b/testcases/lib/tests/shell_loader_invalid_block.sh
@@ -27,4 +27,4 @@ tst_test()
 	tst_res TPASS "This should pass!"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_invalid_metadata.sh b/testcases/lib/tests/shell_loader_invalid_metadata.sh
index 3834f1b9ed..c4c7579243 100755
--- a/testcases/lib/tests/shell_loader_invalid_metadata.sh
+++ b/testcases/lib/tests/shell_loader_invalid_metadata.sh
@@ -19,4 +19,4 @@ tst_test()
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_kconfigs.sh b/testcases/lib/tests/shell_loader_kconfigs.sh
index e1b6187554..d03bc99cac 100755
--- a/testcases/lib/tests/shell_loader_kconfigs.sh
+++ b/testcases/lib/tests/shell_loader_kconfigs.sh
@@ -16,4 +16,4 @@ tst_test()
 	tst_res TPASS "Shell loader works fine!"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_no_metadata.sh b/testcases/lib/tests/shell_loader_no_metadata.sh
index b664b48b57..2ad458ef8d 100755
--- a/testcases/lib/tests/shell_loader_no_metadata.sh
+++ b/testcases/lib/tests/shell_loader_no_metadata.sh
@@ -12,4 +12,4 @@ tst_test()
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_supported_archs.sh b/testcases/lib/tests/shell_loader_supported_archs.sh
index 9ad24f9c03..a45cc59b7d 100755
--- a/testcases/lib/tests/shell_loader_supported_archs.sh
+++ b/testcases/lib/tests/shell_loader_supported_archs.sh
@@ -16,4 +16,4 @@ tst_test()
 	tst_res TPASS "We are running on supported architecture"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_tags.sh b/testcases/lib/tests/shell_loader_tags.sh
index c780a66c57..56eadaf7a2 100755
--- a/testcases/lib/tests/shell_loader_tags.sh
+++ b/testcases/lib/tests/shell_loader_tags.sh
@@ -19,4 +19,4 @@ tst_test()
 	tst_res TFAIL "Fails the test so that tags are shown."
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_tcnt.sh b/testcases/lib/tests/shell_loader_tcnt.sh
index 93bd612ee2..cf2a0b74ec 100755
--- a/testcases/lib/tests/shell_loader_tcnt.sh
+++ b/testcases/lib/tests/shell_loader_tcnt.sh
@@ -19,4 +19,4 @@ tst_test()
 	tst_res TPASS "Iteration $1"
 }
 
-tst_test
+. tst_run.sh
diff --git a/testcases/lib/tests/shell_loader_wrong_metadata.sh b/testcases/lib/tests/shell_loader_wrong_metadata.sh
index 8f18741100..35c535beed 100755
--- a/testcases/lib/tests/shell_loader_wrong_metadata.sh
+++ b/testcases/lib/tests/shell_loader_wrong_metadata.sh
@@ -19,4 +19,4 @@ tst_test()
 	tst_res TFAIL "Shell loader should TBROK the test"
 }
 
-tst_test
+. tst_run.sh
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
diff --git a/testcases/lib/tst_run.sh b/testcases/lib/tst_run.sh
new file mode 100644
index 0000000000..5f573b9a06
--- /dev/null
+++ b/testcases/lib/tst_run.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+
+. tst_env.sh
+
+if [ -n "$TST_CLEANUP" ]; then
+	if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
+		trap $TST_CLEANUP EXIT
+	else
+		tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)" # FIXME: debug
+	fi
+fi
+
+if [ -n "$TST_SETUP" ]; then
+	if command -v $TST_SETUP >/dev/null 2>/dev/null; then
+		$TST_SETUP
+	else
+		tst_brk TBROK "TST_SETUP=$TST_SETUP declared, but function not defined (or cmd not found)"
+	fi
+fi
+
+tst_test
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
