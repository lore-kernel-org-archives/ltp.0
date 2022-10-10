Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A773C4332F
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 07:08:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE3923CAE55
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 09:08:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04B6B3C1509
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 09:08:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6A4A91000643
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 09:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665385701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sbMpxBdQ/ok/phCEeby53Pmo29LMky5DVxtH5QbPH6Q=;
 b=FT+KaPwXFUFZ05STowVgVWT/p3pxoD8agl/At4Uzb49m44TxgEpHzg7qQDzYYjwuYFH/iS
 M95SoR8zDwGjy9pjZEh2kTIh6BJIf1P/TTQYYQsPBrJToiCKG2HD6wuvOkWxshqH3pGEhK
 Y2rG3ctgRRtt3tMrLLJXkSL0ipFkBvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-JQoxJD9IOgqFShXmoKOioA-1; Mon, 10 Oct 2022 03:08:20 -0400
X-MC-Unique: JQoxJD9IOgqFShXmoKOioA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 418B6185A7AF
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 07:08:20 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C11BA1111C60
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 07:08:19 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 10 Oct 2022 09:08:16 +0200
Message-Id: <adf3a4e338625d85401a7d5ec94b33f86a277c18.1665385670.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/ioctl03: add IFF_NO_CARRIER feature flag
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

commit 195624d9c26b ("tun: support not enabling carrier in TUNSETIFF")
introduced IFF_NO_CARRIER feature flag. Add it to known flags
to avoid triggering:
  ioctl03.c:85: TFAIL: (UNKNOWN 0x40)

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl03.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index 3d4ac3e240ad..d46c60787644 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -40,6 +40,11 @@
 #define IFF_NAPI_FRAGS	0x0020
 #endif
 
+#ifndef IFF_NO_CARRIER
+#define IFF_NO_CARRIER	0x0040
+#endif
+
+
 static struct {
 	unsigned int flag;
 	const char *name;
@@ -51,7 +56,8 @@ static struct {
 	{IFF_VNET_HDR, "VNET_HDR"},
 	{IFF_MULTI_QUEUE, "MULTI_QUEUE"},
 	{IFF_NAPI, "IFF_NAPI"},
-	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
+	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"},
+	{IFF_NO_CARRIER, "IFF_NO_CARRIER"},
 };
 
 static void verify_features(void)
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
