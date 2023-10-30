Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC07C4167D
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 11:51:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2CDC3CEAC4
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 12:51:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 850113CC971
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:50:54 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CC7E600F97
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:50:53 +0100 (CET)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4a93e4b566bso343322e0c.1
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666652; x=1699271452; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jWivzrxCpxwoSOmvAbrkhtD9UjjIuIW8cSCmO3fV9OU=;
 b=dTDrNemGfxPs0kqnfrTV1n31OJeKyg4La2tgZEpOuL0KmlHVvw2rV9GIz9iNBOM58k
 OxNsjFgtynKWazG+tvOurMJxgxX8bGCnaW6GLbrZ3rR6bBUE/r5JstI0B8HEzvigOsw+
 Bm70sPXCVY8am4cYRissAZVl6J3OauUv/z2s+Wl8SiXZBTh/BitobV0XSn63yDgGJBxv
 YtryqGbcuQ/buaZfN3QzoP8bh7ZipttUgFc5gdjkuJDUPx0EyM/MrbfT7VJRHRlQBUkg
 wwhsHzmECSLPwwpeMY9VS1DRYF0eaWlkeIeyesLslkR7mcoJeJAdn6DbhBQPK2xe+6EV
 YB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666652; x=1699271452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jWivzrxCpxwoSOmvAbrkhtD9UjjIuIW8cSCmO3fV9OU=;
 b=dKhQE38Mqe+TYKoUyEcZ027Cstr9vEEI2RIDC6HTaHTchpw6xkpBEAVsYLHjGO/WGL
 LYMilEdscp6Amv/Uqt2gURRbGHIWtTJg2U6m9584Vs+8cSzE1X4A/mLvKxjDwkMsYLP7
 Oc9ORAwywoW957NJQdthYrMHD2Zjoj0EbELcEU6fJHeT1+GXSxHr9d4vadTIMX0qtn1f
 mb1uWumcuoLmKnxZcjRJLDNTYybYJXVb5J+mlwcdTZYD8LZOgVzJE+6A/GJyrwu9lMxZ
 y4wLFsqHMMTCCbHyXto/Lj+PAeOi8KcXYyubFfaDC/panun9wgqcQrMbdo82cDWmhhm5
 fklw==
X-Gm-Message-State: AOJu0YwkIw/rxS7yxsMdftIs7x2m6FpwMZn7CYl4u/bNiReHtyEm/s6j
 tTp+azy9Sd5xZgMgjZKKcrBo5YphyuVyIqqeF/6kYA==
X-Google-Smtp-Source: AGHT+IHOgIY9CwwmMMpgtyV8voIwES59HVGTMaWrITyIszgM+vaGsNlMZzWTtbYTZd0Wli4gnrWw8X77RK+jmocselA=
X-Received: by 2002:a1f:a412:0:b0:4a4:156b:b46 with SMTP id
 n18-20020a1fa412000000b004a4156b0b46mr8433700vke.2.1698666652226; Mon, 30 Oct
 2023 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
 <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
 <CA+G9fYv3Ph6UDpW1uhoXD5QBE4tAZKpUkVy-Oo9NNrghChL_+A@mail.gmail.com>
 <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
In-Reply-To: <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 30 Oct 2023 17:20:40 +0530
Message-ID: <CA+G9fYsyDQZmsHpN+4qv8q_DsagKbmDZ5vjo60QDEr+uCVXoNA@mail.gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

On Mon, 30 Oct 2023 at 13:45, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 30 Oct 2023 at 09:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Sat, 28 Oct 2023 at 13:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 27 Oct 2023 at 12:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > > > > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > > > > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 ...
> > > > > > It looks like this is fallout from the LPA2 enablement.
> > > > > >
> > > > > > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > > > > > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> > > > > >
> > > > > >         0b101011 When FEAT_LPA2 is implemented:
> > > > > >                  Translation fault, level -1.
> > > > > >
> > > > > > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > > > > > The exception is expected, and it's supposed to be handled via the exception
> > > > > > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > > > > > the level -1 faults, and so those all get handled by do_bad() and don't call
> > > > > > fixup_exception(), causing them to be fatal.
> > > > > >
> > > > > > It should be relatively simple to update the fault_info table for the level -1
> > > > > > faults, but given the other issues we're seeing I think it's probably worth
> > > > > > dropping the LPA2 patches for the moment.
> > > > > >
> > > > >
> > > > > Thanks for the analysis Mark.
> > > > >
> > > > > I agree that this should not be difficult to fix, but given the other
> > > > > CI problems and identified loose ends, I am not going to object to
> > > > > dropping this partially or entirely at this point. I'm sure everybody
> > > > > will be thrilled to go over those 60 patches again after I rebase them
> > > > > onto v6.7-rc1 :-)
> > > >
> > > > I am happy to test any proposed fix patch.
> > > >
> > >
> > > Thanks Naresh. Patch attached.
> >
> > This patch did not solve the reported problem.
> > Test log links,
> >  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2XTP1lXcUUscT357YaAm2G1AhpS
> >
>
> Oops, sorry about that.
>
> Fixed patch attched.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
