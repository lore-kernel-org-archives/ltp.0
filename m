Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D97CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:40:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E613E65B5
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:40:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A47D83E65A5
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:39:47 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DCCC91A00987
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:39:46 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-900fa9f178dso462367885a.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778085586; x=1778690386; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhRjYhEOCWRv91Q4nLN03LDSUq3qFLeHEOFxZCC4H4E=;
 b=ZLwsfIVgNciH51UaDNnYN+mavY9ZAaGZK78mfIj2RSUBREQNK9ZZkFjYK+FOGrBdfT
 4pAKgJ/QFxAoWdoySSRW/FR/TSlfNE3P1k4SPFQrbL6z9mbIK4+BimtHSPe7L4YY5owI
 XueJy3SKLR+UiQrWcE6npirOVzPmryPBpNXExJ1Oh2PlJYX/PsTFXlj0aeaP8E1L+05Q
 CEOlPSbzu8U7mQ4WRfdLG041sOBoeZJq84Uiq5iKdzkBGmgIsjnvg51otEkIaFdBjfOp
 rY1SzugqzH5xGdD4LhOYh3ZdK0xIngkvxpVp5xBoVFaS/t4ba9Pr/Ck6bBTW+FigXR2h
 kLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778085586; x=1778690386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WhRjYhEOCWRv91Q4nLN03LDSUq3qFLeHEOFxZCC4H4E=;
 b=GsP+6QazEUcbaai1TCz3jDFIA3VFkN68nrkQTNNFaiy8jQIjutLkm6K76HgZOq0Qx5
 Ug2tgXBaFvqj8zv0FgQf53AGNZCaMXSuMxsa24NSoT8ncRglcGJdVBmxagWcO2V3fWtt
 ZTmetv+da3fv9dWVvnRc1b1S9xVcX8CuvYtNB4aMSdlypV67S5z69Vfxij5MV8A9rwGQ
 nYo56pu+BR4V0GjSLywhFCG8PqW1RIGJkA26qyKsUglfcOlVYJBCGKDkWalRlVf+9Y0r
 CWz8BTfPM71WvqU6dcloFW7HmA2DhWkFCa7HyxzkzickgsYRk/tToFeylKVe/E4Ds7aW
 783w==
X-Gm-Message-State: AOJu0YyhwQe9kj1032a5NmihWbDJ0FA+bJ2oOw8sJ6lqHxezRwopbFPY
 BlzWOd5pKB7SyaRbOa0K0ubCYHiwvtLWDZoKMPmgMWQq6kmkP+1BcCIj
X-Gm-Gg: AeBDievk7Uzd//Oq+kFQWsXzIqm8nnK8jxFeo6NZ4w+vdwtaDEqL4LzrYi1pyzwVo40
 XNPH68yoLID/8xCXec5fvIz6+OzBfYaSeasf3A9dnlkGPJ/N8spY59UqkchZCOfchoA9j866eXU
 8MQSWivkOf5g1su9xyTzeqcV5Hv93XH8E3nO89Nv3FIVvKTzQMTXWHcP0JzSok8Db2PVyRBsg5L
 3EPvBufrz+Vx+/Xm5pBYGqfB/NbNrheQZLkEcoRbPDRF1GM4gsXdZ+9k+cLuLRSe5/tgVKoKdBG
 Gl2kaKNHcfSnofOD+5Sb3BS8KEHQP7Fy/olNe9a4nok+qhZOlFhSFHrPy15EEuCrE4E+X4NqRaZ
 D2nWSjaOt3BgnxFrDd71aD+Kezyik3/TP9wlJchoN7LMQ13cK5Hr9y7t2JTE4vNtt+2UfIXaeO7
 BPSoegn2XDOxtLs7xEiJWvqKX/IfjzB8AbPw1QUbMixMXyx0GTCWZZrrilv/ybB6/y/6BOiZV0m
 P+rOqFcJ4JXFF/c26DZ9OL1qatOc2Ana+dSD+xNFYzV+nyuTl+clrtcVgc=
X-Received: by 2002:a05:620a:280b:b0:8cd:9665:9ef3 with SMTP id
 af79cd13be357-904d4b595dbmr640538185a.19.1778085585531; 
 Wed, 06 May 2026 09:39:45 -0700 (PDT)
Received: from
 runnervmeorf1.t44aakfgbf0ebggs33ekaeudia.bx.internal.cloudapp.net
 ([20.55.86.179]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b5396bf35esm179893376d6.17.2026.05.06.09.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:39:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Wed,  6 May 2026 16:39:44 +0000
Message-ID: <20260506163944.4208-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506151801.20401-2-mmenashe@redhat.com>
References: <20260506151801.20401-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

All four patches are missing a commit body and Signed-off-by tag.
Please add at least one sentence explaining why each test is being added
(gap in coverage, related kernel change, regression, etc.), and add
your Signed-off-by trailer to each commit.

--- [PATCH 4/4] ---

On Wed, 6 May 2026 18:18:01 +0300, Michael Menasherov wrote:
> futex_cmp_requeue03: Add EFAULT and EACCES error coverage test

> + * The EACCES behavior for PROT_NONE was introduced in kernel 5.9.

> +		.exp_errno = tst_kvercmp(5, 9, 0) >= 0 ? EACCES : EFAULT,

I cannot find a kernel code path that returns -EACCES for a PROT_NONE
futex address. get_futex_key() in kernel/futex/core.c returns -EFAULT
when get_user_pages_fast() fails on an inaccessible page, regardless of
whether the failure is due to unmapped or PROT_NONE memory. Please cite
the specific kernel commit that introduced this behaviour, or replace the
conditional with unconditional EFAULT.

[...]

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
