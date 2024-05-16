Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D5C25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 01:40:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D32F3CF8CB
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 03:40:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0985E3CF804
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:39:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 570952009C6
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:39:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D824342B0;
 Thu, 16 May 2024 01:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715823591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEWhNUXPGXKmFdFWwZfOx2dO65/zExXfqvIIYudDBo8=;
 b=SlXNBYIk/TOG3b3AxLf4oUNaw9IxFMBpOSdV1sFKtzhvKCKO+K0TKeJv1xMufvpNrJaJn+
 Cjd8ZvOqOpdG6fH/wlNYLXHrv8ViqALN1+7cPZmxWAkWhSl08CnYqEt+fnX8W+PB9KMv84
 2LNV9S2YazaZHNtn70Po6SwQ88aJXoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715823591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEWhNUXPGXKmFdFWwZfOx2dO65/zExXfqvIIYudDBo8=;
 b=qi7Ju0Hb17RS0Hra4SVeZ6lVb/IW/Uh9t79eQgxXcMnfS7xHMdXuGi1Gz6tAHX0EJgalxM
 Bqk98vgeQwSIHLDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SlXNBYIk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qi7Ju0Hb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715823591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEWhNUXPGXKmFdFWwZfOx2dO65/zExXfqvIIYudDBo8=;
 b=SlXNBYIk/TOG3b3AxLf4oUNaw9IxFMBpOSdV1sFKtzhvKCKO+K0TKeJv1xMufvpNrJaJn+
 Cjd8ZvOqOpdG6fH/wlNYLXHrv8ViqALN1+7cPZmxWAkWhSl08CnYqEt+fnX8W+PB9KMv84
 2LNV9S2YazaZHNtn70Po6SwQ88aJXoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715823591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEWhNUXPGXKmFdFWwZfOx2dO65/zExXfqvIIYudDBo8=;
 b=qi7Ju0Hb17RS0Hra4SVeZ6lVb/IW/Uh9t79eQgxXcMnfS7xHMdXuGi1Gz6tAHX0EJgalxM
 Bqk98vgeQwSIHLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A06B13A5D;
 Thu, 16 May 2024 01:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VZnMEOdjRWbMVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 01:39:51 +0000
Date: Thu, 16 May 2024 03:39:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
Message-ID: <20240516013945.GD260285@pevik>
References: <20240422083657.28363-1-xuyang2018.jy@fujitsu.com>
 <20240516013427.GC260285@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516013427.GC260285@pevik>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5D824342B0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsockopt01: Add case for errno EINVAL
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

Hi Xu,

> Hi Xu,

> ...
> > +++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
> > @@ -15,6 +15,7 @@
> >   * - ENOTSOCK on a file descriptor not linked to a socket
> >   * - EFAULT on invalid address of value or length
> >   * - EOPNOTSUPP on invalid option name or protocol
> > + * - EINVAL on an invalid optlen
> >   */

> >  #include "tst_test.h"
> > @@ -24,6 +25,7 @@ static struct sockaddr_in sin0;
> >  static int sinlen;
> >  static int optval;
> >  static socklen_t optlen;
> > +static socklen_t optleninval;

> Again, -1 should be added here (can be fixed before merge):

Merged with this fix. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
