Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1679C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 02:44:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 223603CC91F
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 04:44:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 148453CC91F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:44:07 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 59E4B1A00264
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:44:07 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8e9c06149e2so7004966d6.1
 for <ltp@lists.linux.it>; Sun, 12 Jul 2026 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783910646; x=1784515446; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vp8+uZSyT+fivzXRfMWluJtb3nmu8dlC+3YJPrGYvDQ=;
 b=E0IyluRwvQ7uWk9MTd5xcACBFJwDY4IyNKeS7dq5q289qbr92JdmcBvm6aL2g22CkX
 hwaI4873nxgyjgQDsid7WiQrDUDrcZ3lj8atmBfmxwPtt69E38ZBNobUw4TTY9UmRpci
 VDcoaJn4+7Tr8dYNkGdXHahlLyoxPz5xAVSXQdsDXyBN3mHXtUKDsrKJobnbk5hUWt12
 ALoc4W0ig6Mq9SgnHkaIpRy7Myxj/M4cr2H5LhHYcKR/GjSAGQJSvDVMMQtt+824NNHG
 qxMg73RoZvIFIHfPH6gD/cB6Xzbu2SdQnk/Vzfg4JzyVIt5EYHwq4ohQJ3Urrc1m42lU
 wnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783910646; x=1784515446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vp8+uZSyT+fivzXRfMWluJtb3nmu8dlC+3YJPrGYvDQ=;
 b=tYcIjc0ecmVH6C90BTAQaURBNlMZ1UbtkVjNDvKnu7bFrOwlm1rV4xcckayKheuX7c
 xWQ4+MO9uqXvTThBJX/l6D+8rQTxEfNZLsmJmRo2Ki9F1hfgCNc6666yECIjlROhBRwb
 7Bgg8UJ+bQWiYfWCuv2Ra5vuENoWIOuXBFFL9a4j7plQ7nfCQv5N4Ykq1wb6iNndaY94
 Lw7NUOaRkNSlf/f931uGyQuUzUgWc5zySuzoaAe/oAoKPko/a08AvOgBuchTRTRXVAFN
 uMBXySvtWpEc9AGGS5B87V42ppPihs6d6Uf+3Mt4cuPp7MFKTxT0L4NvCGV4Wq2Uo8Kw
 7+3A==
X-Gm-Message-State: AOJu0YyFDsM0MjQB4dvy0Vv0UnWlzcn5yZm89qzC5+NwE3L/4ItmlisG
 hlNzg+qFJ0GUQPZd7qktwS0u2On5oBVqnU1eT63bHG1IzaImmepDPB1L
X-Gm-Gg: AfdE7cnXCFAeNE5pH/wq1iq+LXswIytgwlfEMR964wGm044ltdfk5/timwG+p9piZ7H
 JWpJiE6hZwOxAx1mvievIDV2o5jKHuvWdq++u2oUFqBZO15WzPw/a9LU1m+g5Mo9ejQZNI+AQrq
 8fFRVi1v2z9JJdNNtsFH/sJvpdS+R9e2AFZmjaqPoKWck6Mb8rl96EZrG/ZUNgBnX3EbYG7XQ4k
 DUgXgnm9wKG2hPW2p55XvnZL5OlifLU3mfpbAqg7uNEmlDKuUJqS/QFGUL1E3p7Ju8+8YGVcBMM
 xx2vu6PUFoqFB/oG536mh+w2H1pUTQBgb5EhJGCvzqNDSzA/bgtOtJjkJFTOEJRq7wdEE1xuiuf
 kSTht3LWTgKUGaP9uFtclXBYncg5EAN/hBFeDJTNCO8K01S1mkCCs3JfQsxl/AIhqkns1dZOOAH
 ynqty3jpJrZrgEwjmvVVfIpUKXCNqwq5KzD81rglQFe0s4o+NH3X2y0HZmc8xJL/oJ2SC37UaL0
 LAijKYNzsnC4EGXtuRtvXGWbF7kQw==
X-Received: by 2002:a05:6214:2489:b0:8fd:6e32:1aa5 with SMTP id
 6a1803df08f44-90402e6b155mr86216346d6.63.1783910645894; 
 Sun, 12 Jul 2026 19:44:05 -0700 (PDT)
Received: from
 runnervm5mmn9.ilqebtjoo3redgtn5bhhrwy0we.ex.internal.cloudapp.net
 ([135.232.185.19]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd82ea9casm117126756d6.42.2026.07.12.19.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 19:44:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 13 Jul 2026 02:44:04 +0000
Message-ID: <20260713024404.3955-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713012545.3875573-1-wakel@google.com>
References: <20260713012545.3875573-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Reset cgroup limits before retrying test
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

Hi Wake,

On Mon Jul 13 01:25:45 2026, Wake Liu wrote:
> madvise09: Reset cgroup limits before retrying test

> +	if (SAFE_CG_HAS(tst_cg, "memory.max"))
> +		SAFE_CG_PRINT(tst_cg, "memory.max", "max");

The test requires `.needs_cgroup_ctrls = { "memory", NULL }`, so
memory.max is guaranteed to exist when the memory controller is
available. The SAFE_CG_HAS guard is unnecessary here and creates an
inconsistency with the unconditional write to the same file later:

    SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);

Can the guard be dropped to match the style used for the later write?

> +	if (swap_accounting_enabled && SAFE_CG_HAS(tst_cg, "memory.swap.max"))
> +		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");

swap_accounting_enabled is already set in setup() based on
SAFE_CG_HAS(tst_cg, "memory.swap.max"), so the second SAFE_CG_HAS
call is redundant. The later write is correctly guarded with just
swap_accounting_enabled:

    if (swap_accounting_enabled) {
        SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", SWAP_LIMIT);

Can this be simplified to match?

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
