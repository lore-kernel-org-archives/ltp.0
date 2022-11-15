Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3275EC433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:48:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69F743CD14A
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 13:48:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1904E3CD10D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE3B3600795
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AEE622D1E;
 Tue, 15 Nov 2022 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668516462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufZL7REvSbZ5VA8G2uVTNbE6E5v5zJ/UH9/vWEjfP2A=;
 b=k/6YStJPV/k9wLYORy6nzIGJyK78W25rjtyTQ6PYZ5AQtJEV9ZYOJ8nHgqKvyQPJQFdPbp
 qDC6EKvOeX1rOiBWWpfx7bQte3WcrppSGdY1/revmYWNtMvD2WNPnbVMfvj5ewJb+FRYwO
 U2IWmTz5o7yFr/cFwvuJ15rZXkphuRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668516462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufZL7REvSbZ5VA8G2uVTNbE6E5v5zJ/UH9/vWEjfP2A=;
 b=8+ExMFj5GnqvjM1P1A+LhgoSMjT7Qitq5oiva2VGDYfX8tp/h3ZhkiIHyKBsoNeotdAsD0
 S5R3uowZijFMn/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E661713B33;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B+5oN22Kc2POTgAAMHmgww
 (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 12:47:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 4FDF5A070B; Tue, 15 Nov 2022 13:47:41 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 13:47:37 +0100
Message-Id: <20221115124741.14400-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221115123721.12176-1-jack@suse.cz>
References: <20221115123721.12176-1-jack@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event files
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

Add support for marking and generating events on multiple files. We'll
use this for more reliable checking of evictable marks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 417 ++++++++++--------
 1 file changed, 245 insertions(+), 172 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 6f21094bed2c..e19bd907470f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -43,6 +43,7 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
@@ -69,6 +70,7 @@ static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
 static int fd_syncfs;
 
 static char event_buf[EVENT_BUF_LEN];
+static int event_buf_pos, event_buf_len;
 static int exec_events_unsupported;
 static int fan_report_dfid_unsupported;
 static int filesystem_mark_unsupported;
@@ -123,346 +125,377 @@ static struct fanotify_mark_type fanotify_mark_types[] = {
 
 static struct tcase {
 	const char *tname;
-	const char *mark_path;
+	int mark_path_cnt;
+	const char *mark_path_fmt;
 	int mark_type;
-	const char *ignore_path;
+	int ignore_path_cnt;
+	const char *ignore_path_fmt;
 	int ignore_mark_type;
 	unsigned int ignored_flags;
-	const char *event_path;
+	int event_path_cnt;
+	const char *event_path_fmt;
 	unsigned long long expected_mask_with_ignore;
 	unsigned long long expected_mask_without_ignore;
 } tcases[] = {
 	{
 		.tname = "ignore mount events created on a specific file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = FILE_MNT2,
+		.ignore_path_fmt = FILE_MNT2,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore exec mount events created on a specific file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = FILE_EXEC_PATH2,
+		.ignore_path_fmt = FILE_EXEC_PATH2,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE_EXEC_PATH,
+		.event_path_fmt = FILE_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "don't ignore mount events created on another file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = FILE_PATH,
+		.ignore_path_fmt = FILE_PATH,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE2_PATH,
+		.event_path_fmt = FILE2_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore exec mount events created on another file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = FILE_EXEC_PATH,
+		.ignore_path_fmt = FILE_EXEC_PATH,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE2_EXEC_PATH,
+		.event_path_fmt = FILE2_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "ignore inode events created on a specific mount point",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_INODE,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_MNT2,
+		.event_path_fmt = FILE_MNT2,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore exec inode events created on a specific mount point",
-		.mark_path = FILE_EXEC_PATH,
+		.mark_path_fmt = FILE_EXEC_PATH,
 		.mark_type = FANOTIFY_INODE,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_EXEC_PATH2,
+		.event_path_fmt = FILE_EXEC_PATH2,
 		.expected_mask_with_ignore = FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "don't ignore inode events created on another mount point",
-		.mark_path = FILE_MNT2,
+		.mark_path_fmt = FILE_MNT2,
 		.mark_type = FANOTIFY_INODE,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore exec inode events created on another mount point",
-		.mark_path = FILE_EXEC_PATH2,
+		.mark_path_fmt = FILE_EXEC_PATH2,
 		.mark_type = FANOTIFY_INODE,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_EXEC_PATH,
+		.event_path_fmt = FILE_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "ignore fs events created on a specific file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = FILE_PATH,
+		.ignore_path_fmt = FILE_PATH,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore exec fs events created on a specific file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = FILE_EXEC_PATH,
+		.ignore_path_fmt = FILE_EXEC_PATH,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE_EXEC_PATH,
+		.event_path_fmt = FILE_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "don't ignore mount events created on another file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = FILE_PATH,
+		.ignore_path_fmt = FILE_PATH,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE2_PATH,
+		.event_path_fmt = FILE2_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore exec mount events created on another file",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = FILE_EXEC_PATH,
+		.ignore_path_fmt = FILE_EXEC_PATH,
 		.ignore_mark_type = FANOTIFY_INODE,
-		.event_path = FILE2_EXEC_PATH,
+		.event_path_fmt = FILE2_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "ignore fs events created on a specific mount point",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_MNT2,
+		.event_path_fmt = FILE_MNT2,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore exec fs events created on a specific mount point",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_EXEC_PATH2,
+		.event_path_fmt = FILE_EXEC_PATH2,
 		.expected_mask_with_ignore = FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "don't ignore fs events created on another mount point",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore exec fs events created on another mount point",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = MNT2_PATH,
+		.ignore_path_fmt = MNT2_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_EXEC_PATH,
+		.event_path_fmt = FILE_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "ignore child exec events created on a specific mount point",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_PARENT,
-		.ignore_path = MOUNT_PATH,
+		.ignore_path_fmt = MOUNT_PATH,
 		.ignore_mark_type = FANOTIFY_MOUNT,
-		.event_path = FILE_EXEC_PATH,
+		.event_path_fmt = FILE_EXEC_PATH,
 		.expected_mask_with_ignore = FAN_OPEN_EXEC,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		.tname = "ignore events on children of directory created on a specific file",
-		.mark_path = DIR_PATH,
+		.mark_path_fmt = DIR_PATH,
 		.mark_type = FANOTIFY_PARENT,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore events on file created inside a parent watching children",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_INODE,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore events on file created inside a parent not watching children",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_INODE,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore mount events created inside a parent watching children",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore mount events created inside a parent not watching children",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "ignore fs events created inside a parent watching children",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore fs events created inside a parent not watching children",
-		.mark_path = FILE_PATH,
+		.mark_path_fmt = FILE_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	/* Evictable ignore mark test cases */
 	{
 		.tname = "don't ignore mount events created on file with evicted ignore mark",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = FILE_PATH,
+		.ignore_path_fmt = FILE_PATH,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore fs events created on a file with evicted ignore mark",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = FILE_PATH,
+		.ignore_path_fmt = FILE_PATH,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore mount events created inside a parent with evicted ignore mark",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
 		.tname = "don't ignore fs events created inside a parent with evicted ignore mark",
-		.mark_path = MOUNT_PATH,
+		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = FILE_PATH,
+		.event_path_fmt = FILE_PATH,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
 	/* FAN_MARK_IGNORE specific test cases */
 	{
 		.tname = "ignore events on subdir inside a parent watching subdirs",
-		.mark_path = SUBDIR_PATH,
+		.mark_path_fmt = SUBDIR_PATH,
 		.mark_type = FANOTIFY_SUBDIR,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_EVENT_ON_CHILD | FAN_ONDIR,
-		.event_path = SUBDIR_PATH,
+		.event_path_fmt = SUBDIR_PATH,
 		.expected_mask_with_ignore = 0,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_ONDIR
 	},
 	{
 		.tname = "don't ignore events on subdir inside a parent not watching children",
-		.mark_path = SUBDIR_PATH,
+		.mark_path_fmt = SUBDIR_PATH,
 		.mark_type = FANOTIFY_SUBDIR,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_ONDIR,
-		.event_path = SUBDIR_PATH,
+		.event_path_fmt = SUBDIR_PATH,
 		.expected_mask_with_ignore = FAN_OPEN | FAN_ONDIR,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_ONDIR
 	},
 	{
 		.tname = "don't ignore events on subdir inside a parent watching non-dir children",
-		.mark_path = SUBDIR_PATH,
+		.mark_path_fmt = SUBDIR_PATH,
 		.mark_type = FANOTIFY_SUBDIR,
-		.ignore_path = DIR_PATH,
+		.ignore_path_fmt = DIR_PATH,
 		.ignore_mark_type = FANOTIFY_PARENT,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path = SUBDIR_PATH,
+		.event_path_fmt = SUBDIR_PATH,
 		.expected_mask_with_ignore = FAN_OPEN | FAN_ONDIR,
 		.expected_mask_without_ignore = FAN_OPEN | FAN_ONDIR
 	},
 };
 
-static void show_fanotify_ignore_marks(int fd, int expected)
+static int format_path_check(char *buf, const char *fmt, int count, int i)
+{
+	int limit = count ? : 1;
+
+	if (i >= limit)
+		return 0;
+
+	if (count)
+		sprintf(buf, fmt, i);
+	else
+		strcpy(buf, fmt);
+	return 1;
+}
+
+#define foreach_path(tc, buf, pname) \
+	for (int piter = 0; format_path_check((buf), (tc)->pname##_fmt,	\
+					(tc)->pname##_cnt, piter); piter++)
+
+static void show_fanotify_ignore_marks(int fd, int min, int max)
 {
 	unsigned int mflags, mask, ignored_mask;
 	char procfdinfo[100];
+	char line[BUFSIZ];
+	int marks = 0;
+	FILE *f;
 
 	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd);
-	if (FILE_LINES_SCANF(procfdinfo, "fanotify ino:%*x sdev:%*x mflags: %x mask:%x ignored_mask:%x",
-				&mflags, &mask, &ignored_mask) || !ignored_mask) {
-		tst_res(!expected ? TPASS : TFAIL,
-			"No fanotify inode ignore marks %sexpected",
-			!expected ? "as " : "is un");
-	} else {
-		tst_res(expected ? TPASS : TFAIL,
-			"Found %sexpected inode ignore mark (mflags=%x, mask=%x ignored_mask=%x)",
-			expected ? "" : "un", mflags, mask, ignored_mask);
+	f = SAFE_FOPEN(procfdinfo, "r");
+	while (fgets(line, BUFSIZ, f)) {
+		if (sscanf(line, "fanotify ino:%*x sdev:%*x mflags: %x mask:%x ignored_mask:%x",
+			   &mflags, &mask, &ignored_mask) == 3) {
+			if (ignored_mask != 0)
+				marks++;
+		}
 	}
+	if (marks < min) {
+		tst_res(TFAIL, "Found %d ignore marks but at least %d expected", marks, min);
+		return;
+	}
+	if (marks > max) {
+		tst_res(TFAIL, "Found %d ignore marks but at most %d expected", marks, max);
+		return;
+	}
+	tst_res(TPASS, "Found %d ignore marks which is in expected range %d-%d", marks, min, max);
 }
 
 static void drop_caches(void)
@@ -482,6 +515,7 @@ static int create_fanotify_groups(unsigned int n)
 	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
 	int ignore_mark_type;
 	int ignored_onchild = tc->ignored_flags & FAN_EVENT_ON_CHILD;
+	char path[PATH_MAX];
 
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
@@ -501,11 +535,12 @@ static int create_fanotify_groups(unsigned int n)
 			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
 			 * or inode mark on non-directory.
 			 */
-			SAFE_FANOTIFY_MARK(fd_notify[p][i],
+			foreach_path(tc, path, mark_path)
+				SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | mark->flag,
 					    tc->expected_mask_without_ignore |
 					    FAN_EVENT_ON_CHILD | FAN_ONDIR,
-					    AT_FDCWD, tc->mark_path);
+					    AT_FDCWD, path);
 
 			/* Do not add ignore mark for first priority groups */
 			if (p == 0)
@@ -519,9 +554,10 @@ static int create_fanotify_groups(unsigned int n)
 			mark_ignored = tst_variant ? FAN_MARK_IGNORE_SURV : FAN_MARK_IGNORED_SURV;
 			mask = FAN_OPEN | tc->ignored_flags;
 add_mark:
-			SAFE_FANOTIFY_MARK(fd_notify[p][i],
+			foreach_path(tc, path, ignore_path)
+				SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
-					    mask, AT_FDCWD, tc->ignore_path);
+					    mask, AT_FDCWD, path);
 
 			/*
 			 * FAN_MARK_IGNORE respects FAN_EVENT_ON_CHILD flag, but legacy
@@ -578,9 +614,24 @@ add_mark:
 	if (ignore_mark_type == FAN_MARK_INODE) {
 		for (p = 0; p < num_classes; p++) {
 			for (i = 0; i < GROUPS_PER_PRIO; i++) {
-				if (fd_notify[p][i] > 0)
+				if (fd_notify[p][i] > 0) {
+					int minexp, maxexp;
+
+					if (p == 0) {
+						minexp = maxexp = 0;
+					} else if (evictable_ignored) {
+						minexp = 0;
+						/*
+						 * Check at least half the
+						 * marks get evicted by reclaim
+						 */
+						maxexp = tc->ignore_path_cnt / 2;
+					} else {
+						minexp = maxexp = tc->ignore_path_cnt ? : 1;
+					}
 					show_fanotify_ignore_marks(fd_notify[p][i],
-								   p > 0 && !evictable_ignored);
+								   minexp, maxexp);
+				}
 			}
 		}
 	}
@@ -613,7 +664,7 @@ static void mount_cycle(void)
 	bind_mount_created = 1;
 }
 
-static void verify_event(int p, int group, struct fanotify_event_metadata *event,
+static int verify_event(int p, int group, struct fanotify_event_metadata *event,
 			 unsigned long long expected_mask)
 {
 	/* Only FAN_REPORT_FID reports the FAN_ONDIR flag in events on dirs */
@@ -626,33 +677,35 @@ static void verify_event(int p, int group, struct fanotify_event_metadata *event
 			(unsigned long long) event->mask,
 			(unsigned long long) expected_mask,
 			(unsigned int)event->pid, event->fd);
+		return 0;
 	} else if (event->pid != child_pid) {
 		tst_res(TFAIL, "group %d (%x) got event: mask %llx pid=%u "
 			"(expected %u) fd=%u", group, fanotify_class[p],
 			(unsigned long long)event->mask, (unsigned int)event->pid,
 			(unsigned int)child_pid, event->fd);
-	} else {
-		tst_res(TPASS, "group %d (%x) got event: mask %llx pid=%u fd=%u",
-			group, fanotify_class[p], (unsigned long long)event->mask,
-			(unsigned int)event->pid, event->fd);
+		return 0;
 	}
+	return 1;
 }
 
-static int generate_event(const char *event_path,
-			  unsigned long long expected_mask)
+static int generate_event(struct tcase *tc, unsigned long long expected_mask)
 {
 	int fd, status;
 
 	child_pid = SAFE_FORK();
 
 	if (child_pid == 0) {
-		if (expected_mask & FAN_OPEN_EXEC) {
-			SAFE_EXECL(event_path, event_path, NULL);
-		} else {
-			fd = SAFE_OPEN(event_path, O_RDONLY);
+		char path[PATH_MAX];
+
+		foreach_path(tc, path, event_path) {
+			if (expected_mask & FAN_OPEN_EXEC) {
+				SAFE_EXECL(path, path, NULL);
+			} else {
+				fd = SAFE_OPEN(path, O_RDONLY);
 
-			if (fd > 0)
-				SAFE_CLOSE(fd);
+				if (fd > 0)
+					SAFE_CLOSE(fd);
+			}
 		}
 
 		exit(0);
@@ -665,6 +718,37 @@ static int generate_event(const char *event_path,
 	return 0;
 }
 
+struct fanotify_event_metadata *fetch_event(int fd, int *retp)
+{
+	int ret;
+	struct fanotify_event_metadata *event;
+
+	*retp = 0;
+	if (event_buf_pos >= event_buf_len) {
+		event_buf_pos = 0;
+		ret = read(fd, event_buf, EVENT_BUF_LEN);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				return NULL;
+			tst_brk(TBROK | TERRNO, "reading fanotify events failed");
+			*retp = -1;
+			return NULL;
+		}
+		event_buf_len = ret;
+	}
+	if (event_buf_len - event_buf_pos < (int)FAN_EVENT_METADATA_LEN) {
+		tst_brk(TBROK,
+			"too short event when reading fanotify events (%d < %d)",
+			event_buf_len - event_buf_pos,
+			(int)FAN_EVENT_METADATA_LEN);
+		*retp = -1;
+		return NULL;
+	}
+	event = (struct fanotify_event_metadata *)(event_buf + event_buf_pos);
+	event_buf_pos += event->event_len;
+	return event;
+}
+
 static void test_fanotify(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -672,6 +756,7 @@ static void test_fanotify(unsigned int n)
 	int ret;
 	unsigned int p, i;
 	struct fanotify_event_metadata *event;
+	int event_count;
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
@@ -715,7 +800,7 @@ static void test_fanotify(unsigned int n)
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
 
 	/* Generate event in child process */
-	if (!generate_event(tc->event_path, tc->expected_mask_with_ignore))
+	if (!generate_event(tc, tc->expected_mask_with_ignore))
 		tst_brk(TBROK, "Child process terminated incorrectly");
 
 	/* First verify all groups without matching ignore mask got the event */
@@ -724,64 +809,52 @@ static void test_fanotify(unsigned int n)
 			break;
 
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
-			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
-			if (ret < 0) {
-				if (errno == EAGAIN) {
-					tst_res(TFAIL, "group %d (%x) "
-						"with %s did not get event",
-						i, fanotify_class[p], mark->name);
-					continue;
-				}
-				tst_brk(TBROK | TERRNO,
-					"reading fanotify events failed");
-			}
-			if (ret < (int)FAN_EVENT_METADATA_LEN) {
-				tst_brk(TBROK,
-					"short read when reading fanotify "
-					"events (%d < %d)", ret,
-					(int)EVENT_BUF_LEN);
+			event_count = 0;
+			event_buf_pos = event_buf_len = 0;
+			while ((event = fetch_event(fd_notify[p][i], &ret))) {
+				event_count++;
+				if (!verify_event(p, i, event, p == 0 ?
+						tc->expected_mask_without_ignore :
+						tc->expected_mask_with_ignore))
+					break;
+				if (event->fd != FAN_NOFD)
+					SAFE_CLOSE(event->fd);
 			}
-			event = (struct fanotify_event_metadata *)event_buf;
-			if (ret > (int)event->event_len) {
+			if (ret < 0)
+				continue;
+			if (event_count != (tc->event_path_cnt ? : 1)) {
 				tst_res(TFAIL, "group %d (%x) with %s "
-					"got more than one event (%d > %d)",
-					i, fanotify_class[p], mark->name, ret,
-					event->event_len);
+					"got unexpected number of events (%d != %d)",
+					i, fanotify_class[p], mark->name,
+					event_count, tc->event_path_cnt);
 			} else {
-				verify_event(p, i, event, p == 0 ?
-						tc->expected_mask_without_ignore :
-						tc->expected_mask_with_ignore);
+				tst_res(TPASS, "group %d (%x) got %d events: mask %llx pid=%u",
+					i, fanotify_class[p], event_count,
+					(unsigned long long)(p == 0 ?
+					tc->expected_mask_without_ignore :
+					tc->expected_mask_with_ignore),
+					(unsigned int)child_pid);
 			}
-			if (event->fd != FAN_NOFD)
-				SAFE_CLOSE(event->fd);
 		}
 	}
 	/* Then verify all groups with matching ignore mask did got the event */
 	for (p = 1; p < num_classes && !tc->expected_mask_with_ignore; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
-			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
-			if (ret >= 0 && ret < (int)FAN_EVENT_METADATA_LEN) {
-				tst_brk(TBROK,
-					"short read when reading fanotify "
-					"events (%d < %d)", ret,
-					(int)EVENT_BUF_LEN);
-			}
-			event = (struct fanotify_event_metadata *)event_buf;
-			if (ret > 0) {
-				tst_res(TFAIL, "group %d (%x) with %s and "
-					"%s ignore mask got unexpected event (mask %llx)",
-					i, fanotify_class[p], mark->name, ignore_mark->name,
-					event->mask);
+			event_count = 0;
+			event_buf_pos = event_buf_len = 0;
+			while ((event = fetch_event(fd_notify[p][i], &ret))) {
+				event_count++;
 				if (event->fd != FAN_NOFD)
 					SAFE_CLOSE(event->fd);
-			} else if (errno == EAGAIN) {
-				tst_res(TPASS, "group %d (%x) with %s and "
-					"%s ignore mask got no event",
-					i, fanotify_class[p], mark->name, ignore_mark->name);
-			} else {
-				tst_brk(TBROK | TERRNO,
-					"reading fanotify events failed");
 			}
+			if (ret < 0)
+				continue;
+			if (event_count > tc->event_path_cnt / 2)
+				tst_res(TFAIL, "group %d (%x) with %s and "
+					"%s ignore mask got unexpectedly many events (%d > %d)",
+					i, fanotify_class[p], mark->name,
+					ignore_mark->name, event_count,
+					tc->event_path_cnt / 2);
 		}
 	}
 cleanup:
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
