Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA6C433F5
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 09:02:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008A3611C7
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 09:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 008A3611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 485D63CA086
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 11:02:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714543C6EE5
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 11:02:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 881711000A13
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 11:02:41 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7AED721BC2;
 Tue, 28 Sep 2021 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632819760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7rw75VSmRwP8/RIgXFPLCmhyy1FPhry8ZvpaNKqg7aQ=;
 b=pWvl8r9N6tqQ508IhwJ0P2cgH9bILyurruAKGvqHocV6+0dOcAvYlz07rCporIsasrs+N7
 f6gzMo0Akcn8ARvdw97rF1N2i9IRpCLOa4YTLu60KNiE0rakTzyY4Q3lPVsmO1pF5nJ0Za
 JFzZ8m/DDx4trXvdRqUjnAE679OOhJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632819760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7rw75VSmRwP8/RIgXFPLCmhyy1FPhry8ZvpaNKqg7aQ=;
 b=OV+rtC16fdoMmYxtaeEUVcBdefcxrTBtLO7r1A83cfYnwlIZ3Xaubkr77qI9b1SNYp11Qx
 fybX1Zl3tv+JhmDg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay1.suse.de (Postfix) with ESMTPS id 92F8725D50;
 Tue, 28 Sep 2021 09:02:37 +0000 (UTC)
References: <20210927161955.28494-1-rpalethorpe@suse.com>
 <CAK8P3a2kuZkoF1m0pTXWeq0gnzUG9oSTQKtjjdiCyo1ptmXPgA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
In-reply-to: <CAK8P3a2kuZkoF1m0pTXWeq0gnzUG9oSTQKtjjdiCyo1ptmXPgA@mail.gmail.com>
Date: Tue, 28 Sep 2021 10:02:32 +0100
Message-ID: <87pmstf4yf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: linux-s390 <linux-s390@vger.kernel.org>, rpalethorpe@richiejp.com,
 Vasily Gorbik <gor@linux.ibm.com>, Linux API <linux-api@vger.kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Mon, Sep 27, 2021 at 6:21 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>>
>> Presently ia32 registers stored in ptregs are unconditionally cast to
>> unsigned int by the ia32 stub. They are then cast to long when passed
>> to __se_sys*, but will not be sign extended.
>>
>> This takes the sign of the syscall argument into account in the ia32
>> stub. It still casts to unsigned int to avoid implementation specific
>> behavior. However then casts to int or unsigned int as necessary. So
>> that the following cast to long sign extends the value.
>>
>> This fixes the io_pgetevents02 LTP test when compiled with
>> -m32. Presently the systemcall io_pgetevents_time64 unexpectedly
>> accepts -1 for the maximum number of events. It doesn't appear other
>> systemcalls with signed arguments are effected because they all have
>> compat variants defined and wired up. A less general solution is to
>> wire up the systemcall:
>> https://lore.kernel.org/ltp/20210921130127.24131-1-rpalethorpe@suse.com/
>>
>> Fixes: ebeb8c82ffaf ("syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32")
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks good to me, thanks for following through with this part, and for
> checking the other syscalls!
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the feedback and suggestions.

>
> I've added this to my randconfig build tree as well, to see if
> it causes any unexpected compile-time issues, though I
> don't expect any problems here.
>
> There are a few things that I think we should do as a follow-up:
>
> - do the same thing in the generic syscall wrapper, to ensure the
>   other architectures also do the sign-extension.
>
> - Fix the big-endian architectures (ppc64be, mips64be, sparc, s390
>   parisc) so they pass the correct signal mask, either using your original
>   approach, or by reworking the syscall to detect compat syscalls
>   at runtime, killing off the separate entry point
>
> - Go through the compat syscalls to see if any of them can be
>   removed once all architectures do sign-extension correctly.
>
> Are you motivated to help out with one or more of these as well?
>
>        Arnd

I am motivated. There have been a number of nasty bugs in compat
code. Including high-profile stuff like CVE-2021-22555. However also
just relatively minor things which cause tests to fail and could be
masking worse issues. I like the idea of removing as much syscall/arch
specific compat code as possible.

I also wonder whether syscalls like ftruncate64 can be generalised and
if there would be any benefit to doing so. All it is doing is merging
two u32 args into an s64 arg.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
