Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96DC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:22:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C37743CDCB6
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 16:22:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76833CDB74
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:22:12 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3BFC062D8E3
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:22:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46E1B3402E;
 Tue,  7 May 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A484913A2D;
 Tue,  7 May 2024 14:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6ZLWIxI5OmYkPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 14:22:10 +0000
Date: Tue, 7 May 2024 16:22:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240507142204.GA138935@pevik>
References: <20240430122208.13043-1-mdoucha@suse.cz>
 <20240430122208.13043-2-mdoucha@suse.cz>
 <20240506194156.GA38981@pevik>
 <cd8f5fb9-606b-4543-8a3e-02079d2ea630@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd8f5fb9-606b-4543-8a3e-02079d2ea630@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 46E1B3402E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] KVM: Disable EBP register use in 32bit code
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

> On 06. 05. 24 21:41, Petr Vorel wrote:
> > >   ifeq ($(HOST_CPU),x86)
> > > -	GUEST_CFLAGS += -m32
> > > +	GUEST_CFLAGS += -m32 -ffixed-ebp

> > FYI this will fail on 32 bit build on clang:

> > clang: error: unknown argument: '-ffixed-ebp'

> > I don't want to block this patchset which brings important test, but it'd be
> > great to fix it.

> > Is there clang equivalent? Or is it even needed for clang?

> > Either way, we need to detect clang. I don't think simple

> > ifeq ($(CXX),clang)

> > would be enough, because cc can be alias to clang.
> Hmm, I need to fix this. I guess that configure should just check for
> -ffixed-ebp support.

Yes, that would be ideal solution which I definitely don't want to force you.

> Fortunately, clang doesn't generate code that would
> trigger stack segment fault so the workaround is only needed for GCC.

Great!

> Could you review and merge the trivial patches (4, 5, 6, 7) so that I don't
> need to resubmit everything?

Sure!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
