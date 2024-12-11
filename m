Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC381E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 19:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9918E3E9BD7
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 20:37:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3CD93E93AC
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:36:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1ABEB602772
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:36:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 969911F38D;
 Wed, 11 Dec 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 256711344A;
 Wed, 11 Dec 2024 19:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hpz7AtbpWWdREAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 19:36:54 +0000
Date: Wed, 11 Dec 2024 20:36:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241211193652.GC443680@pevik>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-5-chrubis@suse.cz>
 <20241211001106.GE386508@pevik> <Z1lg6tNdAzzL2UAh@rei.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z1lg6tNdAzzL2UAh@rei.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 969911F38D
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] lib/tst_res_.c: Add TBROK handler + more
 verbose errors
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
> > > We use the tst_res_ helper for tst_brk_ as well so we need to be able to
> > > handle TBROK type as well.

> > How can we call tst_brk_() via tst_res_() ?
> > 	tst_res_(argv[1], atoi(argv[2]), type, "%s", msg);

> In the end both of these functions increment counters, but in this case
> we need to return to the shell so we cannot call tst_brk() in the
> helper. It's a very special situation here.

Thanks for info. Maybe a little note anywhere (e.g. commit message) would help.

> > Also we have TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN check to not
> > add TBROK to tst_res_().

> That only works when the value is constant, if you pass via variable
> that is not constant at build time you can pass whatever you want. Which
> is another reason why it makes sense to relax the constraints.

Good point. So you plan to remove these build time checks?

Also we have nice docs from you include/tst_res_flags.h.
ATM include/tst_test.h and doc/old/C-Test-API.asciidoc are outdated,
but if you relax allowed ttype, than it would not need to be updated.

Also, any reason to not support TWARN?

I suppose we don't need TERRNO, TTERRNO, TRERRNO (not supported by tst_test.sh).

Anyway, LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
