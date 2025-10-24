Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D8CCD1A5
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 08:16:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914EC3CF293
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 10:16:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 102F13CEF12
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 10:16:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E327600B7C
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 10:16:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 719802115D;
 Fri, 24 Oct 2025 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761293768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
 b=P3KNtUVe0ldSy98VSM78tDn84HB2P3mLf6OFCxxGmGZzmE6AxyQ5OJlIgQF68KBRTiD5LQ
 m8N3/y6RRFF0UwWegrrtiMB5fvVbatXWNC2jxe43dMoQ4We6FS94NkEXRc6XUc3mM2ViiS
 2OMdXbXTBu+Wb+w20Kc1aGroWXsp5tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761293768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
 b=gFE4XOXn9cXYTHuN8v6d1dMC+9tEnYU+VKr3dMyw6tgKU4YcOZm6AKLce668GR+WoNZQw2
 kRYYxH9hRNFNBVAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761293764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
 b=Se5jpWc2cAjwm0BK9VAslFH3u0dTHv0RliJcduVrRQ/y3nrEbMswBz0lz7b7C7Eg2yCW3w
 MU19J1edMKCoWf9+fUznlzLpmPtlK7nAshTGZhu/QawwJDNlG7YHVk3OHATRm5X9Qg7lII
 gOaJIDjYeJ7Q5Pc/UcNk4DD8KWe/Ifc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761293764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQDrtNvjKJr/WaX1Mv8sYjcgQzM/jpXVpNYnmYky8iM=;
 b=9ilVHeZAI6Ljz61brD4UoVTahQP8+0e2eJAStRvnh40t4t+dqvXglwqxraU6E3QWfnvyeh
 BgntVsYK1p7QUQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F411313693;
 Fri, 24 Oct 2025 08:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xsQdM8I1+2g8RwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Oct 2025 08:16:02 +0000
Date: Fri, 24 Oct 2025 10:15:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20251024081556.GA570960@pevik>
References: <20251023164401.302967-1-naresh.kamboju@linaro.org>
 <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY
 as valid errors
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
Cc: arnd@kernel.org, brauner@kernel.org, jack@suse.cz,
 regressions@lists.linux.dev, arnd@arndb.de, linux-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, ltp@lists.linux.it, benjamin.copeland@linaro.org,
 linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, lkft@linaro.org,
 dan.carpenter@linaro.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Thu, 23 Oct 2025 at 18:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> > Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
> > invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
> > test to accept both EINVAL and ENOTTY as valid errors to ensure
> > compatibility across different kernel versions.

I dared to add a commit which caused the change (found by Cyril Hrubis):
3c17001b21b9f ("pidfs: validate extensible ioctls")

and merged!

Thanks for fix and review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
