Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D084BFF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777893109; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LUoALwl5sQj1FBzZH0UB/ltC5hNvNoTeXsBcE/pNvso=;
 b=MrqvpYmERWfX1YZTNEx30M5DsyQhiOaPDRLYUwDNaGvwHPRR9gWoBk28K2f2oWjNCyjaV
 HXV08Jq2blpeT5n2YZCZrIaeslorI25kzjcV+ih+JO/CaXpHzq8DMv63cnLaHsDUqHr8fWo
 ppBgp+jN9ODd5U6Mh1nplUPc/9cf080=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474903E4AC0
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:11:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C87213E49A8
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:11:25 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D426B1A00264
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:11:24 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso27625105e9.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777893084; x=1778497884; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PKM4/aJGLM2FRXZe+qw1T0dTtwU+Nc+ASFiP8O8aPE4=;
 b=L08/24Wv1aevuElcUZmyASGL+dYdoOyvpShEv/ay/v/XsNlO2ewCN7LKjnFFFIJRO2
 1C1TvtvQJyHhQaU9AXS+hGcs2WarZQVssIC+8wM+N9D66SvEATpfgsDJk4TgH/qWM1PV
 6G42yhJMTAy4SWNtGU7X4daf4DmTTNHVRSXpQrUwlZjGdiwhnkj7QaLbTmvfVtBGaApO
 FFhzz7mhkSHB7Y8N1/A5UM9pOtvjCNE1ooKKQEChBNeOvm1VtzZ1DMoW170j6hHr0Kwr
 KXESVNkU/cyQ9uuMJxvGXAgYVH3swJOI6csTlYoE6I2OL3aX6GGNEbi3FDwNwIFY66lT
 QG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777893084; x=1778497884;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKM4/aJGLM2FRXZe+qw1T0dTtwU+Nc+ASFiP8O8aPE4=;
 b=BJaWK3GOmW+uCqZgtZZ7/4i/e5/p+lY2hdXQg6OfrFyvHf2ZMX+7MYPEZwEF+uiCl+
 cy3KAy5jh6+D1be0FM7ih7AfhgB4j6BRAfHQQGj/om0/R+5/1GipGYSYK0KIMsv1zzYf
 gK5JCTzeyVX54NEP7m2iMjtGpWZyECNmY02F3Be0kL1eSQx1ABQz+B+c67XvKa8VuGJN
 +QCo6xrZMcnqdTg5OugKhALp9Zq1Ksw8tEf96AFjn4rpqj7gW5k94AZ3Apfw/c0eUw+3
 1WiccgGEM2UV4eg33IROA/PJsqpmPCodJiXY73em668KVTo72mj3Kzm02d8k3SKQOV1a
 jF1g==
X-Gm-Message-State: AOJu0YyZP673DzhV24sNJnR4ROvk7UCniFIWJE5765Gm3aVHwmFmcG3w
 jaFkwAs+0M1DMLAD0iURpuCKvfCHD2rKRNIJwnctbJXJt9MgJXQFezMGDoXYlOuMnqqtNZ9pT3X
 cAPi7u7dcQg==
X-Gm-Gg: AeBDievVY6Ls2f9n74JD1pVn+AJJy+wxeTenfr/E9fb704SyV83BNRkJKwR9ij0VMCx
 jPQVSlQXptUFJLpsptsuMQAInHqmBwoUtd6d7nEALzN5pjC9uiweytf/owdXAvhQwbTzKg8jc20
 gvEx68JnBv5QT5LoQtuYtqAmmjYYBqXyrDtzztKzUFJ/PHyUI4As6WOPTK+SuB6VgAeepH/hQBd
 Rgq7EPs8oaQkLSfYcGWY/cRtZ1EPXwERxCvCLeJAfo+trMskmYHU6XgNC7mPxWazXsui+ayy8aB
 0HyYOHj2MC/DG0sqQD8TKNgv57jhuEgpIWd6oxrhRaXdBPR7P8TrQWMoQxS1Vm7VU6+CdXogTnu
 XhEZAPlQ+G0kQXXc45hFImIa4magjFitp8/7mcMmi069GYSUWn+v+rA9VulKNyiaVc8/EgB0z7i
 e45QKNrTEDm4mjKXWhbgbtRZznc7YvB+KWWqeYy+Po0VjQkluokbGR
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48d03b401f5mr89043535e9.22.1777893083784; 
 Mon, 04 May 2026 04:11:23 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8bf18c9bsm24963041f8f.0.2026.05.04.04.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 04:11:23 -0700 (PDT)
Message-ID: <69f87edb.5d0a0220.e12b4.1927@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260430112346.4054436-1-wakel@google.com>
Date: Mon, 04 May 2026 11:11:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04: Allow both EINVAL and EBADF for
 BEFORE_6_17_9 case
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> On some LTS kernels (like 6.12.y or 6.6.y), the bug fix
> commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
> by grab_requested_mnt_ns") was backported.

Actually that commit is included from 6.18, which make it non-available
also in 6.17.9. The `BEFORE_6_17_9` variable excludes 6.17.9 (equivalent
to < operation).

This means the patch is not resolving the issue for that specific kernel,
but only for the kernels before that commit. Is that correct?

For instance, the patch fails with `v6.18-rc1-118-ga3f8f8662771`:

tst_test.c:2042: TINFO: Tested kernel: 6.18.0-rc1-virtme #9 SMP PREEMPT_DYNAMIC Mon May  4 13:01:41 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.18.0-rc1-virtme/build/.config'
tst_test.c:1867: TINFO: Overall timeout per run is 0h 00m 30s
listmount04.c:161: TPASS: request points to unaccessible memory : EFAULT (14)
listmount04.c:161: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
listmount04.c:161: TPASS: invalid flags : EINVAL (22)
listmount04.c:161: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:141: TCONF: Test not suitable for current kernel version
listmount04.c:161: TFAIL: invalid mnt_id_req.mnt_ns_fd expected EBADF: EINVAL (22)
listmount04.c:161: TPASS: invalid mnt_id_req.param : EINVAL (22)
listmount04.c:161: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
listmount04.c:161: TPASS: non-existant mnt_id : ENOENT (2)

Summary:
passed   7
failed   1
broken   0
skipped  1
warnings 0

I guess the choice is to use EINVAL when >= 6.18. EBADF otherwise.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
