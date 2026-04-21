Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB14F8FA90
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 17:07:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22B743E53E0
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 19:07:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C96B83C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 19:06:49 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B4FE20075B
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 19:06:49 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8d6d5e45c43so520793685a.3
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776791208; x=1777396008; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9W/jprFqdqjGEeT1gr5ncjSOURdzEYmmLu2NzQeRQQ=;
 b=kIYr0D3ulRH1meWz6XZpC4ZPHCzJNMTPK/fi0uRwKt9blMGU7j1t1j+pGN8fAD1Y9J
 Sg0SDViHZWwKIHo6Zzb5zwdUkrKL1eVACEurXmrvY9zbS8rS4fhzfJlATMPn12kNh2UP
 YN+nfjHKCg6Gb1yGvHRR77Tl3wEPDoqd3sUYnoREYcDzpMzs2Ui7aPCyPByIeJshuBZx
 OKGdFpSRiSnyhvFMMGm/ozs/hUFjb/JHSCqLA4200jD1UrB2HzALlE93IvfHcHhPezpN
 lypl7LnVUikoxVf1PsdeEEuk+R8+x5Ur1ZLFNYMzO9E+/HtemjPrDGYs6X11tKEiyOPd
 JnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776791208; x=1777396008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N9W/jprFqdqjGEeT1gr5ncjSOURdzEYmmLu2NzQeRQQ=;
 b=IoNe4NgPSLYyppe2ziSW/Keui6fZElJW1ysn7XA/gHSfPU0JQdg92eTwdcrEFIVXLs
 GPXv83NsqzVr1tkhzxq7ltYzejjkWqoyxqrBArq/8MduOFFmWlypaJqGT/hJ3TPuhXCL
 sSFbJvDLVHxcpnZc/+RvYCxz7u7E3RYmNf1qtJT0ZG9K9khrv96HHYxtNF2dyKrU3rqa
 1aPZg2bNL1ZWcXT2o46dD2iJEapDH7AZFdxKE3KpopzYcGsja8HT9OsKI0G2JuP4Jurk
 DfcJci2z0PvjcE96UY4AleDyBusrzR8aCmzpmEqBo6/mz022WaitHI9BGoIqaTuH8e6c
 HazA==
X-Gm-Message-State: AOJu0Yy3kX6wLGRfh0GuS/8pt3ixoKxLnMHICr6b7vEcp701HR36EP/k
 8d7qoz9TnWLxg9PxoeZSJWLNBphixLVr4LMW4n4fqIR3duChiRCl01sx
X-Gm-Gg: AeBDiet8bAIDdcW/PeqNFf+bsGdp4nov841ycw7Zhna7sjv+n7rJ74QtB1jWWfsIKNa
 hIO4bDdrzF98IM6i/GO6naj0ETl6yQ3bMnZ+ZQa+SeJDhpc7AeW6YUE6LqdJXrrYgjHet0nElfC
 hKdFsMnPq7OkNLhaPBk1L6qFKq8aa2Itt6l2kQrH/bdrYlKwbcNqCfTv26Xx/yGPNe5GjstVyNb
 jYem1aS5/ZCIXjHlH0HVKcEWJh7gL1RM4FvEZtWms0BZK+tN3YNOlu38NDMFEJRptjrR9vACu4L
 3SC5cE3Hs777j2G21qESGzWzKDtacHjTQ272Inp8BPgX/1LZQajskj5rkUOaIVVxArPrT+7L3CC
 ALpXgQZKxBBSY39Hb4ivhiHsllbKQuNAmEYLvz7k8/zoobEfWjxkEsjY2vgEd0EJmHe7sIqr21k
 HlF2HFxuARW9Pdm8pnKO7Aw07/1rxsBgFxRiNQEsMO45MJovImAAjpNJf9zTaiql8fDjY7uj+bA
 EtqWg9y0JnQExX5rlJ/2mhGoSStFQ7tlAy9Z3l3GnFTwUQHwWKsGYsHTTbGioE=
X-Received: by 2002:a05:620a:258b:b0:8da:384b:9544 with SMTP id
 af79cd13be357-8e78fa1eba1mr2768995385a.2.1776791208197; 
 Tue, 21 Apr 2026 10:06:48 -0700 (PDT)
Received: from
 runnervmeorf1.d25eko5qp01u1c5angi00huzxc.ex.internal.cloudapp.net
 ([135.232.208.151]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb77esm1126710385a.22.2026.04.21.10.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:06:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Cermak <mcermak@redhat.com>
Date: Tue, 21 Apr 2026 17:06:46 +0000
Message-ID: <20260421170646.3943-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152349.1673057-1-mcermak@redhat.com>
References: <20260421152349.1673057-1-mcermak@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Make userfaultfd0{1, 3, 4} LTP tests valgrind compatible
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

Hi Martin,

On Tue, 21 Apr 2026, Martin Cermak wrote:
> Make userfaultfd0{1, 3, 4} LTP tests valgrind compatible

The commit message is missing a Signed-off-by: tag.

> -static void *handle_thread(void)
> +static void *pagefault_handler(void)

Since this is no longer a thread entry point, change the return type to
void and drop the return NULL.

> /*\
>  * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
>  * from a different thread.
>  */

The handler now runs in a forked child, not a thread. Update the doc
comment in all three files.

[...]

> +	pid = SAFE_FORK();
> +		if (pid == 0) {
> +		pagefault_handler();

userfaultfd03.c: extra leading tab on the `if` line.

[...]

> +	SAFE_WAITPID(pid, NULL, 0);
>  	reset_pages();

In the original code the thread closed uffd for the whole process (threads
share the fd table). With fork, the child closes only its own copy; the
parent's uffd is never closed. Add SAFE_CLOSE(uffd) before reset_pages()
in all three tests.

Also, tst_safe_pthread.h is no longer used in userfaultfd03.c and
userfaultfd04.c after this change; remove the include.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
