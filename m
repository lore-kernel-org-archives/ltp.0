Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F8C27C48
	for <ltp@archiver.kernel.org>; Sat, 28 Oct 2023 07:42:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BD6C3CCA50
	for <ltp@archiver.kernel.org>; Sat, 28 Oct 2023 09:42:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B69593C9793
 for <ltp@lists.linux.it>; Sat, 28 Oct 2023 09:42:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 447D16011AF
 for <ltp@lists.linux.it>; Sat, 28 Oct 2023 09:42:45 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EC70760E26
 for <ltp@lists.linux.it>; Sat, 28 Oct 2023 07:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55645C4339A
 for <ltp@lists.linux.it>; Sat, 28 Oct 2023 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698478961;
 bh=htUU5NgNW5XjX1k4bhwOpjiaCPHzbKJXSRlXtBMXaaI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SLt9RpRk04EaksB4alsV5juWqDKrrkoFjxUkbGOZ7QmCkr5DaOIcuWvzpg2KRZFs4
 oyNj7h+Nu2x3s/nz8wlUOhoDuxjmHXZ81/fxdhC/0g5Voz0M9n1SONNKBWxBpMncFw
 lBKCeI9FyvIc3DaiiGzH06wGVU7T0+DOcEqxXG5+SBgGefDMATnj9bRNWCQvHdXZeM
 FyqwXfRoKQYSCd/fmacxctuND9MgMxzBI8ScDwHMoocjekC8Ee6ezXeZ/nIzGkSYtn
 mnayYsRVJbFeSef6Ffe/Rd0T+4ssNkfDQtYf7XwHBc5QWDgU4QDZ0Wt0a762+yDV6w
 L93MhRkYGp9Cg==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-507a62d4788so4346140e87.0
 for <ltp@lists.linux.it>; Sat, 28 Oct 2023 00:42:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx8vsHg/Re4pvRovhXPudfRtMIB81vzSTEhClKzT2AWZkGSTWMo
 VYQ6o9e68uh59HsZeDIK7ii4ttuoNGZPL6pI/VM=
X-Google-Smtp-Source: AGHT+IFiTcDct53OijnP1Dv//ljwa/j8p7snP2xWb1MXmhUAIVhLZvUBdZmrQEndHPbZWL2iA8aWwpyIs51gK8PaGng=
X-Received: by 2002:ac2:4835:0:b0:507:9ff7:2ed4 with SMTP id
 21-20020ac24835000000b005079ff72ed4mr3299897lft.43.1698478959384; Sat, 28 Oct
 2023 00:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
In-Reply-To: <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 28 Oct 2023 09:42:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
Message-ID: <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] qemu-arm64: handle_futex_death - kernel/futex/core.c:661
 - Unable to handle kernel unknown 43 at virtual address
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 LTP List <ltp@lists.linux.it>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 27 Oct 2023 at 12:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 ...
> > > It looks like this is fallout from the LPA2 enablement.
> > >
> > > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> > >
> > >         0b101011 When FEAT_LPA2 is implemented:
> > >                  Translation fault, level -1.
> > >
> > > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > > The exception is expected, and it's supposed to be handled via the exception
> > > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > > the level -1 faults, and so those all get handled by do_bad() and don't call
> > > fixup_exception(), causing them to be fatal.
> > >
> > > It should be relatively simple to update the fault_info table for the level -1
> > > faults, but given the other issues we're seeing I think it's probably worth
> > > dropping the LPA2 patches for the moment.
> > >
> >
> > Thanks for the analysis Mark.
> >
> > I agree that this should not be difficult to fix, but given the other
> > CI problems and identified loose ends, I am not going to object to
> > dropping this partially or entirely at this point. I'm sure everybody
> > will be thrilled to go over those 60 patches again after I rebase them
> > onto v6.7-rc1 :-)
>
> I am happy to test any proposed fix patch.
>

Thanks Naresh. Patch attached.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
