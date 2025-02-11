Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7498CC0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 20:57:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D48423C998A
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 21:57:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECD4A3C769D
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:57:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E2D061E248
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:57:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 424F71F7DF;
 Tue, 11 Feb 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13A5313AA6;
 Tue, 11 Feb 2025 20:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iB5+A8G5q2doSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 20:57:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 21:57:34 +0100
Message-ID: <20250211205734.1932275-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211205734.1932275-1-pvorel@suse.cz>
References: <20250211205734.1932275-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 424F71F7DF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tst_test.sh: Convert only TBROK/TCONF to TWARN
 in cleanup
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

Second attempt to convert only TBROK/TCONF to TWARN in cleanup().

Also print original message to help find function call with wrong
parameter.

Fixes: 55bfa08e17 ("tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 testcases/lib/tst_test.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 5a6e34473f..0747f7aaf4 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -126,11 +126,17 @@ tst_brk()
 	local res=$1
 	shift
 
-	if [ "$res" != TBROK -a "$res" != TCONF ]; then
-		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res)"
-	elif [ "$TST_TBROK_TO_TWARN" = 1 ]; then
-		tst_res TWARN "$@"
+	if [ "$TST_TBROK_TO_TWARN" = 1 ]; then
+		if [ "$res" != TBROK -a "$res" != TCONF ]; then
+			tst_res TWARN "tst_brk can be called only with TBROK or TCONF ($res, msg: '$@')"
+		else
+			tst_res TWARN "$@"
+		fi
 		return
+	fi
+
+	if [ "$res" != TBROK -a "$res" != TCONF ]; then
+		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res, msg: '$@')"
 	else
 		tst_res "$res" "$@"
 	fi
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
