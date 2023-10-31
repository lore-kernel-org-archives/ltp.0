Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D7EC0018A
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 16:33:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92EDE3CEA03
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 17:33:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0364A3CC934
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 17:32:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 91DE4600B78
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 17:32:48 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F762F4;
 Tue, 31 Oct 2023 09:33:28 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.36.213])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02DA3F67D;
 Tue, 31 Oct 2023 09:32:43 -0700 (PDT)
Date: Tue, 31 Oct 2023 16:32:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <ZUEsKUVENQXftM4I@FVFF77S0Q05N>
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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

On Thu, Oct 26, 2023 at 05:39:11PM +0200, Ard Biesheuvel wrote:
> On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 and
> > > 6.6.0-rc7-next-20231025.
> > >
> > > BAD: next-20231025
> > > Good: next-20231024
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >
> > > Log:
> > > ----
> > > <1>[  203.119139] Unable to handle kernel unknown 43 at virtual
> > > address 0001ffff9e2e7d78
> > > <1>[  203.119838] Mem abort info:
> > > <1>[  203.120064]   ESR = 0x000000009793002b
> > > <1>[  203.121040]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > set_robust_list01    1  TPASS  :  set_robust_list: retval = -1
> > > (expected -1), errno = 22 (expected 22)
> > > set_robust_list01    2  TPASS  :  set_robust_list: retval = 0
> > > (expected 0), errno = 0 (expected 0)
> > > <1>[  203.124496]   SET = 0, FnV = 0
> > > <1>[  203.124778]   EA = 0, S1PTW = 0
> > > <1>[  203.125029]   FSC = 0x2b: unknown 43
> >
> > It looks like this is fallout from the LPA2 enablement.
> >
> > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> >
> >         0b101011 When FEAT_LPA2 is implemented:
> >                  Translation fault, level -1.
> >
> > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > The exception is expected, and it's supposed to be handled via the exception
> > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > the level -1 faults, and so those all get handled by do_bad() and don't call
> > fixup_exception(), causing them to be fatal.
> >
> > It should be relatively simple to update the fault_info table for the level -1
> > faults, but given the other issues we're seeing I think it's probably worth
> > dropping the LPA2 patches for the moment.
> >
> 
> Thanks for the analysis Mark.
> 
> I agree that this should not be difficult to fix, but given the other
> CI problems and identified loose ends, I am not going to object to
> dropping this partially or entirely at this point. I'm sure everybody
> will be thrilled to go over those 60 patches again after I rebase them
> onto v6.7-rc1 :-)

FWIW, I'm more than happy to try; the issue has lagely been finding the time.
Hopefully that'll be a bit easier after LPC!

Mark.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
