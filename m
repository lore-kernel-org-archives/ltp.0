Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F55AC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 17:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058E33D0AC2
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 19:34:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B5273D075F
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 19:33:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 612F0200743
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 19:33:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 971DB21B51;
 Fri,  7 Jun 2024 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717781626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjcg3V1bJF2fSS8V6kUy6kne6P1OZkyUoQSW7GnKxeU=;
 b=2IgC7tmR3ordnJxVaTEjnM+U7v+4g4yicNALJ4kn+0PaxUs7P8d4l93AwTSxGJCkONqa2Q
 S0qjmJq/JOflFmPNhMxrKt9iuRr+kq9EelUuce/NLsA+inzThx4XPEH8qld98yFQueIj7R
 p/3vJePu3VHuI/8gsMDaOGbKXg4MGNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717781626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjcg3V1bJF2fSS8V6kUy6kne6P1OZkyUoQSW7GnKxeU=;
 b=bVqOhYcaqXVvOi+PApM0GSibAIISkhvuaoNfxoK///gAVYQVvoyPdONxKsYVTRpTfeq8xJ
 G1FOJgYtIsR920Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717781626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjcg3V1bJF2fSS8V6kUy6kne6P1OZkyUoQSW7GnKxeU=;
 b=2IgC7tmR3ordnJxVaTEjnM+U7v+4g4yicNALJ4kn+0PaxUs7P8d4l93AwTSxGJCkONqa2Q
 S0qjmJq/JOflFmPNhMxrKt9iuRr+kq9EelUuce/NLsA+inzThx4XPEH8qld98yFQueIj7R
 p/3vJePu3VHuI/8gsMDaOGbKXg4MGNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717781626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjcg3V1bJF2fSS8V6kUy6kne6P1OZkyUoQSW7GnKxeU=;
 b=bVqOhYcaqXVvOi+PApM0GSibAIISkhvuaoNfxoK///gAVYQVvoyPdONxKsYVTRpTfeq8xJ
 G1FOJgYtIsR920Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 834BC134C7;
 Fri,  7 Jun 2024 17:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TqDFH3pEY2YWRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jun 2024 17:33:46 +0000
Date: Fri, 7 Jun 2024 19:33:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <ZmNEW_Q20Cf7hnUr@yuki>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This may actually work, since we are trying to make kirk flexible enough
> > to run other testsuites, I think that we already run subset of selftest
> > with kirk in our environment.
> 
> I'm not convinced that would be a great fit for either project to be
> honest. Reading more below, you have a very specific idea of how
> communication should happen and many of our test workflow needs are
> going to be outside of scope of a single binary communicating over
> virtio. It makes sense for kernel testing but we have other needs.

Fair enough.

> > > > That being said, the current kirk implementation ended up more complex
> > > > than I would like it, and that is something to improve over the
> > > > deprecation period. The general idea is to allow users to experiment
> > > > with kirk, even when it's not perfect to get feedback and ideally make
> > > > it usable for most usecases before we get rid of runltp for good.
> > > 
> > > It sounds like we need to switch to kirk and use it simply as a direct
> > > run host driver, but we are going to have a lot of complexity in there
> > > we aren't in need of.
> > 
> > I'm afraid that's not a good solution either. The end goal for kirk is
> > to have a small binary locked in RAM and with realtime priority to
> > execute tests and send back logs, in case of qemu over virtio, to the
> > kirk. That is to make sure that logs are collected properly even when
> > kernel is out of memory and in a similar situations.
> > 
> > If you run kirk on the VM, reporting is not going to be reliable.
> 
> This means you're effectively mandating how ltp be run and the only
> variable would be the kernel binary. Whilst I can understand that, I'm
> not sure how useful us testing with this would be.

Not at all. As I replied to Tim, there is no secret sauce in runltp or
kirk. In the end it's a tool to execute a test binaries. If you have a
system that can execute binaries, reliably transfer logs and handle
kernel crashes you can as well just execute the tests yourself. All you
need from us is a tooling that will produce a list(s) of tests to
execute.

> > My initial idea was to build the new generation testrunner as a set of
> > building blocks, that could be reused separately, but the current desing
> > does not make it easy.
> > 
> > We do have the ltx binary, which is the small dispatcher supposed to run
> > on the VM. And in an ideal world we would have a python library that
> > talks to it on the other end, as a part of kirk, that could be reused
> > separately. And the same for building lists of test to execute, ideally
> > we would have a python library that would export a simple interface so
> > that everyone could integrate the blocks that they really need into
> > their solution.
> 
> Automated testing is a hard problem to solve generically and even if
> you do manage that, this all looks like a lot of work even just to
> reproduce what works today :/.

Indeed. However I stil think that there are reusable parts that may be
worth putting together.

> I do understand the idea but in practise, I don't have the time or know
> anyone with the time to put into something like this. I can barely keep
> the tests/infra we have running.

This reminds me:

https://en.wikipedia.org/wiki/Boots_theory

If we apply that to software not being able to inovate keeps you doing
work that shouldn't needed to be done in the first place.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
