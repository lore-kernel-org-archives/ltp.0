Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B09ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 07:55:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAF163CA6F9
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 09:55:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB76D3C136F
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 09:54:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 593261400DCA
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 09:54:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 397FD221EF;
 Wed, 31 Aug 2022 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661932492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CWDf0z+XXRWNOOumQniMpLh7ZWiWUvZmQkgq4VR6xF8=;
 b=p1kHI89SBRNXzx4nwBwQdeDRw0EvY6GPl98HF+lA515epiNmV+G5yZSAMmG2yZd1FDTosj
 Vt+AftP8RnafEOFmM40j7pFaxdFyufqHv5gDqWmahB5kCqdU3JSc2+H6rRBjYyRZ3j9Mi3
 hOMLNsxAdVdEnIgegaOE5MOiuKY3JK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661932492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CWDf0z+XXRWNOOumQniMpLh7ZWiWUvZmQkgq4VR6xF8=;
 b=QnDyg8iMpP/jZSH9GjdwnUaxs63Whr7Hg6Z3dVi1kTISwZy0mh/P52XcNNgtFvRiarxiEm
 Q6N+xAt05HHzBuDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CF3513A7C;
 Wed, 31 Aug 2022 07:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9s5pAcwTD2NTGwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 31 Aug 2022 07:54:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Aug 2022 09:54:47 +0200
Message-Id: <20220831075447.8803-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test: Add === marks to "Testing filesystem"
 message
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

Each filesystem run of .all_filesystems is not visible enough.
Add === marks to separate each run.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 4b4dd125d..8ccde1629 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1596,7 +1596,7 @@ static int run_tcases_per_fs(void)
 
 	for (i = 0; filesystems[i]; i++) {
 
-		tst_res(TINFO, "Testing on %s", filesystems[i]);
+		tst_res(TINFO, "=== Testing on %s ===", filesystems[i]);
 		tdev.fs_type = filesystems[i];
 
 		prepare_device();
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
