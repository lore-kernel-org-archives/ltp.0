Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26963C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59F4C3CE6D7
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:19:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72C53C94EA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81AB41000DDA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:40 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a28b1095064so115563266b.2
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403180; x=1705007980; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMptlQfc+cOdfFNU3A38BEFgJUuHQVoBgMhbtMPXIAI=;
 b=IUPVnJ9z8ZienzYD2AIN/vn9KWRhk7hetA2cM7v6ExqTHcczzCWCAFdO/KIl+BqPWZ
 a+lRvgHe5xVZ5VbEL1bUuhTqMb+LF1Dx4YOXnfQRPaXkJsTmpgs3i/qtOwwLcRdLrPql
 NB8jaU+ZxaxTwRFaPSjR4tdKqPLbth0yud7ILHB9YQSxtR8TMRKxR3oB0BdBkMMuvHbe
 yNRVoU9am1EtvTJ/htpGTRE78XexF/TOyLut9b40i1haFTrZ2zBVuKiP4NQkrVsRAD2D
 gHzOBgbgcZXKnU99u19zyvhFwazu21PhRnE2DgXFmkVl6GSRmDKuNaxSiQZeUQP8HkHm
 b2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403180; x=1705007980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMptlQfc+cOdfFNU3A38BEFgJUuHQVoBgMhbtMPXIAI=;
 b=U8pD/7sGk11rhnyTdqwcqY7AEm99n/lucWbBEWZ3El/re6TPN6Rmm4DeSWGcQ7YE3b
 TC0g1aU+fM17S7E4M6ezboTEI3E3itxmeFHrOjQlmKlR+tFYdYMIN8dWzG5pXSLK/ap8
 Kb75izKX0O5ZYod/WMtKF+I8kCq7n8BV8DR/+c+gRXtCFi7uJFhpZX+Ba1OJCPvt0gSQ
 OCuLm5YZDm8oBLbykT4mEDdbHbhe/GeHyEFE/n1Bk8kQfM8QXyhvKCxqcOV0WbExcsoD
 BT5AVFygxC2WqbVOI1v0Qt1NRXaEA16bWkf4k16I2rvVnFGKG1iM7ZHhVl3F0NhMp3my
 XZfQ==
X-Gm-Message-State: AOJu0Yx+80a564TUiXkQYkJm4iqqhwON1AnCm4/tqliGBMOObotPnYog
 FB7dW8Tk/ps6twbdlu/PZJAhdOEkAMYM5Q==
X-Google-Smtp-Source: AGHT+IGz0VoiFN86V4pTIlnMiY+2CeCHrW7dFJayUVXqtH/Nj33CSXQSqf32GYRNT6GL4T3AWTPw0g==
X-Received: by 2002:a17:906:c018:b0:a28:b9c8:c3aa with SMTP id
 e24-20020a170906c01800b00a28b9c8c3aamr350075ejz.95.1704403179954; 
 Thu, 04 Jan 2024 13:19:39 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 dt12-20020a170906b78c00b00a26c8c70069sm83058ejb.48.2024.01.04.13.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:19:39 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:19:33 +0100
Message-ID: <20240104211935.1438103-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104211935.1438103-1-petr.vorel@gmail.com>
References: <20240104211935.1438103-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Makefile: Add doc target
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

From: Petr Vorel <pvorel@suse.cz>

Alias for metadata and docparse generation.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 53f94d9f7..ee92e64ea 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2009-2022
+# Copyright (c) Linux Test Project, 2009-2024
 # Copyright (c) Cisco Systems Inc., 2009-2010
 # Ngie Cooper, July 2009
 
@@ -178,6 +178,9 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
+.PHONY: doc
+doc: metadata-all
+
 .PHONY: check
 check: $(CHECK_TARGETS)
 
@@ -209,7 +212,7 @@ endif
 	$(call _test,-s)
 
 test-metadata: metadata-all
-	$(MAKE) -C $(abs_srcdir)/metadata/ test
+	$(MAKE) -C $(abs_srcdir)/metadata test
 
 ## Help
 .PHONY: help
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
