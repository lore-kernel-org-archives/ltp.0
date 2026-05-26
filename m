Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03683CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 14:16:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B47E53E62C1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 16:16:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7723C01A4
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:15:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76A411000223
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:15:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECF7E6B42E;
 Tue, 26 May 2026 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779804947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENsmGX48mjx8OrbpC/M99EAKCcgX4iXxACTKSo5TxOM=;
 b=AN6Go4du7xDUA1DM7L9KyQvRtx+ZT44TixDM+6np+riy1ybUc4GiP6St/NSFC2U0cTrdJQ
 8SnSZbO3N4xk/dinfpSEXHO/Y8Ad6lhF7SGl0bKbh4ocXf7T/wzmlbMf/+hcz7Sr5Sbfg0
 GqiqYju5Szzfj0WLDvP31tR9HUI8Gak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779804947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENsmGX48mjx8OrbpC/M99EAKCcgX4iXxACTKSo5TxOM=;
 b=YAZKaoI5cm9aVepNdG9em17OLq4PPuXzu6yTPoabQyDb3w7o2ZR3mevM8FKLoNjs6wTp3l
 9OhFQ4y8rUQ4LzBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AN6Go4du;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YAZKaoI5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779804947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENsmGX48mjx8OrbpC/M99EAKCcgX4iXxACTKSo5TxOM=;
 b=AN6Go4du7xDUA1DM7L9KyQvRtx+ZT44TixDM+6np+riy1ybUc4GiP6St/NSFC2U0cTrdJQ
 8SnSZbO3N4xk/dinfpSEXHO/Y8Ad6lhF7SGl0bKbh4ocXf7T/wzmlbMf/+hcz7Sr5Sbfg0
 GqiqYju5Szzfj0WLDvP31tR9HUI8Gak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779804947;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENsmGX48mjx8OrbpC/M99EAKCcgX4iXxACTKSo5TxOM=;
 b=YAZKaoI5cm9aVepNdG9em17OLq4PPuXzu6yTPoabQyDb3w7o2ZR3mevM8FKLoNjs6wTp3l
 9OhFQ4y8rUQ4LzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D01935A24A;
 Tue, 26 May 2026 14:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bvUZLxKrFWq0IgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 14:15:46 +0000
Date: Tue, 26 May 2026 16:15:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260526141545.GA176931@pevik>
References: <20260526083406.357092-1-chrubis@suse.cz>
 <20260526083406.357092-2-chrubis@suse.cz>
 <20260526133922.GB215060@pevik> <ahWn6zko0ktmS15V@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahWn6zko0ktmS15V@yuki.lan>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ECF7E6B42E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] safe_macros: Add SAFE_READ_ANY_EAGAIN
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
> > ...
> > > +/* supported values for safe_read() len_strict parameter */
> > Could we have kerneldoc (ok to fix before merge).

> > /**
> >  * enum safe_read_opts - supported values for safe_read() len_strict parameter */
> >  *
> >  * @SAFE_READ_ANY: no length strictness, short reads are ok.
> >  * @SAFE_READ_ALL: strict length, short reads trigger :c:enum:`TBROK <tst_res_flags>`.
> >  * @SAFE_READ_ANY_EAGAIN: converts EAGAIN to read that returns 0.
> >  */

> > Otherwise LGTM, thanks for spotting the error.

> I would avoid that for now, since we are likely going to change the API
> after the release. Is that okay?

Sure, I'm sorry I overlooked expected API change.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
