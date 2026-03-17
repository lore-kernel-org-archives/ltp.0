Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16715FD8741
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 11:58:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B59AB3E486B
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 12:58:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BEC93C7A18
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 12:58:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7527140007D
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 12:58:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F6E24D327;
 Tue, 17 Mar 2026 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773748710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbkyigRsH6ruqCSqN2ngRErzek7xDijFRtXqq5+zTyY=;
 b=Cqxx8Zc9WczK91LhiJHc0m8jWQY3+6s/hx6NsuIcg9Pi4QxqeRUy7qQj3IDr67nF83jX+c
 IVjncSBNs1JnHbbCHd4OPU0aJH/bRSUFZHAfi0MG9ai9dPPTkD4yfKn333zjETT28lHwuB
 jCe5/EuEVmWMzO8EOIDVM+sJ2nZjqDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773748710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbkyigRsH6ruqCSqN2ngRErzek7xDijFRtXqq5+zTyY=;
 b=T2LO1r4RRdEVyyfZCIF83Tl7YdSYNhW91G4Owt+ozW8L8w7m2jTNer+iyhY+plwYeNi+o+
 ankFkjuO07r7w8Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773748710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbkyigRsH6ruqCSqN2ngRErzek7xDijFRtXqq5+zTyY=;
 b=Cqxx8Zc9WczK91LhiJHc0m8jWQY3+6s/hx6NsuIcg9Pi4QxqeRUy7qQj3IDr67nF83jX+c
 IVjncSBNs1JnHbbCHd4OPU0aJH/bRSUFZHAfi0MG9ai9dPPTkD4yfKn333zjETT28lHwuB
 jCe5/EuEVmWMzO8EOIDVM+sJ2nZjqDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773748710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbkyigRsH6ruqCSqN2ngRErzek7xDijFRtXqq5+zTyY=;
 b=T2LO1r4RRdEVyyfZCIF83Tl7YdSYNhW91G4Owt+ozW8L8w7m2jTNer+iyhY+plwYeNi+o+
 ankFkjuO07r7w8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9DAC4273B;
 Tue, 17 Mar 2026 11:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2WF6LeVBuWmvYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Mar 2026 11:58:29 +0000
Date: Tue, 17 Mar 2026 12:58:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260317115828.GA365182@pevik>
References: <69b93029.050a0220.2e2929.5885@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69b93029.050a0220.2e2929.5885@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

[ Cc others who were on LTP meeting + Sebastian who might be interested ]

> Hi all,

> so we still have ~200 patches to refactor and to move from old LTP API into
> the new LTP API. That would be really useful for tests maintenance and long
> term supports, such as the `runtest` removal and replacement with a smarter
> tests filtering/grouping.

> This is a tedious task that requires a huge amount of work and in the past
> years we managed to convert hundreds of tests by hand, each one requiring
> multiple reviews iterations.

> It was overwhelming not only for developers, but also for reviewers who
> were stucked by reviewing new patches + tests rewriting.

> In 2026 we have the chance to accelerate this transition from old API to
> new API using LLMs and, as we discussed in the yesterday LTP after release
> meeting, we might be in the right way to start doing it (at least for
> smaller tests).

> I created a set of configurations and skills in my personal repo which can
> be used to start this process: https://github.com/acerv/agents-config.
> It's maily tested using Claude Code, since it's the model which perform
> the best (at the moment), but any other model can be used.

> I experimented with a list of tests that can be obtained with the following
> command:

> wc -l $(grep -R '"test\.h"' --include="*.c" testcases/kernel/ | cut -d: -f1) | sort -g

wc -l $(grep -R '"test\.h"' --include="*.c" testcases/ | cut -d: -f1) | sort -g

Otherwise you miss 12 old API tests.

> .. and tests conversion for tests which are smaller than 200 lines of code
> requires minimal (if no) edit. I will continue to adapt the ltp-convert skill
> in order to tweak and to improve this process for bigger tests.

> ~~ Said so..

> .. since this process seems to be quite straight forward, and with the usage
> of LLM we could easily generate hundreds of patches per month, we don't really
> want to flood the ML with garbage and to overwhelm who's involved into
> maintenance review.

> How we should organize this job?
> Should we set a maximum amount of tests refactoring per month?
> How do we organize these patches? (i.e. with blocks of patches)

I'd vote for limiting patchsets to max tests in a single directory.
Why? Smaller patchset is easier to review. And if just some of the commits are
accepted then fewer commits need to be rebased.

Kind regards,
Petr

> Kind regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
