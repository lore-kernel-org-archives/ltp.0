Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A96CA0EE0
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 14:00:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A8C23CB83A
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 16:00:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2F03CB3B3
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 15:41:19 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D9F61400429
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 15:41:18 +0200 (CEST)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af51596da56so5124833a12.0
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755092477; x=1755697277; darn=lists.linux.it;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
 b=hh40xfFDRwIR0S5tODoT2OSz/TFIQmcKylU0rbN/iCoDA9e1bGYdK8Wq7ptLE2eSkm
 1pVB2u2OEYY2fEsBYccXyPnUpHP/9CK9fB/GAEpTpctmzaC1Z+rS3IGGCeRwouO9zVpa
 8bUVLA6CW56mU/6MfVSiRkzK6552d+uEFG+QSO5Gjvjxyf0T7TWmp7YANDUEhFqDEhMc
 QhE4IOJl2MylxEbZ1Zz6Z2svmX44XB1aUZ8uM96IxYAHNF2yDezfRtRjAmiWa3699q0e
 1KjuV69Sj9AqqvyJCCsCZ860PN9Ma9vm84qrgUP22vJ0NdL4SUXZLigkMpU1rulZx7lQ
 L9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755092477; x=1755697277;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
 b=CdYAWcZnyz65ZOtltgwRplzs7IEf8M3fRyaCBi4R7BE3gg344O8GBQsl+0av88YBUa
 sObAZrMdrb3PSAFcABI+IvjDi9teS1UlaZ1Q3LVJB0+OZxfAu7rXuw2mGW3OgkVQrlcm
 9h7A1iLATUwui4doXRLqolUrx+z4m8KJg2iH4MHqyRdBJc6P8uGwodTeyHSh6QahoBiX
 6tf5Re+peBDZsksAP/lzCmR/csLXy4UGAu9JfVXWKxLef+i0HYMzXOOMpq0cr9EyA13Q
 7FBtak+gHJ9js7KtG8MI008aiGi2zrjXo8fl5pKs88FjHa5lf8SVHxNzPHsZxJAjiAJw
 1cbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr9loznRGp9+XhDUWWT1l2VLuMVZliq8YebGUd+FVCqhwJOYD1qgoTW+o0s8dlZQGQoi0=@lists.linux.it
X-Gm-Message-State: AOJu0YxH5qYan/MBhzjNvJoNgVwWml9nBABiEK9O5WvXofJRHkZLrOlw
 aQsaqTAonxJSaaXFRqieHo91MTWc+3EQ1PB3XM2iGk5Z0NSUxtnDHQXayIMDIeb+csj6x1Js71v
 vnvdFgXB9YqB2l+i+1Hz1OqoaRg32lIY/GMN5TmvkPg==
X-Gm-Gg: ASbGncsn4uZ68hl9WHMMY0e3bkk3nQGnrRFnCKn+MUSXVPN3IFyzQ/e1eFav8EM69ch
 v3LTs8+uHtBLeX0sGiWcSJYdyTcZPOU8XIM4a5SHpMjSgTh6b0kErosxaHSLKL2+UYMI/+0u9yg
 eMZxvXG1yxzzANSAgH5PMwSlYOIlEBnpvqOlRIvUNlJXWGto/Zuz2jmG2+5b/ThP5WcQ3ldlEUu
 XksocBUZTdJi1QKBbGXVWN7KbquC1pnrSNCZDPF
X-Google-Smtp-Source: AGHT+IHJ5NorMBOk/mMmvjq4NxC90d+IjwHZjpyxn70pQloc6AgGTp1y/wa+zMeluJYPNCBvRdh21gvKSjV030UR2Pk=
X-Received: by 2002:a17:902:f785:b0:23f:e51b:2189 with SMTP id
 d9443c01a7336-2430d0f9a4bmr54705775ad.17.1755092476818; Wed, 13 Aug 2025
 06:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
In-Reply-To: <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 19:11:05 +0530
X-Gm-Features: Ac12FXxKeYVh06szquTrecWrS7rqGYyi8ckXtXfcapehmWdAEuqul8ZUWvjf2tw
Message-ID: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
 shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
 pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
 conor@kernel.org, hargar@microsoft.com, achill@achill.org, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>, 
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, 
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
 Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>,
 Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Aug 2025 15:59:43 +0200
Subject: Re: [LTP] [PATCH 6.16 000/627] 6.16.1-rc1 review
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
>
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01

These test failures are not seen on Linus tree v6.16 or v6.15.

>
> I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> still running but I suspect given the error message:

Right !
LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
with this error on LKFT CI system on several platforms.

>
> epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
>
> that it might be:
>
> # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
>
> which already got tested, or something adjacent.

A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos

-https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
