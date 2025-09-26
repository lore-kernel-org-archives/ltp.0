Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789F3CAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 04:08:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1490D3CE084
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 06:08:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DF5E3CA434
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 06:08:01 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 573F810005FE
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 06:07:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naotchy.com;
 s=protonmail; t=1758859678; x=1759118878;
 bh=xukG3SFWCPl9PLP2b6AaxRDQmDE+fxR0ZtgXJ2Py8Vc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hkuNE6vDBQhRNBRsyrmyHm2eEUoHbvdNpz0h5nHExWMd9pfhhZqlO4dx/XrM0Q0Ai
 SpLc5hYFjr7hj5Kft61qO76FHR8Q1bpb6FfP50gWoLwLLSdZmSe95gydDSK25twr22
 4gVIexq7LbCfJTnzkweDj03K2ZuFzYOGkMgJxEFdSEDZrU20MFuFPc3Dd1DFMdUILg
 xRa0q/bkYsTDDki0OqsFIlTD4TgWGliLnQN0vwoy5spUPMCGEJm+eGdQfB4VzVovte
 lwbpmD9dBixG4Ap62739M6iRYGksf8HZMWEL7QWBXD7DmKj2w8cPS8zKkiQ4JGXmcp
 +5cVQTFok8JQw==
Date: Fri, 26 Sep 2025 04:07:55 +0000
To: ltp@lists.linux.it
From: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <20250926040707.671282-2-jmorgan@naotchy.com>
In-Reply-To: <20250926040707.671282-1-jmorgan@naotchy.com>
References: <20250926040707.671282-1-jmorgan@naotchy.com>
Feedback-ID: 96944049:user:proton
X-Pm-Message-ID: ab1018c09975aaa440376a768440bf0aeaca7c43
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] statmount09.c: Enable mnt_ns_id for
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

When LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID is defined, use mnt_ns_id
for statmount09 test case. Otherswise, use mnt_id.

Fixes: #1260

Signed-off-by: Jack Morgan <jmorgan@naotchy.com>
---
 testcases/kernel/syscalls/statmount/statmount09.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/statmount/statmount09.c b/testcases/kernel/syscalls/statmount/statmount09.c
index 20c76ba24..aae32cd95 100644
--- a/testcases/kernel/syscalls/statmount/statmount09.c
+++ b/testcases/kernel/syscalls/statmount/statmount09.c
@@ -39,7 +39,11 @@ static void run(void)
 		return;

 	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_NS_ID);
+#ifdef LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID
 	TST_EXP_EQ_LI(st_mount->mnt_ns_id, mnt_ns_id);
+#else
+	tst_res(TCONF, "statmount.mnt_ns_id not available in current headers, skipping check");
+#endif
 }

 static void setup(void)
--
2.51.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
