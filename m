Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E22FC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 07:01:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B04A43D206D
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 09:01:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADBB03D1FCE
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 09:00:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA78A200D10
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 09:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723100449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TXC/RC+0/1G+ApuEcKnhjAXr7ORLkYLsSDF7wc3VHcg=;
 b=SktJwrNg8IsFJovG8v/Ap715pMIjLtkrGsy6UaVsIRlTWOv0emOCSf6otZ6ZqEO93xNZqg
 7A16hX5TgdsAgSqfJN7grTvc4DTFvCRSi7xPKwtGVPhbuGGnC0XD6tIVjoFMdqcZ1iHjA+
 oKJSN8zYCLgA+szSIkrqNvDlj8B1rY0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370--hqfYpB0MR6rNaub4_csow-1; Thu, 08 Aug 2024 03:00:43 -0400
X-MC-Unique: -hqfYpB0MR6rNaub4_csow-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb576921b6so836912a91.1
 for <ltp@lists.linux.it>; Thu, 08 Aug 2024 00:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723100443; x=1723705243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TXC/RC+0/1G+ApuEcKnhjAXr7ORLkYLsSDF7wc3VHcg=;
 b=PBP8w2bWd1BwcVnKqtsZMQOZGYQZp/Awail+t35O26zS4EG5r7BG2j7M67Cw92Rf3S
 q0GMlwN/MQzP3wowbSkiMraGFyoikTjE6Gy/g0W890vslTXvlhXOU6obRo7k/zLJUvtX
 FxD0W75BdKGy5VVDwa5JiHxluIuelAUFZYzajckDrtlV1xh8CaWrq0O8qpYDNmJ2L+20
 8tmzMTynfVnugIihKbEYCgDbpik59dDkhYYY0hGpPTwRwhjFJ8Awb0aRueEVMPog0LdD
 TYCLp902MmO5f5bBzxS5LoGGmdOg8ljN+/j/RN85yq1NH9aWxV0NyFIPRTkhegxww+pE
 kicA==
X-Gm-Message-State: AOJu0YxmxbwJFKFKFZwMZtqgKlPCj1E9t0Y1Tr9drXBtcym5faHx4qZv
 jaCt2jkxYgPq+eelyemLH1CiI9W1wxB5X5DmYmCdb6cBF6xtfo59r/VqIq+XMtCsYCM1twj7pua
 wW56GSF6ATHQ1wZeKwCnfEuDksoSx+rD07CRVLc2iHFk0N+2i0TptQ7zBb4z7+kNVcsxH+HSuaJ
 3onpPTEDBxsA3vVR09uk0p2Ho=
X-Received: by 2002:a17:90a:7346:b0:2c9:7cb6:38b0 with SMTP id
 98e67ed59e1d1-2d1c33e6872mr1047426a91.19.1723100442529; 
 Thu, 08 Aug 2024 00:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuxEebvxiQBLfdXSrO8W0JP90LyqgqlDGr/AdNO1LPFJo8BwnP59lBBACYJE8/49tNLL+cIyRG1/P29P0MfLM=
X-Received: by 2002:a17:90a:7346:b0:2c9:7cb6:38b0 with SMTP id
 98e67ed59e1d1-2d1c33e6872mr1047394a91.19.1723100442025; Thu, 08 Aug 2024
 00:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240807090043.229889-1-pvorel@suse.cz>
In-Reply-To: <20240807090043.229889-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Aug 2024 15:00:29 +0800
Message-ID: <CAEemH2f1+VfLnF88YJE8K3v7TPJJJKZK7aoqKG3QP7ypBtUvjA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] pkey01: Add .test_variants
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,


Petr Vorel <pvorel@suse.cz> wrote:

not sure if testing libc wrappers makes ATM sense, because (if I read
> glibc code correctly), there is only pkey_mprotect() very thin wrapper
> in sysdeps/unix/sysv/linux/pkey_mprotect.c [1]:
>

Yep, seems pkey_* series wrapper is uncompleted in glibc so far.
I also hesitating to add the variant in LTP test at this moment.

Let's hear other's opinions.

Btw, I additionally add a new test for PKEY_DISABLE_EXECUTE in
separate patch[1], but considering may your patch may be delayed, I
haven't rebase the code from yours.

[1] https://lists.linux.it/pipermail/ltp/2024-August/039719.html



> int
> pkey_mprotect (void *addr, size_t len, int prot, int pkey)
> {
>   if (pkey == -1)
>     /* If the key is -1, the system call is precisely equivalent to
>        mprotect.  */
>     return __mprotect (addr, len, prot);
>   return INLINE_SYSCALL_CALL (pkey_mprotect, addr, len, prot, pkey);
> }
>
> pkey_alloc() and others [2]:
>
>         This adds system call wrappers for pkey_alloc, pkey_free,
> pkey_mprotect,
>         and x86-64 implementations of pkey_get and pkey_set, which
> abstract over
>         the PKRU CPU register and hide the actual number of memory
> protection
>         keys supported by the CPU.  pkey_mprotect with a -1 key is
> implemented
>         using mprotect, so it will work even if the kernel does not
> support the
>         pkey_mprotect system call.
>
>         The system call wrapers use unsigned int instead of unsigned long
> for
>         parameters, so that no special treatment for x32 is needed.  The
> flags
>         argument is currently unused, and the access rights bit mask is
> limited
>         to two bits by the current PKRU register layout anyway.
>
> Besides, something like SYSCALL_VARIANT could be added to
> include/tst_test_macros.h,
>

+1


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
