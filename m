Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55E5ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:31:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73DFA3CA15C
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 18:31:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7033C4D7B
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 18:31:07 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 257B2140098D
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 18:31:07 +0200 (CEST)
Received: by mail-vs1-xe33.google.com with SMTP id q127so3520726vsa.7
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kNuBpC5OQJn05F5D1MBTU0zkGVwj91545QeBDqWnUuQ=;
 b=NnKAXq/guC8bUVWCpiWAjQYzAFs32lCQpG/jE/CePUa7SpQV8SKanhOhpu/qMcykqE
 PLH6l0NAn/2woSBm+/EFv44cZqZdA3+un3GeLa94sUDBtum4G4QlDcDRA0NkzdCraFMN
 qB3bA1FprxRi0hDCahbwupLLKepJR9psx7986RX9+NWI5uFYyPc0DcUIFmU4uRl43SUk
 fZRB8zaDz4Bmcrrk8qRvHDT54nwChSVL190m9XC/T244JTOTY0PIXquHKkykzQvLnahA
 m5DJWmPiAmgNC+uHn6rcH9HXltOIpOutHYMdhoR1ShMPAFRr+ludkJR5g4vtpDGPKpTJ
 Vagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNuBpC5OQJn05F5D1MBTU0zkGVwj91545QeBDqWnUuQ=;
 b=Ekg/qPDl5bL0+JHGRknJhmcFNl9TgkFRbMGn98HjfuO96nuUorfW6vfj8crc/ZNNRe
 HHmvfCRaoZoXvhdiKiAlxUSgSnAgvH+pXARvuMBebMmU5nBol5q+WPf+9YZkuyv10QVb
 t9mNoOdTX8RmPNBYc13x/dlJE6SZKctTk9zvVbZ6SN4kXxGOwTalR9BWRTmK9Bf6kyNS
 J3wEwwIbKnsYb6Dz4wV7p8p9L0w7xmeWHWcHJkqKVaYQkn8wXVuR+PhN8M8nXiS+C0/b
 dZsGMfrKH2uuKOFtYlO5uzeQy9eA/CLbi+akT9EHDlCebTvvhLnXestROcYLn3ZbI/SR
 cvwA==
X-Gm-Message-State: ACrzQf1h8eufnfVnDRG79bnU98gu03c7W88pQfclhC6vqljk3Dx70LNK
 2PqbhQWMYRZ9nzKitcXwV/4Z9ThaYtjTvLtmM/s=
X-Google-Smtp-Source: AMsMyM7Re37dXC3/AtuGjkD0mkW5PgnICG4ceKRdIOV0sm2oE+Bu9rzaJATbDoToy99XNUj6bqNaEj7KKq21YCl4JT0=
X-Received: by 2002:a05:6102:3754:b0:3a7:92f9:a9b1 with SMTP id
 u20-20020a056102375400b003a792f9a9b1mr17702182vst.72.1666629065882; Mon, 24
 Oct 2022 09:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz> <Y1a6NXkayyy7esM+@pevik>
In-Reply-To: <Y1a6NXkayyy7esM+@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Oct 2022 19:30:54 +0300
Message-ID: <CAOQ4uxjGGxaa=snebi0wPnPWuFHgQ-9Mt9hPBr3wBAghGQQEJA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 24, 2022 at 7:15 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> > On 24. 10. 22 16:34, Amir Goldstein wrote:
> > > This is how I would fix the problem:
>
> > > <snip>
>
> > > Give or take using more macros and your nicer flag prints.
> > > There is no need for auto-detection of the unsupported kernel flags.
>
> > > If the test case is expected to get to fanotify_mark() (i.e. non-zero tc->mask)
> > > EINVAL from fanotify_init() always means "unsupported".
>
> > This would be a good approach if fanotify_init() returned distinct error
> > code for "flag not implemented", like ENOTSUP. But when EINVAL is returned
> > for both "not implemented" and "wrong use", this has a risk of hiding real
> > bugs. That's why I'm trying to detect the actual set of flags implemented in
> > the running kernel before running the real tests.
> Indeed, that's quite surprising (not really, it was added in 2.6.36 and remember
> Jan Kara's talk about dnotify/inotify/fanotify history). I wonder if it's
> possible to fix (backward compatibility would suffer).
>

The kernel UAPI is not very consistent about ENOTSUP vs. EINVAL
renameat(2), unlink(2), link(2) and other return EINVAL for unsupported flags
fallocate(2), ioctl(2) and others return ENOTSUP for unsupported commands.
It's not a clear cut, but ENOTSUP is generally for unsupported fs methods,
not for unsupported options.

> > And since some flags may be backported to older kernels, generating feature
> > sets based on kernel version is not a solution.
> I guess even some not-important fix was not backported. I guess features aren't
> backported to the stable kernel maybe to enterprise kernels (SLES, RHEL), but
> even there I'd guess there are related patches backported, not features. But
> maybe I'm wrong. Jan and Amir?
>

I am fine with writing tests that are friendly to distros that want to backport
features, that is not what my complaint is about.
As I wrote to Martin, I will accept any imaginary kernel as an example
for why the test is wrong for that kernel, but I don't see the bug.

The desire to distinguish between "this kernel should support
these init flags but failed" and "this kernel does not support those init flags"
is not realistic, given that fanotify_init() return codes do not
distinguish between those two cases.

The suggested logic to work this out by testing flag by flags is faulty
because of current and future flag dependencies.

So show me a real bug, as Martin did, and we will fix it.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
