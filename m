Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE79CECAAD4
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 12:39:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42C13CA6F1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 14:39:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6F83CA684
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:39:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 05B431A00CA2
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:39:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 318831F8D1;
 Tue, 30 Aug 2022 12:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1661863183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0zOs5qd6r8cPTShVdL7Flc3bBIMzTsboj2l95TGlcTg=;
 b=GHZy880HUGPVAZJyta9Gt7lBwVzxqIPtX4WAxfbwllsXC2/hmMs32RC6Z/thPIGBG9c66V
 wi+oHlBwoqCCaDGMnQcLK7isQzVKMgNZrdpE/693lcEB2ai5C95gC/4ce18ZcLJL127sko
 DzV8jjK/SBJIkX0faSG94CNJAo7nbcM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D54B513B0C;
 Tue, 30 Aug 2022 12:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Dj4zLg4FDmOBawAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 30 Aug 2022 12:39:42 +0000
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 14:38:49 +0200
Message-Id: <20220830123849.9696-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Improve safe_setxattr error message on ENOTSUP
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
 lib/safe_macros.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a5b6bc504..16e582bc9 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1011,7 +1011,8 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 	if (rval == -1) {
 		if (errno == ENOTSUP) {
 			tst_brkm_(file, lineno, TCONF, NULL,
-				"no xattr support in fs or mounted without user_xattr option");
+				"no xattr support in fs, mounted without user_xattr option "
+				"or invalid namespace/name format");
 			return rval;
 		}
 
@@ -1037,7 +1038,8 @@ int safe_lsetxattr(const char *file, const int lineno, const char *path,
 	if (rval == -1) {
 		if (errno == ENOTSUP) {
 			tst_brkm_(file, lineno, TCONF, NULL,
-				"no xattr support in fs or mounted without user_xattr option");
+				"no xattr support in fs, mounted without user_xattr option "
+				"or invalid namespace/name format");
 			return rval;
 		}
 
@@ -1063,7 +1065,8 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 	if (rval == -1) {
 		if (errno == ENOTSUP) {
 			tst_brkm_(file, lineno, TCONF, NULL,
-				"no xattr support in fs or mounted without user_xattr option");
+				"no xattr support in fs, mounted without user_xattr option "
+				"or invalid namespace/name format");
 			return rval;
 		}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
