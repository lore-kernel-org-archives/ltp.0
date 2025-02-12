Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE825C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 20:11:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDFA73C9A38
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 21:11:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AF0E3C8938
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 21:10:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2BFAA656FD6
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 21:10:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E31191FCD6;
 Wed, 12 Feb 2025 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739391054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9G4wjedMJs49X1JOL2HJmoZWVFfph45URb+SPgcxw7g=;
 b=Ho5YbmH6B7M0rykJ52+nGucwVJMBky4taJwQYg8kVyKEz3SZ+QCUyrfTZm7cUPdLpVEh3d
 V8p3e5fMG4CtLIPfgaJeIAnlKbWdNblUTB4AviQpuZ5UtvQCIUz2JHLmObreua6HpNLhP3
 DuCQ8Dh5pJy2ZBXqOkkFGvck7tZA6xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739391054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9G4wjedMJs49X1JOL2HJmoZWVFfph45URb+SPgcxw7g=;
 b=KnK52r9QugAzcJuLjcOvhjw5yBBVxe5LCPQzBQGX5juziXCPNFb0Wm8ZvZ3c2qFKlKPT6/
 DXEYih4Ah9FPclBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zkRZ7joX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iXfV6yeH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739391053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9G4wjedMJs49X1JOL2HJmoZWVFfph45URb+SPgcxw7g=;
 b=zkRZ7joXM1Q55DDRujWuMdCZe+iOtGhyWTIRmVayJSU8l3Y5jz/axOTW8j53u4D9sUc4A8
 0rMpnoNLWJd5z1tap3fLxzvwpr0V0GQU/vRLVB2pQalX2t41Wh3KWkwsrW/0zeYbB9jdlR
 m/qVqynIOd3KNp025AMWdILnI6Eya24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739391053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9G4wjedMJs49X1JOL2HJmoZWVFfph45URb+SPgcxw7g=;
 b=iXfV6yeHBIbIe3MZbm3eEFw16veE/DDXqwzOkFLXYwFKvl/eH4oeLfBAP3I5pkYAPPVlC5
 M/Bl2oNsxa/6Z9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D13813AEF;
 Wed, 12 Feb 2025 20:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id du7VFE0ArWdoIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 20:10:53 +0000
Date: Wed, 12 Feb 2025 21:10:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250212201047.GA2134110@pevik>
References: <20250211214627.152634-1-jmoyer@redhat.com>
 <20250211214627.152634-3-jmoyer@redhat.com>
 <20250211235232.GA1992438@pevik>
 <x49wmdvhz4n.fsf@segfault.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49wmdvhz4n.fsf@segfault.usersys.redhat.com>
X-Rspamd-Queue-Id: E31191FCD6
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib/tst_device.c: check for
 BTRFS_SUPER_MAGIC instead of device major of 0
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

> Hi, Petr,

> Thanks a lot for the review.  I just have one question, below:

> Petr Vorel <pvorel@suse.cz> writes:

> >> @@ -595,8 +595,13 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
> >>  	dev_minor = minor(buf.st_dev);
> >>  	*dev = '\0';

> >> -	if (dev_major == 0) {
> >> +	if (statfs(path, &fsbuf) < 0)
> >> +		tst_brkm(TWARN | TERRNO, NULL, "statfs() failed");
> > Please use SAFE_STATFS() here.

> SAFE_STATFS appears to be part of the new safe macros
> (tst_safe_macros_inline.h), whereas tst_device.c includes the older
> macros via #include "safe_macros.h".  How would you like me to proceed?
> I could add a SAFE_STATFS to the old macros, or I could submit a prep
> patch that converts tst_device to the new macros.  Or something else?

I'm sorry to overlook this. Your original is perfect then.

Kind regards,
Petr

> Thanks!
> Jeff


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
