Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD1F8FA87
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 14:32:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99B433E4832
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 16:32:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 358D13E1B27
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:32:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D6F41A006E9
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 16:32:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0975A5BCD7;
 Tue, 21 Apr 2026 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776781926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAUSlCQEOPx+kAX7TqrBhm9VGQh52NU3dxOxQ+FdCBE=;
 b=JDrHLWlbrWDehDivMUHWDwStJopBLelp7eil1hJ8lAEi/QUc7Acenwkml7EvjYx7Utova9
 l5DRZmanDUsw/Z8mG5rLlpLu/z8f9XtZe08zjeq9ofC4c+kGiwdQ2X0OotpSjYf5Yq/rFc
 wPRDBBRqpKU6CO61aCiAvOWZOB5NgxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776781926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAUSlCQEOPx+kAX7TqrBhm9VGQh52NU3dxOxQ+FdCBE=;
 b=u+zGUqMzDV4NbLvDZT8ZV0jbl2lfztWKVBTi8CGT5Tht6HuwtvTWvaiOgm/nLdK+w/a99m
 UD443jBcRTS3BSDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776781926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAUSlCQEOPx+kAX7TqrBhm9VGQh52NU3dxOxQ+FdCBE=;
 b=JDrHLWlbrWDehDivMUHWDwStJopBLelp7eil1hJ8lAEi/QUc7Acenwkml7EvjYx7Utova9
 l5DRZmanDUsw/Z8mG5rLlpLu/z8f9XtZe08zjeq9ofC4c+kGiwdQ2X0OotpSjYf5Yq/rFc
 wPRDBBRqpKU6CO61aCiAvOWZOB5NgxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776781926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAUSlCQEOPx+kAX7TqrBhm9VGQh52NU3dxOxQ+FdCBE=;
 b=u+zGUqMzDV4NbLvDZT8ZV0jbl2lfztWKVBTi8CGT5Tht6HuwtvTWvaiOgm/nLdK+w/a99m
 UD443jBcRTS3BSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7123593AF;
 Tue, 21 Apr 2026 14:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qHvlMGWK52mOTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Apr 2026 14:32:05 +0000
Date: Tue, 21 Apr 2026 16:32:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260421143200.GA611911@pevik>
References: <20260325120629.113245-1-pvorel@suse.cz>
 <acT03xEWLjfMjU9z@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acT03xEWLjfMjU9z@yuki.lan>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.h: Convert rest of doc to kerneldoc
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

...
> > +/**
> > + * tst_set_runtime() - Sets maximal test runtime in seconds.
> > + *
> > + * Allows for setting the runtime per test iteration dynamically during the test
> > + * setup phase. The runtime is specified in seconds and defines how long the
> > + * test is allowed to execute its main workload, excluding the setup and
> > + * teardown phases.
> > + *
> > + * This function is useful for tests where the duration of the main workload can
> > + * be controlled or needs to be adjusted dynamically. For example, tests that
> > + * run in a loop until the runtime expires can use this function to define how
> > + * long they should execute.

> Maybe add:

> A test that sets a runtime must monitor the remaining time with
> tst_remaining_runtime() in the main loop.

I understand it as: "tests which calls tst_set_runtime() needs also use
tst_remaining_runtime() for monitoring. FYI while some tests do that (e.g.
starvation.c, fsplough.c), some don't (e.g. semget05.c, readahead02.c,
crash02.c). Obviously they are not interrupted in the middle of action, but
maybe check them once you have time.

Also it might be worth if you check the description of the timeout and runtime
members of struct tst_test
https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-members

Going to finally send v2.

Kind regards,
Petr

> > + * @runtime: A timeout in seconds.
> >   */
> >  void tst_set_runtime(int runtime);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
