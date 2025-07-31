Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E719C87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 08:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B0813CBE28
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 10:24:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713723C0980
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:24:05 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 024596002AE
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:24:05 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45610582d07so4006625e9.0
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950244; x=1754555044; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UgIHWCZ71xt/LPnJ89fnWbo499ekACkgY6aajLPIeO0=;
 b=gfCQ2jCkGuP2h7qATOzqvKY793qdyTkgj09jj1RkOKUNJj8ouNdEivfja2ZLvGTpVT
 HyXb9dJUq0/MooQx3X8QazDBDsCC/KvimPPr5QNLtVOohYKoL2tPBw70PX+2Gi6mHarX
 1QK+AxJKQNnZ6nZKUXncGrY7ORkrjT434Z01ymvDx3fTSy1Z13fFOkzvtqfMfUMUjcxn
 DZj+GcRzOp8FyQgAGSo7Z5uGEzwul+ltcxg8jQmCjb9C8hOoiPCeDqrTTjdjlz09+IdL
 SlOwVCLpGlyCc9U0H0kkgPcLS6jfPNFRHxw4hKPzUC5Y+TtuzaNFX73R7vqDmRf/jKY1
 ABlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950244; x=1754555044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgIHWCZ71xt/LPnJ89fnWbo499ekACkgY6aajLPIeO0=;
 b=HRlmEB3JbJnaUzQJsPNYD537o9lEp4xDgefuGR3PlK7zFVeh9KGNVRfRGWxSpARyhX
 di4ii8mBvdBMy2j83zOmqiA393Cs93XDeK/b2wllTBfKSreRVklfqY3idzX94gwAWLgh
 Ko/78mJLS18qVd3OWyDmZorly0WkI5XFzsSIawCz8ab3nW8ZETxBE7q+jFR8byl7u0aq
 W1TeN0xo83L1GrHks0oABNj9xkna8WurZf71p8MQDiCGd7I/glc3X1pfgGAZyciOeg5H
 YEDY4cP4Ul4ppuKGmFQiUhM7iG5jVkPdBTbZAqkejhMtU3mbuI3LP/IRVt4LV11M1VXz
 25ww==
X-Gm-Message-State: AOJu0Ywdj5rX3osuWa3Z37eJGoOiLaiir7712nOpLeYb6nqdeOWZIOmh
 kLUsyFN4OcNJh1f52bVcETdxcDuYSv6uJMJm9se4IDwOGFiVCnW1VFMq7dXcx8cC+JzPJYPOV4x
 PlwfHBg==
X-Gm-Gg: ASbGncsO4SlgPvoIu67QBrgm+/qPTRIWR8FV59UT2pjSffIe+9Mgh+K7DbU6TDjSpsh
 EqN6O4opOrdD+fhjsQk9vu0nvrjqJBVKTG+0HiovHuxOy4dPIdGciPJwVaVg32MRvuIblrss3Te
 I/eqGXn3luJZViPPQ5JsbZUCCrVya4SNlLY1MqMn8MIEjRHG0v9AvVsvzrfBhBxWPjjOYxeY51d
 SaIBYciJzeuPaSkOJKaPNAdDPUrxcbMRUCYUWXgVxGhMfdm6gck80+9T3wvpCxhxhUf5H+AMcp6
 Itast+7OQgyNWtyaV9rxlwmuIaXuGN6acOgxoXOLUzFjlN8SSHeSrA6+ymqP411pS5563S+GNHS
 Tm+UfzF3K6sCxV0u2ooGFDLn9NwhyHUa/oNSI6w==
X-Google-Smtp-Source: AGHT+IGtdSh9/94ufUVNVGTvRQmXNYXOXtJm3McIQ+1Xxj3gvwIzqM2x9Gv1IUiV7Ewg+v/4TpbD8A==
X-Received: by 2002:a05:600c:3b88:b0:456:285b:db3c with SMTP id
 5b1f17b1804b1-45892b9525amr64200865e9.3.1753950244126; 
 Thu, 31 Jul 2025 01:24:04 -0700 (PDT)
Received: from pickles.copeland.me.uk ([149.40.2.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953f8e0dsm54813605e9.31.2025.07.31.01.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 01:24:03 -0700 (PDT)
From: Ben Copeland <ben.copeland@linaro.org>
To: ltp@lists.linux.it
Date: Thu, 31 Jul 2025 09:24:00 +0100
Message-ID: <20250731082400.1044073-1-ben.copeland@linaro.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] vma05: Fix false positives from stripped system
 libraries
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The vma05 test was producing false positive failures by flagging any
"??" symbols in gdb backtraces as vDSO kernel bugs, including those
from normal stripped system libraries.

This caused widespread false failures in production environments where
system libraries like libc.so.6 are typically stripped of debug symbols.

The fix filters out "??" symbols that originate from system libraries
(paths containing "/lib/" or "/usr/lib/") while still detecting genuine
unresolved symbols in application code that could indicate real vDSO bugs.

Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/vma/vma05.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index c560eecbc..1546342a8 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -64,8 +64,10 @@ tst_test()
 	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
 		vma05_vdso ./core* 2> /dev/null)
 
-	if echo "$TRACE" | grep -qF "??"; then
-		tst_res TFAIL "[vdso] bug not patched"
+	# Only check for ?? symbols in application code, not system libraries
+	APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v -e "from /lib/" -e "from /usr/lib/")
+	if [ -n "$APP_UNKNOWN" ]; then
+		tst_res TFAIL "[vdso] bug not patched - unknown symbols in application code"
 	else
 		tst_res TPASS "[vdso] backtrace complete"
 	fi
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
