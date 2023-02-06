Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E20C61DA4
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 05:37:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C4BA3CC23C
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 06:37:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D2D73CB170
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 06:36:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 42F3D1000524
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 06:36:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A3E03EEB5;
 Mon,  6 Feb 2023 05:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675661811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhd/tbh38fIXATTWujeUnIbfHwviS/7GmBuNlBPQQeQ=;
 b=yEy5mTfESkY5IXVpn9TCtmec0XfdxJD2cKj6NTtIT8SOpTkc3Ahe7BeRZdKbApa932qrer
 Hs/k3GVweVfP6l+u6fCdgCaVmfbt+mZW40YGVWJu1Qo+V5+pfuPocypqCACXJQWdoHx30D
 LtKmplQiC40Ehhc8VCiYRtMZOE9vIwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675661811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhd/tbh38fIXATTWujeUnIbfHwviS/7GmBuNlBPQQeQ=;
 b=GDxNwXO3tS+BwiEKw20iAzGg1lUFj+DpwkVa9N6XK0uLMkYmvT8/eAXVKR2bw62ExPtJKS
 ZsY2fCdrZ8aBTICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC9913A65;
 Mon,  6 Feb 2023 05:36:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HCCKCfOR4GMULgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 05:36:51 +0000
Date: Mon, 6 Feb 2023 06:36:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Y+CR8VDtE4CpmDAA@pevik>
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
 <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
 <Y9trG4QnXUEbhBbJ@pevik>
 <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
 <Y9tyNEspOUlHMOGU@pevik>
 <CAG4es9X=_vaE_3oX4JD598BNSX8RmQmAKVJS2kZdE1XzUjRu+A@mail.gmail.com>
 <Y9zfkeF3MdzMeizT@pevik> <Y9zhLO27YMWd6p6n@pevik>
 <CAG4es9Wy8pnEJqr2D2WvL=4kmP_JF+QTGVKYixCrBenv7Lg83A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9Wy8pnEJqr2D2WvL=4kmP_JF+QTGVKYixCrBenv7Lg83A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Hey Petr,

> We turned on the HAVE_CLOSE_RANGE flag to test the bionic-defined
> close_range on Android, but doing so bypasses tst_syscall in
> include/lapi/close_range.h.  We don't currently have a way to
> configure ltp differently across each kernel version, so I wanted to
> use this check as a fallback to gate earlier kernels.

Thanks for info. OK, at least it's needed :).
If these fixes would be needed for more syscalls, we might want to check if
there is a way to enhance tst_syscall() (likely there is no way).

Also (for next time) it's always safe to be more verbose for the reason in the
commit message to prevent cleanup of workarounds too early (before EOL of that
particular kernel).

Kind regards,
Petr

> Thanks,
> Edward


> On Fri, Feb 3, 2023 at 2:25 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi,

> > hm, I was too fast to merge it. Looking at older result,
> > It looks like this (merged as 7b5ee03899) was not needed,
> > because tst_syscall() properly detects missing support:

> > close_range01.c:134: TINFO: Plain close range
> > ../../../../include/lapi/close_range.h:25: TCONF: syscall(436) __NR_close_range not supported on your arch

> > @Edward: Before we revert it, did you encounter some problem that it's really
> > needed? If yes, please share details.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
