Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EA0C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 21:18:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B62C60FC3
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 21:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B62C60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7FCA3C6E83
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 23:18:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16EEA3C6F18
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 23:18:19 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C499200077
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 23:18:18 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C15AD1F45C6F;
 Fri, 29 Oct 2021 22:18:16 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: jack@suse.com,
	amir73il@gmail.com,
	repnop@google.com
Date: Fri, 29 Oct 2021 18:17:27 -0300
Message-Id: <20211029211732.386127-5-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/9] syscalls/fanotify21: Validate the generic
 error info
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

Implement some validation for the generic error info record emitted by
the kernel.  The error number is fs-specific but, well, we only support
ext4 for now anyway.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - check for error record type in autotools (Amir)
Changes since v1:
  - Move defines to header file.
---
 configure.ac                                  |  3 +-
 testcases/kernel/syscalls/fanotify/fanotify.h | 32 ++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 37 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5bf3c52ec161..9efd5b33430f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -159,7 +159,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
-AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
+		struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 99b898554ede..4294799fe86d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -167,6 +167,9 @@ typedef struct {
 #ifndef FAN_EVENT_INFO_TYPE_DFID
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #endif
+#ifndef FAN_EVENT_INFO_TYPE_ERROR
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#endif
 
 #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
@@ -184,6 +187,14 @@ struct fanotify_event_info_fid {
 };
 #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
 
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
+
 /* NOTE: only for struct fanotify_event_info_fid */
 #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
 # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
@@ -392,4 +403,25 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
 } while (0)
 
+struct fanotify_event_info_header *get_event_info(
+					struct fanotify_event_metadata *event,
+					int info_type)
+{
+	struct fanotify_event_info_header *hdr = NULL;
+	char *start = (char *) event;
+	int off;
+
+	for (off = event->metadata_len; (off+sizeof(*hdr)) < event->event_len;
+	     off += hdr->len) {
+		hdr = (struct fanotify_event_info_header *) &(start[off]);
+		if (hdr->info_type == info_type)
+			return hdr;
+	}
+	return NULL;
+}
+
+#define get_event_info_error(event)					\
+	((struct fanotify_event_info_error *)				\
+	 get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 9ef687442b7c..31ad5cac0a0e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -48,14 +48,38 @@ static void trigger_fs_abort(void)
 
 static struct test_case {
 	char *name;
+	int error;
+	unsigned int error_count;
 	void (*trigger_error)(void);
 } testcases[] = {
 	{
 		.name = "Trigger abort",
 		.trigger_error = &trigger_fs_abort,
+		.error_count = 1,
+		.error = ESHUTDOWN,
 	},
 };
 
+int check_error_event_info_error(struct fanotify_event_info_error *info_error,
+				 const struct test_case *ex)
+{
+	int fail = 0;
+
+	if (info_error->error_count != ex->error_count) {
+		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
+			ex->name, info_error->error_count, ex->error_count);
+		fail++;
+	}
+
+	if (info_error->error != ex->error) {
+		tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
+			ex->name, info_error->error, ex->error);
+		fail++;
+	}
+
+	return fail;
+}
+
 int check_error_event_metadata(struct fanotify_event_metadata *event)
 {
 	int fail = 0;
@@ -78,6 +102,8 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 {
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
+	struct fanotify_event_info_error *info_error;
+	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN) {
 		tst_res(TFAIL, "No event metadata found");
@@ -87,7 +113,16 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	if (check_error_event_metadata(event))
 		return;
 
-	tst_res(TPASS, "Successfully received: %s", ex->name);
+	info_error = get_event_info_error(event);
+	if (info_error)
+		fail += check_error_event_info_error(info_error, ex);
+	else {
+		tst_res(TFAIL, "Generic error record not found");
+		fail++;
+	}
+
+	if (!fail)
+		tst_res(TPASS, "Successfully received: %s", ex->name);
 }
 
 static void do_test(unsigned int i)
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
