Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9F4C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 12:59:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B49D33CCD0C
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 14:59:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4283C6CFE
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3641D2009DC
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 568A91F788;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4pj+m4w0z/KZEGLLUqUfEi9tfc8XCUmVmxt/TQPRLM=;
 b=E001/QdfNYemcKm9WxTqxPHN65cO16hxtf3rRfnkBKvReHg6PNaFcw1MrPLWsKX3kggf9h
 KuZO8tmjVkFmJOu+oBD/sbeAqiWJuA9wwI3VBZjNTFFJ07o0XxVjJ6VLyE+SKxodiw0BlJ
 gM5OYQtDNJzXPfcB4OONWWs+4TDzw9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4pj+m4w0z/KZEGLLUqUfEi9tfc8XCUmVmxt/TQPRLM=;
 b=4vnsYBuRuOahjcCq7VdNt4ew/q3fO19CZTLLpfqMjmS+hrQxIHhBTHndcJIFXAJPr4oRyr
 J+4KWU7OXYM/qACQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4pj+m4w0z/KZEGLLUqUfEi9tfc8XCUmVmxt/TQPRLM=;
 b=E001/QdfNYemcKm9WxTqxPHN65cO16hxtf3rRfnkBKvReHg6PNaFcw1MrPLWsKX3kggf9h
 KuZO8tmjVkFmJOu+oBD/sbeAqiWJuA9wwI3VBZjNTFFJ07o0XxVjJ6VLyE+SKxodiw0BlJ
 gM5OYQtDNJzXPfcB4OONWWs+4TDzw9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4pj+m4w0z/KZEGLLUqUfEi9tfc8XCUmVmxt/TQPRLM=;
 b=4vnsYBuRuOahjcCq7VdNt4ew/q3fO19CZTLLpfqMjmS+hrQxIHhBTHndcJIFXAJPr4oRyr
 J+4KWU7OXYM/qACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26E1113A7E;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yKd4CDCLf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:12 +0200
Message-ID: <20250722125916.74967-3-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/6] shell: Move shell code into functions
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

NOTE: it's important to properly quote strings when assign with local.
Otherwise shell_loader_all_filesystems.sh fails on old dash 0.5.8-2.10 on local export:

/__w/ltp/ltp/testcases/lib/tests//shell_loader_all_filesystems.sh: 20: local: /tmp/LTP_sheiFmNGP/ltp_mntpoint: bad variable name

Quote grep subcomand helps. While at it quote also realpath subcomand.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

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
index 91fac89fd6..8fe3809a5e 100755
--- a/testcases/lib/tests/shell_loader_all_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
@@ -14,16 +14,22 @@
 
 . tst_loader.sh
 
-tst_res TINFO "In shell"
+tst_test()
+{
+	local mntpath="$(realpath ltp_mntpoint)"
+	local mounted="$(grep $mntpath /proc/mounts)"
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
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
