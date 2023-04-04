Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC36C76196
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 03:07:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C1BA3CDCC2
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 05:07:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFE6F3CC816
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:07:41 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 902C060083C
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:07:37 +0200 (CEST)
X-UUID: c5ffa00ae13d49cb8679f4b4a2a240aa-20230404
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:a5cef54c-9ee1-4899-9e35-d02ffffd1055, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:20
X-CID-INFO: VERSION:1.1.22, REQID:a5cef54c-9ee1-4899-9e35-d02ffffd1055, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:120426c, CLOUDID:449931b5-beed-4dfc-bd9c-e1b22fa6ccc4,
 B
 ulkID:230404110732JCX7F15Z,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c5ffa00ae13d49cb8679f4b4a2a240aa-20230404
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
 (envelope-from <lienze@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
 with ESMTP id 617369895; Tue, 04 Apr 2023 11:07:30 +0800
From: Enze Li <lienze@kylinos.cn>
To: ltp@lists.linux.it
Date: Tue,  4 Apr 2023 11:07:12 +0800
Message-Id: <20230404030712.914700-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] gitignore: ignore GNU Global output files
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
Cc: enze.li@gmx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update .gitignore to ignore GNU Global outputs.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 .gitignore | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitignore b/.gitignore
index 915d22104..c626d7153 100644
--- a/.gitignore
+++ b/.gitignore
@@ -48,6 +48,12 @@ autom4te.cache
 cscope.*
 ncscope.*
 
+# GNU Global outputs
+GPATH
+GTAGS
+GRTAGS
+GSYMS
+
 .dep_modules
 .gitattributes
 .pc/

base-commit: 906cbd9067511f70445886b764b2e5c77c12bc4f
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
