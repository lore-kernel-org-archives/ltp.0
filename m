Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68713C433EF
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 19:02:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6E860F92
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 19:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A6E860F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E89C3C9644
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 21:02:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5DE33C8CB6
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 21:02:17 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B4B001A010F3
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 21:02:16 +0200 (CEST)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Ma1wY-1mIunr3kWK-00VuGX for <ltp@lists.linux.it>; Mon, 27 Sep 2021
 21:02:15 +0200
Received: by mail-wm1-f43.google.com with SMTP id
 z184-20020a1c7ec1000000b003065f0bc631so1497601wmc.0
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 12:02:15 -0700 (PDT)
X-Gm-Message-State: AOAM532giiF/a+n2BmUwUbnEIXY7vIzhc8YTOLS6ffIqmmPxqazLXRH4
 NuBSdtE0FZyx6PGSITg3j8dGdxz0jCzBNJ0ZBT0=
X-Google-Smtp-Source: ABdhPJy79GvrLbGbTQ8AFXTHbME27yck4aLAU/Tyk7Yz+HgqfmX9UVGglkndMij2PPstBo5KAXPiu0yRr6boGHxrkfU=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr701388wmc.98.1632769335470;
 Mon, 27 Sep 2021 12:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210927161955.28494-1-rpalethorpe@suse.com>
 <875yuletsw.fsf@oldenburg.str.redhat.com>
In-Reply-To: <875yuletsw.fsf@oldenburg.str.redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Sep 2021 21:01:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3o96yR4LBSv8Q-_oy0g3hULS_kcm2fpahjEvqB6i_EuQ@mail.gmail.com>
Message-ID: <CAK8P3a3o96yR4LBSv8Q-_oy0g3hULS_kcm2fpahjEvqB6i_EuQ@mail.gmail.com>
To: Florian Weimer <fweimer@redhat.com>
X-Provags-ID: V03:K1:NoJbvFBc6s0hXF7mz3UVMqb9SF9Sdb4ZB+AZXb5X00H7pPc1t+5
 Cyggq+EhTVcwHa2UtyY18IDW8dBFRpccIUPTEh4ZGm+nfgD+b4Pam9AG24CH8MCawFzB2Ck
 /l7UZEYovvUFLvvkB1Ms6OL5JBuZukaPncVuMCXNs7/4WdWungNIhvzXHXfzSH8lI/BCMPB
 +RckQxxtVWfbP4EfAF0Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yYGTjEN+rEM=:wrxjKGMGrN8ahIHbFfxLM5
 mZIBPQiOxcCSE6X+n+8skBtDumnmgD5eYg1SL1k3WfKjqaNQRMic3WfidAXg8X5lk6F+Tfz0B
 wMAUoorkttKKQE911NG/j1jUKM+Wi1WA/xQ6GUGgp9AnD6hasNZ4H1E3ZttelWC2CspVTt1/R
 JD2sXsepnLvk9978h32XY+gPv/KH8I8d8dtg/K/xTjEIATdnB/jBWz5Hy1KnfLA3xh+ptaGxL
 nRM4x3AuSp6U2PiFMvUmERdeyx84z7vMd/i9VNqWNu6av9QR6lAi045awGg3g+xY/tRKgd7eY
 PcezJISRXasA7xjOTuE9hswbBo9pXfns+h2wSBBeIeZKwunNpEFcGp/0H5bLw/ho7YZbXpjoU
 D+qd6Tj8ASSkjY+XC3cITdsUJ6RK1D+wJDBymT/yUFHBLcN+TkA7/GtmOE866h+ARdgzNDRxI
 +aOuFnTm4YdvuC6v2SxhO7BDxYjf9UNSsFT8oxwkHdHlxGVwjrpWyLofidpEsQJ4HDZVKEYL6
 d1VPP2sXrx3kw1Onw3tvrZMEEtKj3f1goFUTWmBuffQBk/bP2UTY0XsOkMYVICO863Mr3sVq+
 1N9J1mxanEhqsC87s430Bj89HXXybq8JiVaD7E0WgtgPpuBvUiGR4qPUQLRiaY0PpTACuy8DY
 ZzRx6KjRopXJtme0MfRZbQIvGNQOGP9ypSwJglkatPScGXItzmM9zFuQ9CmBUJvxHCc9gUsZm
 kl5MJKqGpSG/t3wQBBrEiSqeQTdw5hjfQ5t5+kq6F3pHOXRL/B0njqxytuWc+ocbtMFbmTdTF
 1p+y0/Mu98YKbEF1VCOavVJlpjw8Jsl+rFny6JBa4YYI0kclJ+nB+pHLzlzay+SFyXH4pOSKe
 FfS4fKGI74SgCeNi/87g==
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
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 27, 2021 at 8:51 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Richard Palethorpe:
>
> > +#define __SC_COMPAT_CAST(t, a)                                               \
> > +     (__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))        \
> > +     (unsigned int)a
>
> So this casts to int (triggering sign extension) if the type on the
> 64-bit kernel side is long?  But not in other cases (unsigned long,
> pointer)?  Just double-checking.

Correct, this is the only case that is not already handled: anything smaller
than a 'long' is the same size on all architectures we support and we
ensure those are correctly sign- or zero-extended. 'unsigned long'
and any pointer are zero-extended by the entry code from 32-bit user
space to a 64-bit register in the kernel. Only signed 'long' requires
explicit sign-extending from the userspace 'long' to the kernel function
argument.

         Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
