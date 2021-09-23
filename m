Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31B0C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:01:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065766126A
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 065766126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6617C3CA1C3
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 12:01:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 353723C7ABD
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 12:01:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B45A601029
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 12:01:14 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9655622308;
 Thu, 23 Sep 2021 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632391273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzJP1NacuRrgyoFRt4Ocp3ynHeVYoUlVZdZtaHi2uBE=;
 b=iKFB2v0lDs03sugqu0Q8wHXo3HNjI9ogoEkYBh7xRrfRqEAtOfWbd2+4O8e+1PXbOlQh6j
 X9kBnJ+m9TluSiKGzk/1iXGV11ptPNYTLtku1zq+CQTxYL95l+ND8ulHSPuEj+3ZzBV2Mn
 pikn9ttaONfoVNQJyeSPSEapY90g+RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632391273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzJP1NacuRrgyoFRt4Ocp3ynHeVYoUlVZdZtaHi2uBE=;
 b=As0XRGUSDMSN0X6e0YkkmOOs1WrEAm2X429Mo3aBaWRx8duMlnAXU3N22wHQFkMVACE5L2
 3m5uyfsRfzuh4MAw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay1.suse.de (Postfix) with ESMTPS id 8DCA525D3C;
 Thu, 23 Sep 2021 10:01:12 +0000 (UTC)
References: <20210921130127.24131-1-rpalethorpe@suse.com>
 <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de> <87lf3qkk72.fsf@suse.de> <87ilytkngp.fsf@suse.de>
 <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
In-reply-to: <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
Date: Thu, 23 Sep 2021 11:01:09 +0100
Message-ID: <87fstvlifu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ia32 signed long treated as x64 unsigned int by
 __ia32_sys*
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
Cc: linux-aio <linux-aio@kvack.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Sep 22, 2021 at 10:46 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>> Richard Palethorpe <rpalethorpe@suse.de> writes:
>
>> >
>> > Then the output is:
>> >
>> > [   11.252268] io_pgetevents(f7f19000, 4294967295, 1, ...)
>> > [   11.252401] comparing 4294967295 <= 1
>> > io_pgetevents02.c:114: TPASS: invalid min_nr: io_pgetevents() failed as expected: EINVAL (22)
>> > [   11.252610] io_pgetevents(f7f19000, 1, 4294967295, ...)
>> > [   11.252748] comparing 1 <= 4294967295
>> > io_pgetevents02.c:103: TFAIL: invalid max_nr: io_pgetevents() passed unexpectedly
>>
>> and below is the macro expansion for the automatically generated 32bit to
>> 64bit io_pgetevents. I believe it is casting u32 to s64, which appears
>> to mean there is no sign extension. I don't know if this is the expected
>> behaviour?
>
> Thank you for digging through this, I meant to already reply once more yesterday
> but didn't get around to that.

Thanks, no problem. I suppose this will effect other systemcalls as
well. Which if nothing else is a pain for testing.

>
>>     __typeof(__builtin_choose_expr(
>>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>>         0LL, 0L)) min_nr,
>>     __typeof(__builtin_choose_expr(
>>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>>         0LL, 0L)) nr,
>
> The part that I remembered is in arch/s390/include/asm/syscall_wrapper.h,
> which uses this version instead:
>
> #define __SC_COMPAT_CAST(t, a)                                          \
> ({                                                                      \
>         long __ReS = a;                                                 \
>                                                                         \
>         BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&              \
>                      !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&           \
>                      !__TYPE_IS_LL(t));                                 \
>         if (__TYPE_IS_L(t))                                             \
>                 __ReS = (s32)a;                                         \
>         if (__TYPE_IS_UL(t))                                            \
>                 __ReS = (u32)a;                                         \
>         if (__TYPE_IS_PTR(t))                                           \
>                 __ReS = a & 0x7fffffff;                                 \
>         if (__TYPE_IS_LL(t))                                            \
>                 return -ENOSYS;                                         \
>         (t)__ReS;                                                       \
> })
>
> This also takes care of s390-specific pointer conversion, which is the
> reason for needing an architecture-specific wrapper, but I suppose the
> handling of signed arguments as done in s390 should also be done
> everywhere else.
>
> I also noticed that only x86 and s390 even have separate entry
> points for normal syscalls when called in compat mode, while
> the others all just zero the upper halves of the registers in the
> low-level entry code and then call the native entry point.
>
>         Arnd

It looks to me like aarch64 also has something similar? At any rate, I
can try to fix it for x86 and investigate what else might be effected.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
