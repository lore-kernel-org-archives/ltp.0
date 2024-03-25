Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE49C54E64
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 11:51:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A6E13CFEDB
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 12:51:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D51303CFEC6
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:43 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 64DC81A00E2E
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE3425C61A;
 Mon, 25 Mar 2024 11:50:40 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE8F413ABC;
 Mon, 25 Mar 2024 11:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id YPSRLRBlAWZSCQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 25 Mar 2024 11:50:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Mar 2024 12:50:32 +0100
Message-ID: <20240325115034.643892-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325115034.643892-1-pvorel@suse.cz>
References: <20240325115034.643892-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: DE3425C61A
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lib/tst_tmpdir: Normalize user defined TMPDIR
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

Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_tmpdir.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index b73b5c66f..b6e51ba0a 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -124,16 +124,32 @@ char *tst_get_tmpdir(void)
 
 const char *tst_get_tmpdir_root(void)
 {
-	const char *env_tmpdir = getenv("TMPDIR");
+	char *env_tmpdir = getenv("TMPDIR");
+	char prev_c = 0;
+	size_t k = 0;
 
 	if (!env_tmpdir)
-		env_tmpdir = TEMPDIR;
+		env_tmpdir = strdup(TEMPDIR);
 
 	if (env_tmpdir[0] != '/') {
 		tst_brkm(TBROK, NULL, "You must specify an absolute "
 				"pathname for environment variable TMPDIR");
 		return NULL;
 	}
+
+	for (int i = 0; env_tmpdir[i] != '\0'; i++) {
+		if (i)
+			prev_c = env_tmpdir[i-1];
+
+        if (env_tmpdir[i] != '/' || prev_c != '/')
+            env_tmpdir[k++] = env_tmpdir[i];
+	}
+
+	env_tmpdir[k] = '\0';
+
+	if (env_tmpdir[k-1] == '/')
+		env_tmpdir[k-1] = '\0';
+
 	return env_tmpdir;
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
