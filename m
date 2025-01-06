Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABD6E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 16:20:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38D3D3C69EA
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 17:20:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C14473C336D
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 17:20:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EFC3C63DC5F
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 17:20:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 196432116D;
 Mon,  6 Jan 2025 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736180418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJXxD28yRMxq7YKDv8razuTCETHQPTyoPHNamabMYSY=;
 b=Jjzq48o/jUssN1H5hr68lYDxkgQ/OXhSZa0E4DYxgORpcoJJ288/7ynmBctw+cVXeHtdLq
 jRmE9PJ48943wQvh9U0fiqokPeZrNG+9i5HOPVTVtKTky5EU9026Exjs9MjyBeV2AJoOlR
 rnRxDPX8mpIVIl3ZPfzH3P0YUBMDhe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736180418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJXxD28yRMxq7YKDv8razuTCETHQPTyoPHNamabMYSY=;
 b=5OQ2/cpbpr6WXE9kqUHjsLxwM6kPAZq2678g/iMqtovNufYpGPAka4u5L9/sc71/BbxUmO
 wjsniHyhXo8W3uCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736180418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJXxD28yRMxq7YKDv8razuTCETHQPTyoPHNamabMYSY=;
 b=Jjzq48o/jUssN1H5hr68lYDxkgQ/OXhSZa0E4DYxgORpcoJJ288/7ynmBctw+cVXeHtdLq
 jRmE9PJ48943wQvh9U0fiqokPeZrNG+9i5HOPVTVtKTky5EU9026Exjs9MjyBeV2AJoOlR
 rnRxDPX8mpIVIl3ZPfzH3P0YUBMDhe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736180418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJXxD28yRMxq7YKDv8razuTCETHQPTyoPHNamabMYSY=;
 b=5OQ2/cpbpr6WXE9kqUHjsLxwM6kPAZq2678g/iMqtovNufYpGPAka4u5L9/sc71/BbxUmO
 wjsniHyhXo8W3uCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0A9F137DA;
 Mon,  6 Jan 2025 16:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aKdxOMECfGeKVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 16:20:17 +0000
Date: Mon, 6 Jan 2025 17:19:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z3wCr3LG_ztyQYHj@yuki.lan>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
 <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan> <20250106125255.GC302614@pevik>
 <Z3vc-PafjaXVIcRJ@yuki.lan> <20250106153624.GB323533@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106153624.GB323533@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> And if value does not get changed it's the default value. Also name is a bit
> confusing (you suggest to have members "timeout", "runtime"), which suggest the
> special value is related to both.
> 
> OK, flag which would allow us to see that time will be changed.
> 
> > Then all long running test would have either tst_test->timeout or
> > tst_test->runtime set.
> 
> > Technically we would need two special timeout values
> > TST_UNLIMITED_TIMEOUT and TST_RUNTIME_TIMEOUT.
> 
> OK, TST_UNLIMITED_TIMEOUT is equivalent of:
> 
> #define TST_UNLIMITED_RUNTIME (-1)
> 
> Maybe have just single definition TST_UNLIMITED, which could be used in both
> tst_test->timeout and tst_test->runtime? But that's just an implementation
> detail.

The UNLIMITED_RUNTIME would not be needed anymore. Because runtime will
mean _only_ for how long will a few tests spend in the main loop.
Infinite loop does not make any sense. The tst_runtime will be basically
renamed to timeout and TST_UNLIMITED_RUNTIME becomes
TST_UNLIMITED_TIMEOUT.

> > > > Maybe we should have called the max_runtime a timeout and add runtime
> > > > for tests that needs it. That way we would have timeout compromising of
> > > > two parts, one would be the 30s that is used for all tests and second
> > > > part from the tst_test structure. And then the sum of these two would be
> > > > multiplied by the timeout multipliers. Then we would have a runtime,
> > > > which would be used only by tests that call tst_remaining_runtime().
> 
> OK, the point of whole change is to separate some general timeout (30 sec) from
> runtime (used for tst_remaining_runtime()), right?

The point is to separate timeout, which is a guess on upper bound on the
time the test will spend executing from a runtime which is the exact
time a few tests will spend looping in the test function.

> > > > The overall test timeout would be then:
> 
> > > > (default_30s_timeout + tst_test->timeout) * TIMEOUT_MUL + tst_test->runtime * RUNTIME_MUL
> 
> (default_30s_timeout + tst_test->timeout) * TIMEOUT_MUL is meant for setup or
> cleanup and library overhead, tst_test->runtime * RUNTIME_MUL for running test
> function?

No, it's the other way around. The timeout is a guessed upper bound for
a test execution time. It's for everything the test does and in most of
the cases only the default timeout (which is kind of safety measure) is
sufficient. Then there are tests that do some work that is not time
bound, e.g. I/O. In that case we set the timeout in the tst_test
structure to some value we measured in practice and that plus the
default timeout will become the overall test timeout.

Then we have a few testcases that do a loop in the test function that
takes exact time. In that case we know that we spend exactly runtime in
the test function, but there is a setup and cleanup as well. So we add
the default timeout to the runtime to get the overall timeout. There may
be also a case where the test setup for such test takes some time, in
that case we would set both the timeout and runtime in the tst_test
structure. The timeout would be upper bound for the test setup and
runtime would be exactly for how long will the test function loop.

Mainly this would make sure that if timeout part of the overall test
time limit gets multiplied, because we are running on a slow system, the
runtime will not. Because we could control the timeout and runtime
separately.

> > Not only, the default 30s timeout is for the whole testrun for tests
> > that are quick enough. We have a lot of tests that run just for less
> > than 1s even on small embedded boards.
> 
> And yes, with properly set data, 30s could be carefully lowered down a bit.

That was my long term plan.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
