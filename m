Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EC71061B18
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 22:54:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DA3B3E9320
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 00:54:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB8D83C18F1
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 00:53:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C34B71000D31
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 00:53:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C70F15BD80;
 Mon, 30 Mar 2026 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774911235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4G4AkYRRP3bYcf2HMUdgZiOmF2WXNRci5wbC8iXZRY=;
 b=a1esk4i0fcfwZPdmyPutDrG0SYmSIA2JfsnKjWmLyzCsWr6s9H4BoLkuavcDx085n7TLAf
 bOJBPOM4jzpB8iLUxbYcfOZVz9DFfrQUqTeJfgF6VrExB7mMJToSlEfRdC2N9PjX8k1MRB
 xpF967IPVn3af9RDTHMHpB5VvzWPmx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774911235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4G4AkYRRP3bYcf2HMUdgZiOmF2WXNRci5wbC8iXZRY=;
 b=EkxFHkXY4+oY+hFEO/CuB4Xiwyjsdwn4KV/Fexr5J5IxiJca4HChlYzcU9X9N4+RppfqhY
 /eEaoRf7dowRirBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774911235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4G4AkYRRP3bYcf2HMUdgZiOmF2WXNRci5wbC8iXZRY=;
 b=a1esk4i0fcfwZPdmyPutDrG0SYmSIA2JfsnKjWmLyzCsWr6s9H4BoLkuavcDx085n7TLAf
 bOJBPOM4jzpB8iLUxbYcfOZVz9DFfrQUqTeJfgF6VrExB7mMJToSlEfRdC2N9PjX8k1MRB
 xpF967IPVn3af9RDTHMHpB5VvzWPmx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774911235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4G4AkYRRP3bYcf2HMUdgZiOmF2WXNRci5wbC8iXZRY=;
 b=EkxFHkXY4+oY+hFEO/CuB4Xiwyjsdwn4KV/Fexr5J5IxiJca4HChlYzcU9X9N4+RppfqhY
 /eEaoRf7dowRirBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A63CD4A0A2;
 Mon, 30 Mar 2026 22:53:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qVywJQP/ymmtVgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 22:53:55 +0000
Date: Tue, 31 Mar 2026 00:53:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260330225353.GA108555@pevik>
References: <20260326125216.159239-1-pvorel@suse.cz>
 <acYYc47HXGYa5Mqj@redhat.com> <20260327090505.GA40147@pevik>
 <acaDd9VjQX-FtCkb@yuki.lan> <acaDztrhBMninsBV@yuki.lan>
 <20260327151741.GA1092845@pevik> <acarQ7I8FUNNtDpg@yuki.lan>
 <20260327164459.GA1097030@pevik> <acqPsJkCQXlH9gx5@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acqPsJkCQXlH9gx5@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
> > > > > > > Nothing besides trying to fix 6.11 (which was not the case) and trying to
> > > > > > > simplify. But whole effort is somehow relevant to general checking test
> > > > > > > requirements cleanup (we had a discussion runtime checks vs. kconfig/min_kver
> > > > > > > which resulted in Cyril's "lib: tst_kconfig: Add runtime checks" [2]).

> > > > > > I guess that the check for all userfaultfd tests should be moved to the
> > > > > > tst_kconfig.c once my patch that adds runtime checks there is in.

> > > > > Or I can send a V3 that adds that check as well.

> > > > Sure, having /dev/userfaultfd in kconfig check would be a benefit. Thanks!

> > > However it looks like we cannot do that, the /dev/userfaultfd was added
> > > into 6.1 while the usefaultfd syscall existed since 4.3. Hence tests
> > > that need /dev/userfaultfd need additional checks.

> > We require for userfaultfd05.c also CONFIG_HAVE_ARCH_USERFAULTFD_WP=y.
> > Maybe bound /dev/userfaultfd check to it?  OTOH
> > CONFIG_HAVE_ARCH_USERFAULTFD_WP=y is much older (v5.19-rc1) and original commit
> > in 6.1 [1] does not refer to it.

> Does not work either, the /dev/userfaultfd was added without any changes
> in CONFIG. If we wanted this as generic funcitionality we would have to
> add .needs_devices field into tst_test structure but as far as I my
> grepping shows, usefaultfd is at the moment the only test that depends
> on a device that has been added recently so it does not look like
> it's worth the trouble.

Agree (not worth of the trouble).
Thanks for checking.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
