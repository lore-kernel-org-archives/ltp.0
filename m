Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5471610F284E
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 16:45:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35103D03E3
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:45:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C79623C52FE
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 17:45:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58C596009D4
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 17:45:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C12455BE6B;
 Fri, 27 Mar 2026 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774629904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mK5wgXU7cGu6uNb/ijbjkSabPX1aYJ/EsEpfGHz3vk=;
 b=03BOt88CnidyGnPDJP5z4nUUPvINTjAl8mBT+4SXdF7Czz+MYS/SIq5U9CCgpN0HvWjmIb
 ZNBq1sF9G+fT1VYM/cYjW2JMbAQtH4yXShozZt8wwfcdtt8AMaxGzD8RsOs7Le9dtUVfaa
 oDIMcqF1yGfdU0oBXWeUZHbZOi+zthk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774629904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mK5wgXU7cGu6uNb/ijbjkSabPX1aYJ/EsEpfGHz3vk=;
 b=iVFGTD83DhOzhCx9/hEVVle1T5W+BUOXctk6HaM0LjO+QMjrQF6CGXqsCTTkMKed5bGVq5
 Nl0IPtv4IRfHaOBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774629904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mK5wgXU7cGu6uNb/ijbjkSabPX1aYJ/EsEpfGHz3vk=;
 b=03BOt88CnidyGnPDJP5z4nUUPvINTjAl8mBT+4SXdF7Czz+MYS/SIq5U9CCgpN0HvWjmIb
 ZNBq1sF9G+fT1VYM/cYjW2JMbAQtH4yXShozZt8wwfcdtt8AMaxGzD8RsOs7Le9dtUVfaa
 oDIMcqF1yGfdU0oBXWeUZHbZOi+zthk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774629904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mK5wgXU7cGu6uNb/ijbjkSabPX1aYJ/EsEpfGHz3vk=;
 b=iVFGTD83DhOzhCx9/hEVVle1T5W+BUOXctk6HaM0LjO+QMjrQF6CGXqsCTTkMKed5bGVq5
 Nl0IPtv4IRfHaOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7FFC4A0A2;
 Fri, 27 Mar 2026 16:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rGMVJxC0xmmhXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 16:45:04 +0000
Date: Fri, 27 Mar 2026 17:44:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260327164459.GA1097030@pevik>
References: <20260326125216.159239-1-pvorel@suse.cz>
 <acYYc47HXGYa5Mqj@redhat.com> <20260327090505.GA40147@pevik>
 <acaDd9VjQX-FtCkb@yuki.lan> <acaDztrhBMninsBV@yuki.lan>
 <20260327151741.GA1092845@pevik> <acarQ7I8FUNNtDpg@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acarQ7I8FUNNtDpg@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > > Nothing besides trying to fix 6.11 (which was not the case) and trying to
> > > > > simplify. But whole effort is somehow relevant to general checking test
> > > > > requirements cleanup (we had a discussion runtime checks vs. kconfig/min_kver
> > > > > which resulted in Cyril's "lib: tst_kconfig: Add runtime checks" [2]).

> > > > I guess that the check for all userfaultfd tests should be moved to the
> > > > tst_kconfig.c once my patch that adds runtime checks there is in.

> > > Or I can send a V3 that adds that check as well.

> > Sure, having /dev/userfaultfd in kconfig check would be a benefit. Thanks!

> However it looks like we cannot do that, the /dev/userfaultfd was added
> into 6.1 while the usefaultfd syscall existed since 4.3. Hence tests
> that need /dev/userfaultfd need additional checks.

We require for userfaultfd05.c also CONFIG_HAVE_ARCH_USERFAULTFD_WP=y.
Maybe bound /dev/userfaultfd check to it?  OTOH
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y is much older (v5.19-rc1) and original commit
in 6.1 [1] does not refer to it.

Also, general note about .needs_kconfig callbacks: I'm glad you chose TINFO
for "%s=%c present but disabled at runtime" message which is always visible,
because people will not expect runtime checks.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d5de004e009

> However it may be a good idea to add .needs_kconfig to all the
> userfaultfd tests we have.

+1. 4 of them does not have it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
