Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AEDCEDD86
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:36:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C54A83C2AF7
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 13:36:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 226413C2A71
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 13:35:49 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DC0B601F65
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 13:35:49 +0200 (CEST)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbc1638608so1390846d6.0
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728473748; x=1729078548; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FurzM10u95VKmaZwS7ymh0VKZoWWm9NbSC/cRDUlyeU=;
 b=wD/Za2zgWlO4cQqQVP/JS9y9JXAqOOF9CGDQ0THkdSa/eQjnKnlIvYJKvCYozNawu7
 d/eIRel8rizgALHOXBZlKj0QiU56KuA9hPV3szCW1yxNyqDfsuX0iCT5yu/yV+dSdQcp
 5hxNjRFetWrneWdkZYyJyiAplwqIzNG5tuAwqRLkLde6ktth0E3hbO8E5NUY+8YbNTuM
 TJFdYpRNpERGurVhRzwmI94KC58LYzAGnr+WF+E74g/bTGZs14FvRxrmQkTofg+zKftr
 5D7dB5QG0BptOk5Oh2iwv1yVzMErFBukTvBqICYV8I1o4LPQjvhWdJ4umHpWVMFGSyxD
 q62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728473748; x=1729078548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FurzM10u95VKmaZwS7ymh0VKZoWWm9NbSC/cRDUlyeU=;
 b=hGX1i/AatR+C/9vRw/ka4SV7qVG/p+UcnPPtw3W2M+sZ/wNoiD2tQvtACadr+PTMTg
 avG3ATYQpURLXcqraxvrMhZfUBEyPe+ENGigcCp0ysIbQJ2E/8w9H5LYvXQfL/KolGaX
 qEaDulMtLsltab/ZimZl+aXI/0hcnDhM1EQHp+ei447Xl9H3QTMnjMn4ZZXW4ZC706oD
 4I6H8U1WpjuxUSQ1MyV/Za1kMmCj9zDImsTeniFGTEoXXvFUKVJtaByo7yctfKHiBQVG
 wq4Z/ROWy63rc+Y9j5z97W2Cb0aWSlUSsZluLRyWCL1HaFoP0nQBDT5K2omARyXE2DRN
 azcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqKYQTkbx29UjRU5TsswmLazesJX0uaMiO4SX7mU7n4cP0RmY90+rKBkXUCH1jw3DyD5A=@lists.linux.it
X-Gm-Message-State: AOJu0YwvOPLJ0VQLeBohHrE8xrxfLMjjhgt/M7cnck4IaQCW+THs6ABF
 v7EhWLy0bsHj8km1F6f19/WY3Q3HT3UEYs99APDFeEWyD5bPPAIJZmbnAQCX6WbZPH7enKXiGOW
 NBXn1lSCFk+/mnYF4WsiXDtVxduBkxYpAg7V4ww==
X-Google-Smtp-Source: AGHT+IGxVD61+vnO6Sd1PNMSaYrQo9NkwfAClZ0FVDtlnROBKd2JA5fPqspTbiQbddkGddY+tZ38AMM6AmjuFdGb7sY=
X-Received: by 2002:a05:6214:5014:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cbc932a05amr17137026d6.5.1728473747881; Wed, 09 Oct 2024
 04:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241008115648.280954295@linuxfoundation.org>
 <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
In-Reply-To: <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 9 Oct 2024 13:35:36 +0200
Message-ID: <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.10 000/482] 6.10.14-rc1 review
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

On Wed, 9 Oct 2024 at 08:22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 8 Oct 2024 at 17:42, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.10.14 release.
> > There are 482 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> The LTP syscalls fanotify22 test failed  (broken).
> This regression is noticed on linux.6.10.y, linux.6.11.y and linux.6.6.y.
>
> We are bisecting this issue.

The bisection pointed to patch b1a855f8a4fd ("ext4: don't set
SB_RDONLY after filesystem errors")
[ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

Reverting patch b1a855f8a4fd ("ext4: don't set SB_RDONLY after
filesystem errors") makes
ltp-syscalls/fanotify22 pass.

That said, I also checked Linus tree and fanotify22 fails there too.
Reverting the upstream
patch d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem
errors") from Linux tree
v6.12-rc2-58-g75b607fab38d and run syscalls/fanotify22 it pass.

Any ideas whats wrong here?

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
