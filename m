Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F8C433EF
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 18:17:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666B66141B
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 18:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 666B66141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047F53C9AE0
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 20:17:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DE2B3C8B74
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 20:17:20 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7AAA100115D
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 20:17:19 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id s21so5742783wra.7
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JawMFD7cvdfJ9AnmB2hfxyQjHGSsPOFFuzC2+0Rpddg=;
 b=CusOzmUfQTYQefeUU/bvtafi1B74I40G5kjaZIv+zLd7sryE8okLLUZySkJWR3OhHH
 QdMXIje9mC+BzP7K0aLKJHC5I+MBoVV9jT4cIxfRk1gyrWCBLz8hippqgcmtRoKBxDxh
 oZzD47tcWIG70ohrRz7wMvi2mak//J9vTMnVq860jJ6P4dL8bcORekmtWWjysro8I4JT
 8OttuymfolNiH2jxBHZ6K1rW6BHg0Q3e35jmvgEHsp2mvpxKqlIwrMvUIHVfdkFJn3Qw
 fB1BVgm4FsjTlqFdGPNcHoiA2uqi2+v00N9kcJFQiC6/VXEc3WmSvzHgDnNBaWztZUFn
 Mmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JawMFD7cvdfJ9AnmB2hfxyQjHGSsPOFFuzC2+0Rpddg=;
 b=Hki5A7ALs2JREmFLNMEgLEi25Y/U43zO9XDwD+6Un7hqA7yJf+bitjQBjhtIRlvjtn
 KDLQH3WzBkU8yt4B1IhXeLgAYzfPm97yppPMMShqefKIUQzj2SIc/oSiiHFrUpJAu43Y
 8DHx1Zoq2yOlTaqC1TRVfWsEssKlsUByTwwsOeChoTH2VGwqxodfYrCivbnQvXmGl0/Z
 6A9hOMCsaG2ME5vZPB4wQJOcSXAMm7Pih5kRpUzQlBdGwCO7WRKdxZv32AIS4RYticx0
 Xbp9/HqgQnNoGfHYFaukLDA7EAACtf5cZhciBXOkdYId53w8wCX1xNH3p9vSsjpJVRB1
 1n/g==
X-Gm-Message-State: AOAM533u8qauYBhNyHxWwxAxvqmgk/d89P2Ez/xAwhqwvfoOdR1FBCcG
 tiBfxW+XW+kFgXTmMPdO1+Ox1XR0Ng0=
X-Google-Smtp-Source: ABdhPJwxvT68IqGZV1KjNeIKQRb69PtKB/a22YPLk2zJ7PgtxR8xNx+J2oDc2tzuMJgxBu6bixIYUQ==
X-Received: by 2002:adf:8b52:: with SMTP id v18mr1553255wra.1.1632939439174;
 Wed, 29 Sep 2021 11:17:19 -0700 (PDT)
Received: from dell5510.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id f15sm449299wrd.44.2021.09.29.11.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 11:17:18 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Sep 2021 20:17:09 +0200
Message-Id: <20210929181709.31788-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929181709.31788-1-petr.vorel@gmail.com>
References: <20210929181709.31788-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/2] lapi/if_addr.h: Define IFA_FLAGS
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

and use it in icmp_rate_limit01.c.

This fixes error on toolchains with very old kernel headers, e.g.
Buildroot sourcery-arm:

icmp_rate_limit01.c:82:3: error: 'IFA_F_NOPREFIXROUTE' undeclared (first use in this function)
   IFA_F_NOPREFIXROUTE);

Fixed because IFA_F_NOPREFIXROUTE was added in 3.14 and the oldest
system we still support is Cent0S 7 with 3.10 kernel.

NOTE: Cent0S 7 is obviously heavily patched thus it contains
IFA_F_NOPREFIXROUTE and therefore CI build didn't catch this error.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/lapi/if_addr.h            | 4 ++++
 testcases/cve/icmp_rate_limit01.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
index 07e6a7c9b..0f7e44784 100644
--- a/include/lapi/if_addr.h
+++ b/include/lapi/if_addr.h
@@ -8,6 +8,10 @@
 
 #include <linux/if_addr.h>
 
+#ifndef IFA_FLAGS
+# define IFA_FLAGS 8
+#endif
+
 #ifndef IFA_F_NOPREFIXROUTE
 # define IFA_F_NOPREFIXROUTE	0x200
 #endif
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index b3a237b30..3ada32675 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -27,11 +27,12 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
-#include <linux/if_addr.h>
 #include <linux/errqueue.h>
 
 #include <sched.h>
 #include <limits.h>
+
+#include "lapi/if_addr.h"
 #include "tst_test.h"
 #include "tst_netdevice.h"
 
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
