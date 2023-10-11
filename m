Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB1CCD6E5D
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 12:15:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 610073CD55E
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 14:15:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FBD63CB456
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 14:15:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85C7B200BCA
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 14:15:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2A611FEBF;
 Wed, 11 Oct 2023 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697026539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ybwtw9v6FPiAmXqcnOa0VPwsjBobV8Y+DEs1mUKCNZo=;
 b=mI5TNmTPKouc7Zy6Diwdn9Wj9m1Z5aEIuzLVHFKRaqfRoMEoO8+g5nMaySI+5q7sj4JwHW
 yVa4E5QeHwMyDUE+M9B59/WnAZNHXsOq7u/Rj4Ps8r1qfOqJMvNlX9S8hFhByGiPSV7FwE
 Q+nbqufBHRRoenpSDdgpze0NNvh9z1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697026539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ybwtw9v6FPiAmXqcnOa0VPwsjBobV8Y+DEs1mUKCNZo=;
 b=yVPecAMRqm/LmRCIyLZmn53tFM2KdocWHRUvzDso5w3M5HGJt6N8iwrLK54sSqGN9su3/x
 siXvG75B2Bes33CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FA4D138EF;
 Wed, 11 Oct 2023 12:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SEigJeuRJmUsIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 11 Oct 2023 12:15:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 14:14:48 +0200
Message-ID: <20231011121448.23134-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] runtest/syscalls: Add missing entry for splice06
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: 895edeed2ebe ("splice06.c: Add splice check on proc files")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 149c93820..53e519639 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1513,6 +1513,7 @@ splice02 splice02
 splice03 splice03
 splice04 splice04
 splice05 splice05
+splice06 splice06
 
 tee01 tee01
 tee02 tee02
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
