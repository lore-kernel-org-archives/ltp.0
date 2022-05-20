Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BAEC433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:43:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEF303CAB2B
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 14:43:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82EE33CAAE6
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:43:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A59E6005C3
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:43:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE8B721BFD;
 Fri, 20 May 2022 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653050600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSqL8nsgAv00sDiUATTy88034b/XQOvdak++T4C3w5I=;
 b=xxHvgPM3zfRwigoOuFq/5ehteCnmXoEiWGKy8ukNBawY6qckxlOmvQ5Ir6ouIffmbJBHgi
 X+l31WlGk2YLggardWLgNYCPi2xEE3030ynYem1rHm3EuUEdR3CPwL+5UrH3gScnKwsdzr
 R5Fe52s1lcjc1k/u6+11Mu2S3jcUWjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653050600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSqL8nsgAv00sDiUATTy88034b/XQOvdak++T4C3w5I=;
 b=HWFZWgMwJjFuypXSIe6NKFyvp71V3ddM395yOQg9LahdsHLgMwkmjU+SocTCtJpwfjNKxK
 3PLnz7S27JGL7fDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89CDC13AF4;
 Fri, 20 May 2022 12:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uKw0IOiMh2JETgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 12:43:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 May 2022 14:43:14 +0200
Message-Id: <20220520124314.20251-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520124314.20251-1-pvorel@suse.cz>
References: <20220520124314.20251-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] doc/maintainer: Check also -i0
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/maintainer-patch-review-checklist.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
index 4e10dc514..5d3c6886a 100644
--- a/doc/maintainer-patch-review-checklist.txt
+++ b/doc/maintainer-patch-review-checklist.txt
@@ -30,6 +30,7 @@ New test should
 * Have a record in runtest file
 * Test should work fine with more than one iteration
   (e.g. run with `-i 100`)
+* Run with `-i 0` to check that setup and cleanup are coded properly (no test is being run)
 * Have a brief description
 * License: the default license for new tests is GPL v2 or later, use
   GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should not change
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
