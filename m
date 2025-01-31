Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93D0C0218F
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 10:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 363293C7AA4
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 11:35:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A4C93C6F7C
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 11:34:55 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9724206BE7
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 11:34:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73A662116C;
 Fri, 31 Jan 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CA15133A6;
 Fri, 31 Jan 2025 10:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id USlyFU2nnGeUMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 10:34:53 +0000
Date: Fri, 31 Jan 2025 11:34:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250131103451.GA1097590@pevik>
References: <20250131091535.GB1090737@pevik>
 <92cb274a-440a-42e5-95ab-5dd0e1513074@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92cb274a-440a-42e5-95ab-5dd0e1513074@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 73A662116C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Remove [Description] subtitle from docparse
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

Hi Andrea,

> Hi Petr,

> I'm currently working on parsing metadata in order to produce a tests list
> in the LTP documentation.
FYI I planned to work on it (announced in ML [1]), but since you started I stop
working on it.

> I just replace "[Description]" with "**Description**". Same for
> "[Algorithm]".

> I would keep the bold version tho, with the double star **.

We talk about a different things. You about the conversion of the subtitles to
the final documentation (previously was done in docparse/testinfo.pl, now you
will do it in python).

But I'm suggesting to entirely remove subtitle "Description". It looks to me
useless and some people don't add it thus docs looks inconsistent.

Kind regards,
Petr

> Andrea

> On 1/31/25 10:15, Petr Vorel wrote:
> > Hi,

> > Can we remove [Description] part from docparse documentation in tests?
> > This is transformed into "Description" subtitle in resulted html/pdf.

> > 1) It's not really needed (it's obvious that it's a description of the test)
> > 2) Sometimes it's missing (inconsistency).

> > I would keep other subtitles (e.g. [Algorithm]), just remove the first one.

> > Kind regards,
> > Petr

[1] https://lore.kernel.org/ltp/20241227073921.GB290415@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
