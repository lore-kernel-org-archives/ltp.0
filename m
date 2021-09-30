Return-Path: <SRS0=m48/=OU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549A6C433F5
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 18:31:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681F661288
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 18:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 681F661288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80C753CA03D
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 20:31:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C8463C229B
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 20:31:27 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2136E1000D41
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 20:31:27 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 z184-20020a1c7ec1000000b003065f0bc631so9258022wmc.0
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dgiYGSNl2iWaVmC3tBDo1KFcVjMOXrUxq8fvu05yRhI=;
 b=FDkuHrsosuFib8Ol5SHr1teureV2c8+bRaVKJjHOXM9SRO85Mv8YE0nCOM81URh45v
 mXo9/kq1q1degbk7WKRjLpREXWbnGIMQ2/ekhR5vpWAotDgV/6ow32xzuKeYKwxUoCKt
 jaHz9pV1or9TyRk86QKKgkunNoWczws9twtSwnDpCxJyHGsPMpIw76C+d7Kqn7Qb0K1O
 eZ4NQWZtsHEodqBZN70VDoNojioJ6JbsVSsDdTibBfe0mydM2UL8NUqhdnHmwwwtrJ+U
 +3+mlhtFMjUvxYYR8WdVoj4JBy4ewSFHJjOf8AI6oFOgEE9ezrU+oh0UY8Gt9iBKJ2D9
 pgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dgiYGSNl2iWaVmC3tBDo1KFcVjMOXrUxq8fvu05yRhI=;
 b=qc7eIpmMIPJIay+6I+xNkef/Q7ky7zykRtBajechEF4qNl1EaPEcN25GoISTA/FC53
 Wnrg/O/IoDYyQ0+Wk+wgbl2xBpQNz5BAdCbdcwBmRsTJCsr2GRg7pS6u0PdhmC7X6F6F
 kd+RHw9GvYi5EQLS0TpQ46qpLbdOQBQj4zMd1VjSeD7afh3zlOWkrqyxBA0W+BuQR+p4
 42fM3txaJ5iuz408svK7OZn/qNaXu5rRHqdVwMT5/rNSOLJWUYcyZyrZyQZ/cuacDfPm
 VaLPs5VAHTLwBcjPo47tfZMFuRFHBTj/492vAaJEmU6w+aPgXoUhwdQgcFafaf4dVRW9
 xxUA==
X-Gm-Message-State: AOAM532kq119QvltPIWzIAI0siNPZdNfm8VHA8eSLwvWKKqCp/Dqzx1U
 rcNWqq2aIQ/l5B4/4gbbpKMxOWoqS6w=
X-Google-Smtp-Source: ABdhPJwHwyOoS9QGu8XUMNrpJ8y5w+N6P4UoIgOa2cBaf1ixHuWmRLPGDsj5Hag8F1MEzsePQawrzw==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr662708wmj.4.1633026686700; 
 Thu, 30 Sep 2021 11:31:26 -0700 (PDT)
Received: from dell5510.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id c9sm5767996wmb.41.2021.09.30.11.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 11:31:26 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 30 Sep 2021 20:30:56 +0200
Message-Id: <20210930183058.5240-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930183058.5240-1-petr.vorel@gmail.com>
References: <20210930183058.5240-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 1/3] tst_netdevice.c: Drop redundant include
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
Cc: buildroot@buildroot.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

<linux/rtnetlink.h> is already included in lapi/rtnetlink.h.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/tst_netdevice.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index ba9a55b70..4a0442932 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -4,7 +4,6 @@
  */
 
 #include <asm/types.h>
-#include <linux/netlink.h>
 #include <linux/veth.h>
 #include <sys/socket.h>
 #include <net/if.h>
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
