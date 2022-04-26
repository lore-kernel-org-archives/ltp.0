Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93C9C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 15:51:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2912D3CA43B
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 17:51:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C34553C9C87
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 17:51:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 375DF600802
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 17:51:37 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9B8CF1F388
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650988297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kud+ridNJdz+0oycyrUhQSOGddaYwqsBTHH7bFkoGC4=;
 b=zCHo1pEK91wsSTueurN1q+qm7dWdk6/0GOHMyz7S8khQduUzL7xKxviwOSll2IC/IPiLJd
 afFXh34ZrA+nLcHoU5cByoH6To1VxQ+aNLhfijYd1mmhDzl8MK3peoWDo/Hbrdbva0Cftn
 6CFIOuQUzysJvY1ibe0Lw0V33t/V9Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650988297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kud+ridNJdz+0oycyrUhQSOGddaYwqsBTHH7bFkoGC4=;
 b=B/lKISiZMzcH2aJlW84A56xqVmGthP7j/vEian8R7hCZtDvLrPzmfbH3NRhDQ+NWg+EWH3
 R2UXlz981cQrJyDw==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5E91B2C141;
 Tue, 26 Apr 2022 15:51:37 +0000 (UTC)
References: <20220425133816.720-1-rpalethorpe@suse.com> <Ymfjm0mdVKacvDnq@yuki>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Apr 2022 16:44:20 +0100
In-reply-to: <Ymfjm0mdVKacvDnq@yuki>
Message-ID: <87h76f9720.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/signal.h: rm references to _SC_SIGRT_* and
 __SIGRT*
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> The old API's tst_sig.c uses_SC_SIGRT_MIN/MAX are not extant and a
>> quick internet search does not reveal much. It's assumed they meant
>> the same thing as tst_sigrt{min,max}_kern.
>> 
>> The fallback using __SIGRT{MIN,MAX} is also replaced with
>> tst_signal_is_reserved_rt. It says sigrtmin on HPPA is 37. However in
>> the kernel all arches have it set to 32.
>> 
>> In all cases __SIGRT{MIN,MAX} is replaces with constants we define as
>> we can not use __ variables. Two functions are introduced to make the
>> meaning clear when using these constants to check if a signal is
>> reserved and/or realtime.
>> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Suggested-by: Petr Vorel <pvorel@suse.cz>
>> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
>> ---
>>  include/lapi/signal.h                         | 36 ++++++-------
>>  lib/tst_sig.c                                 | 51 +------------------
>>  testcases/kernel/syscalls/ptrace/ptrace05.c   |  2 +-
>>  .../syscalls/rt_sigsuspend/rt_sigsuspend01.c  |  2 +-
>>  testcases/kernel/syscalls/sighold/sighold02.c |  4 +-
>>  5 files changed, 23 insertions(+), 72 deletions(-)
>> 
>> diff --git a/include/lapi/signal.h b/include/lapi/signal.h
>> index 6f4a76881..aa185a5a6 100644
>> --- a/include/lapi/signal.h
>> +++ b/include/lapi/signal.h
>> @@ -1,24 +1,24 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> The style with "//" seems to be more common in LTP. If we want to unify
> on the latter it should be done for all files and in a separate patch.
>
>>  /*
>> - * Copyright (c) 2019 Linaro Limited. All rights reserved.
>> - * Author: Daniel D??az <daniel.diaz@linaro.org>
>> + * Copyright (c) 2022 SUSE LLC
>>   */
>> -
>> -#ifndef LAPI_SIGNAL_H__
>> -#define LAPI_SIGNAL_H__
>
> Why have you deleted the guards?

Uff, I don't think I was paying attention when writing this patch!

>
>>  #include <signal.h>
>>  
>> -/*
>> - * Some libc implementations might differ in the definitions they include. This
>> - * covers those differences for all tests to successfully build.
>> - */
>> +const int tst_sigrtmin_kern = 32;
>> +const int tst_sigrtmax_kern = 64;
>
> I would go for macros here but I guess that either one works.
>

This at least is deliberate because constant variables work better with
some tooling such as clangd. I'm not sure why, but it can't rename
macros. Although thinking about it, I'm not sure if these should be
static...

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
