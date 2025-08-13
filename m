Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD4EC87FCF
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 14:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA75F3CB906
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 16:35:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4650B3C1BE3
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 16:32:06 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BC67600781
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 16:32:06 +0200 (CEST)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31f4e49dca0so7753697a91.1
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755095525; x=1755700325; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
 b=B9br0BZUdzUFMRCwr99nftInyPQUDgJJuHQJ386AsCW+OjgmcM7nR0ztSfQblop6AD
 EoIOVvBSvpxDITDAZIS8vzhM7IciJraY9PWTAP7tDMAT4bFKuPqUmz17AS5QYBylfg+n
 1f0ghP6ZXh8kNHn+/pTZ1YhMKhCk9JvuK04UNbjH/aIpA8UCBM+PDQgY4oRE6//FAoRS
 jMR4AYjrKClJFdul6G1KqObZPgsrnkAWdtrmuhj1taTayeK5ron6uji8eIVTrxkeVn0v
 PQwLDWeHSy7Fz3kgPVgcvOKIzr5CPtVkhcxZ31S7mKbnR9MTNey2yvyM1EbuqkqA0LpY
 79YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755095525; x=1755700325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
 b=aZirFYAzXKicI1Or0ag2y1/x3loFSL/zbt/ozPPl7BRRuTnZenDrgzST9h+Y3EZYCV
 A7p5JPbbfN34aYBTWpf8wP18m/g/oYfJgMxrfNh+EJpjnU1+DqMuCllT3SKy595gdrRc
 e54vSVojo1weLYEjN4IBfDv7sVPTwEjOJXSqm680cb5QWDJDrhV7R9f8wNqY8ZcTBCmh
 kS5zJjwubNAlU6UQdF17DF84jLvPMYjER5HnG3t44hCvZA+cCPD3S0Ce+oP2Lh5TQ0eA
 mSFA6FmBydgfnr/O3hAktBEKKg0jzFIzqGbnRwiXso0yMtMFksSrALsqzJfb9Qv4Ejng
 gmsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY2DOBkJ9rDC7GBMyCi1Vd7ojGhPkgM1bOAe/3cKDDzSJLMa5uJ7QiLH8q/zK6FkCFnbs=@lists.linux.it
X-Gm-Message-State: AOJu0YzP0DNr7sUYkVCuya0CCVuAQCY7qF6pKwthBUwdnIQguikIKUtj
 RxsiJMg4BeH6ZyfbVngUXskm5YlD14wLl0OJwpsejtb2jsaMlXOsipdnMfZrRQAsyxm4TOHGrO0
 92UGavwY5eRHkpHBi69IKMUF/bo97aQfE0cHFsK2mPw==
X-Gm-Gg: ASbGnctHfL1KmOxcWYBhxvcRqoQAh9KX70nSJyf83di2FgSEZJj6cJLO2TMzRUiaBLv
 s7yV6bPVjqaFVePBUPjTL/sJ0GIE58/jW2ulq2GFSo8ofQKjLReBp+nDll7C1/YMPna+l45HOtQ
 +/o5M4kKoGUJYMTolhYn2G7OnDADrja2DYd9giU6PGt0JdewoSCfstIBDroGSW9LAb+hg74LlGr
 rUeGw14ZUatl8CGHY5sVfNB/8lywsMG2G6qYO1YchfxU+ldjuqivtTn29k6yA==
X-Google-Smtp-Source: AGHT+IFzsa7z2LB/NwMV+7ODMzwtQZ5c6SDjL/beKBH/4CiDe3n9MltwqzwrpDodhDWNKfzJI3ZmU6XpdnvXzSkeC14=
X-Received: by 2002:a17:90b:39c7:b0:321:cfbf:cbd6 with SMTP id
 98e67ed59e1d1-321d0d6912bmr4596811a91.6.1755095524619; Wed, 13 Aug 2025
 07:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 20:01:51 +0530
X-Gm-Features: Ac12FXzTlKbJUDUafTa4ZlpVkqfN8sdY7Wfx9w4NKXTaujZ4mJCVSf-u4y5vZP8
Message-ID: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Aug 2025 16:35:08 +0200
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
Cc: Ian Rogers <irogers@google.com>, Jan Kara <jack@suse.cz>,
 Zhang Yi <yi.zhang@huawei.com>, qemu-devel@nongnu.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, Joseph Qi <jiangqi903@gmail.com>,
 patches@kernelci.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>, rwarsow@gmx.de,
 pavel@denx.de, patches@lists.linux.dev, conor@kernel.org,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 achill@achill.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Greg,

> > 2)
> >
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
> >
> > Reproducibility:
> >  - 64K config above listed test fails
> >  - 4K config above listed test pass.
> >
> > Regression Analysis:
> > - New regression? yes
>
> Regression from 6.16?  Or just from 6.15.y?

Based on available data, the issue is not present in v6.16 or v6.15.

Anders, bisected this regression and found,

  ext4: correct the reserved credits for extent conversion
    [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]

Report lore link,

https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
