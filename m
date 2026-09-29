Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE4FCA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 12:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8073D3E57BE
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:16:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 874493E57BC
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 14:16:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 042A51400F2A
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 14:16:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D06121B5C;
 Tue, 29 Sep 2026 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790684183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2XIMdctwHphAAeHFVWXPp46dJPF2omeg6yxRrVzgug=;
 b=bPBC/w7zj3U2QZBIa5Y8mzbGLd0Aml/9+sLDAx3EIdo4cWlToSpPnSaiRWBzet5M0KxJXk
 vn6ImuGFmK13hPhdNURNkO/6uVFJ6dBt74ir5N81IBVNMyjbSi89eAS8yvLyAGUA3zN3U5
 +QeSb+swhjvx/0z013AXE0DDjvs3sKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790684183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2XIMdctwHphAAeHFVWXPp46dJPF2omeg6yxRrVzgug=;
 b=tz4wzfDJ0ivJSt4IyxEIModgJHeptle/PEqTHBCOcHiR7n7DAdewdt5gYb64Mnfb+2Z9B6
 drVmQvqSoxItp8BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pz1cfiiL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QlPFgqNv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790684179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2XIMdctwHphAAeHFVWXPp46dJPF2omeg6yxRrVzgug=;
 b=pz1cfiiLQT/YPXPuUNE87XlBuHTIZJATb7iY4Q+nRH7ZHRT+V6yLDtwTU82v4O0NdCsI6t
 czDG8m187b3Qqdme7HCLZeMtJ98i+SJhYHpUzkcVlm74VtuXLto3V/onidfdOzdsa9WMkq
 5HWKHRFBFO9f3YiWbOkc0FYQOvKolwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790684179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2XIMdctwHphAAeHFVWXPp46dJPF2omeg6yxRrVzgug=;
 b=QlPFgqNvUYQSDLA+F+UzVzxjoSZ/JNklflBOkjmFu2TjuOxcYzu0vjrx4z7GHrPq3MWfLX
 LzDA55NHpn+QLgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B60A7136E4;
 Tue, 29 Sep 2026 12:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cemUHhKsu2o1SwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 12:16:18 +0000
Date: Tue, 29 Sep 2026 14:16:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260929121613.GA2462033@pevik>
References: <20260808150331.127440-1-avinesh.kumar@suse.com>
 <20260929114945.GA2456273@pevik> <aruobnaT_g0U7CDo@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aruobnaT_g0U7CDo@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7D06121B5C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: timer_*/speculative: Handle SIGSEGV
 on invalid timer ID
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

Hi Cyril,

> Hi!
> > I'm not sure if the approach of creating bogus timer_t is a good idea anyway.
> > Shouldn't be just some timer_t tid set to invalid value? That would IMHO be
> > less awkward solution.

> There is no documented invalid value. It's a opaque handle we get from
> libc and different versions of libc interpret the value differently.
> Sometimes it's a pointer, sometimes it is not and we have no idea what
> it is until we try to pass it to the timer functions.

> So choosing safe enough safe value and handling SIGSEGV is probably the
> best we can do.

Thanks for correcting me, fair enough. I guess we don't bother with factoring
out function into include/.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Will you add your RBT/ABT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
