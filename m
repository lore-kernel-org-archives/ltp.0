Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D356FC021AD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 04:12:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 166BC3C591E
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 05:12:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81BCB3C23F2
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 05:12:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07DE6101C5BB
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 05:12:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20F71210F6;
 Thu, 20 Feb 2025 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740024754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07McuQlGALdudEjSm6FVejAj5zBL43Je1C42umy1klE=;
 b=R1EyG96fkPlIvRTJQkxH0McD96lnEJuWJDabK9Bm9hw2PcCr1Ph67dR4Jr5j0lkw2cmnp/
 jiafCPrzIslG6HVPLGBr6fBl+B8ttIfALL0TTfD81CfjiNkoea/+zYlCG6MDdmjQ2XJ/3o
 mzUpUWccQ5Cii09hcrMIItY217cLq2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740024754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07McuQlGALdudEjSm6FVejAj5zBL43Je1C42umy1klE=;
 b=/hsXyQd+ajxNYsHQuI7YIAKs24EVaYqTZOvT9BifdugVO9E3TBUF2hNHLlp17XOA5hJrUD
 tkmI0l3hADbh4UAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740024753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07McuQlGALdudEjSm6FVejAj5zBL43Je1C42umy1klE=;
 b=sET8wNIZnk00jsPtYvjvbbCYnMRzTf9CPXA5fe471SgeA5ctHH2FvTolJ38vRyk9pGou9d
 ywL9QcHHXUZAJCaB2BXi5NEUN5qOuXg05g0gID9h1j1/nASIX8nvYXtojqzm+rYpNHdRdd
 gSo23tuHe8PUnFgh05BIKkgKmHXbBX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740024753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07McuQlGALdudEjSm6FVejAj5zBL43Je1C42umy1klE=;
 b=kGvdts2m9IbkuF72Pi5BTHpETo9Iq/mO1QKQUOFKLu94XDcN+XKXkGl4+iE50u/l4xfEuU
 nI0Uvlgoq6dPgMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 085701393C;
 Thu, 20 Feb 2025 04:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wxrEALGrtmdQFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 04:12:33 +0000
Date: Thu, 20 Feb 2025 05:12:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250220041227.GA2648636@pevik>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-4-jmoyer@redhat.com>
 <20250218125746.GC2469726@pevik>
 <x49frkbaupp.fsf@segfault.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49frkbaupp.fsf@segfault.usersys.redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] tst_find_backing_dev(): add support for
 overlayfs
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

Hi Jeff,
> > LGTM, thanks for a very nice work!

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > I'd prefer others have look into it before merging.

> Sure, any review is appreciated.

> > Again, I'll apply minor formatting changes before merge (using SAFE_STAT(),
> > moving else branch after break to it's own and checkpatch.pl fixes).

> It looks fine, but I will make a couple of observations.

> > @@ -634,11 +633,11 @@ static char *overlay_get_upperdir(char *mountpoint)
> >  			upperdir = calloc(optend - optstart + 1, 1);
> >  			memcpy(upperdir, optstart, optend - optstart);
> >  			break;
> > -		} else {
> > -			tst_brkm(TBROK, NULL,
> > -				 "mount point %s does not contain an upperdir",
> > -				 mountpoint);
> >  		}
> > +
> > +		tst_brkm(TBROK, NULL,
> > +			 "mount point %s does not contain an upperdir",
> > +			 mountpoint);

> This is technically different, but I don't think it matters.  All
> overlay mount points need an upperdir, so it is valid to error out here.

FYI my point here was to change:

if (...) {
	foo ...
	break;
} else {
	bar ...
}

to:

if (...) {
	foo ...
	break;
}

bar ...

(IMHO slightly readable + checkpatch.pl prefers it.)
Did I overlook something?

> >  	}
> >  	endmntent(mntf);

> > @@ -679,26 +678,21 @@ static char *overlay_get_upperdir(char *mountpoint)
> >   */
> >  static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
> >  {
> > -	int ret;
> >  	struct stat st;
> >  	char *mountpoint, *upperdir;

> >  	tst_resm(TINFO, "Use OVERLAYFS specific strategy");

> > -	ret = stat(tmp_path, &st);
> > -	if (ret)
> > -		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
> > +	SAFE_STAT(NULL, tmp_path, &st);

> Sorry for not using SAFE_STAT.  I don't know how I missed that.  Thanks
> again for the review and for fixing up these issues.

Nah, not a big deal. The patchset is very nice, thanks for that!

Kind regards,
Petr

> Cheers,
> Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
