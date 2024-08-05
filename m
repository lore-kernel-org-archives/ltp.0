Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9522CC3DA4A
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 15:37:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7FA3D1FE3
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 17:37:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731F63CF4EC
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 17:36:46 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3E276233E9
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 17:36:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC8831F7E8;
 Mon,  5 Aug 2024 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722872205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHnJrdi56+Jmcq5Szlhvzme+4N//V95Ps8t0BzuMGHk=;
 b=VlF2cy0r5v4ImZ429tRCPFw5yGCaeRsIHqg9a633I+POu08Uu7/8jPWeWUPvsRjEhXkYnu
 aAUdREGcTYvt3pz48LbIuBgt5Onn4X/xiziPU8otkGjUi9zNbuzaxRyqKrzDRvFLuSfWff
 FIUH9rLYzum4enXfWUETIBAIS4VGgms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722872205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHnJrdi56+Jmcq5Szlhvzme+4N//V95Ps8t0BzuMGHk=;
 b=GAgjGL5zU7MdSAUe2ZN6eoz6UkhZKuDUF5k1SwuGiNJ96V5nngldsDLpUp3L2K0SlCHPlu
 smOoJP2jSGdBnbAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722872204;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHnJrdi56+Jmcq5Szlhvzme+4N//V95Ps8t0BzuMGHk=;
 b=zoxEhXS4NGhCm/m+mTBzIrlZPtmPKtzARUwZmy42KUWX11zFWGrUh8dkk/6hs95F8i/uMM
 vNTvyYZP20DlliLaOGl9kD4To8NewAjayKBUDDaeoZSxKChkq9/g1sW7VSGkezLnkphVW7
 J7E2/2oe91GH9GWTwxy5AVI1ofiEH3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722872204;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHnJrdi56+Jmcq5Szlhvzme+4N//V95Ps8t0BzuMGHk=;
 b=tckw6jT1BxHI4k+BmB+17qj35kXl5uTQB4TMoj5M1A4aliOcQBg5ARYlLJgK9hhm2tcV9B
 w68COMZc0cqvIyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEC0E13ACF;
 Mon,  5 Aug 2024 15:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3FuBLYzxsGaGYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Aug 2024 15:36:44 +0000
Date: Mon, 5 Aug 2024 17:36:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240805153643.GA27762@pevik>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
 <20240802-fchmodat2-v6-3-dcb0293979b3@suse.com>
 <20240802113032.GA1626431@pevik>
 <8984a9e6-6b13-4e34-a709-3d45202f03ad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8984a9e6-6b13-4e34-a709-3d45202f03ad@suse.com>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/5] Add fchmodat2 fallback definition
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

> On 8/2/24 13:30, Petr Vorel wrote:
> > Hi Andrea,


> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > >   include/lapi/stat.h | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> > > index 3606c9eb0..8e38ecfef 100644
> > > --- a/include/lapi/stat.h
> > > +++ b/include/lapi/stat.h
> > > @@ -229,4 +229,20 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
> > >   # define STATX_ATTR_VERITY	0x00100000
> > >   #endif
> > > +#define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
> > > +	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
> > > +
> > > +static inline int safe_fchmodat2(const char *file, const int lineno,
> > > +		int dfd, const char *filename, mode_t mode, int flags)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
> > > +	if (ret == -1)
> > > +		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
> > > +			__func__, dfd, filename, mode, flags);
> > I'm sorry, I overlook that errno check is not needed. tst_syscall() does it
> > (see include/lapi/syscalls.h). Please remove it before merge.

> > With this:
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr

> As far as I see, tst_syscall() only handles ENOSYS and invalid syscalls, so
> it makes sense to handle TBROK | TERRNO inside the safe_* function.

Yes, I'm sorry, I was wrong. But in that case handling ret < -1 is missing.
I have sent a patch fixing this.

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
