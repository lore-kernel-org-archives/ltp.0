Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8586DC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:42:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 042AF3E2F41
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:42:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31E83E2E3E
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:42:05 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F21871A00CA2
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:42:04 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-847917c3678so309831b3a.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782996123; x=1783600923; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMhhe19a92FTvBX33SlT/9enDnHCTVsKajH25xUckF0=;
 b=YwoKQeY0hYNT6teWqqbzEcRzJckINZvJxOvIa8sZW1fX9cYV+0UVBtNqHpqoMvKXE2
 rXA0SZZ+MGxUAnPl9pgGGVH3Y7MIddSsM/NHIPrneXFJsu7giH2yGL69thYLQkXQB8Zo
 9RMRpRsxbhc5PY8WhxzJP3MR4IhN16GXbr+4E2f+j0Xr8fgGThP++RIZ/95buEReY7Zx
 iKkhdsG7qpZYKTqEHEQ+fiayog+lx4gCLQzR6H133+R6Fe4tbIZyNgK9vFFiO4wPpLOO
 Xlo3xjucOWOy6ovam0U5kL2aHnLByUiaXcMi8F1WXH1TQ1es++ePgU9qiSyhtyO+JxvJ
 PUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996123; x=1783600923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMhhe19a92FTvBX33SlT/9enDnHCTVsKajH25xUckF0=;
 b=AWL4A4Y4tCzUa0Yuw0VFQjvjtybCuTuRgACnc02W9X+jycuebXIdSk/7xGb532E9AQ
 2+XDf2amHw3bkoLbHxDML94Wic3/soY/rDkXHvx2Hnf8Wu/0AURkcg7qf7+69ixy1HH1
 gL/zujm+xA8fg3kPZoMKSX9089Gskw3Lm2R0ttH3/O1BM8i3qkyuT5Vd551E8l3z5gYL
 sOLKP1ZQaIzq9o0FA5pAqprk9N3GamOvKJtQ30ABssUQHn5ZuhWjR3h1xsfbApxKT1zh
 fzYmBhbJ673ZF8/idiqwX3Vs5EpNYPeGIrraBJ3oGXt/Zh7lzMR+FTpUMeEFm7SxsjyA
 JeUQ==
X-Gm-Message-State: AOJu0YxHTZafVqmOyC6fNcHmOlKC+b7qh3RBLRsBC1ZSoTNh/TbsKSaV
 rIKLU9kq3ltkEqC5NaVxOhrtanApmlTaGsHhttg9gXmaoGkq8+XMhW9u
X-Gm-Gg: AfdE7cmE/4OBgTXKe3lVy9qAgL4GsvdkYqgzJAfBW7TSZbEdK+3Ctel4D+q2HHHRLjB
 yED1MTWbXIqXfBSkGuyd8YdT7I4Uev50MqgaONgJ7rPNYWfWQt2KWgEYbJwt3OqD92mA1maT8kd
 IGs5Pjx+84Woj3R8umysHvcNluLVCyf7tyjTqe5vjkeFLGlVna0H30VrEyXy9/q+CpszzNszYsd
 Jan3RCqblnqZyGTHPYfXH9O0IdFVstjYpVaVmx2bX4xEZegQjyoRTmg9fTM376JUyQ5LWxjAb1v
 WJ1D18mZ/kX2tSjIxB5gzbwqNUEcrSEm2WLI4ga3cZyXK60irz24a/3xFoykO/WDfPbyZZffbl5
 UPnQmkGoJ0SBzJWDrV2XMtae34tar7SGz2SpMFtKyo65FD5VX7ZF2LuZmSDlQ3ks5zgu0vWvvby
 F8BQxMzRTVAuNyCvR8eX+Ip43Zz/RZ59YVv4bF8zBRlAvKYPPt28/Uzc35/Yu8GNYTKJgj0p8wL
 cvrM6rzW/IkL1ocKwpks62jSIR9Axk=
X-Received: by 2002:a05:6a21:599:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3bfd28ba991mr10314916637.39.1782996122987; 
 Thu, 02 Jul 2026 05:42:02 -0700 (PDT)
Received: from
 runnervmkkn4f.m3vk50xfut3etgkurzddjyiuoc.phxx.internal.cloudapp.net
 ([20.168.111.87]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd2362sm9864954eec.20.2026.07.02.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:42:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu,  2 Jul 2026 12:42:01 +0000
Message-ID: <20260702124201.4073-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260404171614.1695371-1-pavrampu@linux.ibm.com>
References: <20260404171614.1695371-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap35: Migrating libhugetlbfs test v6
 truncate_reserve_wraparound.c
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

Hi Pavithra,

On Sat Apr 4 22:46:14 2026 +0530, Pavithra wrote:
> hugemmap35: Migrating libhugetlbfs test v6 truncate_reserve_wraparound.c

The "v6" in the subject looks like a series revision tag left over from
git-send-email. The libhugetlbfs source file has no "v6" in its name
(the Origin URL confirms this). Please strip it before resubmitting.

Suggested subject:
  "hugemmap35: migrate libhugetlbfs test truncate_reserve_wraparound.c"

> +/*
> + * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
> + *
> + * Test that hugepage reservation accounting is correctly maintained when
> + * truncating a hugetlbfs file. This verifies that reserved hugepages are
> + * properly tracked through the complete lifecycle
> + */

The description block must open with `/*\` (backslash after the opening
`/*`) to be recognised as RST content and exported to the test catalog.
A plain `/* */` comment is not rendered there.

The `Origin:` URL is also inside what should be the RST doc block. It
belongs in a separate plain `/* */` comment before the `/*\ ... */`
block, or can simply be omitted (the commit message and .tags already
record the provenance).

Rule 4 also requires documenting why root is needed. Hugetlbfs has to
be mounted by root, so a sentence to that effect belongs in the block.

Suggested restructure:

    /*
     * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/...
     */

    /*\
     * Test that hugepage reservation accounting is correctly maintained
     * when truncating a hugetlbfs file. This verifies that reserved
     * hugepages are properly tracked through the sequence of: mmap
     * (reserves page), touch (instantiates page), truncate (releases
     * page), and attempted access (triggers SIGBUS). A bug in i_size
     * handling could cause the reservation count to become incorrect,
     * leading to resource leaks or allocation failures.
     *
     * Requires root to mount hugetlbfs.
     */

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
