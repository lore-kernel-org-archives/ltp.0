Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C8EC25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0307C3CEB85
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:58:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C39993C2FAF
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:57:54 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65A992064EA
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:57:54 +0200 (CEST)
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7b610279c8aso878436241.3
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698404273; x=1699009073; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3zQBT6jRuR5jxYiRAr8syfNhHciQ/BHcE4DZFyhdPwI=;
 b=WHXen2h2rYWFq7tK6fS1jcJhsuasl9LBEqfBgG0wop2obsDC18nB/p03xCOncR8z1D
 hv8jFjcmVH2GzrWRgD6gpoEDXzdMM/Ww/xMWR0rryih5C1y/rSuBSShh/WsSJdJ0410L
 VB9ha2CJoD7igbLKPjt0reFa+ejLmL6IXQ4V8YerxKtrbqpUdqI6bsymKIxNuJ5UqmTs
 6K0faleBDJoI3d7riiww9UNtcv/5HnMHCw+XJW4QCE5BSS1DK9aty0YnqMJtPSdANs/M
 PVsBeRG8BQQNJ9U9G+D5Ui3hN03XYIuUpinjHihwVmjewZzjpy+sxsRKcfNFCbRNjh7R
 7Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698404273; x=1699009073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3zQBT6jRuR5jxYiRAr8syfNhHciQ/BHcE4DZFyhdPwI=;
 b=JxxntyDrpU2H6dKQCxB3yeo6XHz3PQYtYtO9OJzL0hN86Wv9bkrs/csMQQbbbMW0mq
 Lf3VAb5VrZofSEwakGgw/oURvAO7BWNUTpo9aGMNI8/vWzKTvhSEqP0cQaDZCpl65t6U
 V7nuP7idIsAqI7PZ4JV0i5QK0tR2FQ0T1C9G6vR/QddMxMrv1q4xc+PlXqNgTEKGVnG1
 z+XOudsr42UupFjfHZnQf1ok/WS6Q2euE0khh3bNrdhhB59ysD+qaMCE3eLqwIxsnYSV
 Tf4BQeyjUXv2TKbpkkDhsYWztWKuiYdvNnFihE6EgMm5az0XA5O0iYiYhhHTxa1vpAn5
 BkEA==
X-Gm-Message-State: AOJu0YwwRGtzj6X6sPpOVWbtdT6OpGvw9XUSMsfq5BgTuSccAQmZ8Lk+
 IQfLjdinNyt/3086H4arl5wESchuWx+iSLCUMuGoYA==
X-Google-Smtp-Source: AGHT+IHarNLCoFsdKNzL1a48n70a2eNgURLrsseEGHkrmEWYJ6n2/q05I2+4jQ74A/lQL0OqJP835LGQwXLk47ENiWU=
X-Received: by 2002:a05:6102:1592:b0:457:dbfc:5c69 with SMTP id
 g18-20020a056102159200b00457dbfc5c69mr2829666vsv.12.1698404273032; Fri, 27
 Oct 2023 03:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
In-Reply-To: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 27 Oct 2023 16:27:41 +0530
Message-ID: <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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

On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
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

I am happy to test any proposed fix patch.

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
