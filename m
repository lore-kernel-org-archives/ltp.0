Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D771C07E97
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 11:55:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53D3B3CD962
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 12:55:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 209283CD953
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 452D6600F2F
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AA341FCE9;
 Wed, 29 Nov 2023 11:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701258885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7M0aEpgAEDU++BJkP0RXCCrapRcuRjLy4QkRvTt4PQQ=;
 b=tsHDxUPClCijbzudyJOVAzItrbthPmTyRdG12BIA2lWmrR4LdSuGFU/L0EVxSEoegNQrpY
 FOP04nnAhIUJSOFs4gHww8jMoLD+EM9GKiUhjR6KyRP7RH2zZVOEEE4v6NN+NJvs/iOirR
 YC+JLRzxPM7YrhfSDKH2HpvzH0/6l+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701258885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7M0aEpgAEDU++BJkP0RXCCrapRcuRjLy4QkRvTt4PQQ=;
 b=YPa3zKuQyb6EgDxn5dBJf5sruMy1Opx0plBuygxn69iTfJYMNviXSUE9w2p/LMeC395I60
 vkDliPsEsMxHGtAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F2DCB13B46;
 Wed, 29 Nov 2023 11:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id kuBLO4QmZ2VPfwAAn2gu4w
 (envelope-from <jack@suse.cz>); Wed, 29 Nov 2023 11:54:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 99B55A03C7; Wed, 29 Nov 2023 12:54:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 12:54:29 +0100
Message-Id: <20231129115440.19100-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231129114617.12660-1-jack@suse.cz>
References: <20231129114617.12660-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] fanotify: Generalize helper
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
 testcases/kernel/syscalls/fanotify/fanotify.h | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 32b510cdc178..ee74c2fffbd5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -176,17 +176,20 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask,
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
+						 unsigned int event_flags,
+						 const char *fname)
 {
 	int fd;
 	int rval = 0;
 
-	fd = fanotify_init(flags, O_RDONLY);
+	fd = fanotify_init(init_flags, O_RDONLY);
 
 	if (fd < 0) {
 		if (errno == ENOSYS)
@@ -198,7 +201,7 @@ static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const
 		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
 	}
 
-	if (fname && fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
+	if (fname && fanotify_mark(fd, FAN_MARK_ADD | mark_flags, event_flags, AT_FDCWD, fname) < 0) {
 		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
 			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
 		} else {
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
