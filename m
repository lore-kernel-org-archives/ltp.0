Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54439C433EF
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 18:22:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798B060F11
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 18:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 798B060F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41A693C8EBA
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 20:22:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C3B13C8CB4
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 20:22:42 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BEC91A00EC9
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 20:22:41 +0200 (CEST)
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MZCKd-1mI7Kz00ED-00V6Ce for <ltp@lists.linux.it>; Mon, 27 Sep 2021
 20:22:40 +0200
Received: by mail-wm1-f50.google.com with SMTP id
 b192-20020a1c1bc9000000b0030cfaf18864so684306wmb.4
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 11:22:39 -0700 (PDT)
X-Gm-Message-State: AOAM5326LSUyF9uI0/3jWXWUklZDs1+v5MHiry+0DfYIZi7a7oZbDRgO
 Yk0GkKYNemey0x5R+NCle7C0aQ0b5CL8GJyzqhg=
X-Google-Smtp-Source: ABdhPJwCCfy48nJsv/jBkQ+FqTChrVTa3J/1b3crzTUhy/rlsn26nuFEnfQytCPMcD0SR1VltuyU2G/7abBHN508EYw=
X-Received: by 2002:a05:600c:22d4:: with SMTP id
 20mr539812wmg.82.1632766959604; 
 Mon, 27 Sep 2021 11:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210927161955.28494-1-rpalethorpe@suse.com>
In-Reply-To: <20210927161955.28494-1-rpalethorpe@suse.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Sep 2021 20:22:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2kuZkoF1m0pTXWeq0gnzUG9oSTQKtjjdiCyo1ptmXPgA@mail.gmail.com>
Message-ID: <CAK8P3a2kuZkoF1m0pTXWeq0gnzUG9oSTQKtjjdiCyo1ptmXPgA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Provags-ID: V03:K1:g5aluj1IDKoDMvaO/ltXYSHtXCiXW0vvRlSF2e0LIPIwNOVr0tY
 YvKYTpeT+pIxJji4bPN9/L9d1BrMZ/C7BVB2mJDP8F1zuG+r3mBpGlcJAGxlwcFZLoXdBVA
 j/TO3EMohTU+5ytgvTUkpZF5ARzhT+wXFtGHXGU0NVWhe9xq16OmhoNM2iSDSc5kA/yFRN7
 2iclLC4vD3xqaXXR6RqOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iBUWycZ4FgQ=:zCHKLxlcs1Y80FsSScNQ9b
 KnLiZ2lflVaDtc9U/GbBfxs0rLoGIr1sdYHuZTYG+uLO3W186otcjP936iJD93AHLMAAOfTJG
 2icBXe5uqvrhQDuUDOgcQa4IBf3zbQL1rE4fsvGk8eW01MUofMHnSOJbBYRR4ptlw0myVBwoO
 Si8s2CAw/MbJWbnq0VoOvZha3kNUsBpXQObAO6a1vYpChKcPWX8WfSmKnMKagqdc2eZ7t0+CK
 WjMMzuSMkwmxcNBSb2Uszb3eJNxpil7jgmbHQpShH7gyOCgPpV8VGZ/0+NFxRtK9r0xu56sPJ
 tb/rkZYCVs9QflvkQFBvmDCmt21E/YZIVNoPu8hSw4/q8gvBk/3SOVuWJF/TkIRH4I7TRNC1I
 KtiVZE/5jZ8ZETwmB14svRZtGObAfpB6/sFr7j99IQMEjTlu1mD1lSwS9KqkzDw/Ie2H7XsdT
 UxvK5xcHchU32QoHEU6+IQRECaPH2j8CLm0sW6UMlDQyb9vEqGzTpcHufNn+65ULdJDhmiFvk
 80zt+OEX9top0kiNd3pdRBX+f0SBkCc55JQ3kDpYe4nfR/MEd36wDA4eLlo/Hf1Swsz7+D4WV
 xeraVnO+7aCCLrqMS4RVJPLqmpLhAE63LigY555B4IGuICtnKduUzJcDVd1SQGvzNDmL1EkII
 o8DN3sViIq08LT6vanzx5dXKq1PyW99DLN+xTCJNwCciq3LM4gXpCCGHiwqlZ4jwh1DXI20/e
 5+6oUUJwkRO3PQFgIgyahBPOCLr4OqygP1McX6oZxjAcs5zR7QEbFSPFYh5eK7hcNBYJ3V3ys
 J0Lzk/pMh4MRfXCGQUfyoKJ6mMQvDW33kPekExIbZQW5VSuGmU5g5oycWtGjvf6KRSqtZEka/
 Aq+H7qipVzlM09XmRirA==
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] x86/entry/ia32: Ensure s32 is sign extended to s64
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, rpalethorpe@richiejp.com,
 Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Linux API <linux-api@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 27, 2021 at 6:21 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> Presently ia32 registers stored in ptregs are unconditionally cast to
> unsigned int by the ia32 stub. They are then cast to long when passed
> to __se_sys*, but will not be sign extended.
>
> This takes the sign of the syscall argument into account in the ia32
> stub. It still casts to unsigned int to avoid implementation specific
> behavior. However then casts to int or unsigned int as necessary. So
> that the following cast to long sign extends the value.
>
> This fixes the io_pgetevents02 LTP test when compiled with
> -m32. Presently the systemcall io_pgetevents_time64 unexpectedly
> accepts -1 for the maximum number of events. It doesn't appear other
> systemcalls with signed arguments are effected because they all have
> compat variants defined and wired up. A less general solution is to
> wire up the systemcall:
> https://lore.kernel.org/ltp/20210921130127.24131-1-rpalethorpe@suse.com/
>
> Fixes: ebeb8c82ffaf ("syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32")
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, thanks for following through with this part, and for
checking the other syscalls!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I've added this to my randconfig build tree as well, to see if
it causes any unexpected compile-time issues, though I
don't expect any problems here.

There are a few things that I think we should do as a follow-up:

- do the same thing in the generic syscall wrapper, to ensure the
  other architectures also do the sign-extension.

- Fix the big-endian architectures (ppc64be, mips64be, sparc, s390
  parisc) so they pass the correct signal mask, either using your original
  approach, or by reworking the syscall to detect compat syscalls
  at runtime, killing off the separate entry point

- Go through the compat syscalls to see if any of them can be
  removed once all architectures do sign-extension correctly.

Are you motivated to help out with one or more of these as well?

       Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
