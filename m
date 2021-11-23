Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F262C433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 14:19:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312CB3C8EA3
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 15:19:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D5733C8190
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:18:57 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 113591400966
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:18:56 +0100 (CET)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N4Qbu-1mfwTm1FqQ-011UVy for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:18:56
 +0100
Received: by mail-wm1-f44.google.com with SMTP id
 i8-20020a7bc948000000b0030db7b70b6bso2418023wml.1
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 06:18:56 -0800 (PST)
X-Gm-Message-State: AOAM5331mY+iz/w2zKTE5WGXmEl7/JCUOstlG82c7Pi/koK18Fu5G4t1
 rvAQZAkoG1Y9WMeeziqypUbzcdv8wbERnxUUzZE=
X-Google-Smtp-Source: ABdhPJy/iu+HUeUW5MAS4aoS4UPs9O0+2rPHcGIO3sxNnrXnPW2hntwc4AmghGSopXx9bjgxeEGyK0ovTBLVT2Rzyac=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr3353750wmi.173.1637677135896; 
 Tue, 23 Nov 2021 06:18:55 -0800 (PST)
MIME-Version: 1.0
References: <YZvIlz7J6vOEY+Xu@yuki>
 <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
 <YZyw56flmdQnBIuh@yuki>
In-Reply-To: <YZyw56flmdQnBIuh@yuki>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Nov 2021 15:18:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2RU8XJp_hS0JkO9mPJctAHHKBobV97gced6pMXcwzWow@mail.gmail.com>
Message-ID: <CAK8P3a2RU8XJp_hS0JkO9mPJctAHHKBobV97gced6pMXcwzWow@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Provags-ID: V03:K1:rRoapDkttEiLPem05MqYqDj96TUmjY/071Kd/US1TYtaM1G66+V
 XQDj3uylWxeZoJjF/V5cHjIkxuHcT3qDMlDzGmrJz6body52HYhgFkhb4vBVQVxw08e6Rib
 QIquU0yGpj6a1WQGpT8E5rmoDL75iZc5VHvxQV47MggHHEBSOXBjQOS9jTfDt4KhHtjPcWU
 U4N6uMPXSUh8blsGn9DDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bU7Q96TdblA=:JT2zJIU3uSEp+XVgfEwnUW
 M++x0EefEtkPz5ubtDJyqRBkwiO597b1g+Q0wA9WHjpGTSM/cK5Lub8a08oWQV2rArkK7xH6b
 24+4PaSs2sW8HAIvyhWYqBwUUCZPbikXwpZSRhn0u5iLSU11+twWAIKjzfg0fATE5t9SKKFXd
 h+ZIONK6BqUmD74VwgDGqVw4JsOiCLM2GB8uKv7ZzBdPOxbyjyObrKwU0jaVUWMgoGkQNUwjO
 ulkS1JHjATD+fsOsWAO49RMNCA/vzFbEcgg5POu0682N+QwJomuvnrCF5/qXhQ3PLftLjs62h
 zpH4SO/tKe5BQsCz3VfIvzdp1P9MsB5ybtIGTcmv3dhP1CaxkGsnuQQzxvg3T6ENhA4tpE1XH
 yuCXtC4GEqczj82HUoAvpI5ovCwfv1yKz4okA1QtsOqoQDiAegPbmgbtAMCMWa2vWUhvSqFk+
 0fOPSaUHie/HRcCHRvT8BBeTRvCgr7kpXSRPL7N8Z+aDUPeiCCjCETj0LcuryRnM7HU5ChW9F
 +96UWa11eXz78e4F7d0H0t7Oq2PYgxkLPTKsZFxiCP7XOpO2lOwlZ4IKVQR4wRRY6EAdFW2BZ
 otii2euarlTtmAge18T6eCq3wvCKdGgiGtU2TMNihsx4Rs+p3nA0DUfCZCCzdZLvZRaUHwu60
 yKCs/Ga5Wio6XzgPriLue/KOvGIZpkAyKoRl90l7a+PdeUvLBzV3mvm1KYUM486L5xM6qpVB9
 b1uj8nwHvr0o4O73AYOpIIFCsL94Ok7QYYPo/daMZ4I2FJPoFS3Tu3CmqWq148OuqYW0dAeFS
 NfT39yTWs0TWwmmQLdVMfESpKyTaB8hDWGxabG+WwBOFMyVfFA=
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 23, 2021 at 10:14 AM Cyril Hrubis <chrubis@suse.cz> wrote:
> > I don't think this is correct on all 64-bit architectures, as far as I
> > remember the
> > definition can use either 'long' or 'long long' depending on the user space
> > toolchain.
>
> As far as I can tell the userspace bits/types.h does exactly the same
> check in order to define uint64_t and int64_t, i.e.:
>
> #if __WORDSIZE == 64
> typedef signed long int __int64_t;
> typedef unsigned long int __uint64_t;
> #else
> __extension__ typedef signed long long int __int64_t;
> __extension__ typedef unsigned long long int __uint64_t;
> #endif
>
> The macro __WORDSIZE is defined per architecture, and it looks like the
> defintions in glibc sources in bits/wordsize.h match the uapi
> asm/bitsperlong.h. But I may have missed something, the code in glibc is
> not exactly easy to read.

It's possible that the only difference between the two files was the
'__u32'/'__s32' definition, which could be either 'int' or 'long'. We used
to try matching the user space types for these, but not use 'int'
everywhere in the kernel.

> > Out of the ten supported 64-bit architectures, there are four that already
> > use asm-generic/int-l64.h conditionally, and six that don't, and I
> > think at least
> > some of those are intentional.
> >
> > I think it would be safer to do this one architecture at a time to make
> > sure this doesn't regress on those that require the int-ll64.h version.
>
> I'm still trying to understand what exactly can go wrong here. As long
> as __BITS_PER_LONG is correctly defined the __u64 and __s64 will be
> correctly sized as well. The only visible change is that one 'long' is
> dropped from the type when it's not needed.

Correct, I'm not worried about getting incorrectly-sized types here,
but using the wrong type can cause compile-time warnings when
they are mismatched against format strings or assigning pointers
to the wrong types. With the kernel types, one would always use
%d for __u32 and %lld for __u64, while with the user space types,
one has to resort to using macros.

       Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
