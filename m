Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F8ACCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:30:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60C33CEFA2
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:30:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092AA3CEF07
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 879CE600CF8
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:29:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C85E1F788;
 Fri,  7 Nov 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE60132DD;
 Fri,  7 Nov 2025 10:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wO5JFhfKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:33 +0100
Message-ID: <20251107102939.1111074-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 9C85E1F788
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/8] tst_cmd.c: Check brk_nosupp when tst_get_path
 failed
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

From: Wei Gao <wegao@suse.com>

Fixes: 257394e4e3 ("Filter mkfs version in tst_fs")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
[ pvorel: fix return value: 1 => false ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: this replaces Wei's patch
https://patchwork.ozlabs.org/project/ltp/patch/20251107003041.28929-2-wegao@suse.com/
https://lore.kernel.org/ltp/20251107003041.28929-2-wegao@suse.com/

 lib/tst_cmd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 2faf7c7430..79f547ab5d 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -265,8 +265,14 @@ bool tst_check_cmd(const char *cmd, const int brk_nosupp)
 	version_token = strtok_r(NULL, " ", &next);
 	str = strtok_r(NULL, " ", &next);
 
-	if (tst_get_path(cmd_token, path, sizeof(path)))
-		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+	if (tst_get_path(cmd_token, path, sizeof(path))) {
+		if (brk_nosupp) {
+			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+		} else {
+			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
+			return false;
+		}
+	}
 
 	if (!op_token)
 		return true;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
