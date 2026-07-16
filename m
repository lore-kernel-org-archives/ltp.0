Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F8FC4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 08:45:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AB523C73A9
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:45:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E39C03C73A9
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:45:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5429960078D
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:45:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B44F43E39;
 Thu, 16 Jul 2026 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784191509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uny5CldBt5UPUHNp2P72mbn4Oe4lijmrQFcvFoVHC4k=;
 b=KvC812JGtnNZdxOEeETTqKZ3kJqTXEBxxAaIqXBKYlXnco4vI95uSO7Rt/YiaN4j8o5ewA
 sApY9MnnHi9PLDftdoR6BhkJReMFtQ6tG5p+Vm8UonDdggdVKyLriJaTZUEaDlNQc+k3Dj
 vXxC8CGyoWlpr/bz1NiN5lCZ3VQ6UUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784191509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uny5CldBt5UPUHNp2P72mbn4Oe4lijmrQFcvFoVHC4k=;
 b=pau6X88mqibyPl7RyxxU/+SpbuqNlDPvBbTZNY+VMeKABa+U27EUcDDrDhqSmUFtyig58S
 wDBNDMn2SgcRLOAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784191509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uny5CldBt5UPUHNp2P72mbn4Oe4lijmrQFcvFoVHC4k=;
 b=KvC812JGtnNZdxOEeETTqKZ3kJqTXEBxxAaIqXBKYlXnco4vI95uSO7Rt/YiaN4j8o5ewA
 sApY9MnnHi9PLDftdoR6BhkJReMFtQ6tG5p+Vm8UonDdggdVKyLriJaTZUEaDlNQc+k3Dj
 vXxC8CGyoWlpr/bz1NiN5lCZ3VQ6UUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784191509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uny5CldBt5UPUHNp2P72mbn4Oe4lijmrQFcvFoVHC4k=;
 b=pau6X88mqibyPl7RyxxU/+SpbuqNlDPvBbTZNY+VMeKABa+U27EUcDDrDhqSmUFtyig58S
 wDBNDMn2SgcRLOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4CFC779AD;
 Thu, 16 Jul 2026 08:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +hP3JhWaWGrlZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jul 2026 08:45:09 +0000
Date: Thu, 16 Jul 2026 10:45:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aliaEcUZ0xM3bhwk@yuki.lan>
References: <aliWtSpjgAR_OY51@yuki.lan>
 <6a58980f.80d8f3ad.34c319.0fb8@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a58980f.80d8f3ad.34c319.0fb8@mx.google.com>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.de,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_cls.h fallback
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > + * Same as NETDEV_REMOVE_QDISC() but does not fail when the qdisc is
> > > > + * missing (strict=0), so it can be used to clear a possibly absent qdisc.
> > > > + */
> > > > +#define NETDEV_MAY_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
> > > 
> > > New public macros in include/ require kernel-doc (/** */), not a plain
> > > block comment. The content is fine; it just needs the right opener:
> > > 
> > >   /**
> > >    * NETDEV_MAY_REMOVE_QDISC - remove qdisc without failing if absent.
> > >    * @ifname: network interface name
> > >    * @family: address family
> > >    * @parent: parent handle
> > >    * @handle: qdisc handle
> > >    * @qd_kind: qdisc kind string
> > >    *
> > >    * Same as NETDEV_REMOVE_QDISC() but passes strict=0, so it does not
> > >    * fail when the qdisc is missing.
> > >    */
> > 
> > Looks reasonable. It may be a good idea to copy&paste this to the header
> > before applying the patch.
> 
> But then we should do it for all the others as well, maybe we should have
> a follow up patch to document all macros instead.

That would work as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
