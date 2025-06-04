Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4027C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 11:59:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 415673CA155
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 13:59:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8441B3CA0B7
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 13:59:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FBA12009A5
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 13:59:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A9BB1FE49;
 Wed,  4 Jun 2025 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749038341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lr/4doJzOTv3ensyuRSp4lSw/Oxal19O9/J+q+0m95g=;
 b=yajaatBU9fS04Moqc8h+IbzQqvgg8wb7pt4gDGGqIU58xWIynyLgDa8f96ITsy0nAUTNaZ
 qVCmUyxoqKYO3+eMQ+Zv7OhXTuofX1WFV7oCKc8a3a3jsoXAtLkeboKYBv9kC/sQonUa8o
 fSVn3wUT/CEYDj4aIu5VbONz7HUDw3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749038341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lr/4doJzOTv3ensyuRSp4lSw/Oxal19O9/J+q+0m95g=;
 b=85cSvEQIyTSrBMNdzBmPmmAcStJjAEBFcW7CK7F8ngHPwXh7j1aSJG5gqrkmV9499IQkou
 2Hl+FfRvvJnaa5DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yajaatBU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=85cSvEQI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749038341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lr/4doJzOTv3ensyuRSp4lSw/Oxal19O9/J+q+0m95g=;
 b=yajaatBU9fS04Moqc8h+IbzQqvgg8wb7pt4gDGGqIU58xWIynyLgDa8f96ITsy0nAUTNaZ
 qVCmUyxoqKYO3+eMQ+Zv7OhXTuofX1WFV7oCKc8a3a3jsoXAtLkeboKYBv9kC/sQonUa8o
 fSVn3wUT/CEYDj4aIu5VbONz7HUDw3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749038341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lr/4doJzOTv3ensyuRSp4lSw/Oxal19O9/J+q+0m95g=;
 b=85cSvEQIyTSrBMNdzBmPmmAcStJjAEBFcW7CK7F8ngHPwXh7j1aSJG5gqrkmV9499IQkou
 2Hl+FfRvvJnaa5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA26913A63;
 Wed,  4 Jun 2025 11:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q1PZOAQ1QGi0RAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Jun 2025 11:59:00 +0000
Date: Wed, 4 Jun 2025 13:59:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aEA1JNiucJyEp96n@yuki.lan>
References: <20250513165640.185122-1-japo@linux.ibm.com>
 <20250513165640.185122-2-japo@linux.ibm.com> <aC2e24S2FzFRM5-N@rei>
 <aC2jBIAHCHGpDM-f@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aC2jBIAHCHGpDM-f@rei>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A9BB1FE49
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/2] safe_macros.c: Fix missing ro flag for
 FUSE NTFS mounts
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
> > > --- a/lib/safe_macros.c
> > > +++ b/lib/safe_macros.c
> > > @@ -942,10 +942,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
> > >  	 */
> > >  	if (possibly_fuse(filesystemtype)) {
> > >  		char buf[1024];
> > > +		const char* mount_fmt;
> > > 
> > >  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> > > -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> > > -			filesystemtype, source, target);
> > > +		if (!strcmp(filesystemtype, "ntfs") && mountflags & MS_RDONLY)
> > 
> > Do we need to limit this to "ntfs"? I suppose that for other FUSE
> > filesystems would have the same problem, e.g. exfat.
> > 
> > Other than this the patch looks good.
> 
> Also if my patch that fixes the fuse blacklist gets applied we need to
> remove the fuse from the blacklist from statmount02 to get the test
> enabled after this fix.

Ping. Are you going to work on this? I think that it's a good idea to
fix the fuse mount to apply the flags correctly and then enable the
tests that were previously disabled by this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
