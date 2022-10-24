Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC902C38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:18:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 381EE3C9882
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 18:18:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C6463C8F82
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 18:18:33 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9651F1400986
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 18:18:32 +0200 (CEST)
Received: by mail-vs1-xe2f.google.com with SMTP id d187so8364836vsd.6
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=34TUr32o/rOxqqT0t8ohaTBkyr/4yOnoxp6YIqrPceA=;
 b=ib92OkzJ2ctfnaOXKBCzS9tWyMzmgjcY1mqVb6xcB1jsym4jgtjGOfxQz+qfWQJvDv
 lhyLS6z4ggS8rJxb+D56Wy3/UWoqXBuloXDX2rZc+83VCP/Mxw2SjhiF+jsFJDAE1QRP
 kxT26yjiFXByEsxI4L4b1T4filZZi+UYQ/xoaZXyVmuT2PNUFUnVCec3UoWLclOCs/gr
 CK/DB6h2M+SMohkYcOuxSb8orrzhsuyFJFX1QexgCX2ZEhSpHQd7yWtRtYAaO2KCW1F0
 81XV0nvWcaZis6UbpJb7T5zrYbSP7wiY5miPREb/24duxbDQj37sK5DEM3sqXi5Ry79R
 07Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=34TUr32o/rOxqqT0t8ohaTBkyr/4yOnoxp6YIqrPceA=;
 b=HnBTkDu92vgxyN2JUfdzmflsYBnsVCFIeUhlaHjOff3ZF+KMMes+xWxPeuUq454egi
 td0wAgdUNp91qk3bKSsbkkMTBL+7c7IGqIgHopSnKt1dhbdAysMK00yweYCI6sibhGue
 Bw9CZil3Io/d1fxWsn+16ykVnf+/lni1lM+MmOgF06JCJVP2h9HtQ6//aYTXlXpxp68X
 CXCE6tptxP3Z7lulLa1z/WreoUaN8WNFU4pPcE+q9ER9CdCvHxZO5r9oIU2tbRG5EjO9
 QZb4kQy3d87F0xc4JxfCx5cTXk6xtYeTuhIs3tlRz0BIZlHeV6RpuZzhMH+L5P0KDm60
 f5zQ==
X-Gm-Message-State: ACrzQf0d9MTf3mCvdnRUIpFTtEShBZc6iNAKXEv8Kv+mxi7vnfh6/U7i
 wbEQbtUcXS3W5qQbxo0L60JJxKjuGCEOO4p/60Y=
X-Google-Smtp-Source: AMsMyM5sjeI4uc0xypnE/SI+z5WvSEj/d6+iu5LNLuZQY4Qq6duXnxopvVpDcPAQDjRLER/KLNwIeTB4Xe9K47lBSRQ=
X-Received: by 2002:a67:c099:0:b0:39b:342:3c0d with SMTP id
 x25-20020a67c099000000b0039b03423c0dmr19903169vsi.3.1666628309120; Mon, 24
 Oct 2022 09:18:29 -0700 (PDT)
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
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
In-Reply-To: <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Oct 2022 19:18:17 +0300
Message-ID: <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 24, 2022 at 5:58 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 24. 10. 22 16:34, Amir Goldstein wrote:
> > This is how I would fix the problem:
> >
> > <snip>
> >
> > Give or take using more macros and your nicer flag prints.
> > There is no need for auto-detection of the unsupported kernel flags.
> >
> > If the test case is expected to get to fanotify_mark() (i.e. non-zero tc->mask)
> > EINVAL from fanotify_init() always means "unsupported".
>
> This would be a good approach if fanotify_init() returned distinct error
> code for "flag not implemented", like ENOTSUP. But when EINVAL is
> returned for both "not implemented" and "wrong use", this has a risk of
> hiding real bugs.

Show me how this could hide a real bug.
Give an example.
It does not need to be a specific kernel
use an example with imaginary kernel with a backported feature if you like.

fanotify14 is not about making sure that flag combinations are allowed
it is about making sure that flag combinations are not allowed.

If the test case is testing illegal init flags, the outcome must be
fanotify_init
EINVAL.

If the test case is testing illegal mark flags, the outcome of fanotify_init
may be EINVAL meaning that this test case will be skipped.
It does not matter which specific init flag or init flag combination
causes this EINVAL.

I am ready to be proven wrong, but with examples,
like the one you provided with test case #8 and kernel 5.3.
hand waving and talking about vague "real bugs" won't convince me.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
