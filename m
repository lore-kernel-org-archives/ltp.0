Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB56AC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF49C3CFB94
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:19:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3B0A3CF9D6
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:19:14 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7D26602586
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:19:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D04033C0C;
 Wed, 17 Apr 2024 12:19:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2553613957;
 Wed, 17 Apr 2024 12:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2fp5B0C+H2YIGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 12:19:12 +0000
Date: Wed, 17 Apr 2024 14:19:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240417121910.GA727397@pevik>
References: <20240417101201.715518-1-pvorel@suse.cz>
 <Zh-lvOimOYLd2Z4H@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zh-lvOimOYLd2Z4H@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5D04033C0C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: documentation: Fix typo other => older
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
> > I suppose you mean "older", otherwise the sentence does not make sense
> > to me (i.e. which versions caused problems?)

> Can we fix this one in the same patch as well?

> diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> index 30dacd384..b56d5b4c7 100644
> --- a/doc/developers/documentation.rst
> +++ b/doc/developers/documentation.rst
> @@ -11,7 +11,7 @@ and it's built on top of `Sphinx <https://www.sphinx-doc.org/en/master/>`_.
>  Building documentation
>  ~~~~~~~~~~~~~~~~~~~~~~

> -First of all, to build the documentation we must be sure that all dependences
> +First of all, to build the documentation we must be sure that all dependencies

Sure, just waiting on Andrea's ack.

BTW how does these spellchecker feature in sphinx works? Did you find it to run something
(tox -e spelling -r [1] or did you spot it manually?

I hoped that errors like this would be caught, e.g. we might want to have CI
check for it, right?

Kind regards,
Petr

[1] https://sphinxcontrib-spelling.readthedocs.io/en/latest/run.html

>  have been installed (please check ``doc/requirements.txt`` file). Sometimes the
>  Linux distros are providing them, but the best way is to use ``virtualenv``

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
