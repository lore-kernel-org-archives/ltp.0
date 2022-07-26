Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C59FC43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:15:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C0C3C9ADB
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:15:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CDF03C05C3
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:15:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 912092009D9
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:15:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C86237698
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658826932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UgCREpzj98tPz2d1rgsuaE87q/Hu7iGN6IVv2viKRxk=;
 b=zJRb+bKo3rdmrxrVQMXWabxFVZG6zdpzoAIC2LWFFqiQthFerch+G/9uX4mtOLJEgz2dEj
 U4qp6eprbF3/F4k6NMWYX6Emzlfuio2zO6W15xI7q57RA3KSfxDWkbJyXJLO3nHnuH+qIj
 YUd/RBxyWHnQv+JRa46aoKpGtvsXOsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658826932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UgCREpzj98tPz2d1rgsuaE87q/Hu7iGN6IVv2viKRxk=;
 b=eaXftwW4bx1cFWders+tOTakaepizl2GAmJhHJaC701cXFVu73lIqGS+fAcfMBDLFH6PJP
 MTKcjt0EoNhPnlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5C5F13A7C
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fvibJLOw32LZHwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:15:31 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 26 Jul 2022 14:45:28 +0530
Message-Id: <20220726091528.29864-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] dup204.c: use TST_EXP_VAL() and TST_EXP_EQ_LU() macros
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
 testcases/kernel/syscalls/dup2/dup204.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index 0fb6b0dc2..112ce0c9d 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -35,23 +35,14 @@ static void run(unsigned int i)
 {
 	struct stat oldbuf, newbuf;
 
-	TEST(dup2(fd[i], nfd[i]));
-	if (TST_RET == -1) {
-		tst_res(TFAIL, "call failed unexpectedly");
+	TST_EXP_VAL(dup2(fd[i], nfd[i]), nfd[i]);
+	if (TST_RET == -1)
 		return;
-	}
 
 	SAFE_FSTAT(fd[i], &oldbuf);
 	SAFE_FSTAT(nfd[i], &newbuf);
 
-	if (oldbuf.st_ino != newbuf.st_ino)
-		tst_res(TFAIL,
-			"original inode(%ld) and duped inode(%ld) do not match",
-			oldbuf.st_ino, newbuf.st_ino);
-	else
-		tst_res(TPASS,
-			"original inode(%ld) and duped inode(%ld) are the same",
-			oldbuf.st_ino, newbuf.st_ino);
+	TST_EXP_EQ_LU(oldbuf.st_ino, newbuf.st_ino);
 
 	SAFE_CLOSE(TST_RET);
 }
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
