Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7AE9A048
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 14:58:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C3813D0751
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 15:58:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167A43D0740
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 15:57:43 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D26E8200926
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 15:57:42 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-354c825dc77so461190a91.0
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771513061; x=1772117861; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mg8on5Q1rqo2XWEv43dN0qfMrK8ZRYBMLeUSHlBehx0=;
 b=irC0lr5IYpgeeiWhiJ7dG1NZrL0uYQfzeT7DdFI2nQOtAWo1oHlY49hXyn/5q6SvgM
 Uw8tJTEsOPMGx32jFlXc1+Wtosr6zWsR9Txfd0IlJ3qvg2oye5MVtjjBYe8CQGwh8Sno
 sCYMyVcLwmtiVowI2KvUd7dxPg1iIodrcau9+5CgosGFbnoylIZkF6F5F8N2+Un4NeMj
 2cK+Frtu4iuwWlbUClzCZzKbGwsHUx9NCxizAyZgGImxxsp8fKt3gDe7fi7OAkhoMYbP
 2scI0gBL41IVkRDzFj1m0rpqvRPrfs521qkrJhlIRMzVjAOBMAZXo8f50I3WOAP2fZn0
 j7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771513061; x=1772117861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mg8on5Q1rqo2XWEv43dN0qfMrK8ZRYBMLeUSHlBehx0=;
 b=mmjko4xh5K+GC0ORcRn+JJc36BuYic6Fphuf/BZOrQ1/RfZSpM+QTbSK9nuWDksC7I
 jKtxadZ52kE0qQVya0b57CyGGu+QvML0qBYVXq5MXx7FORDHL033uSgSFxXSBWaZGXfI
 gITin4ohvT4Rt6hIxBtInZ6RQrgRcRIeLqCdpdrSBEO429rXH3+hJCbJk6KbNBFRW2dq
 X4PUVz1n/S6V5tH46xKQ/Fh8D/aa7pOQLZkOLqQn3MXrxyw8m4kXt8q2xqQn7YuS3nUo
 Lm969NEWiI4mMx0qCorQQ3Wlm3hvW+zxSbazyCO8ichl2ayfwX8WefCzKBWmEOq/6pnq
 7jKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlqQNQzetG60gndGhSV3kuPWHzm4kbw5ozToLtmuwjtrjolWyyki7iw2ofIieUQh0w4H4=@lists.linux.it
X-Gm-Message-State: AOJu0YzGWexh9vADJhF+nPLohKG3tieFEf1B5N9M1NYqqe0QNj7sq1DX
 fgNbeugBr0dmUNaTNt8Ym0NSFy50gm7K3DDn9UpCfMEmnt4t+Flrtkw=
X-Gm-Gg: AZuq6aJHteDgtO/FmEYMJUFsoaOyB27hh/dJ6v8jhRSkdsXn/e8p7ZYGkI1zi+lVhvQ
 WL9Cem6aXN6Rk+DZM9iauGs4lj7FlpPnxJiJycxWuHSi510qFdEV3mQXfl7keGQqRXgXTTbOTlL
 kadlFHd9rHAm4vx7VwDdgyoN/FRxuDL1Ggozw0SuDh+fsl9O+rDPwc5wWZDUFUeT26wKwC4Y+6Y
 7QqltfxQTNPITbJvB2yNglKThtz7jn2C0V/khZT2vUcFUF9xXVAB6sB5a0ut4F7KcQ1fA9C59+J
 lIGrUJPPRJDSP0UHNR04DB68JoLcWI15yI5HL5yDjlDEpecn38YUJoyepfdLtgtJdK3o19/LTJi
 c++o5xlTXB1A+WBLE0m4PiOWCQSBT0XXEo7Lho53SYz3quRcBviPLuC7iUkndGIiM0z2v4HvMDk
 xd8oB0GGGFABVtM5dvq737E70GvdSL8mNgy9IlYXiMgw==
X-Received: by 2002:a17:90b:2882:b0:356:2c7b:c01e with SMTP id
 98e67ed59e1d1-358890e02dcmr4844115a91.11.1771513061120; 
 Thu, 19 Feb 2026 06:57:41 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3589d842fc4sm340055a91.15.2026.02.19.06.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:57:40 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Thu, 19 Feb 2026 23:57:17 +0900
Message-ID: <20260219145719.6660-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZbmf5tEKC75gH7T@yuki.lan>
References: <aZbmf5tEKC75gH7T@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open: fix directory verification and misleading test
 description
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

Hi, Hrubis

Thanks for the review.

I checked fstat/:

None of the existing fstat tests actually verify file type bits as you
suggested.

I think the cleanest solution is to introduce a new test `fstat04.c`
that creates different file types (regular, directory, character, etc.)
and explicitly checks `S_ISREG()`, `S_ISDIR()`, `S_ISCHR()` and so on.

How do you think about removing the O_DIRECTORY case from open01.c and
creating a separate fstat test?

Thanks again,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
