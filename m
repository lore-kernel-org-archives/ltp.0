Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88811C021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 11:00:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEF5D3C9B21
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 12:00:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03FF53C9AC5
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:00:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D3320101734B
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 12:00:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A9D6921167;
 Tue, 25 Feb 2025 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740481222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtdOJi4w9E9/OgneyIkMwu4IghGS5sQyZYmVohqp4FI=;
 b=plTg/J4b5P7d40RId9mFCKIfbf2D88MN3s7EsQqT5mypiZYUoBZtBOHeDS5pnfLGRH0sGN
 oiTB7SGn7cG0YNNusJ0FqIFt17G6c8W8kxj/X1+/Gnx7MZZZmvvmO0uFM4k221etdUkVEy
 /5oKY4vlkAcvNQsxmk/Wc3I/5q74xSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740481222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtdOJi4w9E9/OgneyIkMwu4IghGS5sQyZYmVohqp4FI=;
 b=UFXahiDaVouyRv0NqREzFAZf6YCSWjX/Mv9U1qDg9jSc2SI7GzHET4gvnxCj71PZin5qp/
 wTHC5vRaI2XinLBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="plTg/J4b";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UFXahiDa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740481222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtdOJi4w9E9/OgneyIkMwu4IghGS5sQyZYmVohqp4FI=;
 b=plTg/J4b5P7d40RId9mFCKIfbf2D88MN3s7EsQqT5mypiZYUoBZtBOHeDS5pnfLGRH0sGN
 oiTB7SGn7cG0YNNusJ0FqIFt17G6c8W8kxj/X1+/Gnx7MZZZmvvmO0uFM4k221etdUkVEy
 /5oKY4vlkAcvNQsxmk/Wc3I/5q74xSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740481222;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtdOJi4w9E9/OgneyIkMwu4IghGS5sQyZYmVohqp4FI=;
 b=UFXahiDaVouyRv0NqREzFAZf6YCSWjX/Mv9U1qDg9jSc2SI7GzHET4gvnxCj71PZin5qp/
 wTHC5vRaI2XinLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FD3413332;
 Tue, 25 Feb 2025 11:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FETOHcaivWdCMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Feb 2025 11:00:22 +0000
Date: Tue, 25 Feb 2025 12:00:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250225110017.GA2932346@pevik>
References: <20250214112135.18947-1-chrubis@suse.cz>
 <20250214112135.18947-3-chrubis@suse.cz>
 <20250217074413.GA2350499@pevik> <Z72anBFr2n4REM3E@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z72anBFr2n4REM3E@yuki.lan>
X-Rspamd-Queue-Id: A9D6921167
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] shell lib: Add support for test cleanup
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

Hi Cyril,

> Hi!
> > could we get check for file existence, the same way it's done in metaparse.c?

> > Also, I'd prefer if both tools exit 1 in case of missing file (so that CI
> > notifies the problem).

> Will do.

> > +++ metadata/metaparse-sh.c
> > @@ -6,6 +6,7 @@
> >  #include <stdio.h>
> >  #include <string.h>
> >  #include <libgen.h>
> > +#include <unistd.h>

> >  #include "data_storage.h"

> > @@ -46,6 +47,11 @@ static void parse_shell(char *path)
> >  	FILE *f = fopen(path, "r");
> >  	enum state state = NONE;

> > +	if (access(path, F_OK)) {
> > +		fprintf(stderr, "file %s does not exist\n", path);
> > +		return;
> > +	}

> I guess that I should check the f instead:

> 	if (!f) {
> 		fprintf(stderr, "Failed to open '%s': %s", path, strerror(errno));
> 		exit(1);
> 	}

Yes, that's it. Thanks for both.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
