Return-Path: <SRS0=m48/=OU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847FC433EF
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 18:31:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AA761381
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 18:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74AA761381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFBAC3C8E3C
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 20:31:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 112B13C229B
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 20:31:28 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 56977140097F
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 20:31:28 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id v127so5378926wme.5
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LxT1wJPlx8epPQ96gI9CFqtHDY9ypMS44oyi3q70HIM=;
 b=CKy24y7Ob0Tg5Hepj/VEjR980fK15llL5ULmjUCX044NArlpJeWdh+ygog9tau8z+5
 i/rACg/LOG1tLZbMZKvoJwopLm7af/T/zDOShXkcnmCfZxdkyj4XSJpwuop3wHaKXOMP
 useTZO0xc4WMyTUliOw61+EOx0Lze1JnfqRmVwypulyTbxNad64VLzpp9NJc5+dMQ7no
 tmfFGLvwJqIbXrZvQ62Wdk/o0dZG1bu3nre2gU99YllgwmmgmX/sqHmEwQSBdtJLdVjJ
 uM8XzAJGfK1mNKGqKfzvgZDb+O5XJC6YPSDNY9fOphFCwS/i1DczZjStvXY0NUsq06f2
 GSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LxT1wJPlx8epPQ96gI9CFqtHDY9ypMS44oyi3q70HIM=;
 b=hK67XYlVrReB1LLxYA1PFIZ3mWtWxMTwWs+Fkd0GsFbuj++ZysAEFHGjj3xQumf1NT
 ihTihYRbXTGpDeEWIyjCiROMTxrcg81KuTTXF94nBU2ppFBOWPk+GLCg4wo1I+3jBN++
 BWajfIA6MRG8fySOf4TEIOj4/GoU8BJJ8dYk7lK8f1wjTMnBic2yUr8mO4lapI/AVj+a
 V6ZDBYCTCj1141+2UT7CmcY/NJJoT1wpiVXa2P2pYTed2ZJhvQ/jShAPyxA2DHFiGFpX
 /RZUr+RBW5HRVo2mgDcCESYdLLQyIoVY4Va/YYr1PnXRNgOwdjFrInSr2PMbybBJf89Q
 OIkw==
X-Gm-Message-State: AOAM531jQob9iukaCC1ZB92lPW4whDr5l4i8gb1S5vRNTN1O4Ti44NRI
 ocC4Q2rVkR2Q+FK6otrq9a62w7rZVoI=
X-Google-Smtp-Source: ABdhPJxIwNmEdLd4AjjCjtQJ3U0GLdS0YdGqvCoVyGbr4pthNAS2O9HfxSFfq7qVj4a3i03+bcD0Kg==
X-Received: by 2002:a05:600c:4fd3:: with SMTP id
 o19mr739854wmq.134.1633026687871; 
 Thu, 30 Sep 2021 11:31:27 -0700 (PDT)
Received: from dell5510.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id c9sm5767996wmb.41.2021.09.30.11.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 11:31:27 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 30 Sep 2021 20:30:57 +0200
Message-Id: <20210930183058.5240-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930183058.5240-1-petr.vorel@gmail.com>
References: <20210930183058.5240-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 2/3] lapi: Create if_addr.h and reuse it in
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
Cc: buildroot@buildroot.org
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
 include/lapi/if_addr.h   | 16 ++++++++++++++++
 include/lapi/rtnetlink.h |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/if_addr.h

diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
new file mode 100644
index 000000000..4e50a0a4e
--- /dev/null
+++ b/include/lapi/if_addr.h
@@ -0,0 +1,16 @@
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
+#ifndef IFA_FLAGS
+# define IFA_FLAGS 8
+#endif
+
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
