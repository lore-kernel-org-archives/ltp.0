Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D582AECAAD4
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 12:36:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3CD03CA6AB
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 14:36:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9D9F3C1351
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:36:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7140A600628
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:36:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 556FE2214C;
 Tue, 30 Aug 2022 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1661862997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uBJ0l8MN5jLyRcLPQkR+lRnM/nK14FuY0CfIGTePqx8=;
 b=Etf2UBZT2+KVELXJBjNiBPu+uTu98GkK62pC3tA2awwOARV2vElcySYA4JBy1U9sqT6o8Q
 1FLA/JQF40jhVrDJc0I2RT+aNVkiPANSQKHHZkUD1Wx/3bbNBEyY54CT0aJnTUsO/jxoAY
 ytCqvK2aFo3v8Dc0zcgaZuY162senc0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5D7D13B0C;
 Tue, 30 Aug 2022 12:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jmWHKlQEDmM+agAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 30 Aug 2022 12:36:36 +0000
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 14:35:42 +0200
Message-Id: <20220830123542.1912-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Improve safe_setxattr error message on ENOTSUP
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

According with setxattr manual, ENOTSUP is related also with an
invalid namespace/name format.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/safe_macros.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a5b6bc504..5671f66fb 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1011,7 +1011,7 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 	if (rval == -1) {
 		if (errno == ENOTSUP) {
 			tst_brkm_(file, lineno, TCONF, NULL,
-				"no xattr support in fs or mounted without user_xattr option");
+				"no xattr support in fs, mounted without user_xattr option or bad name format");
 			return rval;
 		}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
