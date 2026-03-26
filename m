Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9E110A62DA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 180BF3CC1C5
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:10:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5ED3C572F
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:10:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D76ED14010E2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:10:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 230624D2B7;
 Thu, 26 Mar 2026 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774534199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVBhmHsS/Zq/c+++jGJVNVWfmLfMycvW7kENkUqMkD0=;
 b=onJ6Rmy7AMajjzlMZAhseqssZZRZf+xkJDE8ntVTjYSF8rTs2Vxo1Wp5VcmxXx+Peg13RN
 dc01OQ1m+X+NcwzPQ7WYG3DwRvOGOJ0OTw70Mov3zRjSsz2el+X+okee3bbw+vJXpv94V0
 hRnjWpJVk8ZQruXbZvsgHkkzW0CAM6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774534199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVBhmHsS/Zq/c+++jGJVNVWfmLfMycvW7kENkUqMkD0=;
 b=edDfRD4J0QLrNHwNwBmx5tWjU0OSK3WZPnPDCic1rRr9VUDMuIEQZGusctq4aBqL80BDSv
 SKj8fCdUwZomsCAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774534199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVBhmHsS/Zq/c+++jGJVNVWfmLfMycvW7kENkUqMkD0=;
 b=onJ6Rmy7AMajjzlMZAhseqssZZRZf+xkJDE8ntVTjYSF8rTs2Vxo1Wp5VcmxXx+Peg13RN
 dc01OQ1m+X+NcwzPQ7WYG3DwRvOGOJ0OTw70Mov3zRjSsz2el+X+okee3bbw+vJXpv94V0
 hRnjWpJVk8ZQruXbZvsgHkkzW0CAM6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774534199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVBhmHsS/Zq/c+++jGJVNVWfmLfMycvW7kENkUqMkD0=;
 b=edDfRD4J0QLrNHwNwBmx5tWjU0OSK3WZPnPDCic1rRr9VUDMuIEQZGusctq4aBqL80BDSv
 SKj8fCdUwZomsCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C0304A0A3;
 Thu, 26 Mar 2026 14:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 23d/ATc+xWm2EQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 14:09:59 +0000
Date: Thu, 26 Mar 2026 15:09:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <acU-LbVnVWoNwvwm@yuki.lan>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <aYWfNaJeXqut0Isb@redhat.com>
 <20260206082303.GA364017@pevik>
 <CAEemH2fDFBzoMvkZ_ZDPFCZVyMn2Dq0Ro6xBLTELRTK24Ey6eg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fDFBzoMvkZ_ZDPFCZVyMn2Dq0Ro6xBLTELRTK24Ey6eg@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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

Hi!
> > IMHO that's why ssh supports multiple '-v', e.g. '-v -v -v' or '-vvv'
> > instead of
> > -v2 or -v3).
> >
> > Anyway I'd prefer solving this somehow in the code so that users don't
> > have to
> > bother about log levels, but I have no idea how. Maybe yet another enum
> > tst_res_flags member? Because aa5a6fcdcd skipped messages, which are likely
> > useful when run by child process (the test), but not by library process.
> > And I
> > want to print message which is always run by library process. Maybe to
> > have some
> > #define in source code, which would force logging even for library
> > process? (not
> > sure what will be needed more often).
> >
> 
> This is something worth thinking about carefully, btw, next week is
> our spring festival hoday. I maybe reply you a bit later :).

Did we reach any conclusion here?

I think that we should implement different debug levels in LTP and drop
LTP_QUIET in the process. Does that sounds reasonable?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
