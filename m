Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2435CAC5B8
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 20:35:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 392E23CE12D
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 22:35:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C26FB3CA61F
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 22:35:35 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E97E200923
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 22:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naotchy.com;
 s=protonmail; t=1758918933; x=1759178133;
 bh=SZCV6K+OpCm9iAUi9G1/ilFiHSDNWDLJy7A8y0GE4uM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=OePG7EfwCrMW/QFMEZImqabXOvG2oP7zBQMLpb7YKIDtorjBN5ugWvDr3uNKbd8zZ
 IkhrsREmRR+sMepYH2uyxuWdxP8bR77JCzARZsJOFKy2t4/dUW7eI0NKcEGXyyGDNt
 IdzscH/KEUGYESSfLhGVq9KJB1ud9tFC1iQYu5vxUx5+OBv9EIl1LDVDJWJAJjB3R/
 +lKdUynzMTgMB8NvMPMrhQ51trVn75rFm77meffUb/2F5MHK3ToJKO9kMMPXeRTTkS
 m9wZKdM1Q9GcfCNOIG8r67NGYRP11d6oo4RqhY5gMxQwEXUtofWnwPHwKoR9PJvOHa
 hc/3rpfji2q6Q==
Date: Fri, 26 Sep 2025 20:35:28 +0000
To: ltp@lists.linux.it
From: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <20250926203502.1350861-1-jmorgan@naotchy.com>
Feedback-ID: 96944049:user:proton
X-Pm-Message-ID: 0194f34fc1537d8d8c6aa8738ae2136ed6d2cc4f
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] statmount09.c: Enable mnt_ns_id for
 STATMOUNT_MNT_NS_ID
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

statmount09.c: Enable mnt_ns_id for STATMOUNT_MNT_NS_ID

When HAVE_STATMOUNT_MNT_NS_ID is defined, use mnt_ns_id
for statmount09 test case. Otherswise, use mnt_id.

Fixes: #1260

Signed-off-by: Jack Morgan <jmorgan@naotchy.com>
---
 testcases/kernel/syscalls/statmount/statmount09.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statmount/statmount09.c b/testcases/kernel/syscalls/statmount/statmount09.c
index 20c76ba24..03f54f2b8 100644
--- a/testcases/kernel/syscalls/statmount/statmount09.c
+++ b/testcases/kernel/syscalls/statmount/statmount09.c
@@ -39,7 +39,11 @@ static void run(void)
 		return;

 	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_NS_ID);
-	TST_EXP_EQ_LI(st_mount->mnt_ns_id, mnt_ns_id);
+#if !defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
+    TST_EXP_EQ_LI(st_mount->mnt_ns_id, mnt_ns_id);
+#else
+    tst_res(TCONF, "statmount.mnt_ns_id not available in current headers, skipping check");
+#endif
 }

 static void setup(void)
--
2.51.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
