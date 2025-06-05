Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AB7C5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 08:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9154D3CA35C
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 10:18:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED3EB3CA280
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 10:18:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 876CE2001D1
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 10:18:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51E3B5BF1B;
 Thu,  5 Jun 2025 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749111487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj1vrF3xzjtsA323KbTLQfS2WmvtwB36WMp51N3iIsE=;
 b=gm0Jv2W3VlynDXsk8tgopQ4lys8K+VxTVDoDCDAmRWmcL+k6j/xWOm04KWOn33gn8DPCCu
 n68dUTqPtKysxoQpFbuS+reOcSPdMhUHQPtIZLO9N4jgvypqreobiTczsrB+IqTwiPxyf6
 2y5hJUfpTbsB4ABr/M7EaWSjJ5GISqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749111487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj1vrF3xzjtsA323KbTLQfS2WmvtwB36WMp51N3iIsE=;
 b=Ooi5GXNFzYwIGIq8ywkyeyfMY+v8eFh7sNEw8suOWXFuPe6//4UaPBTOqNDBsZ8q8vhy7W
 f+RDdyBF8/b/NpCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749111487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj1vrF3xzjtsA323KbTLQfS2WmvtwB36WMp51N3iIsE=;
 b=gm0Jv2W3VlynDXsk8tgopQ4lys8K+VxTVDoDCDAmRWmcL+k6j/xWOm04KWOn33gn8DPCCu
 n68dUTqPtKysxoQpFbuS+reOcSPdMhUHQPtIZLO9N4jgvypqreobiTczsrB+IqTwiPxyf6
 2y5hJUfpTbsB4ABr/M7EaWSjJ5GISqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749111487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj1vrF3xzjtsA323KbTLQfS2WmvtwB36WMp51N3iIsE=;
 b=Ooi5GXNFzYwIGIq8ywkyeyfMY+v8eFh7sNEw8suOWXFuPe6//4UaPBTOqNDBsZ8q8vhy7W
 f+RDdyBF8/b/NpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 130DF137FE;
 Thu,  5 Jun 2025 08:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rBliA79SQWh+QAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 08:18:07 +0000
Date: Thu, 5 Jun 2025 10:18:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, ltp@lists.linux.it
Message-ID: <20250605081801.GE1190804@pevik>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-7-602b7097e722@suse.com>
 <20250605081309.GD1190804@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605081309.GD1190804@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 7/7] Add lsm_set_self_attr01 test
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea, all,

> > Verify that lsm_set_self_attr syscall is raising errors when invalid
> > data is provided.

> ...
> > diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/test=
cases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..caccdda7ecf2edaac1fa8e2=
dc2ccdd0aff020804
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse=
.com>
> > + */
> > +
> > +/*\
> > + * Verify that lsm_set_self_attr syscall is raising errors when invali=
d data is
> > + * provided.
> > + */
> > +
> > +#include "lsm_common.h"
> > +
> > +static struct lsm_ctx *ctx;
> > +static struct lsm_ctx *ctx_orig;
> > +static struct lsm_ctx *ctx_null;
> > +static uint32_t ctx_size;
> > +static uint32_t ctx_size_small;
> > +static uint32_t ctx_size_big;
> > +static uint32_t page_size;
> > +
> > +static struct tcase {
> > +	uint32_t attr;
> > +	struct lsm_ctx **ctx;
> > +	uint32_t *size;
> > +	uint32_t flags;
> > +	int exp_errno;
> > +	char *msg;
> > +} tcases[] =3D {
> > +	{
> > +		.attr =3D LSM_ATTR_CURRENT,
> > +		.ctx =3D &ctx_null,
> > +		.size =3D &ctx_size,
> > +		.exp_errno =3D EFAULT,
> > +		.msg =3D "ctx is NULL",
> > +	},
> > +	{
> > +		.attr =3D LSM_ATTR_CURRENT,
> > +		.ctx =3D &ctx,
> > +		.size =3D &ctx_size_small,
> > +		.exp_errno =3D EINVAL,
> > +		.msg =3D "size is too small",
> > +	},
> > +	{
> > +		.attr =3D LSM_ATTR_CURRENT,
> > +		.ctx =3D &ctx,
> > +		.size =3D &ctx_size_big,
> > +		.exp_errno =3D E2BIG,
> > +		.msg =3D "size is too big",
> > +	},
> > +	{
> > +		.attr =3D LSM_ATTR_CURRENT,
> > +		.ctx =3D &ctx,
> > +		.size =3D &ctx_size,
> > +		.flags =3D 1,
> > +		.exp_errno =3D EINVAL,
> > +		.msg =3D "flags must be zero",
> > +	},
> > +	{
> > +		.attr =3D LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
> > +		.ctx =3D &ctx,
> > +		.size =3D &ctx_size,
> > +		.exp_errno =3D EINVAL,
> > +		.msg =3D "attr is overset",

> FYI The test fails on this check on current Tumbleweed with new
> 6.15.0-1-default. It worked on 6.14.

> Looking at 6.15 landlock related changes (added Landlock audit support and
> Landlock signal scope fixes) test might needs to be updated.
> https://kernelnewbies.org/Linux_6.15#Security

@Micka=EBl @G=FCnther I'm sorry, replying to wrong people. This is not a la=
ndlock
related, the syscall is lsm_set_self_attr().

Kind regards,
Petr

> @Andrea could you please have a look?

> Kind regards,
> Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
