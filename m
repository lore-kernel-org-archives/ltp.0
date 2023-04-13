Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D47C77B6F
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 11:14:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 124753CC4A6
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 13:14:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10CA93CA262
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 13:14:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 84DCB1A006B7
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 13:14:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 596701F383;
 Thu, 13 Apr 2023 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681384478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+qXV9tDqphwKsSvajxhM1TlHyrmwPnRJTVwzPH1TyGc=;
 b=dpLekxicD/j4PeaGIzn25rhnxlGRQPFXVd4bssLsgr4LeMGwj1F1Km+JIW7wsWHKg3TD+M
 bjRzwtuzP72VPxkHtkgF25te+Igj1AYlAKT/UPJI4Rj+VROITa0LYgH0L6dATDKKWz/ksB
 iOyWpOW1qcimE+hAlVKIUSqF3xvVFSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681384478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+qXV9tDqphwKsSvajxhM1TlHyrmwPnRJTVwzPH1TyGc=;
 b=QH3uVSehe7R2IhZdq7xpRrxSpP8c/gHPpYxxvvyFA6D3cpyDG0HW20nklbJcj6677gNag+
 XjajrPhg3uZwFkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30F8013421;
 Thu, 13 Apr 2023 11:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZldPCh7kN2Q+YQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Apr 2023 11:14:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 13 Apr 2023 13:14:34 +0200
Message-Id: <20230413111434.2103422-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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

Similarly to previous commit, which normalized TMPDIR for shell API,
do the same for C API.

Unlike for shell API, here we modify $TMPDIR directly, because
tst_get_tmpdir_root() is used o more places.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Follow up of the same change in shell API:
https://lore.kernel.org/ltp/20230412073953.1983857-1-pvorel@suse.cz/

Kind regards,
Petr

 lib/tst_tmpdir.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index b73b5c66f..8db5c47e8 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -124,16 +124,28 @@ char *tst_get_tmpdir(void)
 
 const char *tst_get_tmpdir_root(void)
 {
-	const char *env_tmpdir = getenv("TMPDIR");
+	char *env_tmpdir = getenv("TMPDIR");
 
-	if (!env_tmpdir)
+	if (env_tmpdir) {
+		/* remove duplicate slashes */
+		for (char *p = env_tmpdir, *q = env_tmpdir; *q;) {
+			if (*++q != '/' || *p != '/')
+				*++p = *q;
+		}
+		/* Remove slash on the last place  */
+		size_t last = strlen(env_tmpdir)-1;
+		if (env_tmpdir[last] == '/')
+			env_tmpdir[last] = '\0';
+	} else {
 		env_tmpdir = TEMPDIR;
+	}
 
 	if (env_tmpdir[0] != '/') {
 		tst_brkm(TBROK, NULL, "You must specify an absolute "
 				"pathname for environment variable TMPDIR");
 		return NULL;
 	}
+
 	return env_tmpdir;
 }
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
