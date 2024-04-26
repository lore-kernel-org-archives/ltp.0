Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE70C4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 18:17:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CC7C3D03AA
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 20:17:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 863263CFA41
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 20:17:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1FFA1405174
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 20:17:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21E853511B;
 Fri, 26 Apr 2024 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714155441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/3ZgffCKJ7zmFAUiVfYabNERpjqgVt+0UhTMo7wOj0=;
 b=OjaW3pW45zjPimugIHi5N/tEYER5gyeLhc8uKdrsNnFImijTXsWDKC+xBLEk4bevToAvOg
 52/wQVejs/bPZ2EQrFxaBAoblrW6VqgpVZCdwKIY8M60rUo+4MklcNMIHk3d7yoP7TJtyu
 3x7B06htAyZWWu0AEkSeOWggNSDIa6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714155441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/3ZgffCKJ7zmFAUiVfYabNERpjqgVt+0UhTMo7wOj0=;
 b=tzll+NHAM9k24CugBENO6kWo0HQf6TAL+3KMF0rJV0313ovPiEK6U7KKq98scW3Yn6yseA
 bS1xj3BqlEFhR6CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714155440;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/3ZgffCKJ7zmFAUiVfYabNERpjqgVt+0UhTMo7wOj0=;
 b=wkkbJxKSrCUsdsDJ+QqY5WGhr4yy+D5GoxeUX58G/1Zv/QeMAUbrD3WJiG3w0/YB64j2b+
 i8ylXuQn9Dmu6W8AqJEQFSU217yh7u5s/BiYVJ0MGSxvIp5bYZ0YSEsVq0RvZgBdDexOp4
 rXyUAo+bNUMwspaFwtdYUA6y7zFdXjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714155440;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/3ZgffCKJ7zmFAUiVfYabNERpjqgVt+0UhTMo7wOj0=;
 b=PvsOEAFFqFkwMy4RG2EPBvbeCe9dRkGtWG+R4st+QHvJ2i1Q7cZEbd+Vl9OtHslYA2FVBo
 YSbNdF3kO0QQzcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF44F136DB;
 Fri, 26 Apr 2024 18:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id roNfJ6/vK2YeLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Apr 2024 18:17:19 +0000
Date: Fri, 26 Apr 2024 20:17:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240426181713.GB6871@pevik>
References: <20240423082119.16117-1-andrea.cervesato@suse.de>
 <20240425213749.GA304030@pevik>
 <6b2dd151-c7cf-48b5-87f5-3c3efb425811@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b2dd151-c7cf-48b5-87f5-3c3efb425811@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] doc: update syscalls statistics
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!

> On 4/25/24 23:37, Petr Vorel wrote:
> > Hi Andrea,

> > > This patch black-list a few syscalls which are not implemented in the
> > > kernel, untestable or either really old (=3D< 2.6 kernel version), as=
 well
> > > as defining already tested syscalls.
> > > Also fixed an index issue with table generation.
> > Thanks a lot, obvious fix, therefore merged.

> > I would still consider:

> > 1) Listing also mq_getsetattr().
> From manual:

> DESCRIPTION
> =A0=A0=A0=A0=A0=A0 Do not use this system call.

> =A0=A0=A0=A0=A0=A0 This=A0 is=A0 the low-level system call used to implem=
ent mq_getattr(3)
> and mq_setattr(3).=A0 For an explanation of how this system call operates=
, see
> the description
> =A0=A0=A0=A0=A0=A0 of mq_setattr(3).


And it continue " Never call it unless you are writing a C library!"

IMHO this is mean to the normal users, because very few people wrote libc.
But we test kernel interface, which include this.

> > 2) Trying to links syscalls names to the syscalls directory
> > (e.g. read =3D> read directory in LTP tree[1]) that should not be that =
hard.

> It's already like this: we check for syscalls subfolders and compare them
> with syscalls file. If subfolder exists, we suppose to have tests for the
> specific syscall (of course, this doesn't include coverage).

I wrote before, just bool test x not test is IMHO not much helpful. But may=
be
others see it differently. That's why I would like at least to add a link so
that reader itself has it easy verify it itself. Ideally all tests would be
listed. I understand if you don't have time to implement it, but IMHO it wo=
uld
be helpful.

> > 3) Write explanation, that these syscalls are to "some extend tested".
> > Ideally, I would wish we would transform metadata output generation [2]
> > to the docs here and enable also LTP latest stable version docs.
> Possible, but it might be a bit challenging

Yes, but it does not make much sense to keep 2 formats. Again, one question
is whether we agree on it and the other is whether anybody finds time to
implement it.

Kind regards,
Petr

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/tree/master/testcases/ker=
nel/syscalls/read
> > [2] https://github.com/linux-test-project/ltp/releases/download/2023051=
6/metadata.20230516.html

> Andrea


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
