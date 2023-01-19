Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A627C00A5A
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 03:13:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17B9B3CC8A2
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 04:13:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E1B63CB48A
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 04:13:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7E28200C78
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 04:13:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D225735022;
 Thu, 19 Jan 2023 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674098015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e0fo0asdKfjYSimvWI38CBEYZaKk40B60fF/y3Zdl+s=;
 b=ExMD3l9SS7DXMn0Q8joen6lqiZI2oWJHEXi7GhG8iN9lKvW9u4jznrbqXPj8ETHE/p9JuQ
 uQwkheFGx1ztJg30LKx7m4LVtW27CPqKZ5SI+Z8NzQpkf0lhk+YlEcdvRXN2GCTyLL8WqF
 LZahsGZ2rA9XTFobdRqTvTRj0ISQFXs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F3CA134F5;
 Thu, 19 Jan 2023 03:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l9ZXAl+1yGMOTgAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 19 Jan 2023 03:13:35 +0000
To: ltp@lists.linux.it
Date: Wed, 18 Jan 2023 22:13:28 -0500
Message-Id: <20230119031328.27345-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] c-test-tutorial-simple.txt:fix typo
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 doc/c-test-tutorial-simple.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index 303a4b27c..62930fdcb 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -814,7 +814,7 @@ master.
 
 [source,shell]
 --------------------------------------------------------------------------------
-$ git log -oneline master..HEAD
+$ git log --oneline master..HEAD
 152d39fe7 (HEAD -> tutorial-rebase2, tutorial-rebase) tutorial: Start Submitting patch section
 70f7ce7ce statx01: Stop checkpatch from complaining
 bb0332bd7 tutorial: Fix review problems
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
