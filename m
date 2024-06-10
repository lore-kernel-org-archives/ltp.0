Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31D7C27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 16:55:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A73F3D0B69
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 18:55:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DC193D0B33
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 18:54:44 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7627F1A00362
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 18:54:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B3C521F03;
 Mon, 10 Jun 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22DE113A51;
 Mon, 10 Jun 2024 16:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dAN/B9IvZ2bSbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 16:54:42 +0000
Date: Mon, 10 Jun 2024 18:54:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <20240610165440.GA780610@pevik>
References: <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <ZmbFyjuXndeXCLp8@rei>
 <SA3PR13MB63722C60AE789DABBCB3A311FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SA3PR13MB63722C60AE789DABBCB3A311FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7B3C521F03
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tim,

> In that case, would kirk or python be required on the target?
> I presume that ltx runs on the target, and that is it a native app?

Yes.

> What are its dependencies?

IMHO no dependencies, except C toolchain. Our openSUSE spec file [1] list
nothing.

Running make on sources [2] show just:

cc -pedantic -W -Wall -Imsgpack \
	msgpack/message.c msgpack/unpack.c ltx.c main.c -o ltx

I.e. just plain source code without dependencies.

Kind regards,
Petr

[1] https://build.opensuse.org/projects/benchmark:ltp:devel/packages/ltx/files/ltx.spec?expand=1
[2] https://github.com/linux-test-project/ltx/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
