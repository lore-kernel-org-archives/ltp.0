Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA123C4451C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:38:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 563B63C01A4
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:38:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 781613C01A4
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:38:39 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 191C86007AF
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:38:39 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-7e9f9a3167aso1451021a34.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784623118; x=1785227918; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T3tlalZG+u9ljJmPDn0HLO3WQjRlqunXKR5cmu6uOZg=;
 b=ln9y7bdAaaWBhp6HEClJQyPk7PN8IkA+G16hs+i+WvgVPkm4YSHH5cwrsumrqgZX8s
 h/L98iboPVuOpt84BNJ5tI5neD6K4zhMRlWEG0LW6lXdgLqyszE0yCIk8gF/s1rfH6Aw
 MiVq904nyTKDPdl8Zo8uxsCX0b+oEugEDqZjY8laxAGmZ8CNw1VsvbO6BheZpHjZjERs
 ZcEraISXC6wWtenz8I/WggPqGc953DtYdRL2WG7oFe02yg4MS29C2jfPZiytGjxRigpM
 LEcwFFDfvRxkvJvcYvGEBAmXpoGerYLcevoW97EA3hGy0RHX1HjUEmSfDKRlh0PB8SGy
 UD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623118; x=1785227918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T3tlalZG+u9ljJmPDn0HLO3WQjRlqunXKR5cmu6uOZg=;
 b=AjEhzu7XJxwvB0dY8nqDZrZ4f4CxIpEzndJl6v7cWyg4OriZCz/g6D3AwB0zgN87Is
 I/Cj+x7tubZZZwHXuYChTxXSH32iyZG3NM+iGmZ9caNczp++Ug1XaDrF6MQ1202bL8lL
 okBc3ETGYvqHsDItDfJelSECSOIbJYpFd/xP8wT1b+edVbj3kl57fwadMdUJpwSY7bzN
 Crnu8PK2sebFPoT+rojvs8z/BRQq1biYhaKFWebn9gWJmUPJsLeug+nNmdLXHyJYRrwF
 NA9zE6j9FZXEbwhJjDYyyqjIiLjl4FqFLhK7vnnz3Znv7H0Mugj/U+BgVi86txW3YOxr
 7NXA==
X-Gm-Message-State: AOJu0YyMzQxsN8bfCViIiPklRDmkbL/54m1hOd0sqxeql05OCp4jB92R
 arExQ9dMYhzDOGNDLEyn9zWpi1HCf6O/enlyLi/pFYkWVTc1WT4FcN3z
X-Gm-Gg: AfdE7cnl3lxX5Loo3WIdXR4y88sJ8a7pUOiLjKYsAF1ywckg5A0M9gY4/f5WmyUTTLT
 qyKx2tVzriBF+OQjByiAQi5KQMG0+jJpvnk9VCSvgENN2dLz/Fig3+Km4DUMs58I9nrtesJvRjq
 nj1dL/PhqtY2C0ukbmQRbUpKb9/NTZe1oWBKgY1aVqg3wxtuOi3EVJ4RjE2/p8XZQP6aBGVyzf8
 Yg25lQMJUnn93VVDqgMA9mcgBsghVXyxzJ8QXGWwhxV3kFrYN3eJpTdhmfBAX7g3kjlnfRh6jpW
 p+IB2GIYgJT5TOQanhOpvvfi8d95ykB0tK6xmtulOmSOdnD3F/qsGCI8Czpor0qysl7OqU1tpIo
 FTWoZvkfsyY4J3/qo8RsLU4bhQfM0OSR9nLiVroyQ/KQcmEyQbICI1U4ClgoDRVJ+djyoRPEM4M
 CarKMamC1O4M/vurDzVrvZh6ro3RxbC5ikmgWxiD9fnoBGj0QNao4CCqRR1GCC29SmRb8jfJyUf
 EX92agLMojRvvzQ
X-Received: by 2002:a05:6830:6a97:b0:7e9:c76c:abe3 with SMTP id
 46e09a7af769-7ed9a9f39d9mr10773872a34.6.1784623112861; 
 Tue, 21 Jul 2026 01:38:32 -0700 (PDT)
Received: from
 runnervm3jd5f.n5pu4pq2qcdujjye3gbrd2khqb.gx.internal.cloudapp.net
 ([20.221.69.21]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaac40bc1sm10370991a34.0.2026.07.21.01.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:38:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 21 Jul 2026 08:38:31 +0000
Message-ID: <20260721083831.4141-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721074146.2779-2-wegao@suse.com>
References: <20260721074146.2779-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

On Tue, 21 Jul 2026 07:41:28 +0000, Wei Gao wrote:
> lib: New library function tst_get_free_uid

--- [PATCH 1/2] ---

> -		tst_res_(file, lineno, TINFO | TERRNO,
> +		tst_res_(file, lineno, TINFO,
>  			"Found unused GID %d", (int)ret);

This hunk is a fix to the existing tst_get_free_gid_() success path --
removing | TERRNO so errno is not printed when a free GID is found.

That is a reasonable fix on its own, but it has no relationship to the
new tst_get_free_uid() API that the commit message describes. The commit
message does not mention it.

Could these be split into two patches?

  1/3  lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path
  2/3  lib: New library function tst_get_free_uid
  3/3  open16: allow restricted O_CREAT of FIFOs and regular files

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
