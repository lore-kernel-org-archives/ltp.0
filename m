Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2C7C433FE
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 19:03:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF2E83CB258
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 21:03:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53B3D3CACEF
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 21:03:46 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3C1C8100099E
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 21:03:46 +0200 (CEST)
Received: by mail-vs1-xe33.google.com with SMTP id 128so2198360vsz.12
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aR/dX+RJc4tUUtnezEXcSwjR3U/STGUSkrxg2WrgzfI=;
 b=nAj7wHDA1YPP7EkiClBPB7atG+6n4CWXrubLg1r6r2XZYp7SvJoBXmgWjHOK4NSc1s
 C01xHGAF4yScfOVxZzcb45HBr7a+C39cS6LxVLmc3JaPeYISbWJvrlcMZO2W9cr5aepq
 gvAAPvkauVAWUBwrfBEaykstdr35K7R8ByN9SMmzBVMjLo7fq7hgarRUnJTtqJeoJ6Ph
 0LcCDg6fxrvJwlP5G1HRv4ddo+8HYz8SsE4QBe9Wl2Aq4y5pK4iA+dLAXA2yJYIuxDgH
 JiGbGYFXUmcvEUiX+pQLhS0+P2ykI+UnePjx7hfou19oAQecYJMcfwCZm9FKxs9AuAN2
 6Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aR/dX+RJc4tUUtnezEXcSwjR3U/STGUSkrxg2WrgzfI=;
 b=s4A1I41n1TQE6eCiSQT7IaKV0vGyN3PtomVgELQuci9pFAhBnwyvxSkuClWM0nSqHI
 FZgb2p13vabun8+lgH/wOLFkdOfGWZ9Dv3UmcmdC00H08apc4K/fU9YjH5HwN9G977AS
 95hMppN1anevkKUFWVdj4uJ585fbpxcW9GwQrql9CiBcKDtWxjs8regy8+sU+Pd1+D9m
 dtBqIN+FFzQzM5wfoby9h6Yggb9rP1OJFeAf6/Ng5MgYqx2fUeHuQrl2W2BHF4dw529b
 SHUCwpwo6UxePGo9Al0/4C9onu7+yffMykc+xPOHkfYIfEb+YKT4aYYeu/Eg1RaCWxRP
 GC5w==
X-Gm-Message-State: ACrzQf3/CrfhXVYdLZiTZvsjPG7u4lCHCYRUTgs+lVBEphPMw74dUFrv
 AV6CSZdhphLId43OwiRLRtusIro4o29ezLr72Hk=
X-Google-Smtp-Source: AMsMyM6hf9k6FWXOEkZZsF3AcZGd+Z4ImjS6JebySLhBVdK4/+uk/Ju4uQOwhmmteWRIuDg0ltzdp8CJ68Lex/zJ048=
X-Received: by 2002:a67:a24e:0:b0:3a5:38a0:b610 with SMTP id
 t14-20020a67a24e000000b003a538a0b610mr13744944vsh.2.1666379024976; Fri, 21
 Oct 2022 12:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
In-Reply-To: <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 21 Oct 2022 22:03:33 +0300
Message-ID: <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 21, 2022 at 4:49 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 20. 10. 22 17:36, Amir Goldstein wrote:
> > NACK
> > this is not the only dependency
> > this is not a valid generic function.
> >
> > I only gave a recipe in v1 review how I think the checks should be done.
>
> I still want to make something that is easy to reuse in other fanotify
> tests. It doesn't have to be fully generic. If you want, I can add a
> list of manually validated init flags into the support check function
> and make the function terminate the program when somebody passes flags
> that haven't been validated. That'll ensure that the flag dependency
> list will be kept up to date.
>

I don't have a vision of what you are proposing.
Make a proposal and I will see if it is correct.

I must say I don't understand what it is that you are trying to improve.
All the test needs to know is if the specific combinations of flags that
the test uses are supported by the kernel/fs.

Trying to figure out which of the bits from a specific combination is
not supported? how does that help users?
Maybe in kernel 5.10 flag X is supported and in kernel 5.11 flag
Y is also supported, but only in kernel 5.12 the combination X | Y
is supported? Do you see why your generic function doesn't make
much sense? or is just too complex to be worth the trouble
for an informational print?

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
