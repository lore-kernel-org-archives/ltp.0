Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B03C2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:03:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D9503D0F2A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:03:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D848B3D0D41
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 15:14:25 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CACB2600B73
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 15:14:24 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4421c014b95so15785131cf.0
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718889263; x=1719494063; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k8loiKfZnA+YA+BNdznuyc93e427hOVjzdhKBo4Mcdg=;
 b=cVK85+rqWxr9piRAexM79z7ZO+pUJ63NH4tH3AsBLpIpEzvYk8WALLlvlBVeEHRLcY
 5hRUx1OttMZhJtcaWJ503CYi6qUijQn87W0ztXG/8HMRgNMaByudvs9d92TUwgdsi80V
 /Yoxx1mGi5P3zc2QzwZWqbfTrxWNUhv1WdKVq5lc6IM2+69+dJlp+o6lWEtm49IJub2z
 Pk9B585gqato21WW3H1BXm621DtMuRw72wzdabpB2WTDyGvt1VaWTDzdc3fInhXCu5/W
 GZ2Y3yIQIck9fzm4YWQnkBYFcPZR64qo4rtixkYcFrBKuLcVsvFHcMthEyJgLKcJbIUo
 d3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889263; x=1719494063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8loiKfZnA+YA+BNdznuyc93e427hOVjzdhKBo4Mcdg=;
 b=KCRP8ffMjhUrqsOo0jjOzdVIhz9OFSqlodv+SW20Bkw0tL2tP6OMG6FJQkGn29dELc
 5M38xR0bVYTIzwQqlZ1e8vO+CnVJcND6gWcgI5EKDLpmcTpDUXb3wpS8Cwy+japfeHP0
 TBu9B2ZhJmkCOAKsKa0TkDtXUGFo5zWjmpYyxyr1cZxTNExRomdnC5NlYliePCDaqlP9
 7Es56/aDU3A2yz69WfPfJZLkcltBF0Xxb79vEhWf3vc/wQP5W8j3wv7F1aFfaclcIoTP
 sSxYPIg4gHrWpkqVqgYbqvevMJcVq4gQMDS50mvW/giAfo20U+qOrQEGxJjuVqxsx2Ww
 qOAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpf58diRJwqDR0fFw81sIVsKcmWZrVrHIh9r2E1MumGGOgMV4pdR87LjRDw5k3vca8zxt6gEXME/z01H31Q1ymhoY=
X-Gm-Message-State: AOJu0YysR1UI/d8aFUnRVqc0WDfTR4/iR4Nd1WIheQsfQRqQn9gyT5+1
 j7oVfPG4apEfh0b1clLMkyAwZzdjCRgWOlZzOxsYrE/mo6/xoN6rWGDRk1b4ftitOy7Q9prZE2h
 0HZfLEnXNPMlOoma50RMnLIrAG5U/F/3fXGsEGg==
X-Google-Smtp-Source: AGHT+IGiHKV+q2qJu/mkMnrbWS6TykUfrsN8Y6wuNtachV8KZU4pBm3Bkt8z8L8YuUKSny6A751rJg0UHn+YKbmJrf0=
X-Received: by 2002:a05:622a:1813:b0:43f:f5e0:8e86 with SMTP id
 d75a77b69052e-4449b90ec32mr145142351cf.10.1718889263444; Thu, 20 Jun 2024
 06:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
In-Reply-To: <2024062028-caloric-cost-2ab9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 18:44:11 +0530
Message-ID: <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
Subject: Re: [LTP] [PATCH 6.9 000/281] 6.9.6-rc1 review
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
Cc: Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>,
 lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 linux-mm <linux-mm@kvack.org>, stable@vger.kernel.org, jbeulich@suse.com,
 shuah@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Cgroups <cgroups@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 rwarsow@gmx.de, pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> > On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.9.6 release.
> > > There are 281 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > 1)
> > The LTP controllers cgroup_fj_stress test cases causing kernel crash
> > on arm64 Juno-r2 with
> > compat mode testing with stable-rc 6.9 kernel.
> >
> > In the recent past I have reported this issues on Linux mainline.
> >
> > LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >   - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >
> > it goes like this,
> >   Unable to handle kernel NULL pointer dereference at virtual address
> >   ...
> >   Insufficient stack space to handle exception!
> >   end Kernel panic - not syncing: kernel stack overflow
> >
> > 2)
> > The LTP controllers cgroup_fj_stress test suite causing kernel oops on
> > arm64 Juno-r2 (with the clang-night build toolchain).
> >   Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000009
> >   Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> >   pc : xprt_alloc_slot+0x54/0x1c8
> >   lr : xprt_alloc_slot+0x30/0x1c8
>
> And these are regressions?  Any chance to run 'git bisect'?

it's difficult to reproduce the first one so we haven't been able to bisect it.
It seemd like David and Baolin might have an idea what's causing it.

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
