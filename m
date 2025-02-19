Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B2C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 11:25:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 912173C2E29
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 12:25:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76FE33C06D0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 12:24:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2AEC9101174A
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 12:24:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 314AC211DD;
 Wed, 19 Feb 2025 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739964291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SzbO7Wj7DnMeh3kerBkB2pqQvRcTNSH337mQ/HQ+i7E=;
 b=j8Rt8UFSY/YEkRTf36J3fv3awfHURKC+Ez4C2Nh7Zaq87rxatq1Sorz1e/IgWX0WzAoG2t
 zkR+Pv5WB7DXY3KVqWpjTCSf6fxrqCZasCwu7c+aLiuSk4HierteED5drQeGJ7sVV/gu10
 QxtaXwbVgU/mUJeKhVxgRA4yeLnxSMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739964291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SzbO7Wj7DnMeh3kerBkB2pqQvRcTNSH337mQ/HQ+i7E=;
 b=a6klycYhgvEN0z3bnwOQ/OzRzylkEIlG0da3xzUZ2TtlEQBwneS+/We96sbgJtYjm+IKM8
 nCit7wgAsZwL2DDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j8Rt8UFS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a6klycYh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739964291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SzbO7Wj7DnMeh3kerBkB2pqQvRcTNSH337mQ/HQ+i7E=;
 b=j8Rt8UFSY/YEkRTf36J3fv3awfHURKC+Ez4C2Nh7Zaq87rxatq1Sorz1e/IgWX0WzAoG2t
 zkR+Pv5WB7DXY3KVqWpjTCSf6fxrqCZasCwu7c+aLiuSk4HierteED5drQeGJ7sVV/gu10
 QxtaXwbVgU/mUJeKhVxgRA4yeLnxSMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739964291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SzbO7Wj7DnMeh3kerBkB2pqQvRcTNSH337mQ/HQ+i7E=;
 b=a6klycYhgvEN0z3bnwOQ/OzRzylkEIlG0da3xzUZ2TtlEQBwneS+/We96sbgJtYjm+IKM8
 nCit7wgAsZwL2DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA8213715;
 Wed, 19 Feb 2025 11:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NZk6BoO/tWdwWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 11:24:51 +0000
Date: Wed, 19 Feb 2025 12:24:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250219112445.GC2544812@pevik>
References: <20250217020423.31602-1-wegao@suse.com>
 <20250218151858.GA2492575@pevik> <Z7WajlVc0xMSztSe@wegao>
 <20250219090536.GB2544812@pevik> <Z7WpkIMnaQPb5yeh@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z7WpkIMnaQPb5yeh@wegao>
X-Rspamd-Queue-Id: 314AC211DD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount_setattr02.c: Check mount_setattr
 attr.propagation
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

> On Wed, Feb 19, 2025 at 10:05:36AM +0100, Petr Vorel wrote:
> > > On Tue, Feb 18, 2025 at 04:18:58PM +0100, Petr Vorel wrote:
> > > > Hi Wei,

> > > > nit: I guess you want to replace dot with space in subject.
> > > You mean i s/attr.propagation/attr propagation ?

> > Yes.
> Will update it in v3

This is not important (the code matters), but IMHO something like:

"mount_setattr02: Add test to check mount attributes propagation"

would be more readable for me than "mount_setattr02.c: Check mount_setattr
attr.propagation" you provided. From your subject it's not even obvious it's a
new test and not a change in the existing test.

> > ...
> > > > > +#define DIRA "/DIRA_PROPAGATION_CHECK"

> > > > Is it necessary to to use directory under root?
> > > Yes. Otherwise failed will happen during mount_setattr.
> > > But i have not check for detail.

> > Ideally we would create files in TMPDIR. Specially if bug in the code leave
> > /DIRA_PROPAGATION_CHECK kept.
> Got it, will try using TMPDIR and investigate why it report error.

Thank you!

Kind regards,
Petr

> > > > ...
> > Sure, it should not block your work on the test.

> > Kind regards,
> > Petr

> > > > Kind regards,
> > > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
