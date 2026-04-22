Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF3F9EDC4
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 12:18:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6334F3E53BF
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 14:18:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 380D63E27A6
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 14:17:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9641360068A
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 14:17:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A46F5BCE8;
 Wed, 22 Apr 2026 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776860268;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUCRWJirr0IhSkhWZp4HE0wOGa8etbNFrafaUVGDuqY=;
 b=JxyJlXmBuYNAseKrMr7AtIyz4QxuvsnnoNCfFFi6g6M4CankrIDRfMw3nXgkppjuVImmw+
 5F5NF2X/LJy0JC+g8SqHw9qSOgThqB3NDZUerBAkHx717t060V6c7+xpBpCKOzNPI4F49q
 /Tw3oAF6x68Lo/hw6kEapgUIpiRvC6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776860268;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUCRWJirr0IhSkhWZp4HE0wOGa8etbNFrafaUVGDuqY=;
 b=OdDFz/F/p7Vg6mNODUnEAFVn1z+NeLTDcBoOk2bqHDoBcCe4rpSUkV2vvahlKqolhOmROm
 CuObytTADLd6e1AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776860268;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUCRWJirr0IhSkhWZp4HE0wOGa8etbNFrafaUVGDuqY=;
 b=JxyJlXmBuYNAseKrMr7AtIyz4QxuvsnnoNCfFFi6g6M4CankrIDRfMw3nXgkppjuVImmw+
 5F5NF2X/LJy0JC+g8SqHw9qSOgThqB3NDZUerBAkHx717t060V6c7+xpBpCKOzNPI4F49q
 /Tw3oAF6x68Lo/hw6kEapgUIpiRvC6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776860268;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUCRWJirr0IhSkhWZp4HE0wOGa8etbNFrafaUVGDuqY=;
 b=OdDFz/F/p7Vg6mNODUnEAFVn1z+NeLTDcBoOk2bqHDoBcCe4rpSUkV2vvahlKqolhOmROm
 CuObytTADLd6e1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 255CF593AF;
 Wed, 22 Apr 2026 12:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDLFB2y86GlKYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 12:17:48 +0000
Date: Wed, 22 Apr 2026 14:17:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260422121742.GA419002@pevik>
References: <20260421152349.1673057-1-mcermak@redhat.com>
 <20260422053712.GB392764@pevik>
 <319d3965-30f0-49c5-b747-ad16334391e2@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <319d3965-30f0-49c5-b747-ad16334391e2@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
Cc: valgrind-developers@lists.sourceforge.net,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> On 4/22/26 7:37 AM, Petr Vorel wrote:
> > > However, some of the testcases can be easily changed to use forked
> > > processes instead of threads.  That's what this patch does.  When
> > > client program forks, Valgrind forks too, and that allows for the nee=
ded
> > > parallelism to handle the page fault.
> > You understand process vs. threads more than me. But shouldn't mmap() u=
se
> > MAP_SHARED instead of MAP_PRIVATE for those which aren't using /dev/use=
rfaultfd?

> The documentation for userfaultfd mentions threads.=A0 I'm afraid we'll
> lose vital coverage if we move to forked processes.

+1, at least some tests would keep threads (not all userfaultfd tests would=
 be
converted, but yes, that's why I suggested to use MAP_SHARED, which could be
similar to threads (yes, the difference between processes and threads in Li=
nux
kernel is not that huge as both are created in clone(), it's mostly about w=
hat
is shared).

> Perhaps we should cover both?

What do you mean by "both"?

Run test with both processes and threads e.g. via .test_variants?
Because combine MAP_SHARED | MAP_PRIVATE is not possible (mutually exclusiv=
e).

> Also checkout UFFD_FEATURE_EVENT_FORK and the BUGS section for this in
> userfaultfd(2).
+1

> I have like 3 patches for userfaultfd that I'm afraid I'd have to rebase
> then.\ Best,

Yeah, that's life of an open source development.

Kind regards,
Petr

> Ricardo

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
