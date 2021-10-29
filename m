Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139FC433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 21:19:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB9A60FC3
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 21:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADB9A60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A74F3C6F14
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 23:18:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 602403C6F23
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 23:18:25 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7ACFB603A59
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 23:18:24 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3F7261F45C6F;
 Fri, 29 Oct 2021 22:18:22 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: jack@suse.com,
	amir73il@gmail.com,
	repnop@google.com
Date: Fri, 29 Oct 2021 18:17:28 -0300
Message-Id: <20211029211732.386127-6-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/9] syscalls/fanotify21: Validate incoming FID in
 FAN_FS_ERROR
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
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify the FID provided in the event.  If the FH has size 0, this is
assumed to be a superblock error (i.e. null FH).

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Move FILEID_INVALID define to header file (Amir)
Changes since v1:
  - Move defines to header file.
  - Use 0-len FH for sb error
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  9 +++
 .../kernel/syscalls/fanotify/fanotify21.c     | 60 +++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 4294799fe86d..f8c39aa490ae 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -234,6 +234,11 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 	}
 }
 
+
+#ifndef FILEID_INVALID
+#define	FILEID_INVALID		0xff
+#endif
+
 struct fanotify_fid_t {
 	__kernel_fsid_t fsid;
 	struct file_handle handle;
@@ -424,4 +429,8 @@ struct fanotify_event_info_header *get_event_info(
 	((struct fanotify_event_info_error *)				\
 	 get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
 
+#define get_event_info_fid(event)					\
+	((struct fanotify_event_info_fid *)				\
+	 get_event_info((event), FAN_EVENT_INFO_TYPE_FID))
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 31ad5cac0a0e..95c988821a34 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -40,6 +40,9 @@ int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
 
+/* These expected FIDs are common to multiple tests */
+static struct fanotify_fid_t null_fid;
+
 static void trigger_fs_abort(void)
 {
        SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
@@ -50,6 +53,7 @@ static struct test_case {
 	char *name;
 	int error;
 	unsigned int error_count;
+	struct fanotify_fid_t *fid;
 	void (*trigger_error)(void);
 } testcases[] = {
 	{
@@ -57,9 +61,43 @@ static struct test_case {
 		.trigger_error = &trigger_fs_abort,
 		.error_count = 1,
 		.error = ESHUTDOWN,
+		.fid = &null_fid,
 	},
 };
 
+int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
+				 const struct test_case *ex)
+{
+	struct file_handle *fh = (struct file_handle *) &fid->handle;
+
+	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
+		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
+			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
+			FSID_VAL_MEMBER(ex->fid->fsid, 0));
+
+		return 1;
+	}
+	if (fh->handle_type != ex->fid->handle.handle_type) {
+		tst_res(TFAIL, "%s: Received bad file_handle type (%d!=%d)",
+			ex->name, fh->handle_type, ex->fid->handle.handle_type);
+		return 1;
+	}
+
+	if (fh->handle_bytes != ex->fid->handle.handle_bytes) {
+		tst_res(TFAIL, "%s: Received bad file_handle len (%d!=%d)",
+			ex->name, fh->handle_bytes, ex->fid->handle.handle_bytes);
+		return 1;
+	}
+
+	if (memcmp(fh->f_handle, ex->fid->handle.f_handle, fh->handle_bytes)) {
+		tst_res(TFAIL, "%s: Received wrong handle. "
+			"Expected (%x...) got (%x...) ", ex->name,
+			*(int*)ex->fid->handle.f_handle, *(int*)fh->f_handle);
+		return 1;
+	}
+	return 0;
+}
+
 int check_error_event_info_error(struct fanotify_event_info_error *info_error,
 				 const struct test_case *ex)
 {
@@ -103,6 +141,7 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
 	struct fanotify_event_info_error *info_error;
+	struct fanotify_event_info_fid *info_fid;
 	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN) {
@@ -121,6 +160,14 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 		fail++;
 	}
 
+	info_fid = get_event_info_fid(event);
+	if (info_fid)
+		fail += check_error_event_info_fid(info_fid, ex);
+	else {
+		tst_res(TFAIL, "FID record not found");
+		fail++;
+	}
+
 	if (!fail)
 		tst_res(TPASS, "Successfully received: %s", ex->name);
 }
@@ -143,12 +190,25 @@ static void do_test(unsigned int i)
 	check_event(event_buf, read_len, tcase);
 }
 
+static void init_null_fid(void)
+{
+	/* Use fanotify_save_fid to fill the fsid and overwrite the
+	 * file_handler to create a null_fid
+	 */
+	fanotify_save_fid(MOUNT_PATH, &null_fid);
+
+	null_fid.handle.handle_type = FILEID_INVALID;
+	null_fid.handle.handle_bytes = 0;
+}
+
 static void setup(void)
 {
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
 						FAN_FS_ERROR, ".");
 
+	init_null_fid();
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 				       O_RDONLY);
 }
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
