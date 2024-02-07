Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC80C4828F
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7FA23CF5A4
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:07:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14D6A3CDEAE
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:36 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40EF96096BA
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5261E1F7FF;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E9E4139D8;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aPHCAYqqw2WRSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:06:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 17:06:25 +0100
Message-ID: <20240207160628.125908-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207160628.125908-1-pvorel@suse.cz>
References: <20240207160628.125908-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5261E1F7FF
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib/tst_tmpdir: Normalize user defined TMPDIR
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

Follow the changes to shell API 273c49793 ("tst_test.sh: Remove possible
double/trailing slashes from TMPDIR") and remove: 1) trailing slash
2) double slashes.

This is needed, because some tests compare file path of files which are
in TMPDIR with strcmp() or and extra slashes break it (e.g. chdir01A,
ioctl_loop0[12], mount0[67]).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_tmpdir.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index b73b5c66f..bc9351251 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -124,7 +124,8 @@ char *tst_get_tmpdir(void)
 
 const char *tst_get_tmpdir_root(void)
 {
-	const char *env_tmpdir = getenv("TMPDIR");
+	char *p, *env_tmpdir = getenv("TMPDIR");
+	int fixed = 0;
 
 	if (!env_tmpdir)
 		env_tmpdir = TEMPDIR;
@@ -134,6 +135,23 @@ const char *tst_get_tmpdir_root(void)
 				"pathname for environment variable TMPDIR");
 		return NULL;
 	}
+
+	if (env_tmpdir[strlen(env_tmpdir)-1] == '/') {
+		env_tmpdir[strlen(env_tmpdir)-1] = '\0';
+		fixed = 1;
+	}
+
+	while ((p = strstr(env_tmpdir, "//")) != NULL) {
+		memmove(p, p + 1, strlen(env_tmpdir) - (p - env_tmpdir));
+		fixed = 1;
+	}
+
+	if (fixed) {
+		tst_resm(TINFO, "WARNING: Remove double or trailing slashes from TMPDIR,"
+			 " please fix your setup to: TMPDIR='%s'",
+			 env_tmpdir);
+	}
+
 	return env_tmpdir;
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
