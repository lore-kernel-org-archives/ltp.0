Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792D9ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 14:10:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A8303CA96F
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 16:10:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3BEA3C0895
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 16:10:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D1B6600C75
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 16:09:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81A5721C97
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666879797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FeqUqVwCvoAHmIeQk0iNPc+qAZnE9+4Ii6DLXG+ObD4=;
 b=yjfMUkoJ/xfNZG2lupJS9+5EJL8ixTagTIXHpnEtDGBtOot8KZvKO70QPjLj87ejHVVo2y
 g9rq0ZrV5Qtd2ZvwBwYBzFt6hXfSnJ0Ww/DFc3ZAFQ4SwyNWpiFcvXT88qddnN5thKBBhD
 0awnL+qvOATt7gPt2ovLjaf2MyzvJY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666879797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FeqUqVwCvoAHmIeQk0iNPc+qAZnE9+4Ii6DLXG+ObD4=;
 b=WYu0DBPasljWoJWWn1V/1v38aBUQ+KYV50KrHoBN+ZqyP63E4WV/b87pZf6VyoAz0ztb6c
 Xn7Z3GGbYRbv/AAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0439313357
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 14:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sEccLjSRWmNEBgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 14:09:56 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Oct 2022 19:39:54 +0530
Message-Id: <20221027140954.4094-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for setfsuid()
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

a uid which does not have an entry in the /etc/passwd
file is not really an invalid fsuid for setfsuid(), so changing
the test to use -1 as an invalid fsuid.
And second setfsuid(-1) call is to verify that preceding call has
actually failed and there is no change in the fsuid.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/setfsuid/setfsuid02.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index 850f17834..f5aa1c004 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -21,9 +21,7 @@ static void run(void)
 	uid_t invalid_uid, current_uid;
 
 	current_uid = geteuid();
-	invalid_uid = 1;
-	while (getpwuid(invalid_uid))
-		invalid_uid++;
+	invalid_uid = -1;
 
 	UID16_CHECK(invalid_uid, setfsuid);
 
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
