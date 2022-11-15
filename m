Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C376AC4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:48:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133883CD159
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 13:48:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3CBC3CD10D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8CEEF200385
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 13:47:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E286922D0F;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668516461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+2uIk777oRkmwQkJsmqIffx2pm6S3dXJaFVf4LGUJU=;
 b=i9BtxsSZ7UvKPlZ9k2zCM2t41fyoa7eC8Q3PtlVZco678b0W6XoRhglHbfwVORJBMCHzxF
 nrOfQkBgtGht+LCruPzAbm4PKXdEqDo8w2j7Gv5cqlkI2CacrUvpSNoU0ZaJHgz/ubmDQC
 D96IpVHiSTCNfq6LqemkPjXweizjkww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668516461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+2uIk777oRkmwQkJsmqIffx2pm6S3dXJaFVf4LGUJU=;
 b=3Vmixnse39SOlOzCyWCrnFdQOzvMcfqbwWu4RrWPcaNktXjk3e7LHiuLzmI2jwP/Xq3Huc
 2ZZb0pJhIWNG6NAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D04F913A91;
 Tue, 15 Nov 2022 12:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IAjSMm2Kc2PKTgAAMHmgww
 (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 12:47:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 4A6B2A06EA; Tue, 15 Nov 2022 13:47:41 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 13:47:36 +0100
Message-Id: <20221115124741.14400-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221115123721.12176-1-jack@suse.cz>
References: <20221115123721.12176-1-jack@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] fanotify10: Use named initializers
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

Convert the testcase to use named initializers instead of anonymous
ones.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 408 +++++++++++-------
 1 file changed, 249 insertions(+), 159 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index ca0d8a9e4a4a..6f21094bed2c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -133,227 +133,317 @@ static struct tcase {
 	unsigned long long expected_mask_without_ignore;
 } tcases[] = {
 	{
-		"ignore mount events created on a specific file",
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		FILE_MNT2, FANOTIFY_INODE,
-		0,
-		FILE_PATH, 0, FAN_OPEN
+		.tname = "ignore mount events created on a specific file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = FILE_MNT2,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE_PATH,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore exec mount events created on a specific file",
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		FILE_EXEC_PATH2, FANOTIFY_INODE,
-		0,
-		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "ignore exec mount events created on a specific file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = FILE_EXEC_PATH2,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"don't ignore mount events created on another file",
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		FILE_PATH, FANOTIFY_INODE,
-		0,
-		FILE2_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore mount events created on another file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = FILE_PATH,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE2_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore exec mount events created on another file",
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		FILE_EXEC_PATH, FANOTIFY_INODE,
-		0,
-		FILE2_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
-		FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "don't ignore exec mount events created on another file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = FILE_EXEC_PATH,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE2_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"ignore inode events created on a specific mount point",
-		FILE_PATH, FANOTIFY_INODE,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_MNT2, 0, FAN_OPEN
+		.tname = "ignore inode events created on a specific mount point",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_INODE,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_MNT2,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore exec inode events created on a specific mount point",
-		FILE_EXEC_PATH, FANOTIFY_INODE,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_EXEC_PATH2, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "ignore exec inode events created on a specific mount point",
+		.mark_path = FILE_EXEC_PATH,
+		.mark_type = FANOTIFY_INODE,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_EXEC_PATH2,
+		.expected_mask_with_ignore = FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"don't ignore inode events created on another mount point",
-		FILE_MNT2, FANOTIFY_INODE,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore inode events created on another mount point",
+		.mark_path = FILE_MNT2,
+		.mark_type = FANOTIFY_INODE,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore exec inode events created on another mount point",
-		FILE_EXEC_PATH2, FANOTIFY_INODE,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
-		FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "don't ignore exec inode events created on another mount point",
+		.mark_path = FILE_EXEC_PATH2,
+		.mark_type = FANOTIFY_INODE,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"ignore fs events created on a specific file",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		FILE_PATH, FANOTIFY_INODE,
-		0,
-		FILE_PATH, 0, FAN_OPEN
+		.tname = "ignore fs events created on a specific file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = FILE_PATH,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE_PATH,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore exec fs events created on a specific file",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		FILE_EXEC_PATH, FANOTIFY_INODE,
-		0,
-		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "ignore exec fs events created on a specific file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = FILE_EXEC_PATH,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"don't ignore mount events created on another file",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		FILE_PATH, FANOTIFY_INODE,
-		0,
-		FILE2_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore mount events created on another file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = FILE_PATH,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE2_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore exec mount events created on another file",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		FILE_EXEC_PATH, FANOTIFY_INODE,
-		0,
-		FILE2_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
-		FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "don't ignore exec mount events created on another file",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = FILE_EXEC_PATH,
+		.ignore_mark_type = FANOTIFY_INODE,
+		.event_path = FILE2_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"ignore fs events created on a specific mount point",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_MNT2, 0, FAN_OPEN
+		.tname = "ignore fs events created on a specific mount point",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_MNT2,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore exec fs events created on a specific mount point",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_EXEC_PATH2, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "ignore exec fs events created on a specific mount point",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_EXEC_PATH2,
+		.expected_mask_with_ignore = FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"don't ignore fs events created on another mount point",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore fs events created on another mount point",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore exec fs events created on another mount point",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		MNT2_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
-		FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "don't ignore exec fs events created on another mount point",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = MNT2_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN | FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"ignore child exec events created on a specific mount point",
-		MOUNT_PATH, FANOTIFY_PARENT,
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		0,
-		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
+		.tname = "ignore child exec events created on a specific mount point",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_PARENT,
+		.ignore_path = MOUNT_PATH,
+		.ignore_mark_type = FANOTIFY_MOUNT,
+		.event_path = FILE_EXEC_PATH,
+		.expected_mask_with_ignore = FAN_OPEN_EXEC,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
-		"ignore events on children of directory created on a specific file",
-		DIR_PATH, FANOTIFY_PARENT,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_EVENT_ON_CHILD,
-		FILE_PATH, 0, FAN_OPEN
+		.tname = "ignore events on children of directory created on a specific file",
+		.mark_path = DIR_PATH,
+		.mark_type = FANOTIFY_PARENT,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = FILE_PATH,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore events on file created inside a parent watching children",
-		FILE_PATH, FANOTIFY_INODE,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_EVENT_ON_CHILD,
-		FILE_PATH, 0, FAN_OPEN
+		.tname = "ignore events on file created inside a parent watching children",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_INODE,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = FILE_PATH,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore events on file created inside a parent not watching children",
-		FILE_PATH, FANOTIFY_INODE,
-		DIR_PATH, FANOTIFY_PARENT,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore events on file created inside a parent not watching children",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_INODE,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore mount events created inside a parent watching children",
-		FILE_PATH, FANOTIFY_MOUNT,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_EVENT_ON_CHILD,
-		FILE_PATH, 0, FAN_OPEN
+		.tname = "ignore mount events created inside a parent watching children",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = FILE_PATH,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore mount events created inside a parent not watching children",
-		FILE_PATH, FANOTIFY_MOUNT,
-		DIR_PATH, FANOTIFY_PARENT,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore mount events created inside a parent not watching children",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"ignore fs events created inside a parent watching children",
-		FILE_PATH, FANOTIFY_FILESYSTEM,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_EVENT_ON_CHILD,
-		FILE_PATH, 0, FAN_OPEN
+		.tname = "ignore fs events created inside a parent watching children",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = FILE_PATH,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore fs events created inside a parent not watching children",
-		FILE_PATH, FANOTIFY_FILESYSTEM,
-		DIR_PATH, FANOTIFY_PARENT,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore fs events created inside a parent not watching children",
+		.mark_path = FILE_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	/* Evictable ignore mark test cases */
 	{
-		"don't ignore mount events created on file with evicted ignore mark",
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		FILE_PATH, FANOTIFY_EVICTABLE,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore mount events created on file with evicted ignore mark",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = FILE_PATH,
+		.ignore_mark_type = FANOTIFY_EVICTABLE,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore fs events created on a file with evicted ignore mark",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		FILE_PATH, FANOTIFY_EVICTABLE,
-		0,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore fs events created on a file with evicted ignore mark",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = FILE_PATH,
+		.ignore_mark_type = FANOTIFY_EVICTABLE,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore mount events created inside a parent with evicted ignore mark",
-		MOUNT_PATH, FANOTIFY_MOUNT,
-		DIR_PATH, FANOTIFY_EVICTABLE,
-		FAN_EVENT_ON_CHILD,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore mount events created inside a parent with evicted ignore mark",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_MOUNT,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_EVICTABLE,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	{
-		"don't ignore fs events created inside a parent with evicted ignore mark",
-		MOUNT_PATH, FANOTIFY_FILESYSTEM,
-		DIR_PATH, FANOTIFY_EVICTABLE,
-		FAN_EVENT_ON_CHILD,
-		FILE_PATH, FAN_OPEN, FAN_OPEN
+		.tname = "don't ignore fs events created inside a parent with evicted ignore mark",
+		.mark_path = MOUNT_PATH,
+		.mark_type = FANOTIFY_FILESYSTEM,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_EVICTABLE,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = FILE_PATH,
+		.expected_mask_with_ignore = FAN_OPEN,
+		.expected_mask_without_ignore = FAN_OPEN
 	},
 	/* FAN_MARK_IGNORE specific test cases */
 	{
-		"ignore events on subdir inside a parent watching subdirs",
-		SUBDIR_PATH, FANOTIFY_SUBDIR,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_EVENT_ON_CHILD | FAN_ONDIR,
-		SUBDIR_PATH, 0, FAN_OPEN | FAN_ONDIR
+		.tname = "ignore events on subdir inside a parent watching subdirs",
+		.mark_path = SUBDIR_PATH,
+		.mark_type = FANOTIFY_SUBDIR,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_EVENT_ON_CHILD | FAN_ONDIR,
+		.event_path = SUBDIR_PATH,
+		.expected_mask_with_ignore = 0,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_ONDIR
 	},
 	{
-		"don't ignore events on subdir inside a parent not watching children",
-		SUBDIR_PATH, FANOTIFY_SUBDIR,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_ONDIR,
-		SUBDIR_PATH, FAN_OPEN | FAN_ONDIR, FAN_OPEN | FAN_ONDIR
+		.tname = "don't ignore events on subdir inside a parent not watching children",
+		.mark_path = SUBDIR_PATH,
+		.mark_type = FANOTIFY_SUBDIR,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_ONDIR,
+		.event_path = SUBDIR_PATH,
+		.expected_mask_with_ignore = FAN_OPEN | FAN_ONDIR,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_ONDIR
 	},
 	{
-		"don't ignore events on subdir inside a parent watching non-dir children",
-		SUBDIR_PATH, FANOTIFY_SUBDIR,
-		DIR_PATH, FANOTIFY_PARENT,
-		FAN_EVENT_ON_CHILD,
-		SUBDIR_PATH, FAN_OPEN | FAN_ONDIR, FAN_OPEN | FAN_ONDIR
+		.tname = "don't ignore events on subdir inside a parent watching non-dir children",
+		.mark_path = SUBDIR_PATH,
+		.mark_type = FANOTIFY_SUBDIR,
+		.ignore_path = DIR_PATH,
+		.ignore_mark_type = FANOTIFY_PARENT,
+		.ignored_flags = FAN_EVENT_ON_CHILD,
+		.event_path = SUBDIR_PATH,
+		.expected_mask_with_ignore = FAN_OPEN | FAN_ONDIR,
+		.expected_mask_without_ignore = FAN_OPEN | FAN_ONDIR
 	},
 };
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
