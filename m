Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CCAC7EE22
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 12:39:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDAE63CD696
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 14:39:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 339C83CB4E4
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:38:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4D79C1400B7C
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:38:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 811681F388
 for <ltp@lists.linux.it>; Wed, 10 May 2023 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683722331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M6QGaNR0Im3jTExdwZo52ggtZ2VWm7L2/utNRe9hXxQ=;
 b=bRUpgk+yHYC3VnpisamoeT7IB8qmeZGJYJrjgRLgtKnUwuIPj7kOSd8NbnRcMK/QSsAYBL
 FFvwB9pUWOyhBAucjvjtydqRXiOGGtu9ccRx50M/hVYSY1L24R6jDDAymBIt3kVKTkIur2
 br0PB6jUGoCwjlID1dbx4a1VIBoqWmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683722331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M6QGaNR0Im3jTExdwZo52ggtZ2VWm7L2/utNRe9hXxQ=;
 b=NKh+mtRc2OumcbcA36P2frZICIdm7Jv77ee7UJ8fdnK6wYBbBCFWTA8stVmqX4RieiLc5D
 QuknqGOlF3zUQYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F47113519
 for <ltp@lists.linux.it>; Wed, 10 May 2023 12:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TF9CGluQW2QddgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 10 May 2023 12:38:51 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 10 May 2023 14:38:49 +0200
Message-Id: <20230510123850.26997-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add tst_getpid() helper function
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

tst_getpid() returns current process ID using direct syscall to bypass
PID caching in some glibc versions. The getpid() cache causes issues
for example in child processes created by direct clone() syscall.

Also use the function in tst_test.c whenever the current test process
may be a child created through unknown means.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_pid.h | 8 ++++++++
 lib/tst_pid.c     | 6 ++++++
 lib/tst_test.c    | 8 ++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/tst_pid.h b/include/tst_pid.h
index 8d999a655..774c845ce 100644
--- a/include/tst_pid.h
+++ b/include/tst_pid.h
@@ -42,4 +42,12 @@ static inline int tst_get_free_pids(void (*cleanup_fn)(void))
 }
 #endif
 
+/*
+ * Direct getpid() syscall. Some glibc versions cache getpid() return value
+ * which can cause confusing issues for example in processes created by
+ * direct clone() syscall (without using the glibc wrapper). Use this function
+ * whenever the current process may be a child of the main test process.
+ */
+pid_t tst_getpid(void);
+
 #endif /* TST_PID_H__ */
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 2fa0c04cd..cfaa5db36 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -30,6 +30,7 @@
 #include "tst_pid.h"
 #include "old_safe_file_ops.h"
 #include "tst_safe_macros.h"
+#include "lapi/syscalls.h"
 
 #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
 #define THREADS_MAX_PATH "/proc/sys/kernel/threads-max"
@@ -160,3 +161,8 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
 	}
 	return max_pids - used_pids;
 }
+
+pid_t tst_getpid(void)
+{
+	return syscall(SYS_getpid);
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 04d6b13bf..04da456c6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -336,7 +336,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
 	 * specified but CLONE_THREAD is not. Use direct syscall to avoid
 	 * cleanup running in the child.
 	 */
-	if (syscall(SYS_getpid) == main_pid)
+	if (tst_getpid() == main_pid)
 		do_test_cleanup();
 
 	if (getpid() == lib_pid)
@@ -1316,7 +1316,7 @@ static void do_test_setup(void)
 	if (tst_test->setup)
 		tst_test->setup();
 
-	if (main_pid != getpid())
+	if (main_pid != tst_getpid())
 		tst_brk(TBROK, "Runaway child in setup()!");
 
 	if (tst_test->caps)
@@ -1379,7 +1379,7 @@ static void run_tests(void)
 		heartbeat();
 		tst_test->test_all();
 
-		if (getpid() != main_pid) {
+		if (tst_getpid() != main_pid) {
 			exit(0);
 		}
 
@@ -1395,7 +1395,7 @@ static void run_tests(void)
 		heartbeat();
 		tst_test->test(i);
 
-		if (getpid() != main_pid) {
+		if (tst_getpid() != main_pid) {
 			exit(0);
 		}
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
