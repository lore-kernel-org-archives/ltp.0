Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8CAC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 12:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85BA13CA0AE
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:12:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CF373C95E3
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:12:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12629600F08
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:12:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3CA541F37D;
 Wed, 16 Feb 2022 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645013548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+z6SBYjPZG82oDtgins1DtzK2bBrf+Toz77c6PkYX4w=;
 b=lCWRXRzkOku5binauiUZMjEhbDoWCJdtleJ0G0TQ2nBVbkXGcDU2mwiqB4KkWSdAKTQtps
 GrZV2yt63RFu0rfzR3zNTE1u3S8gCBcs0AnESsvWl10mR/dsNAaZbae+XNQWDu2lwV1SBR
 icmwtFP8K2MzjWBVLx2nCV32JgtkO7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645013548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+z6SBYjPZG82oDtgins1DtzK2bBrf+Toz77c6PkYX4w=;
 b=gSj/EH7opEFjs4fhZw485fLxKcWMvujkAIhDVJPAO2LFFhOcUWDZj04N3LY/Vqn/14rrZ3
 OoSYJq1Jcm8ipLBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F84113AF3;
 Wed, 16 Feb 2022 12:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lzTmBSzqDGJLRQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Feb 2022 12:12:28 +0000
Date: Wed, 16 Feb 2022 13:12:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgzqIR3o8XpUJTAN@rei>
References: <20220210151448.18394-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210151448.18394-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactoring mmap16.c test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with a minor changes, thanks.

The biggest issue was that the original test did run the actuall test 10
times, my guess that it was to make sure that we are able to reproduce
the issue. The rest of the changes is cosmetic, such as better
description and code formatting.

Full diff:

diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index a892051ac..cb146d120 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -7,9 +7,22 @@
 /*\
  * [Description]
  *
- * This is a regression test for commits:
- * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0572639ff66dcffe62d37adfe4c4576f9fc398f4
- * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6320cbfc92910a3e5f10c42d98c231c98db4f60
+ * This is a regression test for a silent data corruption for a mmaped file
+ * when filesystem gets out of space.
+ *
+ * Fixed by commits:
+ *
+ *  commit 0572639ff66dcffe62d37adfe4c4576f9fc398f4
+ *  Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *  Date:   Thu Feb 12 23:00:17 2015 -0500
+ *
+ *      ext4: fix mmap data corruption in nodelalloc mode when blocksize < pagesize
+ *
+ *  commit d6320cbfc92910a3e5f10c42d98c231c98db4f60
+ *  Author: Jan Kara <jack@suse.cz>
+ *  Date:   Wed Oct 1 21:49:46 2014 -0400
+ *
+ *      ext4: fix mmap data corruption when blocksize < pagesize
  */
 
 #define _GNU_SOURCE
@@ -25,8 +38,8 @@
 #define FILE_PARENT "mntpoint/testfilep"
 #define FILE_CHILD "mntpoint/testfilec"
 #define FS_BLOCKSIZE 1024
+#define LOOPS 10
 
-static int page_size;
 static int parentfd = -1;
 static int childfd = -1;
 
@@ -83,7 +96,7 @@ static void do_child(void)
 	exit(1);
 }
 
-static void run(void)
+static void run_single(void)
 {
 	int ret, status;
 	pid_t child;
@@ -138,6 +151,14 @@ static void run(void)
 		tst_res(TPASS, "bug is not reproduced");
 }
 
+static void run(void)
+{
+	int i;
+
+	for (i = 0; i < LOOPS; i++)
+		run_single();
+}
+
 static void cleanup(void)
 {
 	if (childfd >= 0)
@@ -154,32 +175,25 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
 	.needs_checkpoints = 1,
-	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.dev_fs_type = "ext4",
-	.dev_fs_opts =
-		(const char *const[]){
-			"-b",
-			"1024",
-			NULL,
-		},
-	.dev_extra_opts =
-		(const char *const[]){
-			"10240",
-			NULL,
-		},
-	.needs_cmds =
-		(const char *const[]){
-			"mkfs.ext4",
-			NULL,
-		},
-	.tags =
-		(const struct tst_tag[]){
-			{ "linux-git",
-			  "d6320cbfc92910a3e5f10c42d98c231c98db4f60" },
-			{ "linux-git",
-			  "0572639ff66dcffe62d37adfe4c4576f9fc398f4" },
-			{},
-		},
+	.dev_fs_opts = (const char *const[]){
+		"-b",
+		"1024",
+		NULL,
+	},
+	.dev_extra_opts = (const char *const[]){
+		"10240",
+		NULL,
+	},
+	.needs_cmds = (const char *const[]){
+		"mkfs.ext4",
+		NULL,
+	},
+	.tags = (const struct tst_tag[]){
+		{"linux-git", "d6320cbfc929"},
+		{"linux-git", "0572639ff66d"},
+		{},
+	},
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
