Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8D0D3B7F8
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 15:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8F043D02EB
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 16:52:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFE2F3D0295
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 16:52:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3470F6003CA
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 16:52:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D67A5BE32;
 Tue,  9 Dec 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C2433EA63;
 Tue,  9 Dec 2025 15:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4f4WGalFOGkmIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Dec 2025 15:52:09 +0000
Date: Tue, 9 Dec 2025 16:53:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aThF5PMjWqsLZsnp@yuki.lan>
References: <20251127143959.9416-1-wegao@suse.com>
 <20251209004242.31774-1-wegao@suse.com>
 <20251209111725.GA756311@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209111725.GA756311@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7D67A5BE32
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	uint32_t mnt_ns_fd;
> > +#else
> >  	uint32_t spare;
> > +#endif
> >  	uint64_t mnt_id;
> >  	uint64_t param;
> >  	uint64_t *mnt_ids;
> > @@ -73,12 +77,21 @@ static struct tcase {
> >  	{
> >  		.req_usage = 1,
> >  		.size = MNT_ID_REQ_SIZE_VER0,
> > +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > +		.mnt_ns_fd = -1,
> > +#else
> >  		.spare = -1,
> > +#endif
> >  		.mnt_id = LSMT_ROOT,
> >  		.mnt_ids = mnt_ids,
> >  		.nr_mnt_ids = MNT_SIZE,
> > +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > +		.exp_errno = EBADF,
> > +		.msg = "invalid mnt_id_req.mnt_ns_fd bad file descriptor",
> > +#else
> >  		.exp_errno = EINVAL,
> >  		.msg = "invalid mnt_id_req.spare",
> > +#endif

This is never going to work, how kernel interprets the value depends on
solely on the running kernel verision not on headers that were present
during the compilation.

What we need to do is to differentiate the expected errno based on
running kernel version.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
