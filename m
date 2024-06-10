Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E2C27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 10:58:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 944293D0B38
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 12:58:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95E13D01A9
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 12:58:03 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CF9F6600D2A
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 12:58:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 889981F7BE;
 Mon, 10 Jun 2024 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718017081;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIbt5GBZ4NfQ6S+OVGVL7SIprkeFG+ULjJtRGqbwD/g=;
 b=lkZz7BeEnWYNi5ahz8J4aNqJmNWMDuKjc4nXOUwuv9RUK9cYHk+8iGFNmTAF6N0h/ciVLV
 n9Yjn42UvVWbqI7t7IQUyGJ19UdzSWVoslsDJyvUtFTPi9QTFxysdVK495XukG/9X/nNUy
 OI/06HsSjq5aWWWPLj/vK750tlm2gjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718017081;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIbt5GBZ4NfQ6S+OVGVL7SIprkeFG+ULjJtRGqbwD/g=;
 b=j19FcGOgLhLgnbMJS5u4Ii05emtX0PCHIgKgzkB23wtwfHASa7+q/hyw+NDVWyH+hxt7ul
 5irwSQz+mlGaksBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lkZz7BeE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j19FcGOg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718017081;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIbt5GBZ4NfQ6S+OVGVL7SIprkeFG+ULjJtRGqbwD/g=;
 b=lkZz7BeEnWYNi5ahz8J4aNqJmNWMDuKjc4nXOUwuv9RUK9cYHk+8iGFNmTAF6N0h/ciVLV
 n9Yjn42UvVWbqI7t7IQUyGJ19UdzSWVoslsDJyvUtFTPi9QTFxysdVK495XukG/9X/nNUy
 OI/06HsSjq5aWWWPLj/vK750tlm2gjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718017081;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIbt5GBZ4NfQ6S+OVGVL7SIprkeFG+ULjJtRGqbwD/g=;
 b=j19FcGOgLhLgnbMJS5u4Ii05emtX0PCHIgKgzkB23wtwfHASa7+q/hyw+NDVWyH+hxt7ul
 5irwSQz+mlGaksBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62DF813AA8;
 Mon, 10 Jun 2024 10:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iWlSFTncZmYpBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 10:58:01 +0000
Date: Mon, 10 Jun 2024 12:57:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240610105759.GA710648@pevik>
References: <20240607115304.86028-1-pvorel@suse.cz>
 <6521fb41-3ac4-4487-8cf4-e1faff1e86b7@suse.com>
 <20240610093226.GA705643@pevik>
 <3031ceb7-0070-4e71-a1f2-13c78fd6ed64@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3031ceb7-0070-4e71-a1f2-13c78fd6ed64@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; REPLYTO_EQ_FROM(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 889981F7BE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [KIRK PATCH 1/1] README: Document passing environment
 variables
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

> On 6/10/24 11:32, Petr Vorel wrote:
> > Hi Andrea,

> > > Hi!
> > > LGTM
> > > Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > Thanks, merged as
> > https://github.com/linux-test-project/kirk/commit/5e8c8064a0b2cee465f2a1dca1cfebef5ade36a2

> > BTW I wonder if recent kirk commits (SSH fixes) are strong enough to release
> > kirk and update LTP. WDYT? Or do you wait for ltx improvements before releasing
> > new version?

> > Kind regards,
> > Petr

> There were really minor updates in kirk. We can probably create a new
> version after more features will be added, but I have no idea when.

OK, thanks for info. From the description they looks as a real bug fixes which
would users appreciated.

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
