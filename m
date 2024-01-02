Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E42DC46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 22:40:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42A1C3D0513
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 23:40:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1EA43CE894
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 23:39:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 004AC10007CC
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 23:39:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42CF821F26;
 Tue,  2 Jan 2024 22:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704235184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzmOXFFT4vDofU1j8zr3/Q4adWh1BwR1TQR0W8S1PBQ=;
 b=adJGL3z3falq2tMScIUqcD9CYlQqLty2W25GVTk3PDTSyC1YwckVsc2L2IQzz8fv8Pefg5
 j2Gt+k3msutnrN6v5CKurRpUrF9DY0TcLISUkmhBESzcqAy44Wvs1qpCqLwszQuxDHsxZx
 EZMb/kjmj6fmhn5F6OboZ1BMfwpM5KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704235184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzmOXFFT4vDofU1j8zr3/Q4adWh1BwR1TQR0W8S1PBQ=;
 b=f79/6N7/tnUqF2lshukz/4SkCYipHGdZCIA7VTmo3ObU91dTM+c5+gLJAUveRf4rBfsf5W
 dYYKZOyJSd7Tq1DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704235184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzmOXFFT4vDofU1j8zr3/Q4adWh1BwR1TQR0W8S1PBQ=;
 b=adJGL3z3falq2tMScIUqcD9CYlQqLty2W25GVTk3PDTSyC1YwckVsc2L2IQzz8fv8Pefg5
 j2Gt+k3msutnrN6v5CKurRpUrF9DY0TcLISUkmhBESzcqAy44Wvs1qpCqLwszQuxDHsxZx
 EZMb/kjmj6fmhn5F6OboZ1BMfwpM5KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704235184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzmOXFFT4vDofU1j8zr3/Q4adWh1BwR1TQR0W8S1PBQ=;
 b=f79/6N7/tnUqF2lshukz/4SkCYipHGdZCIA7VTmo3ObU91dTM+c5+gLJAUveRf4rBfsf5W
 dYYKZOyJSd7Tq1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B0FC13C96;
 Tue,  2 Jan 2024 22:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0NB8BbCQlGVkWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 02 Jan 2024 22:39:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  2 Jan 2024 23:39:35 +0100
Message-ID: <20240102223935.1012840-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102223935.1012840-1-pvorel@suse.cz>
References: <20240102223935.1012840-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[32.98%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_fs_setup.c: Add tst_ prefix to new API
 functions
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

To fix our warning due not following our policy:
tst_fs_setup.c:14:6: warning: LTP-003: Symbol 'create_overlay_dirs' is a public library function, but is missing the 'tst_' prefix
tst_fs_setup.c:27:5: warning: LTP-003: Symbol 'mount_overlay' is a public library function, but is missing the 'tst_' prefix

+ Fix missing blank line.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_file_ops.h | 8 ++++----
 lib/tst_fs_setup.c          | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 401f6ee25..0d8819594 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -59,13 +59,13 @@
 /* New API only functions */
 
 /* helper functions to setup overlayfs mountpoint */
-void create_overlay_dirs(void);
-int mount_overlay(const char *file, const int lineno, int strict);
+void tst_create_overlay_dirs(void);
+int tst_mount_overlay(const char *file, const int lineno, int strict);
 
 #define SAFE_MOUNT_OVERLAY() \
-	((void) mount_overlay(__FILE__, __LINE__, 1))
+	((void) tst_mount_overlay(__FILE__, __LINE__, 1))
 
 #define TST_MOUNT_OVERLAY() \
-	(mount_overlay(__FILE__, __LINE__, 0) == 0)
+	(tst_mount_overlay(__FILE__, __LINE__, 0) == 0)
 
 #endif /* TST_SAFE_FILE_OPS */
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
index aaa8f3bc9..d3284a145 100644
--- a/lib/tst_fs_setup.c
+++ b/lib/tst_fs_setup.c
@@ -11,9 +11,10 @@
 #define TST_FS_SETUP_OVERLAYFS_MSG "overlayfs is not configured in this kernel"
 #define TST_FS_SETUP_OVERLAYFS_CONFIG "lowerdir="OVL_LOWER",upperdir="OVL_UPPER",workdir="OVL_WORK
 
-void create_overlay_dirs(void)
+void tst_create_overlay_dirs(void)
 {
 	DIR *dir = opendir(OVL_LOWER);
+
 	if (dir == NULL) {
 		SAFE_MKDIR(OVL_LOWER, 0755);
 		SAFE_MKDIR(OVL_UPPER, 0755);
@@ -24,11 +25,11 @@ void create_overlay_dirs(void)
 	closedir(dir);
 }
 
-int mount_overlay(const char *file, const int lineno, int strict)
+int tst_mount_overlay(const char *file, const int lineno, int strict)
 {
 	int ret;
 
-	create_overlay_dirs();
+	tst_create_overlay_dirs();
 	ret = mount("overlay", OVL_MNT, "overlay", 0,
 				TST_FS_SETUP_OVERLAYFS_CONFIG);
 	if (ret == 0)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
