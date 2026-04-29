Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E8CFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:51:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 484433E2D48
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:51:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C1ED3CA104
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:50:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DE801400205
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:50:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 244615BD4E;
 Wed, 29 Apr 2026 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777449044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crJSylargaY81SGrisFb9v708uGW40B1M45Xb/hO8rM=;
 b=SqZ8EIwH+NizIaE2M0gQCryDzeo9vRVe63NuaxyXGa/Xflm/5+bEfAl+p7QeuH17kHP+2+
 5zlal5cFNiAntgd0eHv8cdEdeEKKbM6b3bswWVSIOD5c04lGZTuoS6ug0co0ZuglLaSgLP
 WPg8wmu14bAZJSnZlsrvdXaxoGHMXZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777449044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crJSylargaY81SGrisFb9v708uGW40B1M45Xb/hO8rM=;
 b=7PqJk+XmHPnF8OCgz8H+3OzNVrz0Z55YNl5qHVOIuDkeW+QF2E8/M7T1RHh4nXK076kbV4
 m2XiCDa/asOV5fAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3VCPQNwG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="//YM5sKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777449043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crJSylargaY81SGrisFb9v708uGW40B1M45Xb/hO8rM=;
 b=3VCPQNwGCObLOMD+ywSNIxMh8ztQet66Ur8IX3PGaSu2qMoEv0VWnsUEPYQIqI7ImgQ1Jk
 iRceN8VLaLxzuYEVlER2DNtGDGekgRNs0QueReJMjy3lzHCwgdjwH/ZNqpc84gmpvTrAeT
 BinJAdV5fzIW+L48CRWNKvqdl1WZe30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777449043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crJSylargaY81SGrisFb9v708uGW40B1M45Xb/hO8rM=;
 b=//YM5sKlwsBeod081fZlRoM8ExKGjkck0HbPOeGVEb1XTTLbX5tizhbfsnrTC7UhJKCxnS
 ymJbNc2AkQ5Bu+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E643F593B0;
 Wed, 29 Apr 2026 07:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E03LNlK48WkKJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 07:50:42 +0000
Date: Wed, 29 Apr 2026 09:50:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260429075029.GA968839@pevik>
References: <20260331-clock_settime_fix-v2-1-e222fe379b16@suse.com>
 <acvWwBNhJ5b8A7r2@rei.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acvWwBNhJ5b8A7r2@rei.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_DN_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 244615BD4E
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_settime: Detect external clock
 adjustments via CLOCK_MONOTONIC
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
Cc: Claude <noreply@anthropic.com>, Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > These tests manipulate CLOCK_REALTIME to verify timer and
> > clock_nanosleep behavior, but NTP or VM time sync can also adjust
> > CLOCK_REALTIME during the test, causing timers to fire at wrong times
> > and producing spurious failures.

> > Use CLOCK_MONOTONIC as a sideband check to detect external interference.
> > If the monotonic elapsed time is anomalous, report UNTESTED instead of
> > a false FAIL. Guard the checks with _POSIX_MONOTONIC_CLOCK since
> > CLOCK_MONOTONIC is optional in POSIX.1-2001.

> Maybe we can retry a few times before we give up and report untested?

+1.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
