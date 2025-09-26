Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47BCCAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 04:07:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9CF63CE07C
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 06:07:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57CD03CA434
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 06:07:32 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 55E931A002F5
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 06:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naotchy.com;
 s=protonmail; t=1758859649; x=1759118849;
 bh=K3Zk2w0qQeAO/51Y5uAEG/tERgkPL1NTmSQA4gPbadU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=llZB0pzIkotPCbg3WVnLRO5s0kXetCbzEmHX6rAqYccl3XVLHge+CwVl4qP9d4jIf
 y7/cWJZh5h0qhF2SeBbGBVhPNujP30rxw7U8J55tAHBdcr9HboOBma/cBaWvtiTGnV
 qnVUKS1wcUg3ORqZZ/eiBz8n9uEBSKTri1FtSwF2EvLuP8JpX1+GXwNJJr5jfH8Kc4
 aR++VcE8Mqg04LOiBykwH82h/5bPhoEjcPnT2gZIJtwBM5LnBkzSV+mUZ3M3aalC+W
 DXf5hpfp7Qf1WpTu9rDbh/YPWRs5gwWECmowc5VH5h2iQG6jz4c2gvEcnQ53zUDuSP
 XJtye//fvuTYg==
Date: Fri, 26 Sep 2025 04:07:25 +0000
To: ltp@lists.linux.it
From: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <20250926040707.671282-1-jmorgan@naotchy.com>
Feedback-ID: 96944049:user:proton
X-Pm-Message-ID: e60c856897762ca24de1728c0c90be936b880de1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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

statmount.h: add check for STATMOUNT_MNT_NS_ID

Enable check for STATMOUNT_MNT_NS_ID in kernel
headers. Define LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID
for mnt_ns_id and mnt_id use cases.

Fixes: #1260

Signed-off-by: Jack Morgan <jmorgan@naotchy.com>
---
 testcases/kernel/syscalls/statmount/statmount.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
index d21d7f8da..df883f792 100644
--- a/testcases/kernel/syscalls/statmount/statmount.h
+++ b/testcases/kernel/syscalls/statmount/statmount.h
@@ -13,6 +13,11 @@
 #include "lapi/syscalls.h"
 #include "tst_safe_stdio.h"

+/* Enable STATMOUNT_MNT_NS_ID check for struct statmount. */
+#if!defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
+#define LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID 1
+#endif
+
 static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
 		     size_t bufsize, unsigned int flags)
 {
--
2.51.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
