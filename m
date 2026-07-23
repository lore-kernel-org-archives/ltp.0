Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9CAC44524
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 08:32:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D71D3E1DAF
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 10:32:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0A9D3C1C41
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 10:32:05 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 585791A00918
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 10:32:05 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e46e59297so21936685a.0
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784795524; x=1785400324; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q7E5JeEoR5rw42Qv+BJuVYAoT9qtewrOLxC9fPhi3/Y=;
 b=HYlERNtlmtsnhAG1/4v+JibGyVpNbHBtG6qYj5pEy9k7syW7k+rQi/Akt6KdS5v2MO
 w+Nsl1g405MW4srmnQ295tYJWy6b6xXkVBclBbK5jiOwhohfveZQbdadUBbSaFfq7WXg
 2/sWOe7DCTa7RpbFUr8bLwY1rImZua6E8RKKdVjiJL/6ZnM4xiESVYP8BAjOyjGqreg9
 xsbZIvJwBRwvG/Oq0hMzfBnGh1TJZsKTi71wwtF9tu6tKz6FJWFCojas25NfczQq+ktS
 DRtz6N4ydKtAaWwzKNs7RgWl4ySuwV5eqH/qH7SCnwNSPsiy1QqF77NNtwiMy3dNlO9x
 E/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795524; x=1785400324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q7E5JeEoR5rw42Qv+BJuVYAoT9qtewrOLxC9fPhi3/Y=;
 b=D226mhLdqbCY2kUdq19DJrvL472dhcIEjbEAYi7o1kWpvoTr1dicgJewxA8Q8hbcNU
 wgo3R5yNLPulEQXerSAzKmx10uQZvXhCEhun+gYJW5UgJ87sNBJif71beqAwEXKCXpxO
 QhkFE+v+dRfScBz9h9lfUcZF3XMQ5rwFnrCW8KVko1W047g/xEA0ml4u5K+E5j1Aym6d
 neg8BnYN4u+qVh2+vgTODmSGD6LgA6v4WWwlEgeAnCL2FQkwgizCJw3NJN1Q3L5n/zX1
 5/mSGI/hGjknQhlQ27qZlMU77RqIznQ+qrsZZFSCgYkL+gr30xiAo1tZeFzT01CFB/xv
 C8pA==
X-Gm-Message-State: AOJu0YxEagXPrayub+Kp3qt+8tqh78Khef2ZUsvSJbB1gx8ZyVixT5fw
 gdi3ja2zSkkbhfWqvYniddsizb+hPzvAIm+yuqmLjyEgLLR2hkk2tGQ+
X-Gm-Gg: AR+sD10FV2HqGBfY0SU8IRG9oe+SvpMgB7cci85Jf02CdsEskZZYx0LH4hzLQxmmcOL
 Uv3SgBrPGAzAtmws53bjRGVGz74uccX1SR3XxITA8yDgEVZQQKzJYztzgJ+NgAEDXs3vjWHua0e
 T5hKseJ6oF1LvTtaokZxNSvrPyJc8cgc4/meovLhIolcVZZyP9ljbMNwBwydbWMlPuSxYLCet45
 xRA0XyeNtvop/5lJrogYGkEBgNzVRCddr8U+DrtGpvS9fc0DX4HQU8OgBpmUi14PO7oDgh35eZq
 1Mlh3kmxn6kTfde86jS6HaVa6VT4URJqc+hTf4kgaBs6kFwVWnwl5bAv8M200lgHGLMO9XYprmP
 cKUZY5dfjVK7HJBCz68mviWzypU1Hf8T6JA0XxF1KUPiAXcvLgqiJg3adT4RrL6cD50bXK+0unR
 boy60FTQeB9d/wrt16g+3PqHPn5Uf4obRqJkizd00eklG4PtuWXBnmgcYw2yAJQ5oLqAy1SxN0N
 fxGvop2NrnmBQ9OTA==
X-Received: by 2002:a05:620a:458a:b0:92e:c116:bf07 with SMTP id
 af79cd13be357-93103a87daemr179514285a.80.1784795523643; 
 Thu, 23 Jul 2026 01:32:03 -0700 (PDT)
Received: from
 runnervm3jd5f.5f5m2w1q5mnedkaia2eyulueah.ex.internal.cloudapp.net
 ([172.183.91.41]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f687465csm376632585a.10.2026.07.23.01.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 01:32:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 23 Jul 2026 08:32:01 +0000
Message-ID: <20260723083201.3957-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723075319.4920-1-wegao@suse.com>
References: <20260723075319.4920-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Scale cgroup memory/swap limits dynamically
 with page size
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

Hi Wei,

On 2026-07-23, Wei Gao wrote:
> madvise09: Scale cgroup memory/swap limits dynamically with page size

> * o Set memory limits
> *   - memory.max = 8MB
> *   - memory.swap.max = 16MB

Now that mem_limit and swap_limit are derived from page_size at
runtime, are these values still accurate for the description block?
On a 64KB page system mem_limit becomes 128MB and swap_limit 256MB,
but the doc comment still states the old fixed 8MB/16MB.

> +	if (tst_available_swap() < swap_limit / 1024) {
> +		tst_brk(TCONF, "System needs at least %ldMB free swap to run this test",
> +			swap_limit / TST_MB);
> +	}

This check runs unconditionally in setup(), but swap_limit is only
ever written to memory.swap.max when swap_accounting_enabled is true;
otherwise child() takes the "running without SWAP_LIMIT" path and
never enforces it. Could this needlessly skip the test (TCONF) on
systems with swap accounting disabled but with less free swap than
swap_limit, even though swap_limit isn't used there?

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
