Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0803FEB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 09:15:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E06853CDC6F
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 11:15:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF2F93C9481
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 61E551000D43
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B366A1F8D5;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689930922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04Fuv8A2X3iotfgHYI4YNYjLC3OxXC0fbvfCWsfXuIU=;
 b=qwDC1jeXM9aUsC/xwujW1K3Mk31h6TfpXUfz5YnrPbAEdpwut/COxbja2//lSjvv/JpMZO
 WrSKWlULhjXT2zccDJjRYQ38YOhr+/ec18RiH6y+wAionhjn92EYtzhc8zTsUMj5xPp2sC
 6qsVfJsqPWQj4nKnPwVwAq0g7maOgMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689930922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04Fuv8A2X3iotfgHYI4YNYjLC3OxXC0fbvfCWsfXuIU=;
 b=lCCVLZtX+GWTiOEuklGSiVy46zVnSWlC07w9WVPejRWd7xl26SJuxd8qaRAxwO54OPAF6v
 B3jpaLyvB1KS0EBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8909A134B0;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qLTEH6pMumRSawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 09:15:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 11:15:12 +0200
Message-Id: <20230721091515.1353371-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721091515.1353371-1-pvorel@suse.cz>
References: <20230721091515.1353371-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] tst_lockdown_enabled: Print lockdown state
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

This will be used to simplify .skip_in_lockdown in next commit.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_lockdown.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index 4ce4736c3..8f2ee6762 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -47,6 +47,7 @@ int tst_lockdown_enabled(void)
 {
 	char line[BUFSIZ];
 	FILE *file;
+	int ret;
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
 		char flag;
@@ -65,5 +66,8 @@ int tst_lockdown_enabled(void)
 		tst_brk(TBROK | TERRNO, "fgets %s", PATH_LOCKDOWN);
 	SAFE_FCLOSE(file);
 
-	return (strstr(line, "[none]") == NULL);
+	ret = strstr(line, "[none]") == NULL;
+	tst_res(TINFO, "Lockdown: %s", ret ? "on" : "off");
+
+	return ret;
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
