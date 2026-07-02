Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A28C43602
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:39:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B41023E2F39
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:39:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 870083E1644
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:39:35 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6B8B60064C
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:39:34 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-38109499830so35700a91.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782995973; x=1783600773; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGRrq0InzswdiWPQE5i24+FDFx/CqBPGCJD7oHiTWYI=;
 b=lAFd03VnY7U4wLlhgAQtu9Ye3Oo+wVkkHBsBO01BQNu7c07QulKkV7psVRYJx7uKzf
 9GTDFflQs4BrY+/pIWb725SNBd8kX72XLek3MWEmPIIIrDXeYKqEPFL+Lj7KYDcydlVU
 fXDea1j2MDPnb7hLpfa7mhoaxA6r4ICbsztCPNMNTFt4+xmMsABDpvtB05s9XNvcw731
 PnAlwZur9yp+nxr2rOK7yFHpQNYtgsDdK9slkziEKK8SJVIQo1s93joUtLubcOabTK3S
 9fU6oWx1bdvdVP9wADoP5N5Ts8Vp3CgSmLNdTnJZ3YKGPDnfIXBvDdY84KNAak/Gtbio
 K6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995973; x=1783600773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGRrq0InzswdiWPQE5i24+FDFx/CqBPGCJD7oHiTWYI=;
 b=LQ3+pzqwlU1AY+bMzpHjyAxTLMdZ7HdB3JDFPzezmjycFBt8Ng57Aa1GwGeK5eo+yK
 /orqrS4GMS9Pd6g/zL31F7ayTjtURMh/Ru6ykPBw08mf/M3YGS0y6Jo7fOiWyIOefTGQ
 YncaqshS90Ngg5wC+txGhRE3xQDho4QAmVgzC2NKCOJv73/hVPcU6hkazjkktEioH5hv
 tSWUzJstXZHrhpBXUg3cUJAUSFVJNg+E0D7cqsRIzy30RgEF2XxP5JSuqkt2nf0jDa1I
 lL4TItTM1g4bnLmZq672RejDVn+9kDwQO/evNE6M2hky1NMWAP2pXY3B2Qg1ff+1QCDY
 lHhA==
X-Gm-Message-State: AOJu0Yxa+tC5Eo9fFncf6w5tO+FzxgOW/8Tv7jECnGYR+cSRczi2dVkw
 Tkgx6l8X3Nq2ABoug3M9+HmvtRI/ml4mjd7h1kntbmruL4ZZK9WR42Jw
X-Gm-Gg: AfdE7clnKLK4fatHa+hYSITz8oI+bA0n+h2cpXUNqxE75YFHJhJ4tgaPKv2p3VniRrX
 IWWdPxVVOG0TVg4aptLPXHOwwOElAuclTDChOpSwc5EfYpXLTxZgVAKWhQDq40ZBz3CPR7zJg4r
 6IpCBg4z48x3138ZhDkxRXgHpWG7D9IBdMG9YvacFWyl0bwq10YkQPfaqcT5rzdJrlgCPu5+6Z1
 tpjiiTjSfDVuJiwR6Cu9IQ0oeaxVv1d/GC7nkFmHPpG5s30iRWWSHtPIa/pn9C+ippImZdBpqXq
 NteVT8FDqWFsM9m/JkcG/GALEUZrapWHFAHNGD2CcmucWVwLkITA49VYKu9OD02hgn08n63lX7G
 6Y6lUSNdy0WwnvYPZ1VLgrdNLToArrpri1FMVvsFTm4c5NA6It1qokPAJgGc370+4qRuLdN5LLE
 oYfFABc7TMrRkiItIa5KQSqAFzJ3MVmivkenMgDc22jhz8OnvYSOxqRLzFx6cUUxcxFEwAeNbyn
 ACVJUxNRApnE5EkPOehoK4vPwUH
X-Received: by 2002:a17:90b:52:b0:36b:b3f4:d578 with SMTP id
 98e67ed59e1d1-380aa0caf3bmr5941940a91.15.1782995973055; 
 Thu, 02 Jul 2026 05:39:33 -0700 (PDT)
Received: from
 runnervmkkn4f.cddunxfqncwu5ncfdzyn0hhfze.dx.internal.cloudapp.net
 ([52.159.244.83]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb84405sm12975822eec.17.2026.07.02.05.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:39:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu,  2 Jul 2026 12:39:31 +0000
Message-ID: <20260702123931.4104-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260404152742.1664783-1-pavrampu@linux.ibm.com>
References: <20260404152742.1664783-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap37: migrated task-size-overrun.c from
 libhugetlbfs v4
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

On Sat Apr 4 2026, Pavithra wrote:
> hugemmap37: migrated task-size-overrun.c from libhugetlbfs v4

> +static unsigned long find_last_mapped(void)
> +{
> +	char line[MAPS_BUF_SZ];
> +	...
> +	/* Read all lines and keep the last non-special mapping */
> +	while (fgets(line, MAPS_BUF_SZ, f)) {
> +		/* Skip special mappings like [vsyscall], [vdso], [vvar] */
> +		if (strstr(line, "[vsyscall]") || strstr(line, "[vdso]") ||
> +		    strstr(line, "[vvar]"))
> +			continue;
> +
> +		found = 1;
> +	}
> +	...
> +	tst_res(TINFO, "Last map: %s", line);
> +	if (sscanf(line, "%lx-%lx %*s %lx %*s %ld", &start, &end, &off, &ino) != 4)

The comment says "keep the last non-special mapping" but the code does
not do that.  fgets() overwrites `line` on every iteration, including
iterations that immediately hit the `continue`.  After the loop, `line`
holds the last line read overall, not the last non-special line.

On x86_64 with vsyscall support, [vsyscall] appears as the final entry
in /proc/self/maps at address 0xffffffffff600000.  In that case sscanf
parses that address and find_last_mapped() returns 0xffffffffff601000.
find_task_size() then starts its binary search with a low-PFN value
already above TASK_SIZE, all probe mmaps fail, and an incorrect
TASK_SIZE is returned -- making straddle_addr wrong and the test
results unreliable.

The fix is to copy `line` into a separate buffer when a non-special
line is encountered, and use that saved buffer after the loop.

> +// SPDX-License-Identifier: LGPL-2.1-or-later

Other tests in this directory that were migrated from the same
libhugetlbfs upstream (e.g. hugemmap34.c, which credits the same
original authors) carry GPL-2.0-or-later.  LTP relicenses migrated
code under GPL-2.0-or-later for consistency.

> +/*
> + * Origin: https://github.com/libhugetlbfs/...
> + *
> + * This test verifies the behavior of mmap across the TASK_SIZE boundary.

The high-level description block must open with /*\ (backslash after
the slash-star) so that the LTP documentation build recognises it as
an RST-formatted block and includes it in the test catalog.  A plain
/* comment is silently ignored by the doc toolchain.

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
