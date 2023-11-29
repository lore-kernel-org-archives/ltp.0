Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C81C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 11:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DFDE3CD997
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 12:56:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27C7B3CD95A
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3A4681A0081B
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C96321AB2;
 Wed, 29 Nov 2023 11:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701258885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8HgyITP0Ax1MbLhAC7aSGbcYZInVkt5epmunTWDhNg=;
 b=odrX/v+mx08U0lAE3N8RF2X0SX1+SyuM/w0swFKt6UsyFl4ZH08srvKSKaC69+GLcJw/Ti
 6Rzx5aJp0nSgr+5f89RdHAgdylnrFga9Iofh+V5knMMX3EeDoPuMQS8YFas0WDRf5lwVbh
 BvqbawKnenDWXbZU6q4/DVB6sjJ8NRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701258885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8HgyITP0Ax1MbLhAC7aSGbcYZInVkt5epmunTWDhNg=;
 b=UOb1vvpgtnGZk6K1p5i0frMDM9A9LL3BE2fPOJuqVwygAleNua/ejIy+Cu6qMK9cXg1MVI
 FhYlXHXe3P/qFjDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 50E5413B45;
 Wed, 29 Nov 2023 11:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 2a2+E4UmZ2VffwAAn2gu4w
 (envelope-from <jack@suse.cz>); Wed, 29 Nov 2023 11:54:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id BD946A07EB; Wed, 29 Nov 2023 12:54:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 12:54:34 +0100
Message-Id: <20231129115440.19100-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231129114617.12660-1-jack@suse.cz>
References: <20231129114617.12660-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] fanotify: Convert permission events feature check
 to be performed on fs
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

Convert feature check for availability of permission events to be
performed on the tested filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 5 +++--
 testcases/kernel/syscalls/fanotify/fanotify03.c | 3 +--
 testcases/kernel/syscalls/fanotify/fanotify07.c | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 052b29a7cedc..7cd2213e17bf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -133,13 +133,14 @@ static inline int fanotify_save_fid(const char *path,
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
-static inline void require_fanotify_access_permissions_supported_by_kernel(void)
+static inline void require_fanotify_access_permissions_supported_on_fs(
+							const char *fname)
 {
 	int fd;
 
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
-	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
+	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname) < 0) {
 		if (errno == EINVAL) {
 			tst_brk(TCONF | TERRNO,
 				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not configured in kernel?");
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 343ba857e1ae..028da742c76c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -320,11 +320,10 @@ static void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
-	require_fanotify_access_permissions_supported_by_kernel();
-
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
+	require_fanotify_access_permissions_supported_on_fs(fname);
 	filesystem_mark_unsupported = fanotify_mark_supported_on_fs(FAN_MARK_FILESYSTEM, fname);
 	exec_events_unsupported = fanotify_flags_supported_on_fs(FAN_CLASS_CONTENT,
 					0, FAN_OPEN_EXEC_PERM, fname);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 396c8490eeda..34aa810c7dac 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -189,10 +189,9 @@ static void test_fanotify(void)
 
 static void setup(void)
 {
-	require_fanotify_access_permissions_supported_by_kernel();
-
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "%s", fname);
+	require_fanotify_access_permissions_supported_on_fs(fname);
 }
 
 static void cleanup(void)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
