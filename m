Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1592CA5FA7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:00:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B4653E9F72
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 18:00:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE87E3E5879
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:59:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9AE731400059
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:59:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B929F21BE0;
 Tue, 29 Sep 2026 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790697581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRj6KzuHPTvTbWn2NYO2HL3SWuCYinJVwFlJGiTm2XY=;
 b=Mi3slMbEFhSyB4KMX1DaHL59NQE+Ue7g/67GYlORFjOUEom+MUQ+B4ee9tJv58/jw5xNrS
 YY1Vql2jbGDrW0gcaEc19E6aSxE+babaGYWEWhD0h9MFv2OZZh1gG6k/GXPXYRkAbAY07J
 K9l1FhCz/PIxZHmtGHSIM4xL3ffb0n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790697581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRj6KzuHPTvTbWn2NYO2HL3SWuCYinJVwFlJGiTm2XY=;
 b=YZfCVrc4KaPm+vtrvdvz+guYjN/3qhxxGmV9+eM/V58SIk3tddvinka078C+wbCJxwCxuE
 cRedgc60l9hH+iCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790697577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRj6KzuHPTvTbWn2NYO2HL3SWuCYinJVwFlJGiTm2XY=;
 b=u5tu5q3Y3N2lEvqNGoIPB/gy/Zo8ODvaijGt8fT6LAgPGZfeLuCNhDa3DcL6aKd7bFAbqp
 9ag3zDMk5Gd9jzlZJLss4WObwMxpYiR+ZG8gKms87ZnoqMo2G15Qy76cfmZxrs3hq6H6jD
 qJv9yqPSgGT+wRmMti7gs/PgzzIcMCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790697577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRj6KzuHPTvTbWn2NYO2HL3SWuCYinJVwFlJGiTm2XY=;
 b=qhkGdMB6kdIwxyR3KswgWwokPD/iSNYBBZ4/si8UKuzPKht+DvNeX4o5JsL9GNwmKdmfn2
 3iq3OlXKUFKdpmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA0D613777;
 Tue, 29 Sep 2026 15:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DuDYKmjgu2q/QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 15:59:36 +0000
Date: Tue, 29 Sep 2026 17:59:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260929155935.GB2614679@pevik>
References: <20260929141659.2513510-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929141659.2513510-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:email,linaro.org:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi: Update syscalls numbers to v7.3-rc5
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Updating syscalls should help fixing issue with sparc not working on
> tst_clone().

> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> It should be safe, but do we dare to merge before LTP release?

> This tries to avoid workaround for sparc()
> https://patchwork.kernel.org/project/ltp/patch/20260929084253.3093742-1-anders.roxell@linaro.org/
> https://lore.kernel.org/ltp/20260929084253.3093742-1-anders.roxell@linaro.org/

>  include/lapi/syscalls/arc.in         |   3 +
>  include/lapi/syscalls/arm.in         |   4 +-
>  include/lapi/syscalls/arm64.in       |   3 +
>  include/lapi/syscalls/i386.in        |   4 +-
>  include/lapi/syscalls/loongarch64.in |   3 +
>  include/lapi/syscalls/mips64.in      |   5 +-
>  include/lapi/syscalls/mips64n32.in   |   5 +-
>  include/lapi/syscalls/mipso32.in     |   5 +-
>  include/lapi/syscalls/parisc.in      |   4 +-
>  include/lapi/syscalls/powerpc.in     |   4 +-
>  include/lapi/syscalls/powerpc64.in   |   4 +-
>  include/lapi/syscalls/s390.in        | 103 +++++++--------------------

Hm, this removes s390 31 bit support, which was removed in v6.19-rc1
8e0b986c59c67 ("s390: Remove compat support")

Quoting the commit message, it gives me confidence, that nobody will miss these
syscall numbers. But I should note that into the commit message.

Kind regards,
Petr

	There shouldn't be any 31 bit code around anymore that matters.
	Remove the compat layer support required to run 31 bit code.

	Reason for removal is code simplification and reduced test effort.

	Note that this comes without any deprecation warnings added to config
	options, or kernel messages, since most likely those would be ignored
	anyway.

	If it turns out there is still a reason to keep the compat layer this
	can be reverted at any time in the future.

>  include/lapi/syscalls/s390x.in       |   5 +-
>  include/lapi/syscalls/sh.in          |   4 +-
>  include/lapi/syscalls/sparc.in       |   5 +-
>  include/lapi/syscalls/sparc64.in     |   5 +-
>  include/lapi/syscalls/x86_64.in      |   5 +-
>  17 files changed, 77 insertions(+), 94 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
