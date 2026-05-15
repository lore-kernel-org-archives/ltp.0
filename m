Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A69CD4F48
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 15:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2AEA3E57DA
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 17:33:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55803DC86F
 for <ltp@lists.linux.it>; Fri, 15 May 2026 17:32:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60548200B60
 for <ltp@lists.linux.it>; Fri, 15 May 2026 17:32:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33B52619FC;
 Fri, 15 May 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778859176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAdp/aKeHy7jIiMjz1ZKFUiIUMnmuQGX3HSvU8C/BMg=;
 b=V4mdxeGHjFETy6enUB8nB3hlPceqRMj25hnh7+1UabyboSJ0liaMDhRhiPVzarQZNAoTYR
 lmM5+ulXXoQ4phL4dPeKDJF9FR2UPmNrbshO9HaLrihWJhnM5/hvcoozRf5eKoTFusKrh5
 AHFvT+qwNkAmhjYo8q70yp6npvG2u1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778859176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAdp/aKeHy7jIiMjz1ZKFUiIUMnmuQGX3HSvU8C/BMg=;
 b=2mLBp9bvV1RS0sTk4uHkg/t6goZHTOmH7YjX+fbqrTebtn6PiNH5CrI2d9uhuLNLuYqnyX
 Al+vEyibuHYx5DBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778859176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAdp/aKeHy7jIiMjz1ZKFUiIUMnmuQGX3HSvU8C/BMg=;
 b=V4mdxeGHjFETy6enUB8nB3hlPceqRMj25hnh7+1UabyboSJ0liaMDhRhiPVzarQZNAoTYR
 lmM5+ulXXoQ4phL4dPeKDJF9FR2UPmNrbshO9HaLrihWJhnM5/hvcoozRf5eKoTFusKrh5
 AHFvT+qwNkAmhjYo8q70yp6npvG2u1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778859176;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAdp/aKeHy7jIiMjz1ZKFUiIUMnmuQGX3HSvU8C/BMg=;
 b=2mLBp9bvV1RS0sTk4uHkg/t6goZHTOmH7YjX+fbqrTebtn6PiNH5CrI2d9uhuLNLuYqnyX
 Al+vEyibuHYx5DBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12607593A9;
 Fri, 15 May 2026 15:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qnT1Aqg8B2rrZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 May 2026 15:32:56 +0000
Date: Fri, 15 May 2026 17:32:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260515153250.GA45497@pevik>
References: <20260501135100.42278-1-li.wang@linux.dev>
 <20260504133020.14129-1-li.wang@linux.dev>
 <afi3Ml5vFv2irnc0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afi3Ml5vFv2irnc0@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.cz:replyto];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Introduce tst_path.h to consolidate
 system paths
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

> Hi!
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) Linux Test Project, 2026
> > + * Copyright (c) 2026 Li Wang <li.wang@linux.dev>
> > + */
> > +
> > +#ifndef TST_PATH__
> > +#define TST_PATH__
> > +
> > +/* PROC */
> > +#define PROC_SYS_VM		"/proc/sys/vm/"
> > +#define PROC_SYS_FS		"/proc/sys/fs/"
> > +#define PROC_SYS_NET		"/proc/sys/net/"
> > +#define PROC_SYS_USER		"/proc/sys/user/"
> > +#define PROC_SYS_KERNEL		"/proc/sys/kernel/"
> > +/* SYS */
> > +#define SYS_KERNEL_MM		"/sys/kernel/mm/"

> I wonder if this is really better. The macro name is not shorter and the
> kernel path is not going to change since it's part of API.

IMHO it's not about kernel change but about user typos :).
I prefer constants (build failure in case of typo instead of wrong patch being
hidden for years).

I thought in the past about replacing tag keys ("linux-git", "glibc-git", ...)
with constants, but never implement it as I expected it'd be rejected as
useless.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
