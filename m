Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB2C433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 18:17:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C28A6141B
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 18:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C28A6141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 121E73C8B48
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 20:17:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDB653C819D
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 20:17:18 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 650BA60221B
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 20:17:18 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so5754522wra.8
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OfIyqgTtOgrWzAvzAs6VS/S4K8UqsmjZvbkktfBbY38=;
 b=jVTacbYMWoBfxL3BF2nSD0VmMI9M7N/BC/HGQZGZIKKXxk+ciEZbx+rzRnLmMj8+b4
 bFlCyr6vTSu0yt+jCNcmSt4Ius3GCLSanxZKdOnTJIZoWBVmDrVusbMIDHy5/40zxAuT
 tNF2VYEeqdrg5t2g9sKDEZhLCHoYsWIcEhpFERYULfFFJ3DVojNCO7d26J+U78f2zy5G
 pC7s/Ug1Qsbc56iNnsb8KMIkDxpSwwfGYq578ylvXU6s8cJsBVikBgStYBZ+Djugs1YJ
 +MoV31h9Gcq8WXx9W27O2vP6VRlSUrDNAD3QU/tH4jmIdGEQAp0PYvvc/ur7X4qHVG7a
 0w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OfIyqgTtOgrWzAvzAs6VS/S4K8UqsmjZvbkktfBbY38=;
 b=aqkWuGalCT2/75KbWg7VduSMovKxrV5+FIw8Zl57f9efH1I+HFbf8DyBMm3b/ch2UT
 0uGXhNjX3CAfvpkDzlNNzw4nqovMF62xPYBeRnl6zl95E97d0OYCvstYSuP1WKvXHrqb
 E/H+h519OU/AStoF4GkvX1KXWmM87TjjQirf55Ru5GuXYibnAszRvw4scKdsCqJ1FSr1
 yWnHZM8PQei5eVSZXD6uzFPBylrYu8v+jttp0tWYCggI36LhMBzdyJ9XzbTETewBfddE
 ku6V18IhO/KsNLdejyDRP2V8x9Qki7jJqmB5NDf28k5I/5p+R3sRcDo/9RR2xLbeao9a
 U5EQ==
X-Gm-Message-State: AOAM530lcu6HglXeD1DRIVXZ6A0g71IBzSSue3RVC5EeHBb9gBth1SB7
 OnzhW33hT+G8KnPcUBCBf1sgroEXn/U=
X-Google-Smtp-Source: ABdhPJyvwTAhDSLN+frXWwvI/yUOqhK5rrxC1mSPeEfH7If0RP7LQojiXcnG63clxmNbLI/bPtCeWQ==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr1621931wru.137.1632939437994; 
 Wed, 29 Sep 2021 11:17:17 -0700 (PDT)
Received: from dell5510.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id f15sm449299wrd.44.2021.09.29.11.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 11:17:17 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Sep 2021 20:17:08 +0200
Message-Id: <20210929181709.31788-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929181709.31788-1-petr.vorel@gmail.com>
References: <20210929181709.31788-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/2] lapi: Create if_addr.h and reuse it in
 rtnetlink.h
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

There will be fix in next commit for missing IFA_F_NOPREFIXROUTE which
requires creating lapi/if_addr.h. Thus move IFA_FLAGS to lapi/if_addr.h,
as it belongs there and reuse lapi/if_addr.h in lapi/rtnetlink.h just
like <linux/rtnetlink.h> includes <linux/if_addr.h>.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/lapi/if_addr.h   | 15 +++++++++++++++
 include/lapi/rtnetlink.h |  5 +----
 2 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/if_addr.h

diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
new file mode 100644
index 000000000..07e6a7c9b
--- /dev/null
+++ b/include/lapi/if_addr.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Petr Vorel <petr.vorel@gmail.com>
+ */
+
+#ifndef LAPI_IF_ADDR_H__
+#define LAPI_IF_ADDR_H__
+
+#include <linux/if_addr.h>
+
+#ifndef IFA_F_NOPREFIXROUTE
+# define IFA_F_NOPREFIXROUTE	0x200
+#endif
+
+#endif /* LAPI_IF_ADDR_H__ */
diff --git a/include/lapi/rtnetlink.h b/include/lapi/rtnetlink.h
index 04e9ad51a..089bf1a0d 100644
--- a/include/lapi/rtnetlink.h
+++ b/include/lapi/rtnetlink.h
@@ -5,9 +5,6 @@
 # define LAPI_RTNETLINK_H__
 
 #include <linux/rtnetlink.h>
-
-#ifndef IFA_FLAGS
-# define IFA_FLAGS 8
-#endif
+#include "lapi/if_addr.h"
 
 #endif	/* LAPI_RTNETLINK_H__ */
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
