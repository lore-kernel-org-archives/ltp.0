Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802E6C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:00:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEAE33E2C2E
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:00:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1BB33E2642
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 10:00:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF3F21A00A28
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 10:00:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A9123E06;
 Fri,  7 Aug 2026 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786089600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox3qYHnccakB3wcUJGDQTEe5IY8wL4ytjtWbtxGGlTo=;
 b=dMXb24fzY8lnYtgdY7J9zDmN3oMIUyQFdKeqdIBWEIQcpy+H3sMLXAJPZqm/B/+ZomuFwi
 79p9ocvLQzIIYtPiRrYzhDVv5En6klpOVuMUV/75KWcRj35xBvlgd7UZd/X5gMhM56s8sH
 4mwwLUZEIF5xvSU9saK1Jo/bayTnOGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786089600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox3qYHnccakB3wcUJGDQTEe5IY8wL4ytjtWbtxGGlTo=;
 b=+zEO63gfFbypBgia1JxqAPF4fnBQLcLQZarpYH5Aq4q4hmQagkmo7joItuu/zmCPDCov2T
 K6GZTrsZVnBikoCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SOR2Sy1L;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5axNRpU8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786089596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox3qYHnccakB3wcUJGDQTEe5IY8wL4ytjtWbtxGGlTo=;
 b=SOR2Sy1LXrfQGRWz0OEL2ULdIM64csImR5FJg8rWTRKZiY3eo1Rz1v4kmpdI4tvEt3NqhE
 w34VLA1f1kENAkQiomPaVtquO/aCU25E3IRqiE6d+MAdtlr3K8m6WaI8K3gwWzszdzbQkQ
 EvzoNOgasANPDmiVTs9JSPD2tLHDOdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786089596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox3qYHnccakB3wcUJGDQTEe5IY8wL4ytjtWbtxGGlTo=;
 b=5axNRpU8N3StXPGv7JckHskzA68WZ4fI/VZoyUjzLO6OTOpK3Jaq2skgCGCW7cHUyENRwj
 lpLvzUPm+c/htICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C82B779B6;
 Fri,  7 Aug 2026 07:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vhK5EHyQdWq7MAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Aug 2026 07:59:56 +0000
Date: Fri, 7 Aug 2026 09:59:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <anWQedSd9MwlSymD@yuki.lan>
References: <anSMBJKH8bjhJcs5@rei>
 <6a7579d4.5dfca4bd.124bf4.ac84@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a7579d4.5dfca4bd.124bf4.ac84@mx.google.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,suse.cz:email,suse.cz:dkim,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5A9123E06
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] mremap04: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > +	 * Pass old_size of one page while the segment is two pages: the
> > > +	 * mismatch is intentional and must be preserved.
> > >  	 */
> > 
> > Wouldn't this be enough for the mremap() to fail even with regular
> > mmap()? I do not see what the test needs the sysv shm for.
> 
> actually yes, but I think the original idea was to mix SysV with mremap()
> syscall.

I would keep this test simple.

And we can add another test with a gap as well. If we map 3 pages, then
unmap page in the middle we will get:

| page 0 | hole | page 2 |

Now remap without MAYMOVE on page0 that spans into page2 will fail too.

> > Also the interaction between SysV shm and mremap() seems to be more
> > complicated and may warrant more tests.
> 
> mmmh, any idea?

Looking stack overflow mremap() should be strictly local to the process.
That means that that SysV mapping or MAP_SHARED mappings shouldn't
change the mapping length in other processes sharing the mapping.
Strangely there does not seem to be much documentation for this. So it's
a corner case worth exploring (raised more than 10 years ago
https://lwn.net/Articles/591985/).

Also while reading the manual I found another possible test for mremap()
+ userfaultfd(). You should get a fault event for expanded mappings if
you access the expanded region.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
