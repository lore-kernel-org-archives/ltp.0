Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D50CDB477
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 12:08:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4902A3E69B1
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 14:08:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B43EF3C5BAD
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 14:08:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 277462003B7
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 14:08:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5FB775B7F;
 Mon, 22 Jun 2026 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782130121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2bZsSQZRvdwIQclZLwKhByMm1TOUV796CtCLRaqKIQ=;
 b=18Sytik5TRSHQ5AD/1QoLWZYbzpLV2oEiYTEg/0/gIFSuwUjIu5qAGfy/unjNUoQfbnqjG
 oAk0dVrBcUKDwm88dPHbv8v4cQ+KujsRhvqEHxXKdDx+W5vfd4JoBFfdoopaawq5U1dSxM
 NE/pxgxvaBNMN+qgMiTZs1eewwcKTbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782130121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2bZsSQZRvdwIQclZLwKhByMm1TOUV796CtCLRaqKIQ=;
 b=C2VM0s0n9838MGzVKMmsGEetMOF0cuUTuL/nmP2ZejCn3R3d8nZdh+muwxq9bBX7URvj3a
 oSTYrz9we9sQJaBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782130120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2bZsSQZRvdwIQclZLwKhByMm1TOUV796CtCLRaqKIQ=;
 b=OqGXuqQYiyntz9xgRIpJ94fTJN+DjPrU0zwzxVFcJo+kX3SLlYKfHmzRMUALFN2FuAlKei
 ORdAxSeMQqLLQjTpIqJOXU1PjLza0H1PfT6mhT/skQKJm0q3kcVES77nVzRMr91l8uAFSJ
 QkPbBONNz7K6hkTRS2TddU5+wtkpMKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782130120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2bZsSQZRvdwIQclZLwKhByMm1TOUV796CtCLRaqKIQ=;
 b=gamptz8zkTu2qM+gAFEiyEmmueD28iplHbkbSIBdQ7HSfs294w4hEFcmeX1wuc66dRWENH
 aadoSB/5jpjzwoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9593779A8;
 Mon, 22 Jun 2026 12:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dl8+L8glOWqmUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 22 Jun 2026 12:08:40 +0000
Date: Mon, 22 Jun 2026 14:08:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajklx0YwZM2rME93@yuki.lan>
References: <ajkZTtYM1TeYRSTf@yuki.lan>
 <6a3923bd.b682100b.5097e.2dc2@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3923bd.b682100b.5097e.2dc2@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] metadata: add tests grouping support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I'm looking at the metadata and we will need at least one follow up.
> > 
> > For tests that are under cve/ directory we add a 'cve' group now, but
> > tests that have cve tag but are in a different place we do not do so.
> > 
> > For consistency we should do:
> > 
> > * Filter out cve as we do with kernel in the group by path
> > 
> > * Possibly add cve group based on cve tag (I would call this optional as
> >   it kind of duplicates the cve tag)
> 
> Do you mean to take a look at the tst_test->tags and verify if we
> have a CVE tag? I think this is possible yes.

Not really. We have quite a lot of cve reproducers that do not have a
cve directory in their path. And then we have reproducers that do have
it. The current metadata has cve group only for the reproducers in the
cve directory which is inconsistent. So I proposed to filter out the
"cve" directory the same way we filter out "kernel". And possibly add
"cve" group based on tags, but that kind of duplicates the tag field, so
it may not make sense to add it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
