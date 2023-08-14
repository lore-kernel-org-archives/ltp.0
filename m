Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AA7C001E0
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 23:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A80813CD598
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 01:27:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4703CCE5B
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 01:27:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8381360078C
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 01:27:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F0E21F7AB;
 Mon, 14 Aug 2023 23:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1692055619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ajxzgnYAICeD5MEHf9kTx4oNZYtWgvnCxUT5LbTeYSA=;
 b=PdABPL2Mi0krya6vysm2YbyqJJevQ+eURD472No6f/vxY9b7tjUTQn3QRCooBmIvnpUn9v
 TJ/lSE500lAG3vBm29kFNroTVs6NaCy4ouX9csXHTETw9cEyyL0aWW3ebWl0MGPTfegpHa
 c56oBRNQ0JRVHSUEJznWTcV4SXj/LnE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3FCB138EE;
 Mon, 14 Aug 2023 23:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qGPFLUK42mQiVQAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 14 Aug 2023 23:26:58 +0000
To: ltp@lists.linux.it
Date: Mon, 14 Aug 2023 19:26:43 -0400
Message-Id: <20230814232643.17673-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Regression check for unlink fail issue after
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
 testcases/kernel/syscalls/bind/bind03.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index 37a040b29..12285acb9 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -43,8 +43,13 @@ static void run(void)
 	 * locks the socket and does all the checks and the node is not removed
 	 * in the error path. For now we will unlink the node here so that the
 	 * test works fine when the run() function is executed in a loop.
+	 * From v5.14-rc1 the kernel has fix above issue.
 	 */
-	unlink(SNAME_B);
+	if (tst_kvercmp(5, 14, 0) >= 0) {
+		TST_EXP_FAIL(unlink(SNAME_B), ENOENT,"check exist of SNAME_B");
+	} else {
+		unlink(SNAME_B);
+	}
 }
 
 static void setup(void)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
