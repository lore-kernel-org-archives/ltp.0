Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8188EE7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733870205; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=B2hynloCkg5ULa/twdnonXzBYnNdeAdQxzIWfKXl3NM=;
 b=Fj1BEgToRXAxYNVjtrje0pwF8Q5NAtfZdGdYBUQT1tL0S1ZQUkNiv3gbJBpOCo2szm9wC
 ZwmnTQ44DmUvkX/RHXqALF7Pxr9sbBQI5diYMk8oBJaQmt2KoXwbVIwjC2urKyw5f1mqFtE
 9q40Bc5eYkRBIyxtvgRsX238VCaSdZk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B84223E9411
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:36:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F2FA3E8D7E
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:36:23 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 65F681BCD674
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:36:23 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2165433e229so22058595ad.1
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733870182; x=1734474982; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xuxNutnjNpDY5CKeNoDfq5K6V49Vd7UsMIuabAXciAM=;
 b=3lZAQkqYYfvUzFdt4ot/vCpP4uRlLy1udH7YoFxMrT53YXig5OUEh81YHqgVZtxSEo
 fblLcD0wET9CaiETAaIIjJbmh51cUwgySqI6e0XUY9Q3ltXCdKzMMTl2CceUzL2HmUQP
 bJUaXecj174pvDLyCXLeN8bLKuCHYjYcSlQcncnasmodJqqkS8YMIlhOPCwpUEYDK8B1
 UnW3FEMqRzy5Uce0L8ZTSeRXPpxCSIkRXhi9HcnboUHT3en5jR3qd6w/lnPB12LZEZSX
 seOudhSNFSA6BO6gWHg36yFLChDqB4s1euVvfArA1uU6XDYrPIku/+me/pTqd5O3yVqJ
 1GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733870182; x=1734474982;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xuxNutnjNpDY5CKeNoDfq5K6V49Vd7UsMIuabAXciAM=;
 b=dOJ1m1EEKCntitGlJ6Wb1lPsPZopcVsesFfxd3h4FAwkJs2DEhW9EG3q6ABvvLPXHa
 jI3kHyW7rNXundhZ9BhMZAS7IdelTj1YQt7M8WIz1J3gD1uc7osaIJSyKtnHbXuF2ba/
 2ct5suQrjy7eUaU1wLx8MLt4xIrRG9d6PJU92vVU0eGxcBgI46jmtDZMjfMrQqWYT4q1
 vS9WaOiNrtdh0n1MEbMpVt+s6wK9WhFGxfQpVCnvvjfz+JB2K5GHFp9bs5WTeh0D1Tf1
 c4KhXTbBvmCp9+fKHwQbNEV9yaKcAtHpTdFyRQ1RYBU5ZO65AYBmH37otR/dAsEgQPIT
 n07A==
X-Gm-Message-State: AOJu0YwAarSXPpyfHffj/dWujhYzx3H524Wb4YYHTW0JKJ76L4ePEUqK
 b7L9P3PpnjleSAu+cpNfBIozKc+G5MNlKYstU/T+oD3ca/mfJx6g0IusSrw2FRpyneA51Ybar3B
 tKhdXxKxCwQ/eWJ2P1e4fiWkt4iFkUOTsV8yViKRaxvIquaCoU/X4KzhJsqDmB9ceJhRCf+2Sga
 zWo2qsfK+eCVXXbB9M/OSxnN5l1JQ=
X-Google-Smtp-Source: AGHT+IGHNp4tuZWxjj9JGf1l7fpNf4KDsuPJ7cLj3aHQy277hMSLnT2Ov7yI6gVP4IZrTB82d1tP1Z/Dhcc=
X-Received: from plnq12.prod.google.com ([2002:a17:902:f78c:b0:216:3dd2:5562])
 (user=edliaw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d482:b0:216:4b6f:ddda
 with SMTP id d9443c01a7336-217785913a2mr10437955ad.35.1733870181652; Tue, 10
 Dec 2024 14:36:21 -0800 (PST)
Date: Tue, 10 Dec 2024 22:36:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210223617.3936322-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/mman: Include path for lapi/syscalls.h
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/lapi/mman.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/mman.h b/include/lapi/mman.h
index 244ad9f31..edd517c6e 100644
--- a/include/lapi/mman.h
+++ b/include/lapi/mman.h
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <sys/mman.h>
 #include "config.h"
-#include "syscalls.h"
+#include "lapi/syscalls.h"
 
 #ifndef HAVE_STRUCT_CACHESTAT_RANGE
 struct cachestat_range {
-- 
2.47.0.338.g60cca15819-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
