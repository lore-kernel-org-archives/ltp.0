Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6093C54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 07:42:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4494F3E532F
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:42:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4B063E25E8
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:41:42 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C4D12000A3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:41:41 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785397300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDxDkhY1nxvbgrHR+CjNbHiEfgjqG9b76JKjduRBY14=;
 b=p45CxS9u0KIKPhpmf/imJ8L/HZiXbMVKXTcPL8t3UcFfK01WVSvOAlFyTfvnqEVyUEJjM8
 +pKcixvrUbsWJv9ifHFEyQ4Gt4VsDoxlRov0FpcPA7WD1bwDYGMNl9h5Q4UbZY0S9NFT4Y
 /J+xdUIoWIPfWsgGmN9FuQ3cU//aTW0=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it,
	li.wang@linux.dev
Date: Thu, 30 Jul 2026 15:41:20 +0800
Message-ID: <20260730074120.180101-2-li.wang@linux.dev>
In-Reply-To: <20260730074120.180101-1-li.wang@linux.dev>
References: <20260730074120.180101-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] mailmap: enable liwang@hygon.cn address
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
Cc: Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

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
