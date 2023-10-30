Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920F4C4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 08:15:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 117523CEAF9
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 09:15:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31963CC966
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 09:15:16 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BFB9E200208
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 09:15:15 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 43DF261151
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5487EC4339A
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698653712;
 bh=fuGVGto2o5T9jBRD1HhQGS82S7WwmgYHNiuC+wi817I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=l3QZcv5vpUDwVilYNar/MuFOezxUcNnLV7xZYXKuVwblw764y4g2NP8U2Wjw/P3pc
 vtpQDK46ASbrahd0rZ0raB/kOO42v52q661l4bn1mbwUKM1dXOr1UC+UeGVgxPsULW
 vSwpXotUlODxngrf/kO7mfJ1vSTFKVEcCN22qS/knUO2QMlOqBulPguqEz8u/E2xGz
 XADUSKBEhbi2dNaRUZ04q+BZLDVAifThk7LOe/QOmKSlU8c/ZyKUbxZmnHf5cRhSOD
 Aw1/YXwRutv2UZrYjGp6q7dCwnUNBQiuYvhyWXlaa9vnivDus0s4cvAmu1enEoeebs
 5m2GNOva0MLVQ==
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2c509d5ab43so60454481fa.0
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 01:15:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzAoGruOmHnfsq8rlC8J+xwU4NMXgKPKAGeMGeoVvRqNTSJiEeu
 ZFle+O6Jbb9j37WxHZfVSgAWSelXEfzuKft7ntc=
X-Google-Smtp-Source: AGHT+IE1MxdsbScw/CQkZPXtI0pHIpy3V0Ttccz6JvtL8F3t7OA2phye2Ta9366OokZKtxm6H8LGbfpLV13fiPuqId4=
X-Received: by 2002:a2e:918d:0:b0:2c5:ffa:375d with SMTP id
 f13-20020a2e918d000000b002c50ffa375dmr6809167ljg.11.1698653710337; Mon, 30
 Oct 2023 01:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
 <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
 <CA+G9fYv3Ph6UDpW1uhoXD5QBE4tAZKpUkVy-Oo9NNrghChL_+A@mail.gmail.com>
In-Reply-To: <CA+G9fYv3Ph6UDpW1uhoXD5QBE4tAZKpUkVy-Oo9NNrghChL_+A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 30 Oct 2023 09:14:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
Message-ID: <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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

On Mon, 30 Oct 2023 at 09:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Sat, 28 Oct 2023 at 13:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 27 Oct 2023 at 12:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > >
> > > > > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > > > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > > > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 ...
> > > > > It looks like this is fallout from the LPA2 enablement.
> > > > >
> > > > > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > > > > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> > > > >
> > > > >         0b101011 When FEAT_LPA2 is implemented:
> > > > >                  Translation fault, level -1.
> > > > >
> > > > > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > > > > The exception is expected, and it's supposed to be handled via the exception
> > > > > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > > > > the level -1 faults, and so those all get handled by do_bad() and don't call
> > > > > fixup_exception(), causing them to be fatal.
> > > > >
> > > > > It should be relatively simple to update the fault_info table for the level -1
> > > > > faults, but given the other issues we're seeing I think it's probably worth
> > > > > dropping the LPA2 patches for the moment.
> > > > >
> > > >
> > > > Thanks for the analysis Mark.
> > > >
> > > > I agree that this should not be difficult to fix, but given the other
> > > > CI problems and identified loose ends, I am not going to object to
> > > > dropping this partially or entirely at this point. I'm sure everybody
> > > > will be thrilled to go over those 60 patches again after I rebase them
> > > > onto v6.7-rc1 :-)
> > >
> > > I am happy to test any proposed fix patch.
> > >
> >
> > Thanks Naresh. Patch attached.
>
> This patch did not solve the reported problem.
> Test log links,
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2XTP1lXcUUscT357YaAm2G1AhpS
>

Oops, sorry about that.

Fixed patch attched.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
