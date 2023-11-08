Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF4FC4332F
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 07:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08EB03CC669
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 08:50:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B741C3C62E0
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 08:49:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93C06600298
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 08:49:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 645EE1F8AC;
 Wed,  8 Nov 2023 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699429788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QEmeo1dgJm8CzQdA7AqnH94yBY6TPjT6xfUNxwTTECk=;
 b=2m216nCq7wNCi3keSqUgXAeCLaIzeRhKG8ykNGFMM1Qru+tvlZs3VaIeFDTpHhNC41ZSJV
 2rl+mIXBs+ZeZqvnDYU8YqK3ErUTBFL7+V/ckvGZm+47Icnyu9ID2cvQtqHDwR+W0sy/NE
 HTzz7UNV2qKXTRn5Uflzmmr4uS7+EWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699429788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QEmeo1dgJm8CzQdA7AqnH94yBY6TPjT6xfUNxwTTECk=;
 b=ks073aiamCoHhPT/LsV0+0GtowA39mho+C9PV8LzMLzAXU7O2zNkcrl12cdyaiA6VNvSzc
 pGdLWP9un5jLvFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B8CB133F5;
 Wed,  8 Nov 2023 07:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cRtbDZw9S2WrIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Nov 2023 07:49:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Nov 2023 08:49:34 +0100
Message-ID: <20231108074935.1409644-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] link05: Return on link() failure
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If link() fails to be created, the following stat() failed:

link05.c:39: TBROK: stat(lkfile_1391822_1,0x7ffd61e5f000) failed: ENOENT (2)

Therefore skip testing and improve the error message:
5: link(lkfile_1404879, lkfile_1404879_5) failed: ENOENT (2)

Also fix cnt and nlinks condition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@Xu, please merge your "link05: Convert docs to docparse" patchset [1]
first, I'll rebase my afterwards.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20231108053122.GA1383908@pevik/

 testcases/kernel/syscalls/link/link05.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 9b81ef3fd..1d708c6f6 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -22,13 +22,16 @@ static int nlinks = 1000;
 
 static void verify_link(void)
 {
-	int cnt;
+	int cnt = 0, created;
 	char lname[1024];
 	struct stat fbuf, lbuf;
 
-	for (cnt = 1; cnt < nlinks; cnt++) {
-		sprintf(lname, "%s_%d", fname, cnt);
-		TST_EXP_PASS_SILENT(link(fname, lname), "link(%s, %s)", fname, lname);
+	for (created = 1; created < nlinks; created++) {
+		sprintf(lname, "%s_%d", fname, created);
+		TST_EXP_PASS_SILENT(link(fname, lname), "%d: link(%s, %s)", created,
+							fname, lname);
+		if (!TST_PASS)
+			goto cleanup;
 	}
 
 	SAFE_STAT(fname, &fbuf);
@@ -48,13 +51,14 @@ static void verify_link(void)
 		}
 	}
 
-	if (cnt >= nlinks) {
+	if (cnt == nlinks) {
 		tst_res(TPASS,
 			 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
 			 fname, fname, nlinks, TST_RET, nlinks, (int)fbuf.st_nlink);
 	}
 
-	for (cnt = 1; cnt < nlinks; cnt++) {
+cleanup:
+	for (cnt = 1; cnt < created; cnt++) {
 		sprintf(lname, "%s_%d", fname, cnt);
 		SAFE_UNLINK(lname);
 	}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
