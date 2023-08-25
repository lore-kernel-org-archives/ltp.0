Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6612C727A1
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 09:34:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B463B3CC43D
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:34:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1949D3CBA17
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:34:11 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9AD86008CB
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:34:10 +0200 (CEST)
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-48d2c072030so1094685e0c.0
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692956049; x=1693560849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NkOXDPx/S3uX0LGrWHhqDuzgnalOjRvvuzfXBDquIJE=;
 b=ukX0Pnuivh/o6xISkXG2MwEK0o1GsQV27v/wL8PCYr3K8rw4rCQ89pL5zDucAFhMcb
 YskOrO04SlvsfelPwM6wi6bo33kueI9hAzLSHaH+rO3C/KdletWIMPRTOYoAyAI3o5Bb
 gwe8YbDTEL9VB12BM6LBCliW9FWhwvSr325DZcjSigPSeB9JpebjY5rhdU88q9fnhEcr
 bO6YXtDqCkq7TIBUj7afnMs8Ik0gKHvbzTGASsEDdGmUvf5tgRjCJeHx7rzEZgS3e+cq
 5wBCW0y7FKsG5YGqd1KFGnDwwJz8ywHAaQLG/7SL+2BGaFhCrt7m2jYp93piNMTJfTI7
 5ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692956049; x=1693560849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NkOXDPx/S3uX0LGrWHhqDuzgnalOjRvvuzfXBDquIJE=;
 b=gmCSZYIuvjU8dwwD6/PFIycCRO/aeVO/YvhlZySeVQJi6Nu9Mh5nKFHa8sp3WGU05f
 BVSeJI8g+8mD1P9xUPWrwSfSUUmedLdGe9YtHBrIs2Ep8+Ot4ddfD9smxz+3H3ZbaIf1
 PHIuswjgwsKULQlavSmPeUerfjsgoVFgp2ffb/ybadpyl//UK67RikLKromgmIWaEKGS
 hHiBWHVI7S8CYkQ3fAmVq6mgcKBR0tsN5qqG7IS+wVRGI/0Z/zg1M/KX7BOI1yh8lgYB
 4xRTbDauHYf8G4OGegh7+sle3e6m5dryLSrvpNhXysBtVzRTEBvVmpepmIEbOn95Vnsu
 UO4g==
X-Gm-Message-State: AOJu0Yw4xlDJqhXKTM1p1luKxSljpeUvnjtCpdzUSOUUTFJPA9+dpUXp
 7sAxzYCtF2UqLkG5qmgxFyNntAdK0dk8UeyoBOfVSQ==
X-Google-Smtp-Source: AGHT+IHYxHlYu/b9jq1hZYwDJBTUYSSDdzBlVxG6txEHWSCkNIMRdBra+qgQir4lLTbNjKOfAbjN9wZa5rm8CXm04BI=
X-Received: by 2002:a05:6122:2527:b0:48d:969:af8b with SMTP id
 cl39-20020a056122252700b0048d0969af8bmr10536527vkb.1.1692956049376; Fri, 25
 Aug 2023 02:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org>
 <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
 <2023082512-amusement-luncheon-8d8d@gregkh>
In-Reply-To: <2023082512-amusement-luncheon-8d8d@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Aug 2023 15:03:58 +0530
Message-ID: <CA+G9fYsxAgRcvc4G_mU2LW+bw3aUVgTNGd+zmkhkoaXUsWv67Q@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.1 00/15] 6.1.48-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 Sherry Yang <sherry.yang@oracle.com>, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, linux-nfs@vger.kernel.org,
 srw@sladewatkins.net, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, rwarsow@gmx.de, pavel@denx.de,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 conor@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 25 Aug 2023 at 13:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
> > + linux-nfs and more
> >
> > On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.48 release.
> > > There are 15 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Following test regression found on stable-rc 6.1.
> > Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> > chown02 tests creating testfile2 on NFS mounted and validating
> > the functionality and found that it was a failure.
> >
> > This is already been reported by others on lore and fix patch merged
> > into stable-rc linux-6.4.y [1] and [2].
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Odd, it's not a regression in this -rc cycle, so it was missed in the
> previous ones somehow?

I have re-tested with newers and older versions of the kernel and here
I confirm that this is not a regression from this round of stable rc review.

We have made a couple of changes to our infrastructure and are investigating
the root cause of these two test cases failures.

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
