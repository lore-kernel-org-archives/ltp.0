Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8898BD5B17B
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:22:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D751F3D022E
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:22:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BD73C0B8E
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:22:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE5B0600758
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:22:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 971255BDCA;
 Mon, 15 Dec 2025 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765812139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hj4OGH1cD2SVb+nBQGkZfmJ0Vjq5T6i4isy+lzG4Q+k=;
 b=CXRhIIREq33nezEJfgOIzptY+3TGd1Cp8Ahb3iswga0YpuNlBmgmX+8/h/22ktVxPUcurp
 V7CudyX2VKqbFsWfZRRqS+mAzR/lbr6nz4jnz+03TN2lvoTIWsAvalZL1Pv9LcKEOAD8D2
 3xgYUyV6rQaMjxzFWNr582IpX+Q8+4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765812139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hj4OGH1cD2SVb+nBQGkZfmJ0Vjq5T6i4isy+lzG4Q+k=;
 b=HZYJ5OL/p/FiDqeYol3a9bL3j3HrYPL4Edd3FAzF+dGPwhdQg24OXCAoKKaStAgn7K3H8A
 Z/VCnq8TQrKXNBBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765812139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hj4OGH1cD2SVb+nBQGkZfmJ0Vjq5T6i4isy+lzG4Q+k=;
 b=CXRhIIREq33nezEJfgOIzptY+3TGd1Cp8Ahb3iswga0YpuNlBmgmX+8/h/22ktVxPUcurp
 V7CudyX2VKqbFsWfZRRqS+mAzR/lbr6nz4jnz+03TN2lvoTIWsAvalZL1Pv9LcKEOAD8D2
 3xgYUyV6rQaMjxzFWNr582IpX+Q8+4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765812139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hj4OGH1cD2SVb+nBQGkZfmJ0Vjq5T6i4isy+lzG4Q+k=;
 b=HZYJ5OL/p/FiDqeYol3a9bL3j3HrYPL4Edd3FAzF+dGPwhdQg24OXCAoKKaStAgn7K3H8A
 Z/VCnq8TQrKXNBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DD9D3EA63;
 Mon, 15 Dec 2025 15:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eMS0DaonQGk7UQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 15:22:18 +0000
Date: Mon, 15 Dec 2025 16:22:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251215152212.GB272695@pevik>
References: <20251211015915.1086-1-wegao@suse.com>
 <20251212115244.2027-1-wegao@suse.com>
 <20251212122827.GC125889@pevik> <aTwREz2-YroAAyl_@yuki.lan>
 <20251212142045.GD125889@pevik> <20251212151156.GF125889@pevik>
 <aT4Yus2DHhcH4nCZ@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aT4Yus2DHhcH4nCZ@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] listmount04.c: Update case support
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

Hi Wei,

...
> >  static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
> >  			 uint64_t list[], size_t num, unsigned int flags)
> >  {
> > -	struct mnt_id_req req = {
> > -		.size = MNT_ID_REQ_SIZE_VER0,
> > -		.mnt_id = mnt_id,
> > -		.param = last_mnt_id,
> > -	};
> > +	mnt_id_req *req = NULL;
> > +	req->size = MNT_ID_REQ_SIZE_VER0;
> > +	req->mnt_id = mnt_id;
> > +	req->param = last_mnt_id;

> >  	return tst_syscall(__NR_listmount, &req, list, num, flags);
> Thanks for such detail feedback, will sent next patch.
> I guess we need s/&req/req/,
> or i think simple s/struct mnt_id_req/mnt_id_req/ more better.

Sure, just remove "struct" is way better, thanks!

Kind regards,
Petr

> >  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
