Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3BDE77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:39:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AA013C4C03
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:39:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDA363C4BFD
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:39:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 38D721001F37
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:39:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BB8C21102;
 Mon,  6 Jan 2025 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736170762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5E942yni94owsxJIrx/qcPATEX9fv+ghsrXUKgftEw=;
 b=INGTmXDt4+U4g8vIkByABMPSyX5QmNp8hsXXRW/ZKtHDkyfe1ke+hI4BCKnXxU1rkT6E9y
 VQNp3oAvbaH7cxoLGIlre3hUVh1Pzhr6/6vOL3Ti0NAGoH0pThsQC875KaMLJz9X2WB/hx
 szfSq7kaVBtP2Wf6VoJczXg4SjFnMvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736170762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5E942yni94owsxJIrx/qcPATEX9fv+ghsrXUKgftEw=;
 b=qRbhUdxzxJHeThjkbwOvlj5AAig/MMw+P3SkiTDEubaTFE6R5LpmaOePCpeIY0W86K7IH5
 v3GLTt+95TsrvIAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=INGTmXDt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qRbhUdxz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736170762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5E942yni94owsxJIrx/qcPATEX9fv+ghsrXUKgftEw=;
 b=INGTmXDt4+U4g8vIkByABMPSyX5QmNp8hsXXRW/ZKtHDkyfe1ke+hI4BCKnXxU1rkT6E9y
 VQNp3oAvbaH7cxoLGIlre3hUVh1Pzhr6/6vOL3Ti0NAGoH0pThsQC875KaMLJz9X2WB/hx
 szfSq7kaVBtP2Wf6VoJczXg4SjFnMvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736170762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5E942yni94owsxJIrx/qcPATEX9fv+ghsrXUKgftEw=;
 b=qRbhUdxzxJHeThjkbwOvlj5AAig/MMw+P3SkiTDEubaTFE6R5LpmaOePCpeIY0W86K7IH5
 v3GLTt+95TsrvIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ABBA139AB;
 Mon,  6 Jan 2025 13:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +T7LGQrde2cWLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:39:22 +0000
Date: Mon, 6 Jan 2025 14:39:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z3vc-PafjaXVIcRJ@yuki.lan>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
 <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan> <20250106125255.GC302614@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106125255.GC302614@pevik>
X-Rspamd-Queue-Id: 7BB8C21102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
> > > I did a quick grep that some ltp-aiodio tests set it to 1800 sec, which
> > > only 8/91 occupation in the LTP testcases/, I'm not sure if it's worth
> > > adding a new field for those few stress tests.
> 
> > > And with the previous method, the multiple 4 max_runtime for 1800s
> > > is 2hours per test up limit, I can't imagine how long we will get eventually
> > > in the whole test time.
> 
> > > Maybe another way is to create a separate function in a header
> > > like aio_common.h (or in high-level dir) for handling that significantly
> > > larger runtime tests.
> 
> > > BTW, we have TST_UNLIMITED_RUNTIME choice or, invoke
> > > tst_set_max_runtime() in somehow.
> 
> > I stil think that misusing max_runtime, which is supposed to be upper
> > bound for the actual test runtime was a mistake.
> 
> Do you want to separate timeout for setup() and for actual test run?
> Which one would be prolonged in case of "slow" kernels? (e.g. this patch).

Currently the test timeout applies both for the setup, single test
iteration and cleanup. So the short answer is both.

> Or you want to fix -iN?

After each test iteration the child signals the parent that the
iteration has been finished and that restarts the timeout timer.

The test overall timeout is computed in set_timeout() and currently is
computed as:

	results->timeout = tst_multiply_timeout(timeout) + results->max_runtime;


And the tst_multiply_tiemout() would then be changed into:

	return (DEFAULT_TIMEOUT + tst_test->timeout) * timeout_mul;

> Also for docs purposes it might be useful to list long running tests.
> Fortunately there are just few tests which calls tst_set_max_runtime()
> for dynamically set timeout.

That would be actually easier, because we could do:

- add special value TST_RUNTIME_TIMEOUT
- allow test to change timeout only if TST_RUNTIME_TIMEOUT was set in
  tst_test

Then all long running test would have either tst_test->timeout or
tst_test->runtime set.

Technically we would need two special timeout values
TST_UNLIMITED_TIMEOUT and TST_RUNTIME_TIMEOUT.

> > Maybe we should have called the max_runtime a timeout and add runtime
> > for tests that needs it. That way we would have timeout compromising of
> > two parts, one would be the 30s that is used for all tests and second
> > part from the tst_test structure. And then the sum of these two would be
> > multiplied by the timeout multipliers. Then we would have a runtime,
> > which would be used only by tests that call tst_remaining_runtime().
> 
> > The overall test timeout would be then:
> 
> > (default_30s_timeout + tst_test->timeout) * TIMEOUT_MUL + tst_test->runtime * RUNTIME_MUL
> 
> > What do you think?
> 
> Timeout is for setup function, right? e.g. for ioctl_sg01? If yes, timeout is
> too generic, IMHO many people will think that it's a general test timeout.
> I would think about general name.

Not only, the default 30s timeout is for the whole testrun for tests
that are quick enough. We have a lot of tests that run just for less
than 1s even on small embedded boards.

> The above formula should be written in the docs in the separate description and
> this section should be linked in TIMEOUT_MUL and RUNTIME_MUL description [1].

Yes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
