Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EEEC4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:37:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80DB83CF630
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:37:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B25D03CD5A6
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C12181A027B7
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFAF521AB5;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701337031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2YYp8qHsFTO33Hh/wm4VIZV5A+16yX+DzxLsqCg6t4=;
 b=oiYB930JbFMoL5FVzDjqAm7Kw6WMpMr06lWv8qj3stNNS/y13kt368DCpmkFTJi4K3fI9w
 mkz24UeMcg5uiB6YhpQjaslw+jIF67v7vawl/FuuJIocsnx8hDzIK0hFWqHdFPVXDoQhWf
 bREqdipDA49UXqFvI47+8ZQmbyGuEAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701337031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2YYp8qHsFTO33Hh/wm4VIZV5A+16yX+DzxLsqCg6t4=;
 b=DIHL6SdUH91zgZX1lads1tTrPGtk/BaQmFSdEeqzv2Bp3JNsnCSfsaBOX0tmVZDQQUTthZ
 yyFH/WbHFjd5qYBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BED3413B3E;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id O+mRLsdXaGVVKAAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:37:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 49A2AA07E5; Thu, 30 Nov 2023 10:37:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 10:37:04 +0100
Message-Id: <20231130093711.20171-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231130093533.10036-1-jack@suse.cz>
References: <20231130093533.10036-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] fanotify: Generalize helper
 fanotify_flags_supported_on_fs()
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Amir Goldstein <amir73il@gmail.com>

The helper fanotify_init_flags_supported_on_fs() is used to check if
fanotify init flags (usually FAN_REPORT_FID) are supported by kernel
and on a specific filesystem.

The helper fanotify_mark_supported_by_kernel() does not check for
support on a specific filesystem.

There are now specific filesystems (e.g. overlayfs, fuse) that do
not support FAN_REPORT_FID, but not with filesystem and mount mark types.

Generelize the helper fanotify_init_flags_supported_on_fs() to be used
to check also support for mark flags and event flags on a specific
filesystem.

The helper fanotify_init_flags_err_msg() was also renamed to reflect the
fact that it is already used to report an error message for mark flags
and handle flags, not only init flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 55 +++++++++++--------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 32b510cdc178..f34440e0bd41 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -176,35 +176,38 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask,
 }
 
 /*
- * @return  0: fanotify supported both in kernel and on tested filesystem
- * @return -1: @flags not supported in kernel
- * @return -2: @flags not supported on tested filesystem (tested if @fname is not NULL)
- * @return -3: @flags not supported on overlayfs (tested if @fname == OVL_MNT)
+ * @return  0: fanotify flags supported both in kernel and on tested filesystem
+ * @return -1: @init_flags not supported in kernel
+ * @return -2: @mark_flags not supported on tested filesystem (tested if @fname is not NULL)
+ * @return -3: @mark_flags not supported on overlayfs (tested if @fname == OVL_MNT)
  */
-static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const char *fname)
+static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
+						 unsigned int mark_flags,
+						 uint64_t event_flags,
+						 const char *fname)
 {
 	int fd;
 	int rval = 0;
 
-	fd = fanotify_init(flags, O_RDONLY);
+	fd = fanotify_init(init_flags, O_RDONLY);
 
 	if (fd < 0) {
 		if (errno == ENOSYS)
 			tst_brk(TCONF, "fanotify not configured in kernel");
-
-		if (errno == EINVAL)
-			return -1;
-
-		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
+		if (errno != EINVAL)
+			tst_brk(TBROK | TERRNO, "fanotify_init() failed");
+		return -1;
 	}
 
-	if (fname && fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
+	if (fname && fanotify_mark(fd, FAN_MARK_ADD | mark_flags, event_flags, AT_FDCWD, fname) < 0) {
 		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
 			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
-		} else {
+		} else if (errno != EINVAL) {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, %s) failed",
 				fd, fname);
+		} else {
+			rval = -1;
 		}
 	}
 
@@ -213,6 +216,11 @@ static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const
 	return rval;
 }
 
+static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const char *fname)
+{
+	return fanotify_flags_supported_on_fs(flags, FAN_MARK_INODE, FAN_ACCESS, fname);
+}
+
 static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
 {
 	return fanotify_init_flags_supported_on_fs(flags, NULL);
@@ -264,7 +272,7 @@ static inline unsigned int fanotify_get_supported_init_flags(unsigned int flags,
 typedef void (*tst_res_func_t)(const char *file, const int lineno,
 			       int ttype, const char *fmt, ...);
 
-static inline void fanotify_init_flags_err_msg(const char *flags_str,
+static inline void fanotify_flags_err_msg(const char *flags_str,
 	const char *file, const int lineno, tst_res_func_t res_func, int fail)
 {
 	if (fail == -1)
@@ -278,14 +286,17 @@ static inline void fanotify_init_flags_err_msg(const char *flags_str,
 }
 
 #define FANOTIFY_INIT_FLAGS_ERR_MSG(flags, fail) \
-	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_res_, (fail))
+	fanotify_flags_err_msg(#flags, __FILE__, __LINE__, tst_res_, (fail))
+
+#define FANOTIFY_MARK_FLAGS_ERR_MSG(mark, fail) \
+	fanotify_flags_err_msg((mark)->name, __FILE__, __LINE__, tst_res_, (fail))
 
 #define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(flags, fname) \
-	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
+	fanotify_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
 		fanotify_init_flags_supported_on_fs(flags, fname))
 
 #define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(flags) \
-	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
+	fanotify_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
 		fanotify_init_flags_supported_by_kernel(flags))
 
 static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
@@ -323,19 +334,19 @@ static inline int fanotify_handle_supported_by_kernel(int flag)
 }
 
 #define REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type) \
-	fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
-				    fanotify_mark_supported_by_kernel(mark_type))
+	fanotify_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
+		fanotify_mark_supported_by_kernel(mark_type))
 
 #define REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(handle_type) \
-	fanotify_init_flags_err_msg(#handle_type, __FILE__, __LINE__, tst_brk_, \
-				    fanotify_handle_supported_by_kernel(handle_type))
+	fanotify_flags_err_msg(#handle_type, __FILE__, __LINE__, tst_brk_, \
+		fanotify_handle_supported_by_kernel(handle_type))
 
 #define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
 	if (mark_type)							\
 		REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type);	\
 	if (init_flags)							\
 		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
-	fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
+	fanotify_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
 		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
 } while (0)
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
