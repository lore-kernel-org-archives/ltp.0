Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F67C54FD2
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:02:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C96D03E747C
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:02:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCC443E722B
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:01:42 +0200 (CEST)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A194710007D8
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:01:40 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785405700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlWPcJ+40T7HTLRkTr23fs9tgE73SdxF6eis0dHR5fU=;
 b=RPE6dAkZArU5SY9DH0V3nmoCieZ6BHeGSkRbfzm5O6zkAoNRMvepLEoa2h++4nhOI88tf8
 2VgzqWikMooOH6ywQyErr90K3DbgkvfE1+E4uqjvUuDEYBTQdm3Cx/2VkOX9kb1hpv8XV7
 lWsFx52vJIfhQRjvkczufSwxvJ6VfpI=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it,
	liwang@hygon.cn
Date: Thu, 30 Jul 2026 18:01:27 +0800
Message-ID: <20260730100127.193103-2-li.wang@linux.dev>
In-Reply-To: <20260730100127.193103-1-li.wang@linux.dev>
References: <20260730100127.193103-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] mailmap: map liwang@hygon.cn to my primary
 address
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

From: Li Wang <liwang@hygon.cn>

Add liwang@hygon.cn, my new company email address at Hygon, to .mailmap
and map it to my primary address, li.wang@linux.dev.

I may use the Hygon address for Signed-off-by tags to give credit to the
company, while continuing to use li.wang@linux.dev as my primary address
for Linux/LTP communication and reviews.

Signed-off-by: Li Wang <liwang@hygon.cn>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1e4419f0..35f54a937 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,3 +1,4 @@
+Li Wang <li.wang@linux.dev> <liwang@hygon.cn>
 Li Wang <li.wang@linux.dev> <liwang@redhat.com>
 Li Wang <li.wang@linux.dev> <wangli.ahau@gmail.com>
 Petr Vorel <pvorel@suse.cz> <petr.vorel@gmail.com>
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
