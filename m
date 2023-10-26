Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACE2C25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 09:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 285013CEBA9
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 11:30:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 675E73C26EE
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 17:39:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 659B320076F
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 17:39:32 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0FF8C63532
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 15:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FD8C43391
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698334768;
 bh=FDj+TtkA41V8W+Dgx4SdwNTR5EfRCiqvl6KQP3P3OD0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fZprWnS1zKe9CbthGm2D8C8zn1nHzy+//yBaYsrHS2yMyLV4Mra2DrQCWoWjXTzBz
 wmZsR2S4VUKMnbpnDA2j8BvXxn9wQ2HGezAJaWDPSU5a6RYVylVKNc71ZBr7bTLf/0
 md20LufSdvrHbA+7Y/9HEHJai5JDJ/LXeslMvVgc38iVm9ALkXNI0bSx4/No1e7twd
 9IQkuaWHkBn4DGJqpMUo8J4lmwsu3KxMDmWbAFDWyLMymS1z2I94MghGWnphoVzqHH
 ek932aj5ECM/nNLrYNV+rPymMUzHfp8t1fNRvVqE1wuLbmDiAGPKuWymrgHTW8l+XM
 Ylf5ZSpZl3/Zg==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so16096361fa.1
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 08:39:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YxEafoBPmgPNUQhLPm5q8Ls0Pf0dR3Y3LnyUvWbE8amuxVi9yjW
 KmWOKU7Aybt6M6gjdI4FvfN2aJuIzooaaz4MM5I=
X-Google-Smtp-Source: AGHT+IE320/m4nxTYakuJFBJp88Ll7maED97PBXuy6j3H25+6YoIexbnB90kueybRhWmacv8IDTeoQ5wlVQQTkiVzRM=
X-Received: by 2002:a2e:b04b:0:b0:2c5:1b01:b67f with SMTP id
 d11-20020a2eb04b000000b002c51b01b67fmr13026501ljl.52.1698334766885; Thu, 26
 Oct 2023 08:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 26 Oct 2023 17:39:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
Message-ID: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 27 Oct 2023 11:30:48 +0200
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
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

On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 and
> > 6.6.0-rc7-next-20231025.
> >
> > BAD: next-20231025
> > Good: next-20231024
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Log:
> > ----
> > <1>[  203.119139] Unable to handle kernel unknown 43 at virtual
> > address 0001ffff9e2e7d78
> > <1>[  203.119838] Mem abort info:
> > <1>[  203.120064]   ESR = 0x000000009793002b
> > <1>[  203.121040]   EC = 0x25: DABT (current EL), IL = 32 bits
> > set_robust_list01    1  TPASS  :  set_robust_list: retval = -1
> > (expected -1), errno = 22 (expected 22)
> > set_robust_list01    2  TPASS  :  set_robust_list: retval = 0
> > (expected 0), errno = 0 (expected 0)
> > <1>[  203.124496]   SET = 0, FnV = 0
> > <1>[  203.124778]   EA = 0, S1PTW = 0
> > <1>[  203.125029]   FSC = 0x2b: unknown 43
>
> It looks like this is fallout from the LPA2 enablement.
>
> According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
>
>         0b101011 When FEAT_LPA2 is implemented:
>                  Translation fault, level -1.
>
> It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> The exception is expected, and it's supposed to be handled via the exception
> fixups, but the LPA2 patches didn't update the fault_info table entries for all
> the level -1 faults, and so those all get handled by do_bad() and don't call
> fixup_exception(), causing them to be fatal.
>
> It should be relatively simple to update the fault_info table for the level -1
> faults, but given the other issues we're seeing I think it's probably worth
> dropping the LPA2 patches for the moment.
>

Thanks for the analysis Mark.

I agree that this should not be difficult to fix, but given the other
CI problems and identified loose ends, I am not going to object to
dropping this partially or entirely at this point. I'm sure everybody
will be thrilled to go over those 60 patches again after I rebase them
onto v6.7-rc1 :-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
