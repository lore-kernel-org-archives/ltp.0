Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F097EE57C0
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:35:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E29693C1D5D
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 18:35:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E48A93C1D2F
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A1FF2600852
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A81961FD03
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFSVcqkU4XvaNsmiI3LkzkkON62pCv3xN8pDHcf8NNg=;
 b=wbk72x6g49eFR52tb8e7T/aFxKGjCB2j5ggu0w+WyDVRINAObDDvfdpWo/ewlw2zzbdoUg
 djM+2YdgGu9644Oap+u4QJctQmuDQvldy2hMb+UccRyyEA9eY6mqStOVGsqBf8uxxnk2Oo
 FloEW3yxD+e1txT6+J2zqzRL2Fk+5JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFSVcqkU4XvaNsmiI3LkzkkON62pCv3xN8pDHcf8NNg=;
 b=dIAzr8Sp0qgbDJuoEtVPAlt/KbjCRgyX/XsEeVKZ9Mxqu9Fi2QllIY/lbSgNRLDJwnMSDU
 0nKBL3idJVAkSVCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wbk72x6g;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dIAzr8Sp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFSVcqkU4XvaNsmiI3LkzkkON62pCv3xN8pDHcf8NNg=;
 b=wbk72x6g49eFR52tb8e7T/aFxKGjCB2j5ggu0w+WyDVRINAObDDvfdpWo/ewlw2zzbdoUg
 djM+2YdgGu9644Oap+u4QJctQmuDQvldy2hMb+UccRyyEA9eY6mqStOVGsqBf8uxxnk2Oo
 FloEW3yxD+e1txT6+J2zqzRL2Fk+5JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFSVcqkU4XvaNsmiI3LkzkkON62pCv3xN8pDHcf8NNg=;
 b=dIAzr8Sp0qgbDJuoEtVPAlt/KbjCRgyX/XsEeVKZ9Mxqu9Fi2QllIY/lbSgNRLDJwnMSDU
 0nKBL3idJVAkSVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94DCD13A8A
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yCwjJK/G4WZcBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Sep 2024 18:34:37 +0200
Message-ID: <20240911163443.95398-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911163443.95398-1-mdoucha@suse.cz>
References: <20240911163443.95398-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A81961FD03
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] getdents01: Enable .all_filesystems
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

Run the functional getdents() test on all filesystems.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/getdents/getdents01.c     | 54 ++++++++++++-------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index e5e4689ee..d6c4b4979 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -22,6 +22,9 @@
 
 #include <stdlib.h>
 
+#define MNTPOINT "mntpoint"
+#define WORKDIR MNTPOINT "/workdir"
+
 static void reset_flags(void);
 static void check_flags(void);
 static void set_flag(const char *name);
@@ -61,7 +64,7 @@ static void run(void)
 {
 	int rval;
 
-	fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY);
+	fd = SAFE_OPEN(WORKDIR, O_RDONLY|O_DIRECTORY);
 
 	rval = tst_getdents(fd, dirp, BUFSIZE);
 
@@ -147,31 +150,37 @@ static void set_flag(const char *name)
 static void setup(void)
 {
 	size_t i;
+	char path[255];
 
 	getdents_info();
 
-	if (!tst_variant) {
-		for (i = 0; i < ARRAY_SIZE(testcases); i++) {
-			if (!testcases[i].create)
-				continue;
-
-			switch (testcases[i].type) {
-			case ENTRY_DIR:
-				SAFE_MKDIR(testcases[i].name, 0777);
-			break;
-			case ENTRY_FILE:
-				SAFE_FILE_PRINTF(testcases[i].name, " ");
-			break;
-			case ENTRY_SYMLINK:
-				SAFE_SYMLINK("nonexistent", testcases[i].name);
-			break;
-			}
+	/*
+	 * Work in a subdirectory because some filesystems add special files
+	 * or directories to their root.
+	 */
+	SAFE_MKDIR(WORKDIR, 0777);
+
+	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
+		if (!testcases[i].create)
+			continue;
+
+		sprintf(path, "%s/%s", WORKDIR, testcases[i].name);
+
+		switch (testcases[i].type) {
+		case ENTRY_DIR:
+			SAFE_MKDIR(path, 0777);
+		break;
+		case ENTRY_FILE:
+			SAFE_FILE_PRINTF(path, " ");
+		break;
+		case ENTRY_SYMLINK:
+			SAFE_SYMLINK("nonexistent", path);
+		break;
 		}
 	}
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.test_all = run,
 	.setup = setup,
 	.bufs = (struct tst_buffers []) {
@@ -179,4 +188,13 @@ static struct tst_test test = {
 		{},
 	},
 	.test_variants = TEST_VARIANTS,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char *const[]) {
+		"vfat",
+		"exfat",
+		NULL
+	}
 };
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
