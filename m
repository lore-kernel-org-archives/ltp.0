Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA2AD5E128
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 10:54:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DF483D034E
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:54:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CBAB3C1817
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 11:54:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7286D600486
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 11:54:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5A365BCC3;
 Tue, 16 Dec 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9099B3EA63;
 Tue, 16 Dec 2025 10:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2NxUImA6QWlOBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Dec 2025 10:54:24 +0000
Date: Tue, 16 Dec 2025 11:54:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251216105423.GA307257@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251215124404.16395-2-chrubis@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A5A365BCC3
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

Thanks, very nice doc!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Few more style/typo/grammar notes below. Found by chatgpt, I picked just few of
them which looked to me significant (obviously AI would improve the style, but
lets ignore that).  Feel free to ignore, otherwise just amend before merge.
Labels "typo:" or "grammar:" should probably be fixed.

AI also suggests to use often articles, e.g. for "parent" and "child" (mostly "the",
sometimes "a"), but let's ignore that.

> +We have decided what we will not work around bugs in upstream LTP sources. If a
decided what => decided that

...
> +Why is sleep in tests bad then?
Missing "using", also maybe more formal (it's not a blog post but official doc):
Why is using sleep in tests bad?
> +```````````````````````````````

...
> +The second problem is that this wastes resources and slows down a test run. If
> +you think that adding a sleep to a test is not a big deal, lets have a look at
> +the bigger perspective. There is about 1600 syscall tests in Linux Test

grammar (plural): There is about 1600 => There are about 1600
(You have it wrong also in your blog post.)

> +Project, if 7.5% of them would sleep just for one second, we would end up with
> +two minutes of wasted time per testrun. In practice most of the test, that
> +historically misused sleep for synchronization, waited for much longer just to
> +be sure that things will works even on slower hardware. With sleeps between 2
> +and 5 seconds that puts us somewhere between 4 and 10 minutes which is between
And here "sleeps" is plural, maybe: puts => put.
Or maybe just use "sleep"?

> +13% and 33% of the syscall runtime on an outdated thinkpad, where the run
> +finishes in a bit less than half an hour. It's even worse on newer hardware,
> +because this slowdown will not change no matter how fast your machine is, which
> +is maybe the reason why this was acceptable twenty years ago but it's not now.
> +
> +
> +What to do instead?
> +```````````````````
> +
> +Use proper synchronization.
> +
> +There are different problems and different solutions. Most often test needs to
> +synchronize between child and parent proces.

typo: proces => process

> +
> +The easiest case is that parent needs to wait for a child to finish, that can

that parent => when parent

> +be fixed just be adding a :man2:`waitpid` in the parent which ensures that child is
> +finished before parent runs.
"child is finished" => "child finished" (or "child has finished")

> +
> +Commonly child has to execute certain piece of code before parent can continue.
> +For that LTP library implements checkpoints with simple
> +:c:func:`TST_CHECKPOINT_WAIT()` and :c:func:`TST_CHECKPOINT_WAKE()` functions based
> +on futexes on a piece of shared memory set up by the test library.
> +
> +Another common case is where child must sleep in a syscall before parent can
"where child" => "when child"

> +continue, for which we have a :c:func:`TST_PROCESS_STATE_WAIT()` helper that
> +polls `/proc/$PID/stat`.
> +
> +Less often test needs to wait for an action that is done asynchronously, or a
> +kernel resource deallocation is deferred to a later time. In such cases the

"a kernel resource deallocation is deferred to a later time"
Maybe:
"for kernel resource deallocation that is deferred to a later time"

> +best we can do is to poll. In LTP we ended up with a macro that polls by
> +calling a piece of code in a loop with exponentially increasing sleeps between
> +retries until it succeeds. Which means that instead of sleeping for a maximal
> +time event can possibly take the sleep is capped by twice of the optimal
> +sleeping time while we avoid polling too aggressively.
> +
> +
> +Use runtime checks for kernel features
> +======================================
> +
> +What is and what isn't supported by kernel is determined by the version
> +and configuration of the kernel the systems is currently running on.
grammar (singular): "systems is ... running on." => "system is ... running."

> +That especially means that any checks done during the compilation cannot
> +be used to assume features supported by the kernel the tests end up
> +running on. The compile time checks, done by configure script, are only
> +useful for enabling fallback kernel API definitions when missing, as we
> +do in lapi/ directory.
> +
> +
> +Kernel features and RCs
> +=======================
> +
> +LTP tests or fixes for kernel changes that were not released yet can be posted
grammar (present perfect): "were not released yet can" => "have not yet been released may"

> +to the LTP list for a review but will not be be accepted until respective
"review but will" => "review but they will"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
