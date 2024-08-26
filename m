Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBEBC5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 14:52:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDD803D1B57
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 16:52:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C07133CABA1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 16:52:40 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B9D8600C2A
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 16:52:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEC27219ED;
 Mon, 26 Aug 2024 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724683957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwqsT2Ocnp/l1xLpS6NFVB5VV2vK7xtli0BP9dBveY8=;
 b=dBqGqX2QZpvkJTY6vL6dBs20Vq2G6FHooJagtOXsWh4bP2HjGstbABs+aw+YUACQ6iHB3P
 ZS0NjWAsKwX/Thbtgs1aImErcWy2tGNvAwTJmJwe+XuzdwWiJRvStL72SNsiF5aWc/Jp3J
 WL2/y9qQWD5/bszO286djm30KDfBOnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724683957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwqsT2Ocnp/l1xLpS6NFVB5VV2vK7xtli0BP9dBveY8=;
 b=p1bIsHG+B5iqsX4YytfdeBq2ma3hZ75S4kOtXia1rUkg8jGJ6kT47q82UIj8e3k8QIm3KR
 RXYdJ7vHErsgH7BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724683957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwqsT2Ocnp/l1xLpS6NFVB5VV2vK7xtli0BP9dBveY8=;
 b=dBqGqX2QZpvkJTY6vL6dBs20Vq2G6FHooJagtOXsWh4bP2HjGstbABs+aw+YUACQ6iHB3P
 ZS0NjWAsKwX/Thbtgs1aImErcWy2tGNvAwTJmJwe+XuzdwWiJRvStL72SNsiF5aWc/Jp3J
 WL2/y9qQWD5/bszO286djm30KDfBOnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724683957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwqsT2Ocnp/l1xLpS6NFVB5VV2vK7xtli0BP9dBveY8=;
 b=p1bIsHG+B5iqsX4YytfdeBq2ma3hZ75S4kOtXia1rUkg8jGJ6kT47q82UIj8e3k8QIm3KR
 RXYdJ7vHErsgH7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5939813724;
 Mon, 26 Aug 2024 14:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P1OfFLWWzGbUXgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Aug 2024 14:52:37 +0000
Date: Mon, 26 Aug 2024 16:51:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <io@richiejp.com>
Message-ID: <ZsyWcCGmjaWWe7fK@yuki.lan>
References: <20240731092017.8267-1-chrubis@suse.cz>
 <20240731092017.8267-2-chrubis@suse.cz>
 <87wmkksafr.fsf@richiejp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wmkksafr.fsf@richiejp.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add support for mixing C and shell code
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
> In general I like the idea except that it will encourage more shell
> usage, but I'm guessing that is a battle that has already been
> lost.

Indeed. However messy shell is we are not going to get rid of it.

> Also if a suitable embedded scripting language were found this is
> a starting point for that.

My hopes are not that high, LTP targets embedded, so we are quite
limited in what we can do here and having python or perl as a dependency
is a no-go. Perhaps there is a minimalistic scripting language that
integrated into UNIX well out there, but I'm not aware of any. So as far
as I can tell we are stuck with shell for the foreseeable future.

> > This is a proof of a concept of a seamless C and shell integration. The
> > idea is that with this you can mix shell and C code as much as as you
> > wish to get the best of the two worlds.
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  include/tst_test.h                           | 38 +++++++++++++
> >  lib/tst_test.c                               | 51 +++++++++++++++++
> >  testcases/lib/.gitignore                     |  1 +
> >  testcases/lib/Makefile                       |  4 +-
> >  testcases/lib/run_tests.sh                   | 11 ++++
> >  testcases/lib/tests/.gitignore               |  6 ++
> >  testcases/lib/tests/Makefile                 | 11 ++++
> >  testcases/lib/tests/shell_test01.c           | 17 ++++++
> >  testcases/lib/tests/shell_test02.c           | 18 ++++++
> >  testcases/lib/tests/shell_test03.c           | 25 +++++++++
> >  testcases/lib/tests/shell_test04.c           | 18 ++++++
> >  testcases/lib/tests/shell_test05.c           | 27 +++++++++
> >  testcases/lib/tests/shell_test06.c           | 16 ++++++
> >  testcases/lib/tests/shell_test_brk.sh        |  6 ++
> >  testcases/lib/tests/shell_test_check_argv.sh | 23 ++++++++
> >  testcases/lib/tests/shell_test_checkpoint.sh |  7 +++
> >  testcases/lib/tests/shell_test_pass.sh       |  6 ++
> >  testcases/lib/tst_env.sh                     | 21 +++++++
> >  testcases/lib/tst_res_.c                     | 58 ++++++++++++++++++++
> >  19 files changed, 362 insertions(+), 2 deletions(-)
> >  create mode 100755 testcases/lib/run_tests.sh
> >  create mode 100644 testcases/lib/tests/.gitignore
> >  create mode 100644 testcases/lib/tests/Makefile
> >  create mode 100644 testcases/lib/tests/shell_test01.c
> >  create mode 100644 testcases/lib/tests/shell_test02.c
> >  create mode 100644 testcases/lib/tests/shell_test03.c
> >  create mode 100644 testcases/lib/tests/shell_test04.c
> >  create mode 100644 testcases/lib/tests/shell_test05.c
> >  create mode 100644 testcases/lib/tests/shell_test06.c
> >  create mode 100755 testcases/lib/tests/shell_test_brk.sh
> >  create mode 100755 testcases/lib/tests/shell_test_check_argv.sh
> >  create mode 100755 testcases/lib/tests/shell_test_checkpoint.sh
> >  create mode 100755 testcases/lib/tests/shell_test_pass.sh
> >  create mode 100644 testcases/lib/tst_env.sh
> >  create mode 100644 testcases/lib/tst_res_.c
> >
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index 6c76f043d..a334195ac 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -331,6 +331,8 @@ struct tst_fs {
> >   * @child_needs_reinit: Has to be set if the test needs to call tst_reinit()
> >   *                      from a process started by exec().
> >   *
> > + * @runs_script: Implies child_needs_reinit and forks_child at the moment.
> > + *
> >   * @needs_devfs: If set the devfs is mounted at tst_test.mntpoint. This is
> >   *               needed for tests that need to create device files since tmpfs
> >   *               at /tmp is usually mounted with 'nodev' option.
> > @@ -518,6 +520,7 @@ struct tst_fs {
> >  	unsigned int mount_device:1;
> >  	unsigned int needs_rofs:1;
> >  	unsigned int child_needs_reinit:1;
> > +	unsigned int runs_script:1;
> 
> This could be a string constant instead of a flag if you want to future
> proof against multiple scripting languages or you could change it to runs_shell.

Heh, Martin Doucha requtested runs_shell to be changed to runs_script,
and that was a rightful request, since there is actually nothing shell
specific in the test library, it just sets up env variables and passes
command line option to something that is executed by execvpe(). All that
is missing for any other scripting language is a bit of glue code that
would interface the shared memory passed down in LTP_IPC_ENV.

So quite contrary the tst_run_shell() function should be renamed to
tst_run_script() as well, which I will do in v3.

> > +	int pid;
> > +	unsigned int i, params_len = params_array_len(params);
> > +	char *argv[params_len + 2];
> > +
> > +	if (!tst_test->runs_script)
> > +		tst_brk(TBROK, "runs_script flag must be set!");
> > +
> > +	argv[0] = script_name;
> maybe you'd have to cast it here or something, but IMO worth it

Hmm, I was expecting that we would have to copy the data, but casting
seems to work, will do.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
