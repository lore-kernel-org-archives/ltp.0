Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F0AC44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99C283E574D
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:54:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D693C3E2F07
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:54:32 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BB851A00792
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:54:32 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-381c69ad0d9so2506907a91.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784026471; x=1784631271; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KoAF8AkrT5w4//mNdLlkFWyrHOP1Bpl85QZ3xCABsZc=;
 b=H1TTUSlGgCTxqihMQjlmJp98+D15BvmW1guDhgllzKrA/nQkBKCpxz6qZLeurrP6wZ
 Q5PM00rorXRo8tdc1YD7vXpZxRELH5UBhoBk+XXKi3/w79ovnGUSDcAH78EB/UxEMKrC
 aYKxjp+cualikM6waDatkoCfzyMEEF2fsH5YG6c14+2EFoqqtfL+QnITkMTdS83ZZt+n
 4K6UOhiYzREX5mwIYINJWNFByfvqo1mTYpFqgY/xE6RcgetDjfwPL74wuP1asv2doRAz
 msr8lrI1/76rxjFmEvDSQfaFIkLEyOxdI6ada/enZ80IMYFHTNyZrQp1UJ47+aoHs7fY
 fBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026471; x=1784631271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KoAF8AkrT5w4//mNdLlkFWyrHOP1Bpl85QZ3xCABsZc=;
 b=Kjt5yTtpbosnytl2CpSPqXYvztIe29jaUTGBJIjwRJgEUtgwH2b0jFZ4w2tlUUR/os
 omnljXLLNz0K6Ofrd+JarQqzeZ6KAVkWyttSz1Yd2CJgJ1RtnHl/Ezx2uHaMIBPJvnaP
 ok5tcRzjlEWXuLH/wlIgeuO+fJOhjYXUNgh/eSG/KRTEhgEfhHjyzPkShZujgYObNm+K
 tzCKa+DhBMEmVBAV+MPEMHQhr3zXfmTLPkUUUarlSIQ80dBSlzYttzZiIPmmDs/WkQ6a
 e9wKwiwftGLPROKkmbgajrMZKJYb37ncN5vkpGKFMRtC5t4gNQO/6HbEhuhmyuVH4fyl
 Eaeg==
X-Gm-Message-State: AOJu0Yy0ZTFM4CR41ztLoaS87zunkxIOq4X/PcYUsCOlxrj827RDzR4Y
 xiW+EkEDTtEDOU1XCO9wysTr2U4mleq43WKwU8s7pHqC59icil865uFNFrl2bbl+
X-Gm-Gg: AfdE7cl+uyc/zoTGasnMzH1S5UBJvzoONRD1bswEBOAaC1XM2oA5xj3RE01fZC9D71N
 1K/JtAyBDksLZxQ5LIg0jkevS/h2WHgupnj3ZahueFjPSacJjKukbMhdQ871wINo87xMtN9sIWM
 7odgPx1kKXPun442uV7W0Z15e/8lkKFlAR2oxVPqD/vFI2V7DsagXuwll7Av0TS/JrmtG6JOqrn
 1fDCt+7LIWzT/knh7kHKv8JsVyM2whNJI6rh9AHCL0DEcSFU1OqcIOTEBOm0ZGcCFMTmUCdoxIv
 lfFBDeK4Q8ZRA+rZy9FF3OUcRnb8KzQ+Q26O2Ybyat3vQIMDoeoywm8m5Fr0n7gdaBgLPygNwTo
 KrCLzfRGOUqi2ZMeeYTZufyEXDIixlPn+WXnU8EDJoZj3J7Va/QTYh4LRkeStpPz5NHHkDwP0+T
 9CJ4BoBexTIhJ8nhYn5nFKgnrpWLQp7svYkn8VdwvcovK0wcmvjzt8HLkr6ehpP9W6IYiJTaz5N
 N88Oy3kY7WcQb1Frp6jWgAAL2iYPg5t8DG+uZ6PWw==
X-Received: by 2002:a05:6a20:9f95:b0:3b7:d9d6:9fc9 with SMTP id
 adf61e73a8af0-3c356f75555mr2474681637.2.1784026470615; 
 Tue, 14 Jul 2026 03:54:30 -0700 (PDT)
Received: from
 runnervm5mmn9.ksylce4ud4kezku4puvbvmbvsd.dx.internal.cloudapp.net
 ([172.184.204.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b84d6ce15sm37966656c88.5.2026.07.14.03.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:54:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gang Yan <gang.yan@linux.dev>
Date: Tue, 14 Jul 2026 10:54:28 +0000
Message-ID: <20260714105429.4063-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714101454.8784-2-gang.yan@linux.dev>
References: <20260714101454.8784-2-gang.yan@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] loongarch.in: add memfd_secret syscall
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

Hi Gang,

On Tue Jul 14 18:14:52 2026 +0800, Gang Yan wrote:
> loongarch.in: add memfd_secret syscall

--- [PATCH 1/3] ---

The subject names the wrong file. The changed file is "loongarch64.in",
not "loongarch.in".

> In 209f0c6360da('Update arch(s) syscalls files'), it only removes the
> 'memfd_secret' for loongarch, so that caused a error based on the old
> kernel:

"a error" -> "an error". Also, "based on the old kernel" is unclear: the
EBADF failure occurs because __NR_memfd_secret defaults to -1 when absent
from the syscall table, not because of any particular kernel version.

> +memfd_secret 447
>  landlock_restrict_self 446

memfd_secret (447) is inserted before landlock_restrict_self (446),
breaking the ascending numerical order of the file. Should the insertion
point be after landlock_restrict_self?

  landlock_add_rule       445
  landlock_restrict_self  446
+ memfd_secret            447
  process_mrelease        448

--- [PATCH 2/3] ---

The subject names the wrong file. The script is "generate_syscalls.sh"
(plural), not "generate_syscall.sh".

> +#define tst_syscall_base(NR, ...) ({ \
> +    intptr_t tst_ret; \
> +    if (NR == __LTP__NR_INVALID_SYSCALL) { \
> +        errno = ENOSYS; \
> +        tst_ret = -1; \
> +    } else { \
> +        tst_ret = syscall(NR, ##__VA_ARGS__); \
> +    } \
> +    tst_ret; \
> +})

The macro body uses spaces for indentation. LTP follows Linux kernel coding
style which requires tabs. The same applies to the refactored tst_syscall
body below.

> +#define tst_syscall(NR, ...) ({ \
> +    intptr_t tst_ret = tst_syscall_base(NR, ##__VA_ARGS__); \
> +    if (tst_ret == -1 && errno == ENOSYS) { \
> +        TST_SYSCALL_BRK__(NR, #NR); \
> +    } \
> +    tst_ret; \
> +})

Same indentation issue -- tabs required.

--- [PATCH 3/3] ---

> If some feature is not supported by some arch, like _NR__memfd_secret,

Typo: "_NR__memfd_secret" should be "__NR_memfd_secret".

> This patch use tst_syscall to give a more specific fail reason:

The macro used throughout this patch is tst_syscall_base(), not
tst_syscall(). "use" -> "uses".

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
