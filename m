Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A42C77B7C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 10:45:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A336C3CB690
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 12:45:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2122F3CB6CD
 for <ltp@lists.linux.it>; Fri,  5 May 2023 12:44:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 32354600695
 for <ltp@lists.linux.it>; Fri,  5 May 2023 12:44:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 050D52231C
 for <ltp@lists.linux.it>; Fri,  5 May 2023 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1683283494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FBepsudVXHWpqAOornySCD7SCOPajRuG9ieKPggmpkE=;
 b=EgjYOa2N3A0gIA5BJH/5+K+WJB12lYsZ72+s4B3IN7/szj5YuTiFpo4uZKnCXDTHArkRlA
 D4KIrAN7GTQe8QGN2KedMkFwN24LiYSFm78Lf6xGQAi55oLQ+RCUckHjdID611g8KpZ70g
 FSdmaxoBBt/mN0dfKfncHYMpJz3iVhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1683283494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FBepsudVXHWpqAOornySCD7SCOPajRuG9ieKPggmpkE=;
 b=/Yj8l6Zx2wKhXO8PcWlfY6kNr9jpA2SXD18Rir/TldEPBc+EkvKVZwem9BhK7IdfC8EWV+
 8re1OpwsHkkIxUCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A45F313513
 for <ltp@lists.linux.it>; Fri,  5 May 2023 10:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2y2VHiXeVGR5AgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 05 May 2023 10:44:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  5 May 2023 16:14:51 +0530
Message-Id: <20230505104451.21970-1-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] update README.md
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

as we no longer have the file doc/mini-howto-building-ltp-from-git.txt

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 README.md | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/README.md b/README.md
index d7cb4d346..68f6ec897 100644
--- a/README.md
+++ b/README.md
@@ -101,8 +101,7 @@ $ make install
 ```
 
 This will install LTP to `/opt/ltp`.
-* If you have a problem see `doc/mini-howto-building-ltp-from-git.txt`.
-* If you still have a problem see `INSTALL` and `./configure --help`.
+* If you have a problem see `INSTALL` and `./configure --help`.
 * Failing that, ask for help on the mailing list or Github.
 
 Some tests will be disabled if the configure script can not find their build
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
