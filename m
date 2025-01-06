Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D386E77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 12:53:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB9BF3C4BFA
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:53:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C15CC3C4B8B
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 13:53:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D59B021CBFA
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 13:53:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B7F31F399;
 Mon,  6 Jan 2025 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736167985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xT+ilnngS6o3iZ8UaUAO8mbNcZ0W75Q21cX66Dz8hBI=;
 b=AfhdUuvjYPzEoNa+uWFlxhYQoD/rl3hbtMlxtyFQ0QgQFDoCzopASrXUX4OjOmS0RDv9YW
 vCYP6B9rv2pMUo7ghFeb/OjBQrACuHMgheYa+6IvVr1pTmwFmTQZ4x452PgEtaYnozF8cE
 F56kkNxrdDyAKJcAQZgnLY2WmhV9TY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736167985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xT+ilnngS6o3iZ8UaUAO8mbNcZ0W75Q21cX66Dz8hBI=;
 b=a7j/oo03Seedtk4l9yKc4dgM2eZuVBrGDe+5KnG2+27mqxRg+0zsrKkLCy9iuUDVz/eHfc
 A65VUOU/pqS/tUBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AfhdUuvj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="a7j/oo03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736167985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xT+ilnngS6o3iZ8UaUAO8mbNcZ0W75Q21cX66Dz8hBI=;
 b=AfhdUuvjYPzEoNa+uWFlxhYQoD/rl3hbtMlxtyFQ0QgQFDoCzopASrXUX4OjOmS0RDv9YW
 vCYP6B9rv2pMUo7ghFeb/OjBQrACuHMgheYa+6IvVr1pTmwFmTQZ4x452PgEtaYnozF8cE
 F56kkNxrdDyAKJcAQZgnLY2WmhV9TY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736167985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xT+ilnngS6o3iZ8UaUAO8mbNcZ0W75Q21cX66Dz8hBI=;
 b=a7j/oo03Seedtk4l9yKc4dgM2eZuVBrGDe+5KnG2+27mqxRg+0zsrKkLCy9iuUDVz/eHfc
 A65VUOU/pqS/tUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D279137DA;
 Mon,  6 Jan 2025 12:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +WxsBTHSe2fJIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jan 2025 12:53:05 +0000
Date: Mon, 6 Jan 2025 13:52:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250106125255.GC302614@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
 <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z3vII4tENjV4G6GQ@yuki.lan>
X-Rspamd-Queue-Id: 5B7F31F399
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigsD
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I did a quick grep that some ltp-aiodio tests set it to 1800 sec, which
> > only 8/91 occupation in the LTP testcases/, I'm not sure if it's worth
> > adding a new field for those few stress tests.

> > And with the previous method, the multiple 4 max_runtime for 1800s
> > is 2hours per test up limit, I can't imagine how long we will get eventually
> > in the whole test time.

> > Maybe another way is to create a separate function in a header
> > like aio_common.h (or in high-level dir) for handling that significantly
> > larger runtime tests.

> > BTW, we have TST_UNLIMITED_RUNTIME choice or, invoke
> > tst_set_max_runtime() in somehow.

> I stil think that misusing max_runtime, which is supposed to be upper
> bound for the actual test runtime was a mistake.

Do you want to separate timeout for setup() and for actual test run?
Which one would be prolonged in case of "slow" kernels? (e.g. this patch).

Or you want to fix -iN?

Also for docs purposes it might be useful to list long running tests.
Fortunately there are just few tests which calls tst_set_max_runtime()
for dynamically set timeout.

> Maybe we should have called the max_runtime a timeout and add runtime
> for tests that needs it. That way we would have timeout compromising of
> two parts, one would be the 30s that is used for all tests and second
> part from the tst_test structure. And then the sum of these two would be
> multiplied by the timeout multipliers. Then we would have a runtime,
> which would be used only by tests that call tst_remaining_runtime().

> The overall test timeout would be then:

> (default_30s_timeout + tst_test->timeout) * TIMEOUT_MUL + tst_test->runtime * RUNTIME_MUL

> What do you think?

Timeout is for setup function, right? e.g. for ioctl_sg01? If yes, timeout is
too generic, IMHO many people will think that it's a general test timeout.
I would think about general name.

The above formula should be written in the docs in the separate description and
this section should be linked in TIMEOUT_MUL and RUNTIME_MUL description [1].

Maybe part of library README.md [2], which itself should be also moved to sphinx
docs.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/setup_tests.html#library-environment-variables
[2] https://github.com/linux-test-project/ltp/blob/master/lib/README.md

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
