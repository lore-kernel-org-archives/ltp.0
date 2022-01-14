Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE128C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 21:00:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA02F3C0F6A
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 22:00:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FEF93C0F6A
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 22:00:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 618C71400B88
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 22:00:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92A8C21907;
 Fri, 14 Jan 2022 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642194038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XWT5obSkTTchSRj2wPM0j8ZkS9qkzGOZTJRrelDT1RY=;
 b=t+UAUNIu71gIWB0ll7wTVRxOG41ADemTDqBPRuHHETXf1ayDfgbxBI/ArxPuaP2DSXnQx1
 ca+Wceh+NeCzAUx1JKsa7UzMVRQpGlRoThqzjc/sDnKHpmi0f0GIvg3SNgjvk6cPTp3XhV
 5e4anq7uWEHEaYiyjkMglpbxFxoueWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642194038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XWT5obSkTTchSRj2wPM0j8ZkS9qkzGOZTJRrelDT1RY=;
 b=UoJKYLBSypAfBXWLeSoMY/9eCLZLW3fHqBmy9ifPmN0XWKF08ke5/7YcRxNDf4rbIrMsQd
 nRp4np7MKm3bDRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3239113BB4;
 Fri, 14 Jan 2022 21:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /Ow6B3bk4WF2WwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 21:00:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 22:00:34 +0100
Message-Id: <20220114210034.16177-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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

Use the same name as in tst_fs_type_name() to actually skip it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
"v9fs is a Unix implementation of the Plan 9 9p remote filesystem
protocol." [1]

NOTE: filesystem is called v9fs, but mount parameter is "9p"
that's probably the reason why named "9p" and not "v9" in
tst_fs_type_name().

Kind regards,
Petr

[1] https://www.kernel.org/doc/html/latest/filesystems/9p.html

 testcases/kernel/syscalls/utime/utime03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 48cc3bae77..823bc5f72a 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]) {
-		"v9",
+		"9p",
 		"vfat",
 		"exfat",
 		NULL
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
