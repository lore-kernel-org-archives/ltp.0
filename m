Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2E9CCD192
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 13:47:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48C1D3CED0C
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 15:47:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05B403C840D
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 15:47:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3D0A1A000B3
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 15:47:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C2D83386F;
 Wed, 15 Oct 2025 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760536024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ej0kbRVcalL4QZU79W640CkCwxnVonzpyGR7aqzz9Bs=;
 b=tvx/GsL1SBdVbH/Zw8jG6tSKdgtzFh+0E+4uo5XVr+hyMlVY0jR6FrEdn8myHrSjxwYSHT
 v8S2u3TwgkezMPnyLRqNqXXXGLb7E5Ra/Wg5gwpyLoltM4+FI/ckNk+D1ZecpWPXoyq30v
 AVFluSuFIuAitNhzvj7FcnACbARWE+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760536024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ej0kbRVcalL4QZU79W640CkCwxnVonzpyGR7aqzz9Bs=;
 b=y/OIanhB4cIOyLHsKR7k+lrTLtbXQdBQJ50C5z0yGYlGmUaae1hc9OnmMP+TBAEqVePHSf
 PNuGYpdeqavAmmAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tvx/GsL1";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y/OIanhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760536024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ej0kbRVcalL4QZU79W640CkCwxnVonzpyGR7aqzz9Bs=;
 b=tvx/GsL1SBdVbH/Zw8jG6tSKdgtzFh+0E+4uo5XVr+hyMlVY0jR6FrEdn8myHrSjxwYSHT
 v8S2u3TwgkezMPnyLRqNqXXXGLb7E5Ra/Wg5gwpyLoltM4+FI/ckNk+D1ZecpWPXoyq30v
 AVFluSuFIuAitNhzvj7FcnACbARWE+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760536024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ej0kbRVcalL4QZU79W640CkCwxnVonzpyGR7aqzz9Bs=;
 b=y/OIanhB4cIOyLHsKR7k+lrTLtbXQdBQJ50C5z0yGYlGmUaae1hc9OnmMP+TBAEqVePHSf
 PNuGYpdeqavAmmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B49413A42;
 Wed, 15 Oct 2025 13:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7zFNGdil72gpXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Oct 2025 13:47:04 +0000
Date: Wed, 15 Oct 2025 15:47:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251015134702.GA220875@pevik>
References: <20251014145020.178840-1-pvorel@suse.cz>
 <aO99sW4_5_ntsHNr@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aO99sW4_5_ntsHNr@yuki.lan>
X-Rspamd-Queue-Id: 8C2D83386F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] doc: Convert tst_kvercmp.h to RST
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Could you please check my English.
> > @Cyril you're the author of the functions, please check my description.

Cyril, thanks a lot for a patient review and your points.

> Will do, btw some of the functions there are actually older than my
> involvement in LTP...
Lol :)

...
> > +/**
> > + * struct tst_kern_exv - describe vendor kernel.
> > + *
> > + * @dist_name: A distribution name, e.g. "SLES", "RHEL9", "UBUNTU"
> > + * @extra_ver: A vendor kernel version to check, e.g. "5.14.0-441".
> > + */
> >  struct tst_kern_exv {
> >  	char *dist_name;
> >  	char *extra_ver;
> >  };

> > +/**
> > + * tst_kvercmp2() - Compare given *distro* kernel version with the currently running kernel.
> > + *
> > + * @r1: Major kernel version.
> > + * @r2: Minor kernel version.
> > + * @r3: Kernel patch level.
> > + * @vers: struct tst_kern_exv.
>                                   ^
> The array has to be NULL dist_name terminated.

I don't understand "NULL dist_name". You mean array of NULL: { NULL, NULL}
Maybe say:
A NULL terminated array of struct tst_kern_exv.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
