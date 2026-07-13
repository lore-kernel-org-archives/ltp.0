Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC14C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783942688; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lc5gUNsqwRYaSTEtemS7M/q/M1+XvLKP3zQQGfsPaxY=;
 b=N1BhxJgOGILpWvJCJj5YK6q4HX8rqJaQwyGzMlDm0tM8DLCI9IPmcn/KEYxZ+t9Xuzd8r
 5JCbDY7xdOiG9lcyboVopLTpSwH9q9VUulsCaKAjqNt+bf1UWXpuPR9Scmo2VC9Xf2gmAYC
 rpFGktU0ut5SzzYTweDoRR+ryYl15aA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 557BA3E5C4F
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:38:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEBB13C17CE
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:37:48 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D831F1A00437
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:37:47 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso22419505e9.0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783942667; x=1784547467; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/JMLkPnfIz98TPP5ss51CGriGGp0990ysauIVEmg4TE=;
 b=L+NHBEDz7o84YuAjym8xP25D1DtUG4BUF6+c5nYIQRJhJqHfV1e+ieeDuDGvKot4cY
 c1iv0PY8Zm9HD0s9LhBhR14OXYAyVIefIeCua+JIa9sQ614Dsvg2rPhYJymsqkJQKyUs
 Iv0tVCIBI0gUykMgf34i4qzbxrG6QV9uFhgJdC/4N4GwrP0SoEdyNCgdO3HnZZbJrAFv
 X1ERTUmKows0R/IT6MGLLEzli+kXUpN/Bk+Mi5QJCc9WmW13d0E//1TGRm3yB9xgIEmk
 3dGQpFxmUSmrDChkVB3veaZmgZaIsf25vdvFL++2lFZnYYtCLDVRGrCNLBRx9Shs3stD
 PwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942667; x=1784547467;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/JMLkPnfIz98TPP5ss51CGriGGp0990ysauIVEmg4TE=;
 b=snKTHc8SU+ePbYsh5wJq/Yyp3KfMbSc8IRYxuDdBstAI9z2tO4f1a1l+rBe8qyjk1O
 hG1FLmH+iF9ETH2OpQCQZ/ihqAL+MCK20PvRIMdcTY5NI8GdSD0QEIjqUSlKcdHPlxgT
 83lGFp74Mm4rEV3cZUgFgv7XDgunqotQ34Mc6fIQGvGxPCDPMtU2i3uSeqeQrP6t39p2
 2qteO8sjQ9NI+7ZMZCHwW5k+1bedhtaJZIhIsm7v09xiaaLLEM3PphjPfhD2u+PJ2K++
 JnOiZB9NR+3xIvr039fQloTWiCKy8dFkD0yFg63szNnH5/HJVOoYlWgVDoy3mjTBS+Mg
 DRyg==
X-Gm-Message-State: AOJu0YwPZoZaFduasnBlMBvV++3w4D+sBhS2ysrrG9v0nrc4emTIA2fK
 IV9OyQqVwDfyqfIWQn+DR2/kCiLC8oyf6FkZZWLqOQ5ZIzT5x3XNlYkcoOtNzJd1DJOusqFkAVy
 rswpyr58W3g==
X-Gm-Gg: AfdE7ckLwAcj1GhZUGLmLyVSTiRcCgsk1YwMXrB971BWlK7UHLq71I988E0U+Sym+Na
 +we4dbt9fFZ8VY9fkQpScVjLpKMmqEGdnA6GGvroW42cC3JeVlOnjpDp5SQRmybsCKjDtAoqplq
 4cNcEZECG6/pScWfJPvC/HQEo3vxGrEH8q57lw+MI3HrlM2yACOAZiNoZvttCH6kfRr1n3P/Lr7
 xfSChB+149r9FBFw44of5u9DuyMIcgae5lxMbR49DMwH0nN1cK4R8yCHcgPoOVVrxiEcHR/4reZ
 mFuiLHhnlTvtSfEVtrhPZCj3O44jYCT1iuQtH4kSXu13Mm8fDeRaq5NobpBPTIr33inxvzmmLUu
 rShShywVY0UF7vJyZXoY7Q4uAEpEgHfDBPMlYqCz1Co8yKw/nNQp9365uLDYcvWUwGcT1VhokAW
 osV570W2f+Lnona23I83kbwbkOUNW52iE8
X-Received: by 2002:a05:600c:3acf:b0:493:cfc8:12e7 with SMTP id
 5b1f17b1804b1-493f881d44fmr84157585e9.25.1783942667223; 
 Mon, 13 Jul 2026 04:37:47 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm84561437f8f.11.2026.07.13.04.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:37:46 -0700 (PDT)
Message-ID: <6a54ce0a.9b582779.27f3ca.8da8@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260710091437.92148-2-sachinp@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:37:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] mem/min_free_kbytes: refactor to use
 SAFE_FORK and simplify tune logic
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LGTM, but next time please follow the patch-set convention of having

[PATCH <version> <number>/<total>] <subject>

The v3 1/2 is missing the right version tag and it's not linked to the
second patch in this way.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
