Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B70BD6A25B
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 23:49:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 239093D7216
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 00:49:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A73E3D7205
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:48:49 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31FD1641097
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:48:49 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38221500c2bso486093f8f.1
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731628128; x=1732232928; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfsnMYlHyEOPemeKmcUI+D0vb4V1aoBX2UlMiXn9sLo=;
 b=f6e4XD1rchwLLs71hgg2vzPRtgRPf2kwsEm60C5rukkwBaZtLdBnbxv2HtY6J7PfML
 fTDRppENP41qaDFW/XdiJRqXBG3crWdCa+9Ow72PNfJezdvIlLE1kBDc81g3boptd3+A
 lZxCnIRJ9wBtzB9OdydSiEt1Q3C/lKD59ZEw7gAkUM0K0ksoKkxrCrvNrkuiAG7ALBH7
 C4KlhKdtXOhJ+Y7c+DYynM/vxg+UAOYcqCTE1ocbJ6Vsx1vUjtUdZZjTXmWRLUCHZeVg
 3rscIPBnhNguZK4RUS2HYuRxB2vSZgUKEzHrYIW8m8dROrEp6h35j48yvtl84HTY4nXL
 0NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731628128; x=1732232928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfsnMYlHyEOPemeKmcUI+D0vb4V1aoBX2UlMiXn9sLo=;
 b=dK7f6IjuCeZ9Y41hEkki0vTarVX01PRB5FOmf0h75SQvVObDh6qjwQPV+gF9kvl3Nd
 X1HOSV5EsDs3be7cuOtjcLBUFNN+LTHKXKLtWDoKCf5gJTUgJLKXETh2c8yQQV+hE7TV
 HkGp7DBa8e3wZWgGL+cFuqbJq9F6iuaimDE0rF6Ppf+1dVHxCzrAb2HKDtMJMjWTjWw1
 fTjVUsUPKZZ0gZpoW+K+pxJfLQGZM4y8vHevfcB9sxUxygaS4BCJD1yRK2gO3YygfQae
 zjw8XnUoPjRVjMbhJvGlb//G65Bkysdw3U+4+dVBDQyMS96BaNflgRaLonRBqoG+pclV
 w/iA==
X-Gm-Message-State: AOJu0Yxxl4sUhhfGYNeHtK8yVL4xbrEKKlRmzYF7diuQSpaC7JaN+xRr
 Tpxr3ZNo+941GM3DVMOfjBawosyg9lURNqc0xpfaN3+AyfZFVv6fbqdtcA==
X-Google-Smtp-Source: AGHT+IHje0gT5gkyd3KWPsR+PbAhzpFPtH4Iv1uBfW0L0cyzHpNcWglmXns0udWmpjrb6jy62Ottvg==
X-Received: by 2002:adf:e191:0:b0:382:23f0:fa1b with SMTP id
 ffacd0b85a97d-38224d7e53emr738756f8f.0.1731628128389; 
 Thu, 14 Nov 2024 15:48:48 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada2e35sm2789402f8f.5.2024.11.14.15.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 15:48:47 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 00:48:38 +0100
Message-ID: <20241114234839.1680432-4-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114234839.1680432-1-petr.vorel@gmail.com>
References: <20241114234839.1680432-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ci/alpine.sh: Update list of incompatible tests
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

rt_tgsigqueueinfo01.c has been ported in previous commit.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 ci/alpine.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index d2495c3895..2803cf9ffc 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -1,6 +1,6 @@
 #!/bin/sh -eux
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019-2022 Petr Vorel <petr.vorel@gmail.com>
+# Copyright (c) 2019-2024 Petr Vorel <petr.vorel@gmail.com>
 
 apk update
 
@@ -34,7 +34,6 @@ echo "WARNING: remove unsupported tests (until they're fixed)"
 cd $(dirname $0)/..
 rm -rfv \
 	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
-	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
 	testcases/kernel/syscalls/timer_create/timer_create01.c \
 	testcases/kernel/syscalls/timer_create/timer_create03.c
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
