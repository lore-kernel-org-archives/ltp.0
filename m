Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6875FC44501
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:25:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C98A3E5CCA
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 14:25:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD8A13C28C0
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 14:25:40 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 336AF1A006A1
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 14:25:40 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e5eef2abaso8682885a.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783513539; x=1784118339; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wv30NSj0cgpLTYNfUJLOVx3sHXJqtEzecDXdNJJpSwU=;
 b=mHxP3Hphk/jCIkSmFqG4uDkxUnBF1K4zVgGvkToBcf4uvnG+sc47EufqSHk+1rU146
 lm8iFkwPOenwVw0lw+FLudNCaBQr5QwrQMtHpNP0hYLKgYGZAJ3ReOQNNctSQ+1tz8j1
 veKNo3Uql0VX8jEQA7p75emYjwTOAGZe6x0KkfcdoFMFCm59MVW8qkXnmuLIiBp96nwH
 DMgmrT0j+hEu0YnRNdmTyZWbU7z/QBNAlXaEfgF+HLuTqbi808wgf1FwRmVLuy0VYyF4
 unf7vnYOnyQfslQDk3yBS+npjqpDndHw8ewcfsQ0BVD3VWJvvxxSEKYTxYOm2KWTwoDf
 474g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783513539; x=1784118339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wv30NSj0cgpLTYNfUJLOVx3sHXJqtEzecDXdNJJpSwU=;
 b=bLuxKvYLdliV6pny8x4l3zDWWPwpnOHDUc0zYyk2NQiMcMDTD7mAijSKwx5uQUOAEw
 DmzCkaD8MZMKrek3E5EbTjr35v7EnQKU2tZSasw432aD6jGqZj8/gRW10UHYprmjH5dz
 ROvIh+edPhrhCZDyQOg3wZAUrQnkVo8dPY2UTTwy8XrKRnxmolRLRFMM+IFIFCst7CUZ
 z1jSQX2vPGfd65muVaXE/bLwtMACn00PTdTtVHiQDyDd3Uir/jRjdxNBqb4XVvuDYp3j
 HL7Vrn3vh8Gbspyq56KUBroZE9ZV8LqVh+6Wlf+q+hQwVoTDnuhpZQO0F2j3NEyO++eD
 t1QQ==
X-Gm-Message-State: AOJu0YxHCX/DWfnVgGIZhP4KwOSOHtB2uCdUwW1UcNULM+l4RDsvZX75
 F78Hwt+rWRC2VgYT47IAJxvV5mK+nuzxlc7VUzmbmvEICt7u/ogqz6pG
X-Gm-Gg: AfdE7cnj0GAJf4JbzGdf9Lw1ZmzaH7OLn1WdnJ28hS2u9TcUxKBQ7Gjs8yYUy7P6g2J
 ehDk6qHOpoApx5LfS7yklVDS0fNfXJvKLwxczJumC5+pJ9XXaA9TTI9l46NfWqWyxxLznuhqweB
 Y8TT1CAUyiVG0CWNc9iywOYHs3QWiVKC3Ta7TYvvwF8d6ctU4M9PiB2LaSyhckndQLgCdFniCT8
 fw0mYkQ4wnc6mv9vWyBo6kSx6/evDBwYH9IMY7FVT9YiLRSMrrUxe/5ywNXJtO2S4lRhBQaB/6y
 atkCuTEGj33b8p7gRoan4fq3GsNQLRcLiMwQrCANMKyxX3csdkSHZIMcu2VF55AsOqHp7RjAESW
 w7KoMus7x2pU9vM5qpRLbBYduwpCsVKzOOj0DauR/zI2rTQAeKbDDnwEtxRCf85HKsaHudqPmb/
 tUZuz4pDw++iN/EQ+pD/nhomD+LWcibns5Q+efqVdGcFovO4Okzo/1T19/ProvS1CtrpewafRKW
 JA8GrmeboHUGCUWKUsCN26lAhoYAA==
X-Received: by 2002:a05:620a:4044:b0:92e:6a43:4768 with SMTP id
 af79cd13be357-92ecf52845bmr206785085a.11.1783513538611; 
 Wed, 08 Jul 2026 05:25:38 -0700 (PDT)
Received: from
 runnervmkkn4f.dkzskdve0ppefo4zo0uohm45kb.bx.internal.cloudapp.net
 ([172.208.126.99]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ba7e62sm1416673885a.13.2026.07.08.05.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:25:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed,  8 Jul 2026 12:25:37 +0000
Message-ID: <20260708122537.4017-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708104215.507193-1-wakel@google.com>
References: <20260708104215.507193-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp: syscalls/madvise09: Reset cgroup memory limits
 before test retries
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

On Wed, 08 Jul 2026 10:42:15 +0000, Wake Liu wrote:
> ltp: syscalls/madvise09: Reset cgroup memory limits before test retries

The commit message is missing a Signed-off-by: tag.

> +	/*
> +	 * Reset cgroup memory limits to default ("max") in case this is a retry run.
> +	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
> +	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
> +	 */
> +	if (SAFE_CG_HAS(tst_cg, "memory.max"))
> +		SAFE_CG_PRINTF(tst_cg, "memory.max", "max");

The SAFE_CG_HAS guard here is inconsistent with the unconditional
SAFE_CG_PRINTF call further down in the same function:

    SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);

Both lines are on the same execution path. If memory.max could be absent,
the existing call would abort via the SAFE_* macro before the test even
reaches the limit-setting step. Since .needs_cgroup_ctrls requires the
memory controller, memory.max will always be present, making the guard
redundant. Dropping it and calling SAFE_CG_PRINTF directly would match the
pattern used in the rest of the function.

> +	if (swap_accounting_enabled && SAFE_CG_HAS(tst_cg, "memory.swap.max"))
> +		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "max");

The SAFE_CG_HAS check is redundant here. swap_accounting_enabled is set
in setup() only when SAFE_CG_HAS(tst_cg, "memory.swap.max") returns true,
so the condition already implies the file exists. The existing code that
sets SWAP_LIMIT just checks `if (swap_accounting_enabled)` -- the new code
should do the same.

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
