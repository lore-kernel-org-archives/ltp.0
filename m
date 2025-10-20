Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7848CCCD199
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 14:28:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B3A83CEC45
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 16:28:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DE543CEC45
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 16:28:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03B4360005A
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 16:28:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 255951F391;
 Mon, 20 Oct 2025 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760970502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zXpWjnyICONobL6S1n+VSYtAduCBkDmIQYhla4r9seU=;
 b=aKCNctcUzFb38ewEdi/9OETC+DOy1NUuefrdjTlHgjGJBmWIst9MvUlwcON7T/gMkUv65o
 LFSr92t4YexaI/kJ27RtThaLcnFGyauYJsSC6mdal4oAGAVJb7H3RQZ+PzELdOt3P6sF3x
 Jsmbm42sln1QbeecQ0MlLtrLNCDQt70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760970502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zXpWjnyICONobL6S1n+VSYtAduCBkDmIQYhla4r9seU=;
 b=nd5VCyMflghZdlhv3l/NGAu3GzMDQiw5Ejxb2yUvsqtI/AdUL2piE7GKZd2QbmvMvoh2eg
 NWkxfCKu1h5D93Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760970498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zXpWjnyICONobL6S1n+VSYtAduCBkDmIQYhla4r9seU=;
 b=ZzZrO47ukOhFT1bkZFRpCrS6AYdrSsZnOZenLwfibwf1S/KNSOKWzRO9n3Po9lVfRzj+a1
 yrGnnil5YiMuf4rHqD5Y9c0Qi2TgHx/uiKlPNsWBecqdfke7hrE4B6y53wveQpdy9DmMR1
 mptHUr2V1ENh9cx2AGf+hvxHA/N8qnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760970498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zXpWjnyICONobL6S1n+VSYtAduCBkDmIQYhla4r9seU=;
 b=KXg1Rr7KZkMYWywfxCVW+WL8bec+1ZC3lMWrs96EmsgZCBlYBMbwfrw+lHqgIDySNhYXG6
 VmaaXfSJoPAMORCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7DFC13A8E;
 Mon, 20 Oct 2025 14:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RH5YMwFH9mguIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Oct 2025 14:28:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Oct 2025 16:28:13 +0200
Message-ID: <20251020142813.415231-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_cmd: Change tst_check_cmd() return type to int
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

Function use just bool value, no need for int (readability).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_private.h | 2 +-
 lib/tst_cmd.c         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/tst_private.h b/include/tst_private.h
index 292f7e9366..87ec8829a1 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -45,7 +45,7 @@ char tst_kconfig_get(const char *confname);
  * function checks command version whether meets this requirement.
  * If not, case breaks if brk_nosupp is defined.
  */
-int tst_check_cmd(const char *cmd, const int brk_nosupp);
+bool tst_check_cmd(const char *cmd, const int brk_nosupp);
 
 /*
  * Returns NULL-terminated array of kernel-supported filesystems.
diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 82d60497a8..2faf7c7430 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <signal.h>
+#include <stdbool.h>
 #include "test.h"
 #include "tst_cmd.h"
 #include "tst_private.h"
@@ -249,7 +250,7 @@ static struct version_parser {
 	{},
 };
 
-int tst_check_cmd(const char *cmd, const int brk_nosupp)
+bool tst_check_cmd(const char *cmd, const int brk_nosupp)
 {
 	struct version_parser *p;
 	char *cmd_token, *op_token, *version_token, *next, *str;
@@ -268,7 +269,7 @@ int tst_check_cmd(const char *cmd, const int brk_nosupp)
 		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
 
 	if (!op_token)
-		return 0;
+		return true;
 
 	if (!version_token || str) {
 		tst_brkm(TCONF, NULL,
@@ -318,7 +319,7 @@ int tst_check_cmd(const char *cmd, const int brk_nosupp)
 		tst_brkm(TCONF, NULL, "Invalid op(%s)", op_token);
 	}
 
-	return 0;
+	return true;
 error:
 	if (brk_nosupp) {
 		tst_brkm(TCONF, NULL, "%s requires %s %d, but got %d",
@@ -328,5 +329,5 @@ error:
 			cmd, op_token, ver_get, ver_parser);
 	}
 
-	return 1;
+	return false;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
