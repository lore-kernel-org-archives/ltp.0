Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66183C47258
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 13:59:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4BE03CE3E0
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 14:59:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7CB13C578B
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 14:58:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A40D600082
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 14:58:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45394222B2;
 Fri, 12 Jan 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705067926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HqVQzM59rREB+HKNlQD5Ej/HEsQgUqlm1eyf5ROcYM=;
 b=XyqsDZrWYtabY5kJ52JkQby2UXHoT7FE0J9Q3GMOB9V56AEW7PBvZ7zmg5mDcw5bQ3vCbS
 VQeo9nm1w2P7gb3cv2XLxX/Mu3Xet+6zbqHNU2TE+NsQavdlqYz2kOufyyODdTozM8ajYV
 e8QCO8sW5LbHjExLapXU3R+BlnlZuzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705067926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HqVQzM59rREB+HKNlQD5Ej/HEsQgUqlm1eyf5ROcYM=;
 b=mcveIrfmVqqn256Wp3ACMPrClWxe0O4ana+x2HTbQis5LQHFgOB4ZocRHhLtX2kpHY2SOz
 s4hs2eEHbyfzABCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705067926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HqVQzM59rREB+HKNlQD5Ej/HEsQgUqlm1eyf5ROcYM=;
 b=XyqsDZrWYtabY5kJ52JkQby2UXHoT7FE0J9Q3GMOB9V56AEW7PBvZ7zmg5mDcw5bQ3vCbS
 VQeo9nm1w2P7gb3cv2XLxX/Mu3Xet+6zbqHNU2TE+NsQavdlqYz2kOufyyODdTozM8ajYV
 e8QCO8sW5LbHjExLapXU3R+BlnlZuzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705067926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HqVQzM59rREB+HKNlQD5Ej/HEsQgUqlm1eyf5ROcYM=;
 b=mcveIrfmVqqn256Wp3ACMPrClWxe0O4ana+x2HTbQis5LQHFgOB4ZocRHhLtX2kpHY2SOz
 s4hs2eEHbyfzABCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E35136A4;
 Fri, 12 Jan 2024 13:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9/SWBpVFoWVdfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jan 2024 13:58:45 +0000
Date: Fri, 12 Jan 2024 14:58:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Su Yue <l@damenly.org>
Message-ID: <20240112135838.GA2009596@pevik>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-2-pvorel@suse.cz> <frz27k44.fsf@damenly.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <frz27k44.fsf@damenly.org>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XyqsDZrW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mcveIrfm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.72 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.01)[51.26%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[linux.dev,lists.linux.it,suse.cz,redhat.com,suse.com,fujitsu.com,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 45394222B2
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: Add Bcachefs magic
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
Cc: Brian Foster <bfoster@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, fstests@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, linux-bcachefs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,


> On Thu 07 Dec 2023 at 20:40, Petr Vorel <pvorel@suse.cz> wrote:

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > New in v2

> >  include/tst_fs.h  | 3 +++
> >  lib/tst_fs_type.c | 2 ++
> >  2 files changed, 5 insertions(+)

> > diff --git a/include/tst_fs.h b/include/tst_fs.h
> > index eb9841165..06f5be896 100644
> > --- a/include/tst_fs.h
> > +++ b/include/tst_fs.h
> > @@ -34,6 +34,9 @@
> >  #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
> >  #define TST_EXFAT_MAGIC    0x2011BAB0UL

> > +/* fs/bcachefs/bcachefs_format.h */
> > +#define TST_BCACHE_MAGIC		0xca451a4e
> > +

> Not object to the patch. There are three MAGIC values in
> bcachefs_format.h: BCACHE_MAGIC, BCHFS_MAGIC, BCACHEFS_STATFS_MAGIC.

> IIUC, BCACHE_MAGIC is the older one in superblock, BCHFS_MAGIC is the
> new one. BCACHEFS_STATFS_MAGIC is for statfs.
> Kent,
> Would you please export needed magic values to include/uapi/linux/magic.h?

+1, very good idea.

Kind regards,
Petr

> Since you are the maintainer also I'm confused about variables to be named.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
