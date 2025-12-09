Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F52D3B985
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 17:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83A163D0319
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 18:49:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 543AC3CBFDA
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 18:49:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFFDA1000937
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 18:49:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BBAC337E8;
 Tue,  9 Dec 2025 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765302549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aB1rt+VpW+uhD7mfJ+QdI/CPPpCBXx0h+npxvGxdm4=;
 b=qs7kjXxIIkBcP4Z29TPYPzRu15diY4NXzoNwARNy7+pryifTtWLevF/dq1dOV+w8wOlZK9
 h/xQdf4r6QuZqc1IKeg3AcLuVU6gRrC+EqwWA6wokpC8JyeJHPJRjS+4D+Dav0hoORKn4j
 o99O5IR3vzF45yNAUnmk2Bn5W4/hZic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765302549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aB1rt+VpW+uhD7mfJ+QdI/CPPpCBXx0h+npxvGxdm4=;
 b=IBSZPnBobVoFyn4bTFdlpjJVj+qKrlyj2i5sw53CWmSqno0ZR93EJw2+4HjEA9rYM971tn
 yKauSMOleO9lIYBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765302549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aB1rt+VpW+uhD7mfJ+QdI/CPPpCBXx0h+npxvGxdm4=;
 b=qs7kjXxIIkBcP4Z29TPYPzRu15diY4NXzoNwARNy7+pryifTtWLevF/dq1dOV+w8wOlZK9
 h/xQdf4r6QuZqc1IKeg3AcLuVU6gRrC+EqwWA6wokpC8JyeJHPJRjS+4D+Dav0hoORKn4j
 o99O5IR3vzF45yNAUnmk2Bn5W4/hZic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765302549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aB1rt+VpW+uhD7mfJ+QdI/CPPpCBXx0h+npxvGxdm4=;
 b=IBSZPnBobVoFyn4bTFdlpjJVj+qKrlyj2i5sw53CWmSqno0ZR93EJw2+4HjEA9rYM971tn
 yKauSMOleO9lIYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307233EA63;
 Tue,  9 Dec 2025 17:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bGbOCRVhOGmJDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 17:49:09 +0000
Date: Tue, 9 Dec 2025 18:49:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251209174907.GA9500@pevik>
References: <20251127143959.9416-1-wegao@suse.com>
 <20251209004242.31774-1-wegao@suse.com>
 <20251209111725.GA756311@pevik> <aThF5PMjWqsLZsnp@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aThF5PMjWqsLZsnp@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
> > > +	uint32_t mnt_ns_fd;
> > > +#else
> > >  	uint32_t spare;
> > > +#endif
> > >  	uint64_t mnt_id;
> > >  	uint64_t param;
> > >  	uint64_t *mnt_ids;
> > > @@ -73,12 +77,21 @@ static struct tcase {
> > >  	{
> > >  		.req_usage = 1,
> > >  		.size = MNT_ID_REQ_SIZE_VER0,
> > > +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > > +		.mnt_ns_fd = -1,
> > > +#else
> > >  		.spare = -1,
> > > +#endif
> > >  		.mnt_id = LSMT_ROOT,
> > >  		.mnt_ids = mnt_ids,
> > >  		.nr_mnt_ids = MNT_SIZE,
> > > +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > > +		.exp_errno = EBADF,
> > > +		.msg = "invalid mnt_id_req.mnt_ns_fd bad file descriptor",
> > > +#else
> > >  		.exp_errno = EINVAL,
> > >  		.msg = "invalid mnt_id_req.spare",
> > > +#endif

> This is never going to work, how kernel interprets the value depends on
> solely on the running kernel verision not on headers that were present
> during the compilation.

+1, I realized that myself as well.

> What we need to do is to differentiate the expected errno based on
> running kernel version.

Other option would be just accept both errnos (as kernel developers seem to be
not forcing us to be pedantic on kernel internals - recent swapon03.c rewrite
requirement). But lets use tst_kvercmp() to not delay the fix with more
discussion.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
