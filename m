Return-Path: <SRS0=m48/=OU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC6FC433FE
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 18:32:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E2F61381
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 18:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08E2F61381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE2023C9635
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 20:32:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 300E13C962E
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 20:31:30 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A22B320100D
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 20:31:29 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id u18so11614632wrg.5
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AAG1//VMYMPBv+IFXUH8wp7fzoZo8lPLbUSkd/KIWr0=;
 b=JZ74ZFWIkoqAxBi5b/PrHBeIdO0pxm4zHJANuki1iR5M2+8YJk4FJaqv8ArZKRU33d
 ZqClHbDmGwMWodmIIt0xC9Nqa9ZT+ofb3ZXdyevxF/bCM9M9qT4eLgqvpJue0Yt5scLl
 dL62+UWbUXCTjLhJ6K1w0u93UuMTYtSH5sCtD7qG35CS/t5SWBQR2BzzICOs23zM2sam
 SjZCClXWlUqgzM+m9sO/z/ctePBFkhX4irU0yBUId9Zo8Lx+dKdrLu+qOTt0lZwt0WR3
 Qycyybr5Z2gZeefzlkbn3HyGZQacQExjLH1nZ+p6UsAd9mlBlVnODzP93GBZpPnEQDnz
 OLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AAG1//VMYMPBv+IFXUH8wp7fzoZo8lPLbUSkd/KIWr0=;
 b=JSdYd1zgpp0KnGVla6Y0h2F2p8Dg0OMHQKO0xwWc5NiF/6b/RUQQcmxMU03JkpGmFP
 6PyFVMZoMEfiwMJcfa0ZdWiqDyigwME4Kpo+QH5nI0bfaSFSEv9WOUvuZ8HqiJxRX8wz
 +gevosH0hEBX9LEW1Hhnlm0+lFAAKTAGaNUgb57hPlxRbhDXY4d2iR8AtaGwM+2uh4qC
 PpgZn8tCqely5VmyYbH1Q3bqJ7xBnXVi7TC1c6GrDv1hhqpTqXATVnFmbb/NgRrlqWQ7
 78wFRcp+9F/Q3j9tGj8iqwm2/9EX5xgt7gKKNUyhp4L9QYJctlzfbf/MY5PpZhg9HSyH
 6TVw==
X-Gm-Message-State: AOAM533DWYqKkpuh+Zg3AEFShwTPYsqhX8EsLQEmiwKEgD4Chm4edzUF
 d3KZdtblyXJsXy4vGr2h/o4n7GYCTsA=
X-Google-Smtp-Source: ABdhPJw7Kk06hM4RBBQtnG3r4NOjUdXWQHw90JTtNN0UXOHibqV/7js0+q4jj1FJw72OOsEvfohynA==
X-Received: by 2002:a5d:6292:: with SMTP id k18mr8025956wru.110.1633026689162; 
 Thu, 30 Sep 2021 11:31:29 -0700 (PDT)
Received: from dell5510.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id c9sm5767996wmb.41.2021.09.30.11.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 11:31:28 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 30 Sep 2021 20:30:58 +0200
Message-Id: <20210930183058.5240-4-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930183058.5240-1-petr.vorel@gmail.com>
References: <20210930183058.5240-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 3/3] lapi/if_addr.h: Define IFA_FLAGS
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
 include/lapi/if_addr.h            | 3 +++
 testcases/cve/icmp_rate_limit01.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
index 4e50a0a4e..0f7e44784 100644
--- a/include/lapi/if_addr.h
+++ b/include/lapi/if_addr.h
@@ -12,5 +12,8 @@
 # define IFA_FLAGS 8
 #endif
 
+#ifndef IFA_F_NOPREFIXROUTE
+# define IFA_F_NOPREFIXROUTE	0x200
+#endif
 
 #endif /* LAPI_IF_ADDR_H__ */
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
