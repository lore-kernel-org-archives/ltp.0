Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBA3C4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 07:43:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E2463CE9E7
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 08:43:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD4BD3CC91B
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 08:43:24 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCDC260029D
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 08:43:23 +0100 (CET)
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-458d30d63deso2260292137.0
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698738202; x=1699343002; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D7CFAeZxpqqyg0TPZNDgQgUrC155Qrh9XqLfWlj2DOo=;
 b=KuDGLo7kC9IDkitRSz00r+8N5C1VA1wgHzyWbKJfplXUdiWqZOyCspCERXicxo6abw
 IUzvI0ioLqk44ypKvsOBFSS7feiqFwbqq7H9vwbPhzZ9Tc3sf0J2E9wte9PXQeTYc0tn
 2Z9XNAFy+57rhuyZNuDoKvH7Gk5CQpn4zKBXCQe1IVnRixcG56JS50loHlhvi94RFtWo
 BERzAtrZldy1WSMLVoSt7S0N7dezn5OKqSwsNlzLFkTI42s2f9rOlpeJrrTMTIxV5KtO
 hPpP3jZx06rhJNl2bFPsgrrR0m0nh2vClzaUjImj1KHQLj9GOM+8NjTRAuMP+3myrmKh
 /vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698738202; x=1699343002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D7CFAeZxpqqyg0TPZNDgQgUrC155Qrh9XqLfWlj2DOo=;
 b=bgblN30N7GPFgeZ5r1VCDuPCISlNbnaPy/RR3uYUntDrHXlaJOS0RxxvKGywFlPywn
 l2QM+OoynvQyKrnBmyZ23Ahhl2UHGHm3YF9lo6GwF3h/reCbXMpo0NIQuHrUsQX7Pg3w
 Gj4v3C16nfz0XWf8bw+UGESCEbl/s7Bn7uO4kwXy07TBX4iFtGulD+KPXEBuWaUmJkk4
 rpDvUIqnHkJzMu+VtDt3XbZPeOgBe5oowZnRRXbpkN20dJjr9U6XBWbENXcE8uAqUHEj
 7ZmYAXpo1Ync383x6PaxAKKLJz1DUtOxu2h9GN9+LlVLRc00UO1myOqAHZ2Qgfs66S8U
 RBmw==
X-Gm-Message-State: AOJu0YxUT8OpazW0FLNsJIOuPGAn0hEpIBgsdvq4+mv6L4jOHbkN4wM8
 0o/b51y+JSZMjUjnXEIpqp+wTL4gfJRyu2tn02V7qA==
X-Google-Smtp-Source: AGHT+IEviXasTdJ61T5Z7Jo958RBLuU9DCFLECPI5hHVFGbilE7uM1oG5pcWXvUVLSzYb1F41vEHhOHdQE+ERMZ8mwQ=
X-Received: by 2002:a67:ef12:0:b0:457:6b29:9486 with SMTP id
 j18-20020a67ef12000000b004576b299486mr8205164vsr.33.1698738202417; Tue, 31
 Oct 2023 00:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
 <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
 <CA+G9fYv3Ph6UDpW1uhoXD5QBE4tAZKpUkVy-Oo9NNrghChL_+A@mail.gmail.com>
 <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com>
 <CA+G9fYsyDQZmsHpN+4qv8q_DsagKbmDZ5vjo60QDEr+uCVXoNA@mail.gmail.com>
In-Reply-To: <CA+G9fYsyDQZmsHpN+4qv8q_DsagKbmDZ5vjo60QDEr+uCVXoNA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 31 Oct 2023 13:13:10 +0530
Message-ID: <CA+G9fYsuoM9GfrcWXu+M0E21JaBmZ6F0uPpQy1ez4xCptVPj6g@mail.gmail.com>
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

Hi Ard,

Your V2 patch works perfectly.
Thanks for providing a fix patch.

- Naresh

On Mon, 30 Oct 2023 at 17:20, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 30 Oct 2023 at 13:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 30 Oct 2023 at 09:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Sat, 28 Oct 2023 at 13:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Fri, 27 Oct 2023 at 12:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > >
> > > > > On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > > > > > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > > > > > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 ...
> > > > > > > It looks like this is fallout from the LPA2 enablement.
> > > > > > >
> > > > > > > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > > > > > > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> > > > > > >
> > > > > > >         0b101011 When FEAT_LPA2 is implemented:
> > > > > > >                  Translation fault, level -1.
> > > > > > >
> > > > > > > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > > > > > > The exception is expected, and it's supposed to be handled via the exception
> > > > > > > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > > > > > > the level -1 faults, and so those all get handled by do_bad() and don't call
> > > > > > > fixup_exception(), causing them to be fatal.
> > > > > > >
> > > > > > > It should be relatively simple to update the fault_info table for the level -1
> > > > > > > faults, but given the other issues we're seeing I think it's probably worth
> > > > > > > dropping the LPA2 patches for the moment.
> > > > > > >
> > > > > >
> > > > > > Thanks for the analysis Mark.
> > > > > >
> > > > > > I agree that this should not be difficult to fix, but given the other
> > > > > > CI problems and identified loose ends, I am not going to object to
> > > > > > dropping this partially or entirely at this point. I'm sure everybody
> > > > > > will be thrilled to go over those 60 patches again after I rebase them
> > > > > > onto v6.7-rc1 :-)
> > > > >
> > > > > I am happy to test any proposed fix patch.
> > > > >
> > > >
> > > > Thanks Naresh. Patch attached.
> > >
> > > This patch did not solve the reported problem.
> > > Test log links,
> > >  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2XTP1lXcUUscT357YaAm2G1AhpS
> > >
> >
> > Oops, sorry about that.
> >
> > Fixed patch attched.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> - Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
