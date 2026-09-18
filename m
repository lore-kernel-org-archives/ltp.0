Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F45C982D7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 16:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB7143EABB6
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 18:55:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEC923E1DAF
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 18:55:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 327AD200754
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 18:55:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11CF921AA2;
 Fri, 18 Sep 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95928133CF;
 Fri, 18 Sep 2026 16:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OzMFFQBtrWqzGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 16:55:28 +0000
Date: Fri, 18 Sep 2026 18:55:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260918165526.GC1973373@pevik>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-27-pvorel@suse.cz>
 <aq1Pv3MBfRhmdn2A@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aq1Pv3MBfRhmdn2A@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 11CF921AA2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 26/36] keyctl30: Test KEYCTL_PKEY_QUERY on
 private key
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
> > +static void run(void)
> > +{
> > +	memset(query_buf, 0, sizeof(*query_buf));
> > +
> > +	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_PKEY_QUERY, (unsigned long)priv_key,
> > +				    0, (unsigned long)"enc=pkcs1",
> > +				    (unsigned long)query_buf), 0);
> > +	if (!TST_PASS)
> > +		return;

> Here as well, TST_EXP_PASS()?

> Otherwise:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Fixed and merged up to here.

The rest will have to wait till Monday or after release.
(I'd prefer to finish merging up to keyctl37.c on Monday if we both have time).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
