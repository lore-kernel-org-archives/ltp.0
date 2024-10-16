Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4020D1AD30
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 08:55:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 130603C6803
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 10:55:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 922FF3C5ACF
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 10:55:03 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 639AE64164D
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 10:55:02 +0200 (CEST)
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-50d35639bfaso1597092e0c.2
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729068901; x=1729673701; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aM1j+CmDA5rs0zqyd0QFs7mI1QpTz4ZuLqOJ8HwBQeg=;
 b=s3YU54edDw/BEaBpuQvJ872idt7SMnqwRxAHJButiz/ttyQwrb0rr4niXiuhxcbNLG
 ETqmiHBwGk0f5+KhbbLOzK3slvkdBavJI3O0SAo7OL5ARU0XlHzyPfduJ1zpbCJNtYpy
 kHYX9LvVRhwork1QStrUZz3eH6zFcIVnXeXh5KTnGqxQKbbHisTLWGdLdus9uU4uUHC1
 I+fD7Uo4RcAD+XBa5vqXipdACqoHw4K8BmW3a1kvHFtNi9BunYVK0zwfLy8oknHoy58x
 +i99eUtfEjqjyV1eMg9pglgU6ZUgfjU/r/Tagf6W8jyoVizPOwkpL085s+X0gaqrCUYc
 UTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729068901; x=1729673701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aM1j+CmDA5rs0zqyd0QFs7mI1QpTz4ZuLqOJ8HwBQeg=;
 b=j+xmEKuOTduFkG6x749Kdsp5Dsg7W3SmBUe3Ng1rRvgYmOVzMOsrKjyapcEJtymPTc
 nc8cuc6J0s8FAUM9oAyI0dvTwQk0e0SLKZBdnYZeBlCuCxb1ONOV+aaEXZDJRr7C1QtK
 qiHeJECnd164TFcOWDETLYyov5XBGFmZ0sGoCshJxN3PVEE5ApEaCJ6WprZr7IFuYr4w
 avAAXS8Yf5cEBH+leCYPwmKIy0QiRRNnf3/Vb8iQKrLOiWMP9amrgx6+GOBwnL04SfLI
 th/LGsMK4SpvAAyWWEq0HpahxtFO/SXJOHEfZYeD2qsS8InHTLP8haAXUodz6gldKzqP
 BGdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbc8LIxKvlk8YSkuxCvaXL3Dmx//2Sx7QS52YfjpTo3e8GX1Ea2RA5JBB9LGWvUBuN1JA=@lists.linux.it
X-Gm-Message-State: AOJu0YxOkAPjAJ4mG5ix5GQMYyQVcdYXdJr0d0NAiM77bKtc73hEiE7A
 ageWcgsv08zo4ciOqrzdR2WXSP9HIatffo8g84S5DXjQajlAw1lnv1Ng9Za6sn5vr8V8lTeripM
 dlemXMJE59fzDGdtb5kr2GcQ7W0OwJz/MRIy3xw==
X-Google-Smtp-Source: AGHT+IFj1BIMhN2y2ujDgAuHcdv2pSDskTuzb3rgrptZ7N5fVnXHbsRKomX3FKehRMuLXTjo6jvoeqyRgKvU0F7lrlI=
X-Received: by 2002:a05:6122:29ca:b0:50d:354a:19ae with SMTP id
 71dfb90a1353d-50d354a1d7dmr11686940e0c.10.1729068900898; Wed, 16 Oct 2024
 01:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241015112440.309539031@linuxfoundation.org>
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 14:24:49 +0530
Message-ID: <CA+G9fYtTO8QbKEhggzOk-n+pBk5pEHenCfgs2RdQd=Ztsi+hnA@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5.15 000/691] 5.15.168-rc1 review
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
Cc: f.fainelli@gmail.com, rwarsow@gmx.de, pavel@denx.de, conor@kernel.org,
 shuah@kernel.org, allen.lkml@gmail.com, LTP List <ltp@lists.linux.it>,
 patches@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org, lkft-triage@lists.linaro.org, srw@sladewatkins.net,
 patches@kernelci.org, akpm@linux-foundation.org, jonathanh@nvidia.com,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 15 Oct 2024 at 17:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

From last week's regressions reports,
The LTP syscalls fanotify22 test failed (broken).
This regression is noticed on linux.6.10.y [1], linux.6.11.y, linux.6.6.y and
the Linus mainline and next master branch.

Now this has started failing on two additional branches linux.5.15.y and
linux.6.1.y.

 ltp-syscalls
  - fanotify22

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected to patch
  b1a855f8a4fd ("ext4: don't set SB_RDONLY after filesystem errors")
    [ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

There is a fix discussed and posted in these upstream links,
  - https://lore.kernel.org/linux-ext4/20241004221556.19222-1-jack@suse.cz/
  - https://lists.linux.it/pipermail/ltp/2024-October/040433.html

The stable-rc 5.15.y (5.15.168-rc1)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.167-692-g63cec7aeaef7/testrun/25456713/suite/ltp-syscalls/test/fanotify22/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.167-692-g63cec7aeaef7/testrun/25456713/suite/ltp-syscalls/test/fanotify22/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.167-692-g63cec7aeaef7/testrun/25456713/suite/ltp-syscalls/test/fanotify22/details/

[1] https://lore.kernel.org/stable/CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
