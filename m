Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6082DECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 14:24:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A97D3CA6DE
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 16:24:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C423E3CA5C7
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 16:24:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4803B1400431
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 16:24:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51CC321C03
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661869457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hBC96HKOAdNZ1ImQJB53j484bVg7OlMgzrRSUErMRpk=;
 b=nvAxDfQ+gqKHw1C7V0oLhh+eBFVZk6KjpMRe7c/x5w7DmpPh8FNqEV+zF2jv9QBcVGgqhS
 c6xe7ZfPPKKJK1HjmFHOEXnWbVdIS3j8hgk9/D3uxOs68eahj1u9Hui7Y1KWNFVmYRYDJf
 Ym2ACHlCRRzWT/zilMY4UDON6uioi60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661869457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hBC96HKOAdNZ1ImQJB53j484bVg7OlMgzrRSUErMRpk=;
 b=3tSaX0sg+XVSIG+dO8xUjejuXGQdRMc75s9OWPBqBXeZjv1VechdkhN3MePoeAJsUwFlkB
 hq/Af/UuvujkIwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3573713ACF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nc0BDJEdDmN2GwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:24:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 16:24:15 +0200
Message-Id: <20220830142416.3831-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] du01.sh: Fix broken directory change
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

Running `ROD cd dir` doesn't work because the command will be executed
in a subshell. Change the directory correctly.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

After this fix, my older tst_rod patch can be safely merged.

 testcases/commands/du/du01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 274e32a4e..5548d7667 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -14,7 +14,7 @@ TST_NEEDS_CMDS="dd du stat"
 setup()
 {
 	ROD_SILENT mkdir basedir
-	ROD_SILENT cd basedir
+	cd basedir || tst_brk TBROK "cd basedir failed"
 
 	ROD_SILENT dd if=/dev/zero of=testfile bs=1M count=10
 
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
