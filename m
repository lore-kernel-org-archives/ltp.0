Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C8BC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 16:34:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACF5B3E5CF9
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 18:34:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5A943CFBB1
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 18:34:14 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 30501200757
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 18:34:14 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8e9c06149e2so5013416d6.1
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783442053; x=1784046853; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWxRJHhu9XjU1GBUQNuXVWYNYTeICT8Yiwn6vPXGMTc=;
 b=rODoe7vT1ImpYtaVhvHK79Lext6mi5jCaeAM2O/uvcpLWLWNAAR1AzGlQs2xReOTQ6
 6j2GMXbUkd7Nn/cr7cEMGwSLUgfirm5RIlN9xS88bZGR171EwLL1Fiw4IrMEsfM3p9yW
 BycRRxwgjiNmj3LuSsGYj75A0m+JntnwWRcm9leEFbjxL9MUHe7Bls2CphluKzEBkHen
 FrAyBmIEc1Z3JaVCmZ90fbs2VUF4lkrcmcO+yy3VB//Wrruha3KNQYl+gOHwgUlv0any
 8XQ4UQCn/Rfv1gksmFAqxnnQTb6p54dNFYo6iWnjSHxBGNRiMmCugsqSnAEqHvmO8oWw
 b+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442053; x=1784046853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KWxRJHhu9XjU1GBUQNuXVWYNYTeICT8Yiwn6vPXGMTc=;
 b=BPOPdXsTJHttm4h2DvMv8oT5R/pANGngCfcdwqFOEqq51iZMZ+0vLpJiw3YbXLGvnu
 VPENiJy5iLf8F30MembhdcQNjOVvHbtEc0y8qpmsrYK6SDmMPJju7lZSWwy/sP6y0CKK
 Y8AW72YHAUvHfUwpKD3e6lu1h8PwZvYRRQJ3otzD5esGYAcqrAI0wKDtJJKqGeFDL21u
 xGvgvEKkx5GcmHA+xoNVpIuTWdtlkel/2A6wEbXzmjBfjSba1teprUmCBUqMiI8/1bn6
 XqG5fkscq6kbX4HP6hAeGTTroKFxElWpEHObMsx/+X4yJFRLR/mnddS/AIpEd8ofAdzB
 xIaw==
X-Gm-Message-State: AOJu0YzxHeauS5iyhEqx3IXQcZZdydiFyomOctOzaibXVsx06RvWOP4t
 0cSaIqjaUsrTXGwOaTHN2MFck5S2mhJ9mqiIFXY7BYd0n7xsTpgjancV
X-Gm-Gg: AfdE7cl97mkmgiT5k1MDW36oIQZNGPoExXuWClhTSXi5d8zTInfj43xPnsynEIjv8qD
 /V9Vmbe966d57+dzFlPApmi50tpdFlB6cF+PLkS8xIBbGACBeHKsYOL/n+Gr0AUQg4VARZKu7Pj
 64KPJ5igxf7sNcs0rrwNHFAr7WHQkOy5YoZHp5v0xda2KzfGBG1FrRM7ACE6h3cqZ376NGySE8n
 5Gxfjo9f49y4XuNaiHkAG+A1xL3r65NoRiV7zS66UplHUzu+70LuXZu/QUhBB3vipyZKFimEjkA
 ZRi0ZCOXn0b2PiJDiKgwhFVIQ+OHbhZqfrBR5kuIHqWpzxbYVJYzzm8Q8YEwbI99IQbHMm/iV07
 R9WQDTMlCnozdkdp3Q/fyGuLrcgnS/Hzud89h7Zy0efx8mvvK1gZ1CnLVEi+Z/PGe+i7ruTM57b
 bcV3CuGFC7hFmyjX/S+CBpdpaVStdRZTBnXT6WSc8WeOYghQ5lkSJZAcY34UEnZrAN5UFJgQtH5
 /6jwJ4H1VNeTpPReTj6jxdVsgImBKFUMxlTQ5gWUA==
X-Received: by 2002:a05:6214:53c1:b0:8f0:9d9c:52c2 with SMTP id
 6a1803df08f44-8fcb1dda6c9mr76668946d6.5.1783442052673; 
 Tue, 07 Jul 2026 09:34:12 -0700 (PDT)
Received: from
 runnervmkkn4f.n2quayyzdxqexjlunlns3nw2md.bx.internal.cloudapp.net
 ([172.174.125.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46f013f05sm162660066d6.16.2026.07.07.09.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:34:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Tue,  7 Jul 2026 16:34:11 +0000
Message-ID: <20260707163411.4006-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153502.15421-1-always.starving0@gmail.com>
References: <20260707153502.15421-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Replace getppid02 with getpid02 implementation
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

Hi Jinseok,

On Tue, 07 Jul 2026 16:31:02 +0000, Jinseok Kim wrote:
> syscalls: Replace getppid02 with getpid02 implementation

> Remove the existing getppid02.c as its coverage is overlapped by
> getpid02.c. Then, replace it by renaming and adapting the broader checks
> from getpid02.c to serve as the new getppid02.c.

The commit message says "Remove the existing getppid02.c" but the file
that is actually deleted is getpid02.c. getppid02.c is replaced, not
removed. The sentence reads as if getppid02.c disappears, which is the
opposite of what happens.

> +static void verify_getpid(void)

This function is in getppid02.c but the name still says `verify_getpid`.
The function tests both fork/getpid consistency and getppid correctness,
but it was copied from getpid02.c without renaming. Could it be renamed
to `verify_getppid` to match the file it now lives in?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
