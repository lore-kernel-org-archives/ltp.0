Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2DCD3B98A
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:31:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D22D93CA19A
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 20:31:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECDE43C9A08
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:31:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2822C1000488
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:31:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 780DF5BE04;
 Tue,  9 Dec 2025 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765308676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJ9AiRj9woUKFstDFchVooFElvNdAUQ4MBqnAmEjcqA=;
 b=Mqfo0fNp18mfg6/VB0gQHm1kgrxH5/f3n0pL75Gd35TnzAbSuwJONZruXAbiQBGKoF2n6h
 Mt/xzEaUebxy/T5kt3RGbvppJqEMHd5n5POI4REjV0Q/dGpACtb+VJnijRThIIeoVOIVLa
 YGdvDboTvInQR09hdMdWAFBOTIu996Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765308676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJ9AiRj9woUKFstDFchVooFElvNdAUQ4MBqnAmEjcqA=;
 b=16h4aD9QY5pk6p0qrFondA2R/X9TOghS3+rfqmb5lkadLlzu2NTk9POsA9VvKo19/vtk4E
 SBQ3Fa6DOcX7jcCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E13kLgVC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HnpFSOLW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765308675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJ9AiRj9woUKFstDFchVooFElvNdAUQ4MBqnAmEjcqA=;
 b=E13kLgVCKgkqYtUjIOFamW+uYmTM0iuXZ/TD9rB0cUQxBE0EkfUNc/b87Wz85OlDpUIVIx
 eIIjxZtrtRtbcDL9tITScwvsFeNc7WOfhKcOjdJnTPg/RQtWTMgTLQOVhks6NGh6syJmBc
 Yk/DFUT6MhNvhgGHpQ8bTv7nBq/s4hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765308675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJ9AiRj9woUKFstDFchVooFElvNdAUQ4MBqnAmEjcqA=;
 b=HnpFSOLWRKqt4P+5hwQSIP4F5Ssn/p1veadXMX7Mo+19//sj++N3VEAyYM1Q6r0BBf9+TU
 W+/5ueaaF8A0+uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DA273EA63;
 Tue,  9 Dec 2025 19:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qWFpCQN5OGlMaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 19:31:15 +0000
Date: Tue, 9 Dec 2025 20:31:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251209193105.GA20883@pevik>
References: <20251209120246.18435-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209120246.18435-1-chrubis@suse.cz>
X-Rspamd-Queue-Id: 780DF5BE04
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add ground rules page
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

> This is a continued effort to write down the unwritten rules we have in
> the project. Feel free to suggest more topics for the page.

Nice work, thanks for doing this!
Few spell checker issues and style below.
I'd slightly prefer avoiding "I" (first-person) style, i.e. use impersonal
language / passive (it's not a blog post but official document), but it's up to
you.

Acked-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/developers/ground_rules.rst | 68 +++++++++++++++++++++++++++++++++
>  doc/index.rst                   |  1 +
>  2 files changed, 69 insertions(+)
>  create mode 100644 doc/developers/ground_rules.rst

> diff --git a/doc/developers/ground_rules.rst b/doc/developers/ground_rules.rst
> new file mode 100644
> index 000000000..701dcd09a
> --- /dev/null
> +++ b/doc/developers/ground_rules.rst
> @@ -0,0 +1,68 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Ground Rules
> +============
> +
> +Do not work around kernel bugs
> +------------------------------
> +
> +We have decided what we will not work around bugs in upstream LTP sources. If a
> +test fails on your system for a good reason, e.g. patch wasn't backported and
> +the bug is present, work around for this will not be accepted upstream. The
> +main reason for this decision is that this masks the failure for everyone else.
> +
> +
> +Do not synchronize by sleep
> +---------------------------
> +
> +Why is sleep in tests bad then?
> +```````````````````````````````
> +
> +The first problem is that it may and will introduce very rare test failures,
"that it may and will introduce" => "that it will introduce" or "that it will
likely introduce"

> +that means somebody has to spend time looking into these, which is a wasted
> +effort. Also I'm pretty sure that nobody likes tests that will fail rarely for
nit: first-person style, maybe:

effort. Nobody likes tests that ...

> +no good reason. Even more so you cannot run such tests with a background load
> +to ensure that everything works correctly on a bussy system, because that will
bussy => busy

> +increase the likehood of a failure.
> +
> +The second problem is that this wastes resources and slowns down a test run. If
slowns down => slows down

> +you think that adding a sleep to a test is not a big deal, let me put things
> +into a perspective. There is about 1600 syscall tests in Linux Test Project
Also here is first-person style...
> +(LTP), if 7.5% of them would sleep just for one second, we would end up with
> +two minutes of wasted time per testrun. In practice most of the test I've seen
test => tests
> +waited for much longer just to be sure that things will works even on slower

and here: In practice most of the tests wait ...

> +hardware. With sleeps between 2 and 5 seconds that puts us somewhere between 4
> +and 10 minutes which is between 13% and 33% of the syscall runtime on my dated

and here: the syscall runtime on outdated Thinkpad.

> +thinkpad, where the run finishes in a bit less than half an hour. It's even
> +worse on newer hardware, because this slowdown will not change no matter how
> +fast your machine is, which is maybe the reason why this was acceptable twenty
> +years ago but it's not now.
> +
> +
> +What to do instead?
> +```````````````````
> +
> +Use proper synchronization.
> +
> +There are different problems and different solutions.
> +
> +Most often tests needs to synchronize between child and parent proces.
Maybe join this sentence to the previous one?

> +
> +The easiest case is that parent needs to wait for a child to finish, that can
> +be fixed just be adding a waitpid() in the parent which ensures that child is
very nit: if you use :man2:`waitpid`, it will link the text to man page.

> +finished before parent runs.
> +
> +Commonly child has to execute certain piece of code before parent can continue.
> +For that LTP library implements checkpoints with simple wait and wake functions
> +based on futexes on a piece of shared memory set up by the test library.

Maybe mention some functions, e.g. TST_CHECKPOINT_WAIT()? You could link the
macro with:

:c:func:`TST_CHECKPOINT_WAIT()`

> +
> +Another common case is where child must sleep in a syscall before parent can
> +continue, for which we have a helper that polls /proc/$PID/stat.
> +
> +Less often tests needs to wait for an action that is done asynchronously, or a

tests needs => tests need

> +kernel resource deallocation is deffered to a later time. In such cases the
deffered => deferred

> +best we can do is to poll. In LTP we ended up with a macro that polls by
Again, please mention the function. Unfortunately include/tst_fuzzy_sync.h have
not been converted to kerneldoc, therefore it can't be referenced yet.

> +calling a piece of code in a loop with exponentially increasing sleeps between
> +retries until it succeeeds. Which means that instead of sleeping for a maximal
succeeeds => succeeds

> +time event can possibly take the sleep is capped by twice of the optimal
> +sleeping time while we avoid polling too aggressively.
> diff --git a/doc/index.rst b/doc/index.rst
> index 06b75616f..659549cc3 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -19,6 +19,7 @@
>     :hidden:
>     :caption: For developers

> +   developers/ground_rules
>     developers/setup_mailinglist
>     developers/writing_tests
>     developers/test_case_tutorial

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
