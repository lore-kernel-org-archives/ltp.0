Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DCCECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 14:24:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62883CA6F1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 16:24:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E0CA3C96FF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 16:24:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 966F6140044C
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 16:24:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 712C221CCF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661869457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbOifIC5q/mhy/FxAWNr6APbPzjIKO2aV1PysKD1lMY=;
 b=p+omIID1pCdx2EuZPmDwOpWlFfYytWz+7W9yNXJ23tOU3mHPyijER7nS4t9CYWYUAD3g66
 FosKWFEieq9HaTxphNPYwkLoa8EUHN4ri1Nzzm1TpJ3nbWE1+w4/hdhRYeS/sK+J15uvgD
 V7s3JDFqOxudDc6MBPO9P6Xw1TwdCko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661869457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbOifIC5q/mhy/FxAWNr6APbPzjIKO2aV1PysKD1lMY=;
 b=f5xK+oD4A4EWIo9X8SuYJxo5H3uYra65wa0DUV433Tsycid0p3Uzp1K3LTwBdYd/AxHd1m
 pN8HgwUgmy3t5BDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55A9613ACF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ANAMFJEdDmN2GwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:24:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 16:24:16 +0200
Message-Id: <20220830142416.3831-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830142416.3831-1-mdoucha@suse.cz>
References: <20220830142416.3831-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] du01.sh: Avoid l10n issues
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

Some du01.sh subtests are language dependent. Prevent failures on
non-English systems by setting test locale to C.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/commands/du/du01.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 5548d7667..7977fd461 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -27,6 +27,9 @@ setup()
 	# BLOCKSIZE environment variables. Here we need to
 	# set DU_BLOCK_SIZE to 1024 to ensure the result is expected.
 	export DU_BLOCK_SIZE=1024
+
+	# Some subtests are language dependent
+	export LC_ALL=C
 }
 
 du_test()
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
