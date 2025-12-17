Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469DCD65559
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 13:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69D093D03D7
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 14:16:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27B263D03BC
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 14:15:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 916B36008DC
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 14:15:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 829975BCF4;
 Wed, 17 Dec 2025 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765977340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4zBtBRUCm3+HYnqPfdvqcI+SjmaW6BXkOSe8YFuirw=;
 b=ymjxmOI/bhGyLJb4fUWiF5i7jOcWDarm61XZ2t/96SlMZsiXwO/Y5ZkiszKAs9jIM7eIdy
 2g37FWTvkd/AVd/9FMKynVZH2jN5HvFEK3gqiLwVcZWpCoh5iHU0VXflnpxGR7ZxAH8R81
 qNWqjyYfZg72/pnsKht+DScOasD+S5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765977340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4zBtBRUCm3+HYnqPfdvqcI+SjmaW6BXkOSe8YFuirw=;
 b=lRPzf/Gqyqk7vzWhdi4LJ58wsD1C3LTm6Zm+3GJOGzIhci4gBZp7BEwCjqBqWCXuXy1Ycf
 hr5jk/hwIlvCmWBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ymjxmOI/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="lRPzf/Gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765977340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4zBtBRUCm3+HYnqPfdvqcI+SjmaW6BXkOSe8YFuirw=;
 b=ymjxmOI/bhGyLJb4fUWiF5i7jOcWDarm61XZ2t/96SlMZsiXwO/Y5ZkiszKAs9jIM7eIdy
 2g37FWTvkd/AVd/9FMKynVZH2jN5HvFEK3gqiLwVcZWpCoh5iHU0VXflnpxGR7ZxAH8R81
 qNWqjyYfZg72/pnsKht+DScOasD+S5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765977340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4zBtBRUCm3+HYnqPfdvqcI+SjmaW6BXkOSe8YFuirw=;
 b=lRPzf/Gqyqk7vzWhdi4LJ58wsD1C3LTm6Zm+3GJOGzIhci4gBZp7BEwCjqBqWCXuXy1Ycf
 hr5jk/hwIlvCmWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E2A03EA63;
 Wed, 17 Dec 2025 13:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhXyFfysQmmFRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 13:15:40 +0000
Date: Wed, 17 Dec 2025 14:15:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251217131539.GA56642@pevik>
References: <20251212115244.2027-1-wegao@suse.com>
 <20251214021541.3256-1-wegao@suse.com> <aUJ4kiC86tdo9h3n@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aUJ4kiC86tdo9h3n@yuki.lan>
X-Rspamd-Queue-Id: 829975BCF4
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] listmount04.c: Update case support
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
> >  static void run(unsigned int n)
> >  {
> >  	struct tcase *tc = &tcases[n];
> > -	struct mnt_id_req *req = NULL;
> > +	mnt_id_req *req = NULL;
> > +
> > +	if (tc->kver && tc->kver != kver) {
> > +		tst_res(TCONF, "Skip the case that is not suitable for the current kernel version");

> I would shorten this message a bit "Test not suitable for current kernel version"


> Because the information that the test is skipped is already in the TCONF
> flag.

+1. I noticed that as well, just forget to point this out.

I modified the message and also rewrite commit message to get more info what was
needed to do.

Thanks you all, finally we have CI fixed (+ compilation of the package on various
distros) :).

> Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

@Cyril FYI: RBT should be on a separate line otherwise it's not added by
patchwork when applying the patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
