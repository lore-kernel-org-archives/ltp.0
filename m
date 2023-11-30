Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7DDC4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:38:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32A973CD696
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:38:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDAC03C8960
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B7339207CCC
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 288EA1FCE0;
 Thu, 30 Nov 2023 09:37:12 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CEBB13B3E;
 Thu, 30 Nov 2023 09:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id DJQQB8hXaGVnKAAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:37:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 74A6CA07F9; Thu, 30 Nov 2023 10:37:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 10:37:10 +0100
Message-Id: <20231130093711.20171-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231130093533.10036-1-jack@suse.cz>
References: <20231130093533.10036-1-jack@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 288EA1FCE0
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] fanotify: Convert permission events feature
 check to be performed on fs
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 5 +++--
 testcases/kernel/syscalls/fanotify/fanotify03.c | 3 +--
 testcases/kernel/syscalls/fanotify/fanotify07.c | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 66b1b5e4141a..e0d178bcc7b3 100644
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
