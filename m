Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E326C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613073E6CC6
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 14:19:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 365663E27F7
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 14:18:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A323E1400351
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 14:18:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D638822AF;
 Wed, 12 Aug 2026 12:18:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CAF2779B1;
 Wed, 12 Aug 2026 12:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6QXODaRkfGoBIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Aug 2026 12:18:44 +0000
Date: Wed, 12 Aug 2026 14:18:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260812121838.GA1757664@pevik>
References: <20260805151451.648990-2-pvorel@suse.cz>
 <20260805173540.9276-1-linuxtestproject.agent@gmail.com>
 <20260810120208.GE918586@pevik> <anw-Q92lT3CtUS-0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anw-Q92lT3CtUS-0@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8D638822AF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > tst_kvercmp: Factor out error handling

> > > --- [PATCH 1/9] ---

> > > > static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)

> > > Could this be renamed to parse_kver? File-scope identifiers beginning with an
> > > underscore are reserved by C, and LTP's coding rules prohibit such names.

> > I thought this is wrong, because we have functions with underscore, but it's
> > trailing underscore, not the leading one.

> > => I'll rename to tst_parse_kver_().

> > Also, agent does not know about LTP rule to have functions in lib with leading
> > tst_.

> This is a static function, so the identifier is not visible outside of
> the file, therefore there is no need for the tst_ prefix. On the
> contrary it's better if there is no prefix so that it's clear that it's
> not external API.

OK, agent was correct to user parse_kver().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
