Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFDAC433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:59:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C6153C56A7
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 16:59:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C23B13C0894
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:17:30 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28EFD2011BD
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:17:30 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id o13so3182133wrs.12
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=70LFuvA9BwzW8zf1KTQCL6giarK0Nl0WBEKJHk+tQGg=;
 b=lNcgdtvnOSWnBcldpNHr35YPikZfWlGARERZnGXQJam6dJ5VuAYn81zn2TkK5XVcV3
 yqIvxkjQ8EU+s+Hw4acAiBGGsJ/77nrR0Q9SbxrGA+upRT3a7gRWOIF/20QDjVw8QnW2
 /ne0b4ikIg0rXeJWo+VyBmh9PcBn64RGEr5xoiS1OqEoyQFr3F7AJHnC6D30e7r4I1KE
 fJ0oCb7xsyxiFsIUZVz71NEStgnCPdvbP9WA2OIKflWMvB3qHnD9enJrCJz3SNppTx4I
 8o38STuhK0/vLPmlo27lgUx1VPAk7JL4HIMU6xTJfsrCBjni+uW/dC5W9nSDezkCwZam
 m9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=70LFuvA9BwzW8zf1KTQCL6giarK0Nl0WBEKJHk+tQGg=;
 b=xAlChQ72Yz//IJXHB8Hm9L9Q0h6LfZlGVKTqgAgTRi6q4Etk6YWFjLzUUWrA7PUuEI
 wXn+JWbupLyhqQoy1R/tZPqfMvadAt/mZHWWo9w4/KIkB9iUQ7g9bzSt7xBB/Ea5iYui
 CeLUdFTUzQ/jM1/rZR03cuasRKFNQTRzYXVnygV1I8tPH3S0TjT2kfc632ITtGHpPbd7
 98AIYVAA1o5sw76iRzMNt7P5pASWpVufW4qpOySN9vAoq2SK1QV+dDot8vGCbidg84UT
 bxWhA7iCfsvq0egtdnb6b8rFo6lzHUUuEwF6kn+SoAsQJgzfI/KfCrA4E025psyqMvON
 +iHQ==
X-Gm-Message-State: AOAM530kLbfUmg5WEcAFXNpI3uO4YmeYdv/inbWglvF74VI8YFmku1/S
 LNlbod5HC/myCsPoxN+zv6E=
X-Google-Smtp-Source: ABdhPJw6qAm068rM9uv6H9YayQc+b8C9roADbIZnGBi3P3kdRFDA9zzgTdiUq3RKZXFYZkChf7L40A==
X-Received: by 2002:a05:6000:15c8:: with SMTP id
 y8mr17887347wry.101.1637749049690; 
 Wed, 24 Nov 2021 02:17:29 -0800 (PST)
Received: from [10.168.10.11] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id n15sm4445528wmq.38.2021.11.24.02.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 02:17:29 -0800 (PST)
Message-ID: <fb57172d-9268-6aaf-1ba1-fa42a2a47c03@gmail.com>
Date: Wed, 24 Nov 2021 11:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Florian Weimer <fweimer@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
 <YZyw56flmdQnBIuh@yuki> <87a6hups6w.fsf@oldenburg.str.redhat.com>
From: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <87a6hups6w.fsf@oldenburg.str.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:58:59 +0100
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
 Linux API <linux-api@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 11/23/21 20:50, Florian Weimer via Libc-alpha wrote:
> * Cyril Hrubis:
> 
>> As far as I can tell the userspace bits/types.h does exactly the same
>> check in order to define uint64_t and int64_t, i.e.:
>>
>> #if __WORDSIZE == 64
>> typedef signed long int __int64_t;
>> typedef unsigned long int __uint64_t;
>> #else
>> __extension__ typedef signed long long int __int64_t;
>> __extension__ typedef unsigned long long int __uint64_t;
>> #endif
>>
>> The macro __WORDSIZE is defined per architecture, and it looks like the
>> defintions in glibc sources in bits/wordsize.h match the uapi
>> asm/bitsperlong.h. But I may have missed something, the code in glibc is
>> not exactly easy to read.
> 
> __WORDSIZE isn't exactly a standard libc macro.

The (to-be) standard libc macro would be LONG_WIDTH (although it has a 
slightly different meaning, but it can be used for this, but then the 
code also needs to expose <limits.h>), rigth?

Regards,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
