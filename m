Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC24C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 18:43:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9048600CD
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 18:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9048600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 401563C6878
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 20:43:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BAFF3C6A02
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 20:43:28 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0F578100054F
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 20:43:27 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B4E661F43877;
 Tue, 26 Oct 2021 19:43:24 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: ltp@lists.linux.it,
	jack@suse.com,
	amir73il@gmail.com
Date: Tue, 26 Oct 2021 15:42:31 -0300
Message-Id: <20211026184239.151156-3-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/10] syscalls: fanotify: Add macro to require
 specific events
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
Cc: linux-ext4@vger.kernel.org, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>, khazhy@google.com,
 repnop@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a helper for tests to fail if an event is not available in the
kernel.  Since some events only work with REPORT_FID or a specific
class, update the verifier to allow those to be specified.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 28 +++++++++++++++++--
 .../kernel/syscalls/fanotify/fanotify03.c     |  4 +--
 .../kernel/syscalls/fanotify/fanotify10.c     |  3 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |  3 +-
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index c67db3117e29..b2b56466d028 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -266,14 +266,26 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
 	SAFE_CLOSE(fd);
 }
 
-static inline int fanotify_events_supported_by_kernel(uint64_t mask)
+static inline int fanotify_events_supported_by_kernel(uint64_t mask,
+						      unsigned int init_flags,
+						      unsigned int mark_flags)
 {
 	int fd;
 	int rval = 0;
 
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+	fd = fanotify_init(init_flags, O_RDONLY);
 
-	if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
+	if (fd < 0) {
+		if (errno == EINVAL) {
+			rval = -1;
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_init (%d, FAN_CLASS_CONTENT, ..., 0_RDONLY", fd);
+		}
+		goto out;
+	}
+
+	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
 		if (errno == EINVAL) {
 			rval = -1;
 		} else {
@@ -284,6 +296,7 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask)
 
 	SAFE_CLOSE(fd);
 
+out:
 	return rval;
 }
 
@@ -378,4 +391,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 				    fanotify_mark_supported_by_kernel(mark_type)); \
 } while (0)
 
+#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
+	if (mark_type)							\
+		REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);	\
+	if (init_flags)							\
+		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
+	fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
+		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
+} while (0)
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 26d17e64d1f5..2081f0bd1b57 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -323,8 +323,8 @@ static void setup(void)
 	require_fanotify_access_permissions_supported_by_kernel();
 
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
-	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
-
+	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
+								      FAN_CLASS_CONTENT, 0);
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 92e4d3ff3054..0fa9d1f4f7e4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -509,7 +509,8 @@ cleanup:
 
 static void setup(void)
 {
-	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
+	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
+								      FAN_CLASS_CONTENT, 0);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
 									  MOUNT_PATH);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 76f1aca77615..d863ae1a7d6d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -222,7 +222,8 @@ cleanup:
 
 static void do_setup(void)
 {
-	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
+	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
+								      FAN_CLASS_CONTENT, 0);
 
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
