Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5DC433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B50F6113D
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 23:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B50F6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87EF43C89AD
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 00:58:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E7133C8989
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:58:09 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 422306020DA
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 00:58:07 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 431EE1F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637279887; bh=AX3c9fTCJEBoDqzWZ2+ck+gWbQoU+iauYve/clPEhL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m5h96OWWiYow1z8Fvhs2NOGEhNQNzzuzzZ9vUADl7JqPgHADheeSVpaK7eH7rJHga
 5e3WhTN03xLWuJuedwK+LzdEL+sEf2DXWLr8BQe8YDpAo2MPoCO/bAmfDlDjBMc7bc
 hYGtw++ONWbCbZOTeujgr79jT3Ini7eYOThsZ+Jq6QKFn4dSt5G7wKKKgXiz18vvGk
 LmkbxxyLMm/1p+GzCCOJFvImo7lNslS1TC9QizNuxfZwU+gKlbuD08nCU52lVtP518
 mu/s0gX0V0ZSY0k0tclgA4mvS1DfIo+VgIuyqL6avdN5wB5MdWDTrL0QqNJB1A/oMk
 Gh8fWO1Pyb5Qw==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: pvorel@suse.cz,
	jack@suse.com,
	amir73il@gmail.com,
	repnop@google.com
Date: Thu, 18 Nov 2021 18:57:39 -0500
Message-Id: <20211118235744.802584-5-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/9] syscalls/fanotify22: Validate the generic
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, linux-ext4@vger.kernel.org,
 kernel@collabora.com, ltp@lists.linux.it, khazhy@google.com
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
 .../kernel/syscalls/fanotify/fanotify22.c     | 37 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 859aa9857021..a9dc2524966d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -160,7 +160,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
-AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
+		struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 3a8f950950e0..6b0e68a23a6b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -181,6 +181,9 @@ typedef struct {
 #ifndef FAN_EVENT_INFO_TYPE_PIDFD
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #endif
+#ifndef FAN_EVENT_INFO_TYPE_ERROR
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#endif
 
 #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
@@ -205,6 +208,14 @@ struct fanotify_event_info_pidfd {
 };
 #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD */
 
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
@@ -418,4 +429,25 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
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
diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 55e695b133d6..d324191c28c8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
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
