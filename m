Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB8C79F8B
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 13:51:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0D013C259D
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:51:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B16933C235D
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 14:51:12 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C597210005DB
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 14:51:11 +0100 (CET)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-55b265f5122so2565090e0c.1
 for <ltp@lists.linux.it>; Mon, 05 Jan 2026 05:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767621070; x=1768225870; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U9W5HdmDYsoECY1x8XuzaFB5JEeLzP3BCLGhFGddl78=;
 b=FR2hoxN6YfWR653NaXWwpkrnrBuV3CHi+/+I2HJwOFCAqdodcZCRCX/JTkGJ6IHjM+
 y0rWb2szCYvYXdLmHLEA//ILnvK4a6joL34lpNgp5UqsY8mKqFipxYXGwYvP78UComRF
 HHTeX+N+X0hSWO2Tt0GsvNFCovbKogLd0+7p3nOA7N+kh/NJSc4nvE6tn6SMeqveFCoA
 0E3E02Du/NQvG14anMVtsTKjLebBC7tzND0Eic1HPVYlrkhHZHwKTjbm9MMrR6GH7Mjw
 AFrPw3AiiVmcnIs879I387GVGAI1mZ5TDAkuUeuKTnIx1g9Y2fYMAMxdU0FJOE/z6eaS
 dOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767621070; x=1768225870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9W5HdmDYsoECY1x8XuzaFB5JEeLzP3BCLGhFGddl78=;
 b=YgBaN28IfKm0bF9Nq3A7gBG0rF4Sa9Au1kOmm7c1/l2P3uQBnd5pcK+fKkdysl4pQ3
 efBPkjU+ye/kTXtDvKuiegG9BEihUJHmCIeWPrN5BW2dmeXWZA7/K13gjb/yFXt3595O
 +fp78qUCNhOJDruGU4CFouhajPaf7qYFjllSz560XrluRqGHux2ZmitMKBxxq+/wDaji
 omSmXZbK7si2wNyaNMpN55n23BT/Ce5o5KoG3TsRkEv9FPjdfvJ2wQEG2fiMqhHosDsX
 +akcbekvpGNjyt5t7FPUFPsncSeQV5K2ESLcnj0ONoerct1W2EWbGOOmREWqnt2/bkXF
 ep+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvbvL2CDuqEtliWnd8+9qpr2KyxprX4263sHC5TXbXueYeUYsyqSqODU/GZHVgCEvamXA=@lists.linux.it
X-Gm-Message-State: AOJu0YxPhrqEpiJYgIkgITrwdXKvcDTrde73GAWl+fDJV/QxTKRFzyno
 Id/dMKHAqW+VfQb3O5j94CrpP3wfJHYuqSYxkKKYpXDDC3ZiswUlk1U2079UHmlPnYMwc1e4u1T
 jof601X6gmOa0yP11vjDieFyjyyIhGUEo+2sBxg0mgQ==
X-Gm-Gg: AY/fxX4PkMIXtl26Yd0rZLscvAXhvwQKlJqlRtEVlzGwTJ1Wr24eci0ajDdrEoylVFS
 C4NDXZAMvHCbwBYc9uZkOzHr5wueztyYTjxXztdrZCOrxTvt8AOrLzOUL7oi+NTOvaGy++6afrM
 Azweaqpw2Dd8fC3P2AomsUsdV3KWMV+ZcbyXe4n7K+9Zr7tAsasMzEwBVsORN1BaSG6aatiD8XR
 ngCxJ/Yu6I5FLG9pRX+1fgeBgWBVRp1yduToQnpKqYyVWknekfUbtdLIJWZlJEVbJ+Sbhg=
X-Google-Smtp-Source: AGHT+IHfkeKhRzMIgcWhotC+uLaOUhpwMJI9yGMOzarK9flpeWfqwYu3reoHqdaiYRJnZ/iN3Q5B+5tIvFm9LS/KGLE=
X-Received: by 2002:a05:6122:180d:b0:559:7294:da85 with SMTP id
 71dfb90a1353d-5615be31c9fmr13459524e0c.12.1767621068976; Mon, 05 Jan 2026
 05:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik> <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik> <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik> <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
In-Reply-To: <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Mon, 5 Jan 2026 13:50:58 +0000
X-Gm-Features: AQt7F2oAjLb2zwHIxJ7zk3knNSQtRg_hP8XcFHksKPXx2tLFQEUQXYBX2NU62O8
Message-ID: <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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

Hi,

> On Mon Dec 15, 2025 at 5:52 PM CET, Petr Vorel wrote:
> > > > And https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html.
> >
> > > > Yeah, I understand that. The dependency of CLONE_NEWUSER/CLONE_NEWPID is also
> > > > visible in kernel sources (e.g. fs/nsfs.c). But my question was different:
> > > > Do we now prefer everything kind of document with .needs_kconfigs, even it's
> > > > possible to detect it otherwise? (speed of parsing kconfig, kind of hard request
> > > > for kconfig being available even we can figure the support otherwise).
> >
> > > I believe we shouldn't see this as black/white but use this feature when
> > > it's really needed. This is the case.
> >
> > Sure, .needs_kconfigs is used when test request some functionality based on
> > kconfig.  But many tests use /proc or /sys based detection (e.g. ioctl_ns06.c)
> > or based on certain errno, see include/lapi/syscalls.h or
> > testcases/kernel/syscalls/fanotify/fanotify.h) because these were
> > added before LTP supported kconfig. Later, when kconfig was added it was
> > considering as a last resort (when there was no way to detect dependency
> > otherwise).
> >
> > Have we decide to move everything into kconfig?
> >
> > I'm not sure myself.  needs_kconfigs is simpler and obvious, but it requires
> > kernel config.  I suppose the speed of parsing config is not an issue.
> >
> > It'd be nice to mention the resolution (preferred vs. only if no other way to
> > detect the support) into
> > https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html
>
> Feel free to add this comment, but for me it's obvious that if a
> feature can't be present in the kernel due to kconfigs we should check
> kconfig :-)

I've just taken another look at this and it appears the test would still
fail if the config is not present or if KCONFIG_SKIP_CHECK is set, in
which case perhaps the run time detection may be preferred as it will
still work in these cases?

I'm not sure how common either of those cases are though?

Would it be better to have the run time detection in tst_kconfig_check
as a fall back in case the config is not present?
Then the tests can just define the needs_kconfigs and not have to worry
about other checks.

> > or into upcommig doc/developers/ground_rules.rst
> > https://patchwork.ozlabs.org/project/ltp/patch/20251215124404.16395-2-chrubis@suse.cz/
> >
> > Kind regards,
> > Petr
> >
> > > > And if we decide for forcing kconfig, we should update ioctl_ns06.c, which does
> > > > /proc based detection (i.e. to use the same approach).
> >
> > > I didn't check this, but I'm pretty sure we should go all around and
> > > verify many other tests with the same issue. We should do it in this
> > > patch-set or on a searate one.
> >
> >
> > > > Kind regards,
> > > > Petr
>
> So what we do with the patch? Should we merge it?

I'm happy to go through and update other tests in this patch or another.

Thanks
Terry

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
