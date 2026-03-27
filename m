Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7867510F284D
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 16:07:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17AFF3D7E42
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:07:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF12C3D0197
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 17:07:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 40B7B6002E8
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 17:07:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4C3A5BEE1;
 Fri, 27 Mar 2026 16:07:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB1964A0A2;
 Fri, 27 Mar 2026 16:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ctwDKT2rxmkPNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Mar 2026 16:07:25 +0000
Date: Fri, 27 Mar 2026 17:07:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acarQ7I8FUNNtDpg@yuki.lan>
References: <20260326125216.159239-1-pvorel@suse.cz>
 <acYYc47HXGYa5Mqj@redhat.com> <20260327090505.GA40147@pevik>
 <acaDd9VjQX-FtCkb@yuki.lan> <acaDztrhBMninsBV@yuki.lan>
 <20260327151741.GA1092845@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327151741.GA1092845@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C4C3A5BEE1
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > Nothing besides trying to fix 6.11 (which was not the case) and trying to
> > > > simplify. But whole effort is somehow relevant to general checking test
> > > > requirements cleanup (we had a discussion runtime checks vs. kconfig/min_kver
> > > > which resulted in Cyril's "lib: tst_kconfig: Add runtime checks" [2]).
> 
> > > I guess that the check for all userfaultfd tests should be moved to the
> > > tst_kconfig.c once my patch that adds runtime checks there is in.
> 
> > Or I can send a V3 that adds that check as well.
> 
> Sure, having /dev/userfaultfd in kconfig check would be a benefit. Thanks!

However it looks like we cannot do that, the /dev/userfaultfd was added
into 6.1 while the usefaultfd syscall existed since 4.3. Hence tests
that need /dev/userfaultfd need additional checks.

However it may be a good idea to add .needs_kconfig to all the
userfaultfd tests we have.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
