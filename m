Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50FAC3ABC9
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 12:10:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FB833CC5D4
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 14:10:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE4E3CC505
 for <ltp@lists.linux.it>; Fri, 16 May 2025 14:09:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C67001400E70
 for <ltp@lists.linux.it>; Fri, 16 May 2025 14:09:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D1EA216D8;
 Fri, 16 May 2025 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747397385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbA2YXrA6ppFyMy/z+07YaPnxUQUzy8adgt19+puCGg=;
 b=AlNnuVpIDeO4zE7OHtmKJEDdDBNWmDN1wpOn7PkCPXwqVIgaXdJxu+u0GK/HUBiz+FDC2y
 7VCWpyRuqo5AOaqTguK/P8h/GQSmhfzZ/eGCSBgtRahbHgkrwuXe1RK+eITn2KuaFiYG2T
 J+Dz/Lp+1qDBxRKmoLSPIgxa12y8AYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747397385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbA2YXrA6ppFyMy/z+07YaPnxUQUzy8adgt19+puCGg=;
 b=PSq7MJERXSrC07RauQhoGcbQmEhVR8tL2m2AG6qma+wM06QVk9Ngj76ZuGl1ul9sDd6coA
 Rc7KFLb/644VIiDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747397385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbA2YXrA6ppFyMy/z+07YaPnxUQUzy8adgt19+puCGg=;
 b=AlNnuVpIDeO4zE7OHtmKJEDdDBNWmDN1wpOn7PkCPXwqVIgaXdJxu+u0GK/HUBiz+FDC2y
 7VCWpyRuqo5AOaqTguK/P8h/GQSmhfzZ/eGCSBgtRahbHgkrwuXe1RK+eITn2KuaFiYG2T
 J+Dz/Lp+1qDBxRKmoLSPIgxa12y8AYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747397385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbA2YXrA6ppFyMy/z+07YaPnxUQUzy8adgt19+puCGg=;
 b=PSq7MJERXSrC07RauQhoGcbQmEhVR8tL2m2AG6qma+wM06QVk9Ngj76ZuGl1ul9sDd6coA
 Rc7KFLb/644VIiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 242E313977;
 Fri, 16 May 2025 12:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eh8/BwkrJ2g/IgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 16 May 2025 12:09:45 +0000
Date: Fri, 16 May 2025 14:09:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mark Wielaard <mark@klomp.org>
Message-ID: <20250516120943.GA303097@pevik>
References: <20250516075113.522145-1-pvorel@suse.cz>
 <aCb7Pi6Vgkc8OMja@yuki.lan>
 <20250516093129.GG12775@gnu.wildebeest.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250516093129.GG12775@gnu.wildebeest.org>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] valgrind-announce: Update valgrind ML
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it,
 Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mark, Cyril, all,

> Hi,

> On Fri, May 16, 2025 at 10:45:50AM +0200, Cyril Hrubis wrote:
> > > valgrind-developers has heavy traffic, use valgrind-announce.

> > Was this requested by valgrind devs? I suppose this is fine as long as
> > we get their ack.

> I think valgrind-developers is a better place for announcing new
> versions of LTP.  We can then update our own valgrind testing.
> valgrind-announce is really for users when valgrind itself has a new
> release.

Sure, let's keep valgrind-developers. Thanks for feedback.

I would consider it disturbing for myself to need to subscribe on
valgrind-developers before the release and unsubscribe then, but
it's Cyril who is going to send the announcement mail anyway.

Kind regards,
Petr

> Cheers,

> Mark

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
