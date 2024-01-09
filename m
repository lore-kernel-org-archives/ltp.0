Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA36C47073
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 10:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2254A3CE514
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 11:32:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 881BA3CE4F8
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 11:32:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9230A14010EA
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 11:32:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 329A01F7F6;
 Tue,  9 Jan 2024 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704796321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOn5eJ+geO/Iv0b3t0P8rCWcuO2Y7FAKYPtyb8WT6M=;
 b=Jvkffs1h3ZCOgnV+v4rOYd0nDkiMbWnKuqCXkOKj2KatsdD0uGvxuU0DbUlaJg23DmRFl7
 mhHK+rKb2lmWx5AONisJM10Oo2b/ZqT1X6tqPC3NFyWFyvjTLDyHVkDo9n6an2+u0KphFa
 di1mlnkd9u3T04oeC5zbEci2KuEuKDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704796321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOn5eJ+geO/Iv0b3t0P8rCWcuO2Y7FAKYPtyb8WT6M=;
 b=D1QEvop2sHGWz1+93W6SHiqIFVe67oF1z3KLgAXlBUVKaKFrt/XwlgnFYgndq8RXRYOQ17
 13Bc3C2e8/QslVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704796321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOn5eJ+geO/Iv0b3t0P8rCWcuO2Y7FAKYPtyb8WT6M=;
 b=Jvkffs1h3ZCOgnV+v4rOYd0nDkiMbWnKuqCXkOKj2KatsdD0uGvxuU0DbUlaJg23DmRFl7
 mhHK+rKb2lmWx5AONisJM10Oo2b/ZqT1X6tqPC3NFyWFyvjTLDyHVkDo9n6an2+u0KphFa
 di1mlnkd9u3T04oeC5zbEci2KuEuKDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704796321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOn5eJ+geO/Iv0b3t0P8rCWcuO2Y7FAKYPtyb8WT6M=;
 b=D1QEvop2sHGWz1+93W6SHiqIFVe67oF1z3KLgAXlBUVKaKFrt/XwlgnFYgndq8RXRYOQ17
 13Bc3C2e8/QslVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08773134E8;
 Tue,  9 Jan 2024 10:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UteWO6AgnWVZTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jan 2024 10:32:00 +0000
Date: Tue, 9 Jan 2024 11:32:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <ZZ0guBd48WXYapPL@yuki>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
 <ZZvIBO-a1b_nIHJ8@yuki>
 <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jvkffs1h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D1QEvop2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[13]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,redhat.com,suse.com,fujitsu.com,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 329A01F7F6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on
 Bcachefs
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Quite likely, other filesystems does have an inode flag that is set when
> > file has been compressed and simply report that in the foo_getattr()
> > callback. Looking at bcachefs I supose that we need to figure out if the
> > inode is v3 and then unpack the v3 info to get to the compressed flag,
> > you probably know best how to do that.
> 
> I'm still not clear how we want to map STATX_ATTR_COMPRESSED, since it's
> extents that are compressed, not entire files - and just reporting the
> compression option is probably not what we want since it can be flipped
> off, and existing data will still be compressed.
> 
> Do you know anything about the intended use case?

As far as I understand the flag it's a hint that the file I/O may be
slower/need more memory because of the compression.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
