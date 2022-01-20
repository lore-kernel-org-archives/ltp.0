Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B3C433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 15:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62C8C3C9698
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 16:04:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC2AD3C91AD
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 16:04:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C59101A010FF
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 16:04:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03C6B21903;
 Thu, 20 Jan 2022 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642691063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zJDUtWOmU1bCS68ROs7lJrPUNIHv9pbn+UcNJJ1Mnu4=;
 b=nXL9EOgpGTcWoavNPsegt4Zferz8x9SahTx7mHAsi2HUcym2X7VyGan6NgvbYbG7vOVEPO
 jDB6wcKDXxREatiDoXjNOE3lGuqinDtfewe7pCwwRurTiQuh0tTA9Z5PU9O8G7XAfvwwQv
 AXx0VnweWPnyB/l69ui7W7bllOFeVjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642691063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zJDUtWOmU1bCS68ROs7lJrPUNIHv9pbn+UcNJJ1Mnu4=;
 b=y1DyJX7rBEEBm4eGrkXSYkXguggPQzL+E9OiQF7tZKT55vNAlIYjicu88Y+LdZQEdC6UrS
 cLYW8erJq1gYAbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B823C13BD2;
 Thu, 20 Jan 2022 15:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DHWFKvZ56WFwLwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Jan 2022 15:04:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 20 Jan 2022 16:04:21 +0100
Message-Id: <20220120150421.26639-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/ltp-aiodio.part4 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index fc1e1d479..8c10f67fb 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -62,7 +62,7 @@ DIT002 dio_truncate
 #Running read_checkzero
 #gread_checkzero
 #Running dio_read
-DOR000 dio_read -n 1 -i 100
-DOR001 dio_read -n 10 -i 30
-DOR002 dio_read -n 20 -i 15
-DOR003 dio_read -n 100 -i 4
+DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 5M
+DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 5M
+DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 5M
+DOR003 dio_read -n 100 -i 4 -r 512k -w 512k -s 5M
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
