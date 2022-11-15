Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF21C4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:47:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D1E63CD150
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 13:47:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AA033CD10D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1A3E6003CB
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 071EA22D1B;
 Tue, 15 Nov 2022 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668516462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esROsQgrq9JWCjvx+eXtKws0eUlEzEEMf3MupAFCbDQ=;
 b=yNpLFlXQZ7/dndBa9X6767VuuRux7ECv2DFtPeKP2wb5gr6L7lYTfR4iYA5LZcZdNdrvbu
 x2+e8Z67wM+7+3e6kQAXfrutfVJVDPfpn1SzxYXbCkfAVuawz+4FdToqWGqqtQq7vUPQ8P
 HoPnMLEe/BM35Dh6Eo5tERkGG3pqVX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668516462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esROsQgrq9JWCjvx+eXtKws0eUlEzEEMf3MupAFCbDQ=;
 b=WANft1l+i6jzjxdbXQXDqKrCGQkIsd7Excm6Y1UFfj46Zv5PVfWVEi0XCOv4F13T2TvKa0
 qW5zGlrIZ09omRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE39313A91;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s2ceOm2Kc2PUTgAAMHmgww
 (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 12:47:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 563B5A070E; Tue, 15 Nov 2022 13:47:41 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 13:47:38 +0100
Message-Id: <20221115124741.14400-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221115123721.12176-1-jack@suse.cz>
References: <20221115123721.12176-1-jack@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] fanotify10: Make evictable marks tests more
 reliable
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

Tests verifying that evictable inode marks don't pin inodes in memory
are unreliable because slab shrinking (triggered by drop_caches) does
not reliably evict inodes - dentries have to take round through the LRU
list and only then get reclaimed and inodes get unpinned and then inodes
have to be rotated through their LRU list to get reclaimed. If there are
not enough freed entries while shrinking other slab caches, drop_caches
will abort attempts to reclaim slab before inodes get evicted.

Tweak evictable marks tests to use more files and marks in parallel and
just verify that some (at least half) of the marks got evicted. This
should be more tolerant to random fluctuation in slab reclaim
efficiency.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 62 ++++++++++++++++---
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index e19bd907470f..cfbf4c31dd08 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -86,7 +86,10 @@ static int ignore_mark_unsupported;
 #define TEST_APP "fanotify_child"
 #define TEST_APP2 "fanotify_child2"
 #define DIR_PATH MOUNT_PATH"/"DIR_NAME
+#define DIR_PATH_MULTI DIR_PATH"%d"
 #define FILE_PATH DIR_PATH"/"FILE_NAME
+#define FILE_PATH_MULTI FILE_PATH"%d"
+#define FILE_PATH_MULTIDIR DIR_PATH_MULTI"/"FILE_NAME
 #define FILE2_PATH DIR_PATH"/"FILE2_NAME
 #define SUBDIR_PATH DIR_PATH"/"SUBDIR_NAME
 #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
@@ -104,6 +107,7 @@ static int old_cache_pressure;
 static pid_t child_pid;
 static int bind_mount_created;
 static unsigned int num_classes = NUM_CLASSES;
+static int max_file_multi;
 
 enum {
 	FANOTIFY_INODE,
@@ -378,9 +382,11 @@ static struct tcase {
 		.tname = "don't ignore mount events created on file with evicted ignore mark",
 		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path_fmt = FILE_PATH,
+		.ignore_path_cnt = 16,
+		.ignore_path_fmt = FILE_PATH_MULTI,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
-		.event_path_fmt = FILE_PATH,
+		.event_path_cnt = 16,
+		.event_path_fmt = FILE_PATH_MULTI,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
@@ -388,9 +394,11 @@ static struct tcase {
 		.tname = "don't ignore fs events created on a file with evicted ignore mark",
 		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path_fmt = FILE_PATH,
+		.ignore_path_cnt = 16,
+		.ignore_path_fmt = FILE_PATH_MULTI,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
-		.event_path_fmt = FILE_PATH,
+		.event_path_cnt = 16,
+		.event_path_fmt = FILE_PATH_MULTI,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
@@ -398,10 +406,12 @@ static struct tcase {
 		.tname = "don't ignore mount events created inside a parent with evicted ignore mark",
 		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_MOUNT,
-		.ignore_path_fmt = DIR_PATH,
+		.ignore_path_cnt = 16,
+		.ignore_path_fmt = DIR_PATH_MULTI,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path_fmt = FILE_PATH,
+		.event_path_cnt = 16,
+		.event_path_fmt = FILE_PATH_MULTIDIR,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
@@ -409,10 +419,12 @@ static struct tcase {
 		.tname = "don't ignore fs events created inside a parent with evicted ignore mark",
 		.mark_path_fmt = MOUNT_PATH,
 		.mark_type = FANOTIFY_FILESYSTEM,
-		.ignore_path_fmt = DIR_PATH,
+		.ignore_path_cnt = 16,
+		.ignore_path_fmt = DIR_PATH_MULTI,
 		.ignore_mark_type = FANOTIFY_EVICTABLE,
 		.ignored_flags = FAN_EVENT_ON_CHILD,
-		.event_path_fmt = FILE_PATH,
+		.event_path_cnt = 16,
+		.event_path_fmt = FILE_PATH_MULTIDIR,
 		.expected_mask_with_ignore = FAN_OPEN,
 		.expected_mask_without_ignore = FAN_OPEN
 	},
@@ -864,6 +876,8 @@ cleanup:
 
 static void setup(void)
 {
+	int i;
+
 	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
 								      FAN_CLASS_CONTENT, 0);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
@@ -880,7 +894,24 @@ static void setup(void)
 	SAFE_MKDIR(DIR_PATH, 0755);
 	SAFE_MKDIR(SUBDIR_PATH, 0755);
 	SAFE_FILE_PRINTF(FILE_PATH, "1");
-	SAFE_FILE_PRINTF(FILE2_PATH, "1");
+	for (i = 0; i < (int)(sizeof(tcases)/sizeof(tcases[0])); i++) {
+		if (tcases[i].mark_path_cnt > max_file_multi)
+			max_file_multi = tcases[i].mark_path_cnt;
+		if (tcases[i].ignore_path_cnt > max_file_multi)
+			max_file_multi = tcases[i].ignore_path_cnt;
+		if (tcases[i].event_path_cnt > max_file_multi)
+			max_file_multi = tcases[i].event_path_cnt;
+	}
+	for (i = 0; i < max_file_multi; i++) {
+		char path[PATH_MAX];
+
+		sprintf(path, FILE_PATH_MULTI, i);
+		SAFE_FILE_PRINTF(path, "1");
+		sprintf(path, DIR_PATH_MULTI, i);
+		SAFE_MKDIR(path, 0755);
+		sprintf(path, FILE_PATH_MULTIDIR, i);
+		SAFE_FILE_PRINTF(path, "1");
+	}
 
 	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
 	SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
@@ -896,6 +927,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	int i;
+
 	cleanup_fanotify_groups();
 
 	if (bind_mount_created)
@@ -903,8 +936,17 @@ static void cleanup(void)
 
 	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
 
+	for (i = 0; i < max_file_multi; i++) {
+		char path[PATH_MAX];
+
+		sprintf(path, FILE_PATH_MULTIDIR, i);
+		SAFE_UNLINK(path);
+		sprintf(path, DIR_PATH_MULTI, i);
+		SAFE_RMDIR(path);
+		sprintf(path, FILE_PATH_MULTI, i);
+		SAFE_UNLINK(path);
+	}
 	SAFE_UNLINK(FILE_PATH);
-	SAFE_UNLINK(FILE2_PATH);
 	SAFE_RMDIR(SUBDIR_PATH);
 	SAFE_RMDIR(DIR_PATH);
 	SAFE_RMDIR(MNT2_PATH);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
