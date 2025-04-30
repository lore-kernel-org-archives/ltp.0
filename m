Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7A0C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:05:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D53603CBC90
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:05:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40D3C3CBC8F
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CBA21400BE1
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAA951F7F3;
 Wed, 30 Apr 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6087E13A25;
 Wed, 30 Apr 2025 13:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mMZHE9UfEmhRawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Apr 2025 13:04:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:04:15 +0200
Message-ID: <20250430130417.43523-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430130417.43523-1-pvorel@suse.cz>
References: <20250430130417.43523-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CAA951F7F3
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] shell: Move shell code into functions
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

This is a preparation to make next changes smaller.
No functional changes.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/vma/vma05.sh             | 45 ++++++++++---------
 testcases/lib/tests/shell_loader.sh           | 19 +++++---
 .../lib/tests/shell_loader_all_filesystems.sh | 26 ++++++-----
 .../lib/tests/shell_loader_brk_cleanup.sh     |  7 ++-
 testcases/lib/tests/shell_loader_c_child.sh   | 15 ++++---
 testcases/lib/tests/shell_loader_cleanup.sh   |  7 ++-
 .../lib/tests/shell_loader_filesystems.sh     | 23 ++++++----
 .../lib/tests/shell_loader_invalid_block.sh   |  7 ++-
 .../tests/shell_loader_invalid_metadata.sh    |  7 ++-
 testcases/lib/tests/shell_loader_kconfigs.sh  |  7 ++-
 .../lib/tests/shell_loader_no_metadata.sh     |  7 ++-
 .../lib/tests/shell_loader_supported_archs.sh |  7 ++-
 testcases/lib/tests/shell_loader_tags.sh      |  7 ++-
 testcases/lib/tests/shell_loader_tcnt.sh      |  7 ++-
 .../lib/tests/shell_loader_wrong_metadata.sh  |  7 ++-
 15 files changed, 137 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index f4c76b7034..11d6b2ad86 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -41,29 +41,34 @@
 
 . tst_loader.sh
 
-ulimit -c unlimited
-unset DEBUGINFOD_URLS
+tst_test()
+{
+	ulimit -c unlimited
+	unset DEBUGINFOD_URLS
 
-if [ $(uname -m) = "x86_64" ]; then
-	if LINE=$(grep "vsyscall" /proc/self/maps); then
-		RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
-		if echo "$LINE" | grep -q "$RIGHT"; then
-			tst_res TPASS "[vsyscall] reported correctly"
-		else
-			tst_res TFAIL "[vsyscall] reporting wrong"
+	if [ $(uname -m) = "x86_64" ]; then
+		if LINE=$(grep "vsyscall" /proc/self/maps); then
+			RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
+			if echo "$LINE" | grep -q "$RIGHT"; then
+				tst_res TPASS "[vsyscall] reported correctly"
+			else
+				tst_res TFAIL "[vsyscall] reporting wrong"
+			fi
 		fi
 	fi
-fi
 
-rm -rf core*
-{ vma05_vdso; } > /dev/null 2>&1
-[ -f core ] || tst_brk TBROK "missing core file"
+	rm -rf core*
+	{ vma05_vdso; } > /dev/null 2>&1
+	[ -f core ] || tst_brk TBROK "missing core file"
 
-TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
-	vma05_vdso ./core* 2> /dev/null)
+	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
+		vma05_vdso ./core* 2> /dev/null)
 
-if echo "$TRACE" | grep -qF "??"; then
-	tst_res TFAIL "[vdso] bug not patched"
-else
-	tst_res TPASS "[vdso] backtrace complete"
-fi
+	if echo "$TRACE" | grep -qF "??"; then
+		tst_res TFAIL "[vdso] bug not patched"
+	else
+		tst_res TPASS "[vdso] backtrace complete"
+	fi
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
index a7c5848ff5..73812c3e23 100755
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -16,10 +16,15 @@
 
 . tst_loader.sh
 
-tst_res TPASS "Shell loader works fine!"
-case "$PWD" in
-	/tmp/*)
-		tst_res TPASS "We are running in temp directory in $PWD";;
-	*)
-		tst_res TFAIL "We are not running in temp directory but $PWD";;
-esac
+tst_test()
+{
+	tst_res TPASS "Shell loader works fine!"
+	case "$PWD" in
+		/tmp/*)
+			tst_res TPASS "We are running in temp directory in $PWD";;
+		*)
+			tst_res TFAIL "We are not running in temp directory but $PWD";;
+	esac
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
index 91fac89fd6..33c73dfb41 100755
--- a/testcases/lib/tests/shell_loader_all_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -14,16 +14,22 @@
 
 . tst_loader.sh
 
-tst_res TINFO "In shell"
+tst_test()
+{
+	local mntpath=$(realpath ltp_mntpoint)
+	local mounted=$(grep $mntpath /proc/mounts)
+	local device path
 
-mntpath=$(realpath ltp_mntpoint)
-mounted=$(grep $mntpath /proc/mounts)
+	tst_res TINFO "In shell"
 
-if [ -n "$mounted" ]; then
-	device=$(echo $mounted |cut -d' ' -f 1)
-	path=$(echo $mounted |cut -d' ' -f 2)
+	if [ -n "$mounted" ]; then
+		device=$(echo $mounted |cut -d' ' -f 1)
+		path=$(echo $mounted |cut -d' ' -f 2)
 
-	tst_res TPASS "$device mounted at $path"
-else
-	tst_res TFAIL "Device not mounted!"
-fi
+		tst_res TPASS "$device mounted at $path"
+	else
+		tst_res TFAIL "Device not mounted!"
+	fi
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_brk_cleanup.sh b/testcases/lib/tests/shell_loader_brk_cleanup.sh
index 8c704a5406..ff33345ce3 100755
--- a/testcases/lib/tests/shell_loader_brk_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_brk_cleanup.sh
@@ -17,4 +17,9 @@ cleanup()
 	tst_res TINFO "Cleanup runs"
 }
 
-tst_brk TBROK "Test exits"
+tst_test()
+{
+	tst_brk TBROK "Test exits"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_c_child.sh b/testcases/lib/tests/shell_loader_c_child.sh
index 34629e6d26..b2b8f3d057 100755
--- a/testcases/lib/tests/shell_loader_c_child.sh
+++ b/testcases/lib/tests/shell_loader_c_child.sh
@@ -15,9 +15,14 @@
 
 . tst_loader.sh
 
-if [ -n "LTP_IPC_PATH" ]; then
-	tst_res TPASS "LTP_IPC_PATH=$LTP_IPC_PATH!"
-fi
+tst_test()
+{
+	if [ -n "LTP_IPC_PATH" ]; then
+		tst_res TPASS "LTP_IPC_PATH=$LTP_IPC_PATH!"
+	fi
 
-tst_res TINFO "Running C child"
-shell_c_child
+	tst_res TINFO "Running C child"
+	shell_c_child
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_cleanup.sh b/testcases/lib/tests/shell_loader_cleanup.sh
index fb7bbdf5a9..684901b51f 100755
--- a/testcases/lib/tests/shell_loader_cleanup.sh
+++ b/testcases/lib/tests/shell_loader_cleanup.sh
@@ -17,4 +17,9 @@ do_cleanup()
 	tst_res TINFO "Cleanup executed"
 }
 
-tst_res TPASS "Test is executed"
+tst_test()
+{
+	tst_res TPASS "Test is executed"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
index b7e1f9ba49..b2c9d2f7d1 100755
--- a/testcases/lib/tests/shell_loader_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_filesystems.sh
@@ -24,15 +24,20 @@
 
 . tst_loader.sh
 
-tst_res TINFO "In shell"
+tst_test()
+{
+	tst_res TINFO "In shell"
 
-mntpoint=$(realpath ltp_mntpoint)
-mounted=$(grep $mntpoint /proc/mounts)
+	mntpoint=$(realpath ltp_mntpoint)
+	mounted=$(grep $mntpoint /proc/mounts)
 
-if [ -n "$mounted" ]; then
-	fs=$(echo $mounted |cut -d' ' -f 3)
+	if [ -n "$mounted" ]; then
+		fs=$(echo $mounted |cut -d' ' -f 3)
 
-	tst_res TPASS "Mounted device formatted with $fs"
-else
-	tst_res TFAIL "Device not mounted!"
-fi
+		tst_res TPASS "Mounted device formatted with $fs"
+	else
+		tst_res TFAIL "Device not mounted!"
+	fi
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_invalid_block.sh b/testcases/lib/tests/shell_loader_invalid_block.sh
index 01811c971d..370c9043bc 100755
--- a/testcases/lib/tests/shell_loader_invalid_block.sh
+++ b/testcases/lib/tests/shell_loader_invalid_block.sh
@@ -22,4 +22,9 @@
 
 . tst_loader.sh
 
-tst_res TPASS "This should pass!"
+tst_test()
+{
+	tst_res TPASS "This should pass!"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_invalid_metadata.sh b/testcases/lib/tests/shell_loader_invalid_metadata.sh
index aeae066841..3834f1b9ed 100755
--- a/testcases/lib/tests/shell_loader_invalid_metadata.sh
+++ b/testcases/lib/tests/shell_loader_invalid_metadata.sh
@@ -14,4 +14,9 @@
 
 . tst_loader.sh
 
-tst_res TFAIL "Shell loader should TBROK the test"
+tst_test()
+{
+	tst_res TFAIL "Shell loader should TBROK the test"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_kconfigs.sh b/testcases/lib/tests/shell_loader_kconfigs.sh
index b896f03ce0..e1b6187554 100755
--- a/testcases/lib/tests/shell_loader_kconfigs.sh
+++ b/testcases/lib/tests/shell_loader_kconfigs.sh
@@ -11,4 +11,9 @@
 
 . tst_loader.sh
 
-tst_res TPASS "Shell loader works fine!"
+tst_test()
+{
+	tst_res TPASS "Shell loader works fine!"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_no_metadata.sh b/testcases/lib/tests/shell_loader_no_metadata.sh
index e344327ed3..b664b48b57 100755
--- a/testcases/lib/tests/shell_loader_no_metadata.sh
+++ b/testcases/lib/tests/shell_loader_no_metadata.sh
@@ -7,4 +7,9 @@
 
 . tst_loader.sh
 
-tst_res TFAIL "Shell loader should TBROK the test"
+tst_test()
+{
+	tst_res TFAIL "Shell loader should TBROK the test"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_supported_archs.sh b/testcases/lib/tests/shell_loader_supported_archs.sh
index 45f0b1b1c2..9ad24f9c03 100755
--- a/testcases/lib/tests/shell_loader_supported_archs.sh
+++ b/testcases/lib/tests/shell_loader_supported_archs.sh
@@ -11,4 +11,9 @@
 
 . tst_loader.sh
 
-tst_res TPASS "We are running on supported architecture"
+tst_test()
+{
+	tst_res TPASS "We are running on supported architecture"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_tags.sh b/testcases/lib/tests/shell_loader_tags.sh
index 0b9416ea9a..c780a66c57 100755
--- a/testcases/lib/tests/shell_loader_tags.sh
+++ b/testcases/lib/tests/shell_loader_tags.sh
@@ -14,4 +14,9 @@
 
 . tst_loader.sh
 
-tst_res TFAIL "Fails the test so that tags are shown."
+tst_test()
+{
+	tst_res TFAIL "Fails the test so that tags are shown."
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_tcnt.sh b/testcases/lib/tests/shell_loader_tcnt.sh
index ecf48396d6..93bd612ee2 100755
--- a/testcases/lib/tests/shell_loader_tcnt.sh
+++ b/testcases/lib/tests/shell_loader_tcnt.sh
@@ -14,4 +14,9 @@
 
 . tst_loader.sh
 
-tst_res TPASS "Iteration $1"
+tst_test()
+{
+	tst_res TPASS "Iteration $1"
+}
+
+tst_test
diff --git a/testcases/lib/tests/shell_loader_wrong_metadata.sh b/testcases/lib/tests/shell_loader_wrong_metadata.sh
index b90b212371..8f18741100 100755
--- a/testcases/lib/tests/shell_loader_wrong_metadata.sh
+++ b/testcases/lib/tests/shell_loader_wrong_metadata.sh
@@ -14,4 +14,9 @@
 
 . tst_loader.sh
 
-tst_res TFAIL "Shell loader should TBROK the test"
+tst_test()
+{
+	tst_res TFAIL "Shell loader should TBROK the test"
+}
+
+tst_test
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
