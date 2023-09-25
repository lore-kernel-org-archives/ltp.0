Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBB5CE7A95
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:47:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A4CA3CE27C
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:47:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68A3D3CE22E
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:47:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F5262000FD
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:47:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5575F210DD
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695656840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NYMUO4WmWaWBLeYlLpjymSCOeh3FYyXzeGYU57GmGQ0=;
 b=qA/Lri11JFA2T5GlkZ0vQR+Z2fAWGSrkJ17Nt81DFlQNc6bIPJFos3v5TunaWiGDwk/iR7
 WDXdy4WuFCry95W4XrNW29DM1HE3GflX4lTs9vALEjznlaLditv8pQD8wRDXwgUKhFKLuk
 7PS4Lnc0SfaeWc030ChVpUvtSkrdbxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695656840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NYMUO4WmWaWBLeYlLpjymSCOeh3FYyXzeGYU57GmGQ0=;
 b=2yC6LU0z3pTz45fULNZPRzV4/oR4O9qiBJ4IgR/S7NCMZyRT+OrHDWfT6DrH4aQbVm5Ljt
 uc1HcPgFuIkgMQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E567B1358F
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0cfULIerEWUIYQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:47:19 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 21:17:16 +0530
Message-ID: <20230925154717.26594-1-akumar@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] docparse/README: Typo fix
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 docparse/README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/README.md b/docparse/README.md
index db156e64d..9ccfa44af 100644
--- a/docparse/README.md
+++ b/docparse/README.md
@@ -48,7 +48,7 @@ given test, as obviously we cannot run two tests that monopolize the same
 resource. In some cases we would also need to partition the system resource
 accordingly, e.g. if we have two memory stress tests running at the same time
 we will need to cap each of these tests on half of the available memory, or
-make sure that sum of the memory used by these two tests is not greater an
+make sure that sum of the memory used by these two tests is not greater than
 available memory.
 
 Examples of such tests are:
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
