Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BFED6B6AD
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 16:50:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93EA93CB3D4
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 17:50:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4E3D3C61D7
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 17:49:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C54F51BBD389
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 17:49:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37C0221B71;
 Wed, 30 Oct 2024 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730306990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvxA8eDinpQeuCwX5hTgGFZwOh4b2plKh2AOD4P3U2c=;
 b=O7qdT5AhLdLkF0uEbrvWP/XROyVJDzbYImuzuOIMbtIdBInMOQ1mKadNKlWUg584S+e+zq
 i/idqm0p1nPljPaBY5lzGJJLwC9kBK/Vtok0fsW53wqX1CZ8TgzjvwNrw62hwT/GHqS8lr
 inETWX1yuuiIIh6VFhfDcjH/+mdOF5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730306990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvxA8eDinpQeuCwX5hTgGFZwOh4b2plKh2AOD4P3U2c=;
 b=r1vBICBxQDeZihAAcuVfdnmLZ0L4a44e2Dkfs6ngILdxkUEhi0rOjy5aP6WaalolvMByZ/
 sHZq1cyXuUgiFTCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730306990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvxA8eDinpQeuCwX5hTgGFZwOh4b2plKh2AOD4P3U2c=;
 b=O7qdT5AhLdLkF0uEbrvWP/XROyVJDzbYImuzuOIMbtIdBInMOQ1mKadNKlWUg584S+e+zq
 i/idqm0p1nPljPaBY5lzGJJLwC9kBK/Vtok0fsW53wqX1CZ8TgzjvwNrw62hwT/GHqS8lr
 inETWX1yuuiIIh6VFhfDcjH/+mdOF5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730306990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvxA8eDinpQeuCwX5hTgGFZwOh4b2plKh2AOD4P3U2c=;
 b=r1vBICBxQDeZihAAcuVfdnmLZ0L4a44e2Dkfs6ngILdxkUEhi0rOjy5aP6WaalolvMByZ/
 sHZq1cyXuUgiFTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14A26136A5;
 Wed, 30 Oct 2024 16:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0XPDA65jImd8NwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Oct 2024 16:49:50 +0000
Date: Wed, 30 Oct 2024 17:49:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241030164940.GA940932@pevik>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
 <20241030144908.GA915191@pevik>
 <fa37b53b-51c8-4ea2-b95a-c6248b5bc4a3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa37b53b-51c8-4ea2-b95a-c6248b5bc4a3@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Refactor regen.sh script to generate
 syscalls
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

> Hi Petr,

> On 10/30/24 15:49, Petr Vorel wrote:
> > Hi Andrea,

> > > +++ b/include/lapi/syscalls/generate_syscalls.sh
> > > @@ -0,0 +1,115 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +#
> > > +# Generate the syscalls.h file, merging all architectures syscalls input file
> > > +# which are in the current folder and defined inside supported-arch.txt file.
> > > +
> > > +SYSCALLS_FILE="$1"
> > > +
> > > +if [ -z "${SYSCALLS_FILE}" ]; then
> > nit: I would still replace ${...} with $... (e.g. ${SYSCALLS_FILE} =>
> > $SYSCALLS_FILE) as I noted in v4 - readability. IMHO there is no need to use
> > ${...} in whole script.

> > The same applies to include/lapi/syscalls/generate_arch.sh in the second commit.

> This is a bit debatable. The reason why using ${VAR} over $VAR is the
> readability in the first place (i.e. when you have `${PATH}/bin` instead
> `$PATH/bin` or when you use characters which could mix with PATH var name
> and it might create debug issues), but also the fact it provides
> ${VAR:-default} syntax which can always added afterwards.

> I usually prefer this method for these reasons.

Sure, it's matter of preference. At least LTP shell library tst_test.sh
is happy with $VAR instead of ${VAR}. But as generate_arch.sh origin is in the
separate project, and this is a separate shell script (not part of shell API)
let's ignore my suggestion.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
