Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A33C433FE
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 11:06:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CDB03CA541
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 13:06:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A82F3C02B1
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 13:06:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D845C1400760
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 13:06:44 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 00A581F856;
 Tue, 12 Apr 2022 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1649761604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Hiri6qv/4SKaq0sG+N8y7Nrbtv3cd2u500zjZOFq2vA=;
 b=cz5rTyvYluXgNQM0ROT9Xxnk9obWXYxaeqGocNDCWFcwJq97Lgcy3e1Uo840LAMMwHoRvr
 hL2cZbs2E4lWCocUAGrzbzDaClh3fGdGmJ+uHWY0CebjohGfmzDjkAjFC/+7GkLIrjskM0
 t5qqf12Co1gxvLo85N0vDtKaQMj1//g=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id BE083A3B89;
 Tue, 12 Apr 2022 11:06:43 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 12 Apr 2022 12:06:30 +0100
Message-Id: <20220412110631.13865-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tools/sparse: Update to v0.6.4
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use the latest version of Sparse upstream.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 tools/sparse/sparse-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sparse/sparse-src b/tools/sparse/sparse-src
index 8af243292..c4706aa76 160000
--- a/tools/sparse/sparse-src
+++ b/tools/sparse/sparse-src
@@ -1 +1 @@
-Subproject commit 8af2432923486c753ab52cae70b94ee684121080
+Subproject commit c4706aa764f3ae68258ba60be6325a5662900362
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
