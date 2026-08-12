Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C54C5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 17:08:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E79EE3E6FC7
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 19:08:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DB253E27F7
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 19:07:44 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8ACB86003AA
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 19:07:44 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc2c6e0688so7452205ad.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786554463; x=1787159263; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S3w8xqZRwhJXtDv4no5CbfBQZBUvK202OqJj6tcJ/2I=;
 b=YAxVh/u3PgkJT5T2NPfrH3aAqxkwbiEld2KZULuS2tTEsbzS4TD9GnInyzU3wp+gFi
 ADnrJZhejpxYOBhNmKKjvRxAY//gT5EB3o8qUzyHYr7wCEi1VEVG84G+F3Zh1l5ONu5Y
 s7CUZwerzrjX+OI9PakVfgvaFWN2gx2ZcDHdbL0LL2LMLxBg52CLfksVHR/emDJ8Sqzf
 YEe4PmCsusUEtfqXcCyEwQYUeuVtslwKqIjKEzKIeBEhJ4j5dUp2xpImO9KcDiViXDZ6
 EOcxsHxoZ7rkbIET8hNPMxkA6kM1Mf2L+zQyKSVODOlQOuFYVv4qFEo/KrSu5C7WONZb
 U6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786554463; x=1787159263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S3w8xqZRwhJXtDv4no5CbfBQZBUvK202OqJj6tcJ/2I=;
 b=h3/ifRGj+sCJfvuUCL2VCL4RuX992FX5E+Theh2uICyVQBwe6DjOkXdYONRPqbD1c1
 5Ufh1VLkL8aho2KZsx8Mqnkit50RZbBO+cwirseKbo1PnwYpv68Gw0OIQ0A3nR/ud7yK
 +VYfrhMUPBuEv4iCqLjjAqhvnWxdD+xgYg+1hWWouHUpvi+ym8XXiNt/6G6kXLbHO90N
 HH07UcDMHCpsOINNW/hbdwXPIjg2ctnDAf4zg3L3uigir/bVHDUMnlB/3eHvpgJCr/iP
 vS4PfaDknS2FzLoK7nJOqbuKYuK1PGuJl8E7SGemrjvlQKsYyUTeLgECkBgxfjyFMbrV
 EjfQ==
X-Gm-Message-State: AOJu0YxFdMVWuypQz3MFe/WG4SD/kvRgy0iqLWn581aKF814mofhq6tR
 IrrVpWbNG3xKgBPYHpk2P45ffD721bj0D6MQcxC/emDkd8EaMg3V9Q/i
X-Gm-Gg: AR+sD12Ty5LX0DO77Fv10CRbbMUOAFUNpxwLPDI2g6sdB5mtnxtV4J+gazqFzOPisw/
 EspD/3LQD1vjYUWGQIKouQKf1EzOdKCPeQyTVKouTmqRLfwCyy1iqPtoqsDhAZGT3Oe2jNXSAbv
 ZUh4lKrQnqD21NJszLv2LeZqQeUY41br+bXuO+MyZshLLkCiPUd9Q0nqXb6feaN4y+4JXS6J5mr
 BthwH2VxTxHhhyND4eOcR61lN8ggxBfviyDf8SXLm6RMVB2n4n96k58bnyojBsjj9vCmY/89I4V
 tPmfGxmuCq5hbanrH5N/8sCEn1I5zJucZc0tcUeAhBe00BztvVk3c0CD54rAKZmJ0qOeOoOzl/E
 c4uPawHcLHoT2iHrmQoEPsTXysecy6OhjxT87PeWpQHgXGZngTimY5pzJ5m0ZmQn9DQdgFzGN7c
 4QWk3JI65PKSARlYDnGt+xkX8c1PEOJG3GCqycwCAyntMdgKuCllU3tb9wy/qEhJfpxNSXFLsRK
 peMRC9030edD0lk0aL5Jq/9fPT/6ab7yq/hmiuWiyuZKzLt7izOLmkmv3KjgAyDFQpS3ITrCA==
X-Received: by 2002:a05:6a20:9c12:b0:3b4:8880:2089 with SMTP id
 adf61e73a8af0-3cc3f62f8b6mr8928304637.16.1786554462701; 
 Wed, 12 Aug 2026 10:07:42 -0700 (PDT)
Received: from
 runnervmvrwv9.1qk5hrnmv30eljm3ic5sjdqocg.yx.internal.cloudapp.net
 ([20.51.57.113]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141245a9f70sm15489263c88.15.2026.08.12.10.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:07:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Wed, 12 Aug 2026 17:07:40 +0000
Message-ID: <20260812170740.9021-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812161613.2715489-1-pavrampu@linux.ibm.com>
References: <20260812161613.2715489-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

On Aug 12, 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

> +#define ALLOC_SIZE	MB(60)
> +#define ALLOC_SIZE2	MB(20)
> +#define MIN_MEM_AVAIL	80

[Medium] Could MIN_MEM_AVAIL include headroom above the two mappings? The
worker keeps both mappings resident simultaneously, so a host with exactly
80 MiB available passes the framework check but still needs memory for page
tables and other process and kernel allocations. The worker can be OOM-killed
while touching the mappings, producing a timeout or TBROK instead of testing
charge accounting.

> +	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &after_migrate);
> +	TST_EXP_EXPR(after_migrate <= baseline_b + (long)MB(4),
> +		     "group_b memory.current (%ld) not increased after migration (baseline=%ld)",
> +		     after_migrate, baseline_b);

[Medium] Could this also read and verify group_a/memory.current after the
migration? The stated invariant is that existing charges remain pinned to
group_a, but this checks only that group_b did not gain them. A regression
that drops those charges during migration leaves group_b within the allowed
range and reports TPASS despite violating the invariant.

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
