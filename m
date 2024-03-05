Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B641C54E41
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709647889; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7uwSTRTFyFgVpQ67sdwS8WHIVaZpibWC0c4CiWy7o3I=;
 b=oI9wuFrsobAl6jFWZ3uOjWIX9kuBXOUfJ2nNV/ux/556cOzeS/V09y/lcxaTG45o6PJIJ
 jNTYqvclH5F7cvtC9aM1FhrdHamieHJeK0JJuvIshnppWqIR4/6dKKdZbfTOdEnSPN1Z4x5
 XVen+C19IBU5pxUfkxBUamcSmn8wjIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32CD03D0BDE
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 15:11:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEF583CAB55
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 15:11:07 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DC771401336
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 15:11:06 +0100 (CET)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51321e71673so6595841e87.2
 for <ltp@lists.linux.it>; Tue, 05 Mar 2024 06:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709647865; x=1710252665; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EjpsAVCGo0zhBlq/P10cuXfTHrkp9kPNiSGQH1jkJ4=;
 b=gSkB5GGQT1yr6PUrP0SWorTbwcBs29LFBsk8UiZnSIOW30dhUix68tgcwbwb+B7nQd
 fYPNspS9FomoedeOG5IXJYbQ6qAHnCbdIaylZENS4U0QGNNVKRyTv49SBA7jABTIUm0d
 YrFUxVYQ9sywkksgv9KTUfIQcidsFYItcbY8RBuBg1SJ8So3/Lk0FfErFOHnAGam6eSE
 uZj01ohqFKRWemr8VpNygfFo/SCdrIKdgNE8XZ4EusKC9N59x3AA4oiTORyeFqdn3Cgh
 gihEunrf+TuXAYtsbgcorwNRwlkPztwpnZ+xBjaCnXxGa8e7wDwC/qe2MJBOXW9Q2zYM
 nadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709647865; x=1710252665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EjpsAVCGo0zhBlq/P10cuXfTHrkp9kPNiSGQH1jkJ4=;
 b=L4BfO6OF+vg2H9z0sEdRGv2k4LZAlhVpU7J7l05PbQ8tGgJAXDMWgfYc//zpOo7+vb
 iXFEiPo2r61clJEY1NWJz2fxuYy5XwUluhneXpqa3O5vhMSkUYXrlsesparr85iNCi9g
 51/qreII9YioLtwcTa/r4kStPj++Nqou7TAcMPOTvybCO3qGUCGQ3dYsGL/YdlAIlvTG
 Ls74ewX7aryreC3huKpzuLxe9HB6W76/QhOm89JjNZ91VAp0GuY8wINh4p1U41BlVdkY
 Ta/uxg+LUZN47O/9Hq9fenM0oG6sWILE1PXD3IDbTahOI9ctUHqorX/ljMN7jGg5DiLy
 1Spw==
X-Gm-Message-State: AOJu0YwHKm7zMaxXcQOH+IE2/tfpHOZ/VQZFBCkPpwnPWUJRUEKqCmUm
 D3tTLZjKhuxbxNwH/DiQQ3sMnq1SHb7nny1aZtz0mpTgNhXdZdW3Q4hmnBUthIBbNIXv6X1rl+k
 =
X-Google-Smtp-Source: AGHT+IGz7RMJGIuX2crBJLopVVnN9VxXGtd37rvovhHsOJ36MMs6HBAmt0c6OpdMxYrQCUlEm2cPEw==
X-Received: by 2002:ac2:4a75:0:b0:512:dfa1:6a1c with SMTP id
 q21-20020ac24a75000000b00512dfa16a1cmr1253378lfp.10.1709647864956; 
 Tue, 05 Mar 2024 06:11:04 -0800 (PST)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b00412ebd587ebsm2394712wmo.3.2024.03.05.06.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 06:11:04 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue,  5 Mar 2024 09:10:57 -0500
Message-Id: <20240305141057.8754-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301062716.3023-1-wegao@suse.com>
References: <20240301062716.3023-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] libswap.c: Improve calculate swap dev number
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I encounter a dead loop on following code in our test on ppc64 machine:
while ((c = fgetc(fp)) != EOF)

Use fgets instead of fgetc can avoid above issue.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 libs/libltpswap/libswap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index c10db91c0..a26ea25e4 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -13,6 +13,7 @@
 
 #define TST_NO_DEFAULT_MAIN
 #define DEFAULT_MAX_SWAPFILE 32
+#define BUFSIZE 200
 
 #include "tst_test.h"
 #include "libswap.h"
@@ -279,16 +280,14 @@ int tst_count_swaps(void)
 {
 	FILE *fp;
 	int used = -1;
-	char c;
+	char buf[BUFSIZE];
 
 	fp = SAFE_FOPEN("/proc/swaps", "r");
 	if (fp == NULL)
 		return -1;
 
-	while ((c = fgetc(fp)) != EOF) {
-		if (c == '\n')
-			used++;
-	}
+	while (fgets(buf, BUFSIZE, fp) != NULL)
+		used++;
 
 	SAFE_FCLOSE(fp);
 	if (used < 0)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
