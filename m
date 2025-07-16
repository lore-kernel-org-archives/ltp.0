Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F758C83F1B
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752650018; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=9R98n8yEReqQR/18YC8TSNv7AXuwov7yzf0IeeKIPxo=;
 b=qByeFOCTVz9X+SYbUHYKiU2LSS5Od9uVdzDPc0KXiR3Jl3yNMJmbsaCUtIo/SqmYrfFCy
 qtmNIIbXRKR93o1jTq7f1XSC4qqIt8Cj1L5Gikm8dHfQhZsRCIU3pmNSY+JTVR3c1kb8yHR
 GRbg4QqkGa3OnhtIiu8Kltc66FOvAP8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB1603CBD99
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 09:13:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D56B3C7746
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:13:16 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3486A2001A1
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:13:16 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso1014439766b.3
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752649995; x=1753254795; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/YC/vzabL/q6gnrUXhjb8j6vv5y5MZmOySt7hFZvRo=;
 b=FwbcJxMB/AJX4+gdAFlMwUhhQhsX/cYiuxRkf3yGTwXenE3HpOfl8xM9h4Przul3ap
 sCC5lVFoxB0NOc9yGYIllEuYxNsI1wdoC8wIFGQVFI7UYMbEOFZuthiaVrxuODgXJyo6
 S3ejo2EpmfMtQ5S0at4AAksTL+72FEbZCIcP88VGnU2kH/nGoDUqvfhRCX6GGcTgvVGS
 Osq/aj8ljXOUx/wF62sBJmLmPL1INxah/bIqRMG3pR+dE1wyjg5JfcLZdTPqObKMBa7d
 vxa+y4XoRceimpT/mivenAIPDopWcbvbFdy8lmKY3iCW71tSsrLSqNo6R//M35Cwy3GD
 KiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752649995; x=1753254795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u/YC/vzabL/q6gnrUXhjb8j6vv5y5MZmOySt7hFZvRo=;
 b=NaYCdeBTNp35bv3c9lw8xiglYNFyfBfowW2jgG85fVAbOxIN3+P9wVeL3yXjWZxJ3c
 Ykd1n6/DqrFn8W7DLlZJuSnSvj3iI/yLDXq6PiGn06FxKQFBAPBXptdbr4kqNzco8PCM
 g1yEKX3PA8/FEMvnwQbABOyI1x1YYd5NNtHo2v9hXgKnoFoedIGFE+AZWQfqzE++Apep
 SYk58cDdFt34zvukvVW6J+xC7Y3fbxmJAtWD4LV5u57aD1H2yd1Kzc48iKLEn8niQXPT
 LA4wJEgvHHi4AZVPX02+sQYgB9cJwZ24XCnoJ4YN1O4sVG/mgi6bU5vzAv9GS4RVA/WF
 fQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/lmi3n/JJ7wEqoTA4/2+sogW3UfiiUmtGJ3Kz1l/V3exoifmFOgI1O8AROEPOD2xDMek=@lists.linux.it
X-Gm-Message-State: AOJu0YzYNEDOgHObCAvODaTbSvCCS0DQut1yIEfHO5kQATKg98718n5X
 zTHsjIcPsKO3nqQ7xWoITP4v4zPp2+5BPhCMCWZ8UIaiFyVMNYZD0eT3aF+XHc/zmk8=
X-Gm-Gg: ASbGncseB2pGS34fS4mLdc0IDlxgocLrxV+cg1K79b+bnlWh2xgbKpu1ib+JVhbzBJq
 s6+wz9CLqAGFAQjv1Al3pvY+FS62u0uXv4+RVO8/xQpgT3IdleIVv7cRF7iPOnrvAzSfP985CS5
 UL3DOfDCRtXumq0muF2dGj++Jm6MlNjcsSfrZNnsLSR9ggzpFNPHTNuclJQQ0WK13/nosbYhtzB
 Kbw6uGjvpAtaIYhLgB9AOKd2Fi8bLMhQJdkHe8EiqWcQ5nCiPQQP1Sj88E5gPDrDhp3pmJXhL1a
 HPG4m+EL8DsiAp8FpiU8acjxdKC+S6H1qzQM+s4n7tBzvaSNlm7Rxmf7vjLwSP0B3V/2YW+rVd+
 3Z0FwSpH9TZz7Tm/ovtObpfS7j7TNQ/vSCqixBO3ppMOBPC8HA8VSeJuT/M+8IR6wH0bQHOUf+y
 YhzPs7WqhcHXrpKx3SqXrux+JFgdixOt7eb7sUANuR811sk5NZQ8EPQXAL8LfT4w==
X-Google-Smtp-Source: AGHT+IHWSQlZiqZAXzE2lEL52KYPFRXZSX8wIyQqtAF6FBrtl9Pz/eOZLmbvUGa10zTtN6io/Vh9fg==
X-Received: by 2002:a17:906:8462:b0:ae3:de00:3a31 with SMTP id
 a640c23a62f3a-ae9ce0bce35mr103273766b.30.1752649995336; 
 Wed, 16 Jul 2025 00:13:15 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82df4dasm1142438766b.157.2025.07.16.00.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 00:13:15 -0700 (PDT)
Message-ID: <a1a3bf02-5d2a-454d-bbe5-5460cb2dda60@suse.com>
Date: Wed, 16 Jul 2025 09:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250716120600.2855395-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250716120600.2855395-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] splice10.c: New splice tests involving memfd
 secret
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 7/16/25 2:05 PM, Wei Gao via ltp wrote:
> Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
> secretmem LSM bypass") prevents any access to secret memory pages from other
> kernel subsystems.
>
> Splice operations involving memfd secret are checked within this case.

"Test if splice syscall prevents any access to secret memory pages from 
other kernel subsystems."

The linux commit is given via "Reference:" anyway.

>
> Discussed-on: https://lists.linux.it/pipermail/ltp/2025-July/044351.html
> Reference: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   runtest/syscalls                            |  1 +
>   testcases/kernel/syscalls/splice/.gitignore |  1 +
>   testcases/kernel/syscalls/splice/splice10.c | 48 +++++++++++++++++++++
>   3 files changed, 50 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/splice/splice10.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b4a387b28..d6da59bd2 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1585,6 +1585,7 @@ splice06 splice06
>   splice07 splice07
>   splice08 splice08
>   splice09 splice09
> +splice10 splice10
>   
>   tee01 tee01
>   tee02 tee02
> diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
> index 96b1727a1..5e98981fe 100644
> --- a/testcases/kernel/syscalls/splice/.gitignore
> +++ b/testcases/kernel/syscalls/splice/.gitignore
> @@ -7,3 +7,4 @@
>   /splice07
>   /splice08
>   /splice09
> +/splice10
> diff --git a/testcases/kernel/syscalls/splice/splice10.c b/testcases/kernel/syscalls/splice/splice10.c
> new file mode 100644
> index 000000000..98ee73ef0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/splice/splice10.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
> + * secretmem LSM bypass") prevents any access to secret memory pages from other
> + * kernel subsystems.
> + * This case check splice operations involving memfd secret should return EACCES.
> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static void verify_splice(void)
> +{
> +	char buf[1024];
> +	int fd;
> +	int pipefd[2];
Since we are testing only a failure, it makes sense to create input 
arguments via tst_test.bufs and initialize them in the setup().
> +
> +	memset(buf, 0xff, sizeof(buf));
> +
> +	if (!tst_selinux_enforcing())
Maybe it's better to use tst_selinux_enabled() after merging: 
https://patchwork.ozlabs.org/project/ltp/patch/20250709-xattr_bug_repr-v3-1-379c2c291bb7@suse.com/
> +		tst_brk(TCONF, "SELinux not running");
> +
> +	fd = syscall(__NR_memfd_secret, 0);
> +	if (fd < 0) {
> +		tst_brk(TCONF | TERRNO,
> +			"Skipping __NR_memfd_secret check");
> +	}
> +
> +	SAFE_PIPE(pipefd);
> +	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
> +
> +	TST_EXP_FAIL(splice(pipefd[0], NULL, fd, NULL, sizeof(buf), 0), EACCES);
> +	TST_EXP_FAIL(splice(fd, NULL, pipefd[1], NULL, sizeof(buf), 0), EACCES);
> +
> +	SAFE_CLOSE(pipefd[0]);
> +	SAFE_CLOSE(pipefd[1]);
> +	SAFE_CLOSE(fd);
And this part will go in the cleanup().
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_splice,
> +	.min_kver = "6.16",
We will need to add the reference to commit cbe4134ea4bc in here.
> +};
- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
