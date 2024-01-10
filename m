Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44785C4707C
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 12:26:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DF623CE49E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 13:26:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267233C4C18
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 13:26:34 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7CCEB1A0BC5A
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 13:26:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 699181F88C;
 Wed, 10 Jan 2024 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704889592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1s0z/nzY8cJbBKgjgxaxPyiwdc7QBZJouSTHfMbgYU=;
 b=iegckxamOAbBewCppBf+9TCkOvl3TUuXPnRBmImylJVPC8GA93s7LQPKQm9AadX2VfGb1W
 T2M107C4ddHWmtybtUgMu7j5xqsnt470fFdK/YB+tYSvauUu3bkKRhHZGrjGL3FQj4UZkv
 Dup157EPxOYloxKM0lEg+AnUES0ROTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704889592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1s0z/nzY8cJbBKgjgxaxPyiwdc7QBZJouSTHfMbgYU=;
 b=BoF6ThQQ7adD3e2ZKPNOzzVOUsZMiR6xpaQJYqUTxZVN6rj4tsX0Akg2veHvNn5UJuGaf4
 lv742z2xi0P52iCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704889592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1s0z/nzY8cJbBKgjgxaxPyiwdc7QBZJouSTHfMbgYU=;
 b=iegckxamOAbBewCppBf+9TCkOvl3TUuXPnRBmImylJVPC8GA93s7LQPKQm9AadX2VfGb1W
 T2M107C4ddHWmtybtUgMu7j5xqsnt470fFdK/YB+tYSvauUu3bkKRhHZGrjGL3FQj4UZkv
 Dup157EPxOYloxKM0lEg+AnUES0ROTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704889592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1s0z/nzY8cJbBKgjgxaxPyiwdc7QBZJouSTHfMbgYU=;
 b=BoF6ThQQ7adD3e2ZKPNOzzVOUsZMiR6xpaQJYqUTxZVN6rj4tsX0Akg2veHvNn5UJuGaf4
 lv742z2xi0P52iCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EB391398A;
 Wed, 10 Jan 2024 12:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BQA1DviMnmVvOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 12:26:32 +0000
Date: Wed, 10 Jan 2024 13:26:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240110122630.GA1698252@pevik>
References: <20231031125114.5879-1-chrubis@suse.cz>
 <20240109192444.GA1670891@pevik> <ZZ54308dqXEv3OBI@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZ54308dqXEv3OBI@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: add sched sysctl sanity test
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

> Hi!
> > It looks like the second fix 079be8fc6309 ("sched/rt: Disallow writing invalid
> > values to sched_rt_period_us") is not in stable, shouldn't be there?

> No idea to be honest, the second fix about rejecting invalid values is a
> minor fix.

IMHO it's a fix of broken functionality. And Greg stated several times that
stable is not only for security fixes but for other fixes. Therefore I would
vote for adding it.

> > > - Fixed a few whitespaces
> > > - Added second kernel commit into metadata
> > nit: metadata of the git commit looks ugly, but we would need to agree on better
> > solution.

> Which metadata exactly? This part is after the scisors and will be cut
> when the patch is applied.

I don't like formatting after "This is a regression test for a commits:".
It formates like code block (gray background) via using <pre>...</pre> HTML
tags:

	commit c1fc6484e1fb7cc2481d169bfef129a1b0676abe
	Author: Cyril Hrubis <chrubis@suse.cz>
	Date:   Wed Aug 2 17:19:06 2023 +0200

	sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

	commit 079be8fc630943d9fc70a97807feb73d169ee3fc
	Author: Cyril Hrubis <chrubis@suse.cz>
	Date:   Mon Oct 2 13:55:51 2023 +0200

	sched/rt: Disallow writing invalid values to sched_rt_period_us

(see a real output in metadata.html)

Given we have this in the Tag table below, I found it useless. I mean, we could
have it, but not in docparse comment /*\ ... */, but in normal C comment /* ... */
(for reader of the C source, but not in docparse format). Or, if we want to have
it in docparse output, we could format it as:

 /*\
...
 * This is a regression test for a commits:

 * * c1fc6484e1fb ("sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset")
 * * 079be8fc6309 ("sched/rt: Disallow writing invalid values to sched_rt_period_us")

This is not unique to this commit, we don't have to solve it now (and it's
definitely a blocker for this patch). But it would be good to find a consensus
how the output should look like.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
