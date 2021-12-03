Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7588AC433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 05:57:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56D6F3C90B5
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 06:57:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFAAA3C714C
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 06:57:22 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62A4B600F92
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 06:57:22 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 31BFA9F651;
 Fri,  3 Dec 2021 05:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1638511041; bh=NdZo+DO01FO+I+X+3oGsdR5EajfmLvFHd7oZqfS1Opk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=UMea5Xz2FTBnSJ5R41lGREXAvUxG/4ikJvgAJM7Ac7yGrZbtowkV6vltF1JJQmT9P
 /ZzChTlHplposMlAm9jFgMP2SBscMWIuzX5b/K1HvtZD0751E9H+oNZednhcp6Z0ue
 7ax/TxLP+vAo4rO3dzBXh8DgB/feMMMPeyZyWz20=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Fri,  3 Dec 2021 06:57:07 +0100
Message-Id: <20211203055707.2271191-2-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203055707.2271191-1-lkml@jv-coder.de>
References: <20211203055707.2271191-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] make: Build metaparse before running tests
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Running make test(-metadata) without make all did not
build metaparse and so the metadata tests failed.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a94e0da9a..d4399bae6 100644
--- a/Makefile
+++ b/Makefile
@@ -221,7 +221,7 @@ ifneq ($(build),$(host))
 endif
 	$(call _test,-s)
 
-test-metadata:
+test-metadata: metadata-all
 	$(MAKE) -C $(abs_srcdir)/metadata/ test
 
 ## Help
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
