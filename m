Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4FBC55838
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 12:03:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B170F3E71CE
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 14:03:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9CD3C5FFA
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 14:02:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0CB7310009CC
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 14:02:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DEEE7F801;
 Tue,  4 Aug 2026 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785844972;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djiwae3NsYpGvyfXbpc9UyWleQUubD/cRcBi+thZ4hQ=;
 b=RlxQvjstQfqPQtiP4ouGYg+9eWYId3i4IKFLI6V2D1P3wYeju+JCQo/Y/CBI+elbccK4GX
 EFbHcHUpy5pqXnOjLrjCstzZAmedDA5OALusO86s3s33vDYx34ZvJpIy2MXcm81ptZAtYC
 uEqIAA6p0uVSfZXe6wS4QRZO6mj3Q74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785844972;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djiwae3NsYpGvyfXbpc9UyWleQUubD/cRcBi+thZ4hQ=;
 b=MNDeseZsmMIILLChpQSBmvtmJrXpjEg2NGNTELNaCZ2WH7MGSVABzqVX4bY02No7G+eJKO
 I4WqQTgLkD5RRxDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r1kCcRuw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GalZTzRr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785844968;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djiwae3NsYpGvyfXbpc9UyWleQUubD/cRcBi+thZ4hQ=;
 b=r1kCcRuw7hvojAJMuHImvLZIlxfsxLHmpsLHaxtrIyTlLUhx0BUdZfxY2PvnZuCHAfQ5xo
 3BaD6akIKYFXMey3Z+t9omJKUroDAMihy1QqyKRDGTSpy/IuvcPtSkgIJoJPzCYMgq5W7H
 SJfQr6sw8mXCJI/hFO8i5DXPNku854w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785844968;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djiwae3NsYpGvyfXbpc9UyWleQUubD/cRcBi+thZ4hQ=;
 b=GalZTzRrV6eCoKjBJZ1tLNDlw5l1W41WT1jSEyAoLZ0JYkWQL8s2gIQEyCIzI0FPQ5XA61
 WSRHhKQibArc9HCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B23779BE;
 Tue,  4 Aug 2026 12:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aB84MOXUcWpgMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Aug 2026 12:02:45 +0000
Date: Tue, 4 Aug 2026 14:02:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>
Message-ID: <20260804120243.GA285156@pevik>
References: <20260731124232.GB196217@pevik>
 <6a6c98c6.3c943127.1c122.1c09@mx.google.com>
 <20260803130645.GA246496@pevik> <anF5lV_yjqn8OuVE@linux.dev>
 <anGDa2dL19wKNtf6@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anGDa2dL19wKNtf6@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3DEEE7F801
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Re: lib: Rename function check_kver() =>
 check_min_kver()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, all,

> On Tue, Aug 04, 2026 at 01:33:09PM +0800, Li Wang wrote:
> > Petr Vorel wrote:

> > > Hi all,

> > > > > In that case we want to have both in a single commit, right?
> > > > > => yet another version.

> > > > Yes, I think so

> > > I'm not sure what's reasonable, therefore RFC please.

> > > We can for sure can have test with both flags, .min_kver < .max_kver:

> > > .min_kver = "6.5"
> > > .max_kver = "7.2"

> > > which will be tested on kernels <6.5, 7.2> (including all their stable
> > > versions). Here the code works like (using AND):

> > > $(uname -r) >= .min_kver && $(uname -r) <= .max_kver

> > This above is no porblem.

+1

> > > (BTW although current version prints only the version which is not sufficient.
> > > And I think it's better than print the range without specifying which version is
> > > not sufficient).

> > > But can we have also a variant when .min_kver > .max_kver (using OR)?

> > No, please don't do this :).

> > When I see:

> > 	.min_kver = "7.2",
> > 	.max_kver = "6.10",

> > my first assumption would be that the metadata is wrong,
> > not that it means:

Agree, it'd be confusing.

> > 	kver >= 7.2 || kver <= 6.10

> > So this could easily hide real mistakes. If somebody accidentally
> > swaps the two values, the framework would silently accept it and
> > run the test on a different set of kernels instead of reporting
> > an invalid range.

Agree.

> > I think .min_kver/.max_kver should keep simple AND semantics only,
> > and .min_kver > .max_kver should be rejected, or at least reported
> > as broken test metadata.

I can add this check in new version.


FYI other changes will be
Actually remove any version restriction for creat07.c and execve04.c (ETXTBSY is
required due revert as Cyril found and this revert was backported).

+ what we already discussed:

include/tst_test.h
- * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
+ * on any stable release (test with ``max_kver = "7.1"`` runs also on kernel

lib/tst_test.c
-       for (i=0, dots=0; max_kver[i]; i++)
+       for (i = 0, dots = 0; max_kver[i]; i++)

> > If we really need to express "run on old kernels and new kernels,
> > but skip a broken middle range", I think it would be better to handle
> > that explicitly in the test code. That would be a bit more verbose,
> > but much easier to read and review.

Agree, but we also loose this info from the metadata.

> Or, we could achive something simply:

>     .supported_kvers = {
>             "<= 6.10",
>             ">= 7.2",
>     },

Using arrays is a good idea, thanks. We would still somehow decide which boolean
should be used (OR or AND), by some flag (e.g. having supported_kvers struct with
array of values and int flag).

> But I don't think there is currently a strong demand for this.

+1. I'd postpone this until it's actually needed (if ever).
Thanks for your feedback!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
