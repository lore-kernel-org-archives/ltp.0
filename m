Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF9C001B0
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 07:05:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC1E03CCD7B
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 09:05:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 620963CB059
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 09:05:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 75492200041
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 09:05:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C268C2199B;
 Tue, 15 Aug 2023 07:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1692083123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBIRYKMeHERZeGzpS5gbR07yq/6IxG5qGIotO/IwR4c=;
 b=QjuUPLwW5JwV1SjzB/G47ECie0juOflNomnItSF+4ijCtXeLkSq1U1foALEt+88qx4T+rE
 3eTsfOFQg6RK34+kSHhBoR2dn8ffjIaBCyP0Lt3xwWw7w1+tEV09wvYc72Zs9igALiqEuq
 GAzL/stOhRAhYrNBY+KZY/Lzfm+zxSo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F10861353E;
 Tue, 15 Aug 2023 07:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C6paL7Ij22S2fAAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 15 Aug 2023 07:05:22 +0000
To: ltp@lists.linux.it
Date: Tue, 15 Aug 2023 03:05:18 -0400
Message-Id: <20230815070518.21641-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814232643.17673-1-wegao@suse.com>
References: <20230814232643.17673-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Regression check for unlink fail issue after
 successful mknod
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Write a regression test once making unix_bind() undo mknod on failure patchset is merged.

Kernel patch detail:
git describe --contains c0c3b8d380a8f54c75786d41f6f9efbe761dac6c
v5.14-rc1119^286
git log -p c0c3b8d380a8f54c75786d41f6f9efbe761dac6c
commit c0c3b8d380a8f54c75786d41f6f9efbe761dac6c
Author: Al Viro viro@zeniv.linux.org.uk
Date: Sat Jun 19 03:50:32 2021 +0000
unix_bind_bsd(): unlink if we fail after successful mknod

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/bind/bind03.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index 37a040b29..8c95cd799 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -43,8 +43,12 @@ static void run(void)
 	 * locks the socket and does all the checks and the node is not removed
 	 * in the error path. For now we will unlink the node here so that the
 	 * test works fine when the run() function is executed in a loop.
+	 * From v5.14-rc1 the kernel has fix above issue.
 	 */
-	unlink(SNAME_B);
+	if (tst_kvercmp(5, 14, 0) >= 0)
+		TST_EXP_FAIL(unlink(SNAME_B), ENOENT, "check exist of SNAME_B");
+	else
+		unlink(SNAME_B);
 }
 
 static void setup(void)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
