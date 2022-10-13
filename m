Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BCAC4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:50:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C21A3CAEFD
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 17:50:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BB983CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 17:49:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA015601BEB
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 17:49:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ED4720ABC;
 Thu, 13 Oct 2022 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665676176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4G89Vb5QAiMdmwubbhIhd9u8qBhorAKOxQiom88/uTs=;
 b=AxFHHaYXdJ+oT6w6da4ZzQKiDg2F5ENnyETNUlMPOdU5ajQwpb+3rh1C+CNQ6g17pcg06h
 quoAH/9js4hdYVC7uqoifymBZakTX8GKcuKaUwE/4ZuVqYQJVZUEoxvlLoE+nofUtQGdlj
 +zFrKZDYofT3T4cvcj/c9v4pXG6+KJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665676176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4G89Vb5QAiMdmwubbhIhd9u8qBhorAKOxQiom88/uTs=;
 b=ftas0x5qiouaP92IzVolc2gyprG5UsC3N4JzBtQNSdNit9CMKZKUd90nLqdURvLF1KvqNK
 XzjlB9Qp233pxSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EF1113AAA;
 Thu, 13 Oct 2022 15:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6CcjDpAzSGMnDQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 13 Oct 2022 15:49:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 13 Oct 2022 17:49:33 +0200
Message-Id: <20221013154935.20461-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013154935.20461-1-mdoucha@suse.cz>
References: <20221013154935.20461-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] Move fanotify fallback constants and structs to
 LAPI header
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/fanotify.h                       | 210 ++++++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify.h | 199 +----------------
 2 files changed, 211 insertions(+), 198 deletions(-)
 create mode 100644 include/lapi/fanotify.h

diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
new file mode 100644
index 000000000..e27cced3f
--- /dev/null
+++ b/include/lapi/fanotify.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2012-2020 Linux Test Project.  All Rights Reserved.
+ * Author: Jan Kara, November 2013
+ */
+
+#ifndef	LAPI_FANOTIFY_H__
+#define	LAPI_FANOTIFY_H__
+
+#include "config.h"
+#include <sys/fanotify.h>
+
+#ifndef FAN_REPORT_TID
+#define FAN_REPORT_TID		0x00000100
+#endif
+#ifndef FAN_REPORT_FID
+#define FAN_REPORT_FID		0x00000200
+#endif
+#ifndef FAN_REPORT_DIR_FID
+#define FAN_REPORT_DIR_FID	0x00000400
+#endif
+#ifndef FAN_REPORT_NAME
+#define FAN_REPORT_NAME		0x00000800
+#define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
+#endif
+#ifndef FAN_REPORT_PIDFD
+#define FAN_REPORT_PIDFD	0x00000080
+#endif
+#ifndef FAN_REPORT_TARGET_FID
+#define FAN_REPORT_TARGET_FID	0x00001000
+#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
+				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
+#endif
+
+/* Non-uapi convenience macros */
+#ifndef FAN_REPORT_DFID_NAME_FID
+#define FAN_REPORT_DFID_NAME_FID (FAN_REPORT_DFID_NAME | FAN_REPORT_FID)
+#endif
+#ifndef FAN_REPORT_DFID_FID
+#define FAN_REPORT_DFID_FID      (FAN_REPORT_DIR_FID | FAN_REPORT_FID)
+#endif
+
+#ifndef FAN_MARK_INODE
+#define FAN_MARK_INODE		0
+#endif
+#ifndef FAN_MARK_FILESYSTEM
+#define FAN_MARK_FILESYSTEM	0x00000100
+#endif
+#ifndef FAN_MARK_EVICTABLE
+#define FAN_MARK_EVICTABLE	0x00000200
+#endif
+#ifndef FAN_MARK_IGNORE
+#define FAN_MARK_IGNORE		0x00000400
+#endif
+#ifndef FAN_MARK_IGNORE_SURV
+#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
+#endif
+/* Non-uapi convenience macros */
+#ifndef FAN_MARK_IGNORED_SURV
+#define FAN_MARK_IGNORED_SURV	(FAN_MARK_IGNORED_MASK | \
+				FAN_MARK_IGNORED_SURV_MODIFY)
+#endif
+#ifndef FAN_MARK_PARENT
+#define FAN_MARK_PARENT		FAN_MARK_ONLYDIR
+#endif
+#ifndef FAN_MARK_SUBDIR
+#define FAN_MARK_SUBDIR		FAN_MARK_ONLYDIR
+#endif
+#ifndef FAN_MARK_TYPES
+#define FAN_MARK_TYPES (FAN_MARK_INODE | FAN_MARK_MOUNT | FAN_MARK_FILESYSTEM)
+#endif
+
+/* New dirent event masks */
+#ifndef FAN_ATTRIB
+#define FAN_ATTRIB		0x00000004
+#endif
+#ifndef FAN_MOVED_FROM
+#define FAN_MOVED_FROM		0x00000040
+#endif
+#ifndef FAN_MOVED_TO
+#define FAN_MOVED_TO		0x00000080
+#endif
+#ifndef FAN_CREATE
+#define FAN_CREATE		0x00000100
+#endif
+#ifndef FAN_DELETE
+#define FAN_DELETE		0x00000200
+#endif
+#ifndef FAN_DELETE_SELF
+#define FAN_DELETE_SELF		0x00000400
+#endif
+#ifndef FAN_MOVE_SELF
+#define FAN_MOVE_SELF		0x00000800
+#endif
+#ifndef FAN_MOVE
+#define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO)
+#endif
+#ifndef FAN_OPEN_EXEC
+#define FAN_OPEN_EXEC		0x00001000
+#endif
+#ifndef FAN_OPEN_EXEC_PERM
+#define FAN_OPEN_EXEC_PERM	0x00040000
+#endif
+#ifndef FAN_FS_ERROR
+#define FAN_FS_ERROR		0x00008000
+#endif
+#ifndef FAN_RENAME
+#define FAN_RENAME		0x10000000
+#endif
+
+/* Additional error status codes that can be returned to userspace */
+#ifndef FAN_NOPIDFD
+#define FAN_NOPIDFD		-1
+#endif
+#ifndef FAN_EPIDFD
+#define FAN_EPIDFD		-2
+#endif
+
+/* Flags required for unprivileged user group */
+#define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
+
+/*
+ * FAN_ALL_PERM_EVENTS has been deprecated, so any new permission events
+ * are not to be added to it. To cover the instance where a new permission
+ * event is defined, we create a new macro that is to include all
+ * permission events. Any new permission events should be added to this
+ * macro.
+ */
+#define LTP_ALL_PERM_EVENTS	(FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
+				 FAN_ACCESS_PERM)
+
+struct fanotify_group_type {
+	unsigned int flag;
+	const char *name;
+};
+
+struct fanotify_mark_type {
+	unsigned int flag;
+	const char *name;
+};
+
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} lapi_fsid_t;
+#define __kernel_fsid_t lapi_fsid_t
+#endif /* __kernel_fsid_t */
+
+#ifndef FAN_EVENT_INFO_TYPE_FID
+#define FAN_EVENT_INFO_TYPE_FID		1
+#endif
+#ifndef FAN_EVENT_INFO_TYPE_DFID_NAME
+#define FAN_EVENT_INFO_TYPE_DFID_NAME	2
+#endif
+#ifndef FAN_EVENT_INFO_TYPE_DFID
+#define FAN_EVENT_INFO_TYPE_DFID	3
+#endif
+#ifndef FAN_EVENT_INFO_TYPE_PIDFD
+#define FAN_EVENT_INFO_TYPE_PIDFD	4
+#endif
+#ifndef FAN_EVENT_INFO_TYPE_ERROR
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#endif
+
+#ifndef FAN_EVENT_INFO_TYPE_OLD_DFID_NAME
+#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
+#endif
+#ifndef FAN_EVENT_INFO_TYPE_NEW_DFID_NAME
+#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME	12
+#endif
+
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
+struct fanotify_event_info_header {
+	uint8_t info_type;
+	uint8_t pad;
+	uint16_t len;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER */
+
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID
+struct fanotify_event_info_fid {
+	struct fanotify_event_info_header hdr;
+	__kernel_fsid_t fsid;
+	unsigned char handle[0];
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
+
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD
+struct fanotify_event_info_pidfd {
+	struct fanotify_event_info_header hdr;
+	int32_t pidfd;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD */
+
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
+
+/* NOTE: only for struct fanotify_event_info_fid */
+#ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
+# define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
+#else
+# define FSID_VAL_MEMBER(fsid, i) (fsid.val[i])
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL */
+
+#endif /* LAPI_FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index ff2b4a70a..51078103e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -7,12 +7,11 @@
 #ifndef	__FANOTIFY_H__
 #define	__FANOTIFY_H__
 
-#include "config.h"
 #include <sys/statfs.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
-#include <sys/fanotify.h>
+#include "lapi/fanotify.h"
 #include "lapi/fcntl.h"
 
 static inline int safe_fanotify_init(const char *file, const int lineno,
@@ -67,202 +66,6 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #define SAFE_FANOTIFY_INIT(fan, mode)  \
 	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
 
-#ifndef FAN_REPORT_TID
-#define FAN_REPORT_TID		0x00000100
-#endif
-#ifndef FAN_REPORT_FID
-#define FAN_REPORT_FID		0x00000200
-#endif
-#ifndef FAN_REPORT_DIR_FID
-#define FAN_REPORT_DIR_FID	0x00000400
-#endif
-#ifndef FAN_REPORT_NAME
-#define FAN_REPORT_NAME		0x00000800
-#define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
-#endif
-#ifndef FAN_REPORT_PIDFD
-#define FAN_REPORT_PIDFD	0x00000080
-#endif
-#ifndef FAN_REPORT_TARGET_FID
-#define FAN_REPORT_TARGET_FID	0x00001000
-#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
-				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
-#endif
-
-/* Non-uapi convenience macros */
-#ifndef FAN_REPORT_DFID_NAME_FID
-#define FAN_REPORT_DFID_NAME_FID (FAN_REPORT_DFID_NAME | FAN_REPORT_FID)
-#endif
-#ifndef FAN_REPORT_DFID_FID
-#define FAN_REPORT_DFID_FID      (FAN_REPORT_DIR_FID | FAN_REPORT_FID)
-#endif
-
-#ifndef FAN_MARK_INODE
-#define FAN_MARK_INODE		0
-#endif
-#ifndef FAN_MARK_FILESYSTEM
-#define FAN_MARK_FILESYSTEM	0x00000100
-#endif
-#ifndef FAN_MARK_EVICTABLE
-#define FAN_MARK_EVICTABLE	0x00000200
-#endif
-#ifndef FAN_MARK_IGNORE
-#define FAN_MARK_IGNORE		0x00000400
-#endif
-#ifndef FAN_MARK_IGNORE_SURV
-#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
-#endif
-/* Non-uapi convenience macros */
-#ifndef FAN_MARK_IGNORED_SURV
-#define FAN_MARK_IGNORED_SURV	(FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY)
-#endif
-#ifndef FAN_MARK_PARENT
-#define FAN_MARK_PARENT		FAN_MARK_ONLYDIR
-#endif
-#ifndef FAN_MARK_SUBDIR
-#define FAN_MARK_SUBDIR		FAN_MARK_ONLYDIR
-#endif
-#ifndef FAN_MARK_TYPES
-#define FAN_MARK_TYPES (FAN_MARK_INODE | FAN_MARK_MOUNT | FAN_MARK_FILESYSTEM)
-#endif
-
-/* New dirent event masks */
-#ifndef FAN_ATTRIB
-#define FAN_ATTRIB		0x00000004
-#endif
-#ifndef FAN_MOVED_FROM
-#define FAN_MOVED_FROM		0x00000040
-#endif
-#ifndef FAN_MOVED_TO
-#define FAN_MOVED_TO		0x00000080
-#endif
-#ifndef FAN_CREATE
-#define FAN_CREATE		0x00000100
-#endif
-#ifndef FAN_DELETE
-#define FAN_DELETE		0x00000200
-#endif
-#ifndef FAN_DELETE_SELF
-#define FAN_DELETE_SELF		0x00000400
-#endif
-#ifndef FAN_MOVE_SELF
-#define FAN_MOVE_SELF		0x00000800
-#endif
-#ifndef FAN_MOVE
-#define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO)
-#endif
-#ifndef FAN_OPEN_EXEC
-#define FAN_OPEN_EXEC		0x00001000
-#endif
-#ifndef FAN_OPEN_EXEC_PERM
-#define FAN_OPEN_EXEC_PERM	0x00040000
-#endif
-#ifndef FAN_FS_ERROR
-#define FAN_FS_ERROR		0x00008000
-#endif
-#ifndef FAN_RENAME
-#define FAN_RENAME		0x10000000
-#endif
-
-/* Additional error status codes that can be returned to userspace */
-#ifndef FAN_NOPIDFD
-#define FAN_NOPIDFD		-1
-#endif
-#ifndef FAN_EPIDFD
-#define FAN_EPIDFD		-2
-#endif
-
-/* Flags required for unprivileged user group */
-#define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
-
-/*
- * FAN_ALL_PERM_EVENTS has been deprecated, so any new permission events
- * are not to be added to it. To cover the instance where a new permission
- * event is defined, we create a new macro that is to include all
- * permission events. Any new permission events should be added to this
- * macro.
- */
-#define LTP_ALL_PERM_EVENTS	(FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
-				 FAN_ACCESS_PERM)
-
-struct fanotify_group_type {
-	unsigned int flag;
-	const char *name;
-};
-
-struct fanotify_mark_type {
-	unsigned int flag;
-	const char *name;
-};
-
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} lapi_fsid_t;
-#define __kernel_fsid_t lapi_fsid_t
-#endif /* __kernel_fsid_t */
-
-#ifndef FAN_EVENT_INFO_TYPE_FID
-#define FAN_EVENT_INFO_TYPE_FID		1
-#endif
-#ifndef FAN_EVENT_INFO_TYPE_DFID_NAME
-#define FAN_EVENT_INFO_TYPE_DFID_NAME	2
-#endif
-#ifndef FAN_EVENT_INFO_TYPE_DFID
-#define FAN_EVENT_INFO_TYPE_DFID	3
-#endif
-#ifndef FAN_EVENT_INFO_TYPE_PIDFD
-#define FAN_EVENT_INFO_TYPE_PIDFD	4
-#endif
-#ifndef FAN_EVENT_INFO_TYPE_ERROR
-#define FAN_EVENT_INFO_TYPE_ERROR	5
-#endif
-
-#ifndef FAN_EVENT_INFO_TYPE_OLD_DFID_NAME
-#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
-#endif
-#ifndef FAN_EVENT_INFO_TYPE_NEW_DFID_NAME
-#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME	12
-#endif
-
-#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
-struct fanotify_event_info_header {
-	uint8_t info_type;
-	uint8_t pad;
-	uint16_t len;
-};
-#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER */
-
-#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID
-struct fanotify_event_info_fid {
-	struct fanotify_event_info_header hdr;
-	__kernel_fsid_t fsid;
-	unsigned char handle[0];
-};
-#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
-
-#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD
-struct fanotify_event_info_pidfd {
-	struct fanotify_event_info_header hdr;
-	int32_t pidfd;
-};
-#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD */
-
-#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
-struct fanotify_event_info_error {
-	struct fanotify_event_info_header hdr;
-	__s32 error;
-	__u32 error_count;
-};
-#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
-
-/* NOTE: only for struct fanotify_event_info_fid */
-#ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
-# define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
-#else
-# define FSID_VAL_MEMBER(fsid, i) (fsid.val[i])
-#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL */
-
 #ifdef HAVE_NAME_TO_HANDLE_AT
 
 #ifndef MAX_HANDLE_SZ
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
