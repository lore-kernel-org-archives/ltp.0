Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA37C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:36:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 983993D0A9D
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 18:36:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C3F3C23B7
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:35:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C35A3140096D
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:35:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2421721B75;
 Fri,  7 Jun 2024 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717778153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+LcV98nNLL8OeJvT1rV5u+64AgQfGjrtaYNDHAeD+M=;
 b=wDHUj58k8OS9oYcDSPHvhBObTC0JyfAtAAYpgZ4QeEDQa4FV6XcBeYIoil9vaNuQXojpcD
 rPgt7RZh/PmiGG3MMQjUd0c+ZxZCQl363PWYt0Ax5hLzAHsbVK3WZfVx5dEks4BxuB6H2O
 cdhK4+r2VIX4v54OU+gnu+WUAF8MGaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717778153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+LcV98nNLL8OeJvT1rV5u+64AgQfGjrtaYNDHAeD+M=;
 b=+7R794vnTo4Tyg0OdZUHePJHZGfEy4D1DxEwyPuCH6tQm9MdQAeW9fRQmH4VGz+tCMUUtX
 4We9kctjVdny0vBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717778153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+LcV98nNLL8OeJvT1rV5u+64AgQfGjrtaYNDHAeD+M=;
 b=wDHUj58k8OS9oYcDSPHvhBObTC0JyfAtAAYpgZ4QeEDQa4FV6XcBeYIoil9vaNuQXojpcD
 rPgt7RZh/PmiGG3MMQjUd0c+ZxZCQl363PWYt0Ax5hLzAHsbVK3WZfVx5dEks4BxuB6H2O
 cdhK4+r2VIX4v54OU+gnu+WUAF8MGaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717778153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+LcV98nNLL8OeJvT1rV5u+64AgQfGjrtaYNDHAeD+M=;
 b=+7R794vnTo4Tyg0OdZUHePJHZGfEy4D1DxEwyPuCH6tQm9MdQAeW9fRQmH4VGz+tCMUUtX
 4We9kctjVdny0vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D52C133F3;
 Fri,  7 Jun 2024 16:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wuvhAuk2Y2bUMgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jun 2024 16:35:53 +0000
Date: Fri, 7 Jun 2024 18:35:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <ZmM25L0EmJufsS-f@yuki>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > This does therefore worry me a little bit, there appears to be a lot
> > > of complexity in kirk we don't need.
> > =

> > I would say that there is a complexity that you do not think that you
> > need but in reality you do. First of all the assumption that you can
> > have the test runner that keeps the results and overall state on the
> > same machine that runs the tests is the most flawed of them all. So
> > running the tests over some kind of connection is the basis design
> > principle of kirk. That allows us to easily and safely detect when we
> > crash kernels with our tests, which tend to happen more often than most
> > people think. And I can go about all the things that are there because
> > of a good reasons for hours.
> =

> I think you misunderstand my point. Yocto project already has code to
> handle setting up qemu instances, connecting to them, collecting data
> from them etc. and we use that with ltp in the same way we use it for
> lots of other tests. So yes, I agree with you that you need a
> connection but we already have a solution for that.=A0
> =

> We probably don't want some tests doing this with kirk and everything
> else doing it differently. I suspect we wouldn't want to switch
> everything we're doing over to kirk either as that wouldn't work for us
> or the kirk maintainers due to differing needs and expectations.

This may actually work, since we are trying to make kirk flexible enough
to run other testsuites, I think that we already run subset of selftest
with kirk in our environment.

> > That being said, the current kirk implementation ended up more complex
> > than I would like it, and that is something to improve over the
> > deprecation period. The general idea is to allow users to experiment
> > with kirk, even when it's not perfect to get feedback and ideally make
> > it usable for most usecases before we get rid of runltp for good.
> =

> It sounds like we need to switch to kirk and use it simply as a direct
> run host driver, but we are going to have a lot of complexity in there
> we aren't in need of.

I'm afraid that's not a good solution either. The end goal for kirk is
to have a small binary locked in RAM and with realtime priority to
execute tests and send back logs, in case of qemu over virtio, to the
kirk. That is to make sure that logs are collected properly even when
kernel is out of memory and in a similar situations.

If you run kirk on the VM, reporting is not going to be reliable.

My initial idea was to build the new generation testrunner as a set of
building blocks, that could be reused separately, but the current desing
does not make it easy.

We do have the ltx binary, which is the small dispatcher supposed to run
on the VM. And in an ideal world we would have a python library that
talks to it on the other end, as a part of kirk, that could be reused
separately. And the same for building lists of test to execute, ideally
we would have a python library that would export a simple interface so
that everyone could integrate the blocks that they really need into
their solution.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
