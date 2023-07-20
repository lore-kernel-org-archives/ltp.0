Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8607BEB64DC
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 612413CAE7B
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:02:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 037DD3CE974
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA3A510011DB
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D80EC21CE2;
 Thu, 20 Jul 2023 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689865333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVSitUF3n+H7SVlGIBc2/8ex23puKYes0SLZPr2RsTs=;
 b=C/RB20mAWG6K/gUhIPaCpmE4/QqRzBa8cab5wAOF+bKfMWHWDYAuLMdY7PSCgzFccxYVJL
 jDqwda+iX5uyV9s+5pstLDoOOBFS4YXb98Zw3MwuYGHd23vGgTjxq/EocezSQxIJq04onX
 0WRegEPNeqAYixRNMw7WbkFZ2FDMxwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689865333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVSitUF3n+H7SVlGIBc2/8ex23puKYes0SLZPr2RsTs=;
 b=tJP+/ffCHrZGi0wLWAbaWeVDBJIDXaFHoy1ER3UKOqdTjGpPMrF5eDOxU9LpyrSL1mQVd0
 yUIoFrvuLENY2YDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B335C138EC;
 Thu, 20 Jul 2023 15:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mK8vKXVMuWR6CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jul 2023 15:02:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jul 2023 17:02:03 +0200
Message-Id: <20230720150206.1338520-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720150206.1338520-1-pvorel@suse.cz>
References: <20230720150206.1338520-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] tst_lockdown: Check other lockdown configuration
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

Originally we checked only CONFIG_EFI_SECURE_BOOT_LOCK_DOWN=y
(non-mainline patch from 2017 [1]. Various distros (older releases) use
other newer non-mainline patch [2] (originally from Fedora 32), which with
CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT=y forces lockdown, when in secure boot.

[1] https://lore.kernel.org/lkml/149141204578.30815.1929675368430800975.stgit@warthog.procyon.org.uk/
[2] https://lore.kernel.org/lkml/150842483945.7923.12778302394414653081.stgit@warthog.procyon.org.uk/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_lockdown.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index 26a57b6a1..f91bc919d 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -47,18 +47,21 @@ int tst_lockdown_enabled(void)
 {
 	char line[BUFSIZ];
 	FILE *file;
+	char flag;
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
-		char flag;
-
+		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
 		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");
-
-		/* SecureBoot enabled could mean integrity lockdown */
 		if (flag == 'y' && tst_secureboot_enabled() > 0)
 			return 1;
 
 		tst_res(TINFO, "Unable to determine system lockdown state");
 		return 0;
+	} else {
+		/* SecureBoot forces lockdown (non-mainline version) */
+		flag = tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT");
+		if (flag == 'y' && tst_secureboot_enabled() > 0)
+			return 1;
 	}
 
 	file = SAFE_FOPEN(PATH_LOCKDOWN, "r");
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
