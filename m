Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C2C56201
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:12:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B72E33E4B79
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 13:12:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94E093E2D40
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 13:12:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4BCC410000E1
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 13:12:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BB3141B7;
 Wed,  5 Aug 2026 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785928339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3AJB8ZRSWdWnegjsFDcl/4ch/eIRRFYW1VmvPXyCsBE=;
 b=NZR4A6L1ZXL2sl6HRKUIrSGGKDN6Zeg3KqVa8wbtRj54eoDwKdPQ1TnPv9t0DuzaXOAzZu
 2ASIsLvW0SzI01AGGQmQlshY9ZWGjgkrFKXZNZMIl5K+iCXL0XGIlhPNEaDfD1ocptyQS6
 wX95V5iMKa13bkww/tOBmpHLa5p6KbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785928339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3AJB8ZRSWdWnegjsFDcl/4ch/eIRRFYW1VmvPXyCsBE=;
 b=zZHS/zbJojph66VVeMEZIvZCnIhBN3Lk8hZRqSQr/VInXioz9gw1oF3WnGD5EKKxp8bmFs
 bLiYOD19n+KDCQAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d7oLy7J4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ruG6wR8z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785928335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3AJB8ZRSWdWnegjsFDcl/4ch/eIRRFYW1VmvPXyCsBE=;
 b=d7oLy7J4nONrxhjb6shHG8xCnoIGv4RtAqkMzlfvUa8EeJOp1lc/sorf8aiTV6+BHofvly
 94PljdNiExDqubca5hzgBIO0MGHlUhI6vQqDEcSQPavIKPDvbiAH+6yvHyT/iJYQDNqdgX
 y+d3FCs9zpdsHnNBiB6IpmgQejd1ZUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785928335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3AJB8ZRSWdWnegjsFDcl/4ch/eIRRFYW1VmvPXyCsBE=;
 b=ruG6wR8z9RZ4Tf1B51kbiSY9oHgkTR8WWbj8QQcw6SPmw7oEGyC0DrRbJCweNdj1vcRExp
 7kU4dBA3aaFH1JCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45D91779B6;
 Wed,  5 Aug 2026 11:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P/k1D48ac2oUIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 11:12:15 +0000
Date: Wed, 5 Aug 2026 13:12:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260805111213.GA543284@pevik>
References: <20260805094935.448896-2-pvorel@suse.cz>
 <20260805103933.16659-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805103933.16659-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6BB3141B7
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3
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

> On Aug 5, 2026, Petr Vorel wrote:
> > [PATCH 1/4] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3

> --- [PATCH 2/4] ---

> > +# linuxdoc 20260504 is too verbose by default

> Could this change be folded into patch 3? At this point the requirements
> still pin linuxdoc 20240924, so the comment names a version that is not
> present in this commit, and the commit message explicitly depends on the
> following patch.

I deliberately wanted to fix it before updating linuxdoc + document the reason
even in the source code. But, if preferred, I can swap 2rd and 3nd patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
