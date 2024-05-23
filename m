Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF0AC25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:33:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E7363D0191
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 17:33:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1B83D00C3
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:33:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A0BF51000D21
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:33:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5D972207E;
 Thu, 23 May 2024 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716478413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVHCJI8EL3em/zc5h+3Z75ntVKzTudNEIYJ0ywYsySM=;
 b=J1HTHuHGBOMuOdWVGF5gwdiIbABmGM5YVQHW2O/Piq2FdXBdm58OHVKV+Ae1K0DDmQ8nju
 PkNZGrlvyeAHLg6u5L8y/0geZBQD31J5j5DZO+zw0n3zdqYMqOeB4/9xgf8/voJjmz8aI5
 C66TalE21YXta3mUSmYtUvXTQ8HRqHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716478413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVHCJI8EL3em/zc5h+3Z75ntVKzTudNEIYJ0ywYsySM=;
 b=EfciT4fGtLtgZNpvWW/1/ZTBB729CZAQaUhOBnPC/eLGlJmohFHjBUQP2eNwKfnvh4AM4c
 FsXPmGdXfibsSDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716478411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVHCJI8EL3em/zc5h+3Z75ntVKzTudNEIYJ0ywYsySM=;
 b=M2T7y+62Upj/oDFk5YDh+EJ7ylMyr43+1RUJhgYdhy9CVuq6GlXeXarNe2YsSOCTqMesNi
 4vJwgas5QvHyPg0U/7pyC98nRJe15rk0o8fL7plKOEUNASIr36RauE0uNZoOJcJymC5m7t
 3X7t5ne3jmlx+PdqxJPQhRN1AsP56R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716478411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVHCJI8EL3em/zc5h+3Z75ntVKzTudNEIYJ0ywYsySM=;
 b=poZityVxxjkDtf9X9bYi6RYZjeW9g0It+CRj+qmd+MbqI6nSKha1IN0tcjA4dDfjBp8yRO
 Vr6+AOdXLWB5eNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D736813A6C;
 Thu, 23 May 2024 15:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cpueM8thT2bPfQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 23 May 2024 15:33:31 +0000
Date: Thu, 23 May 2024 17:33:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zk9hy4QS4FCmveZ3@yuki>
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-3-chrubis@suse.cz>
 <20240523152054.GA18111@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523152054.GA18111@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/msgstress01: Fix timeouts
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
> > Make the test exit if runtime has been exhausted before we finished the
> > requested amount of iterations.
> 
> > For that to happen we let the main test process to loop while checking
> > the runtime and set the stop flag if runtime was exhausted. We also need
> > to separte the stop and fail flag and add counter for finished children.
> nit: s/separte/separate/
> 
> ...
> >  static void remove_queues(void)
> > @@ -196,12 +210,37 @@ static void run(void)
> 
> >  		if (*stop)
> >  			break;
> > +
> > +		if (!tst_remaining_runtime()) {
> > +			tst_res(TWARN, "Out of runtime during forking...");
> 
> I tested the patchset on various VMs (various kernels), with both 1 or 2 CPU.
> Indeed it fixes the problem. IMHO it can quite easily get KVM host overloaded
> enough to get the TWARN out of runtime during forking, but we can't do anything
> about it.

And I think that it's fair to signal to the user that the machine is too
overloaded to run a meaningful test in this case.

> msgstress01.c:215: TWARN: Out of runtime during forking...
> msgstress01.c:244: TPASS: Test passed. All messages have been received
> 
> > +			*stop = 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!(*stop))
> > +		tst_res(TINFO, "All processes running.");
> very nit: I'd remove dot at the end.
> 
> > +
> > +	for (;;) {
> > +		if (tst_atomic_load(finished) == 2 * num_messages)
> > +			break;
> > +
> > +		if (*stop)
> > +			break;
> > +
> > +		if (!tst_remaining_runtime()) {
> > +			tst_res(TINFO, "Out of runtime, stopping processes...");
> > +			*stop = 1;
> > +			break;
> > +		}
> > +
> > +		sleep(1);
> >  	}
> 
> >  	tst_reap_children();
> >  	remove_queues();
> 
> > -	if (!(*stop))
> > +	if (!(*fail))
> >  		tst_res(TPASS, "Test passed. All messages have been received");
> >  }
> 
> > @@ -242,14 +281,16 @@ static void setup(void)
> >  		MAP_SHARED | MAP_ANONYMOUS,
> >  		-1, 0);
> 
> > -	stop = SAFE_MMAP(
> > +	flags = SAFE_MMAP(
> >  		NULL,
> > -		sizeof(int),
> > +		sizeof(int) * 3,
> >  		PROT_READ | PROT_WRITE,
> >  		MAP_SHARED | MAP_ANONYMOUS,
> >  		-1, 0);
> 
> > -	reset_messages();
> > +	stop = &flags[0];
> > +	fail = &flags[1];
> > +	finished = &flags[2];
> >  }
> 
> >  static void cleanup(void)
> > @@ -260,7 +301,7 @@ static void cleanup(void)
> >  	remove_queues();
> 
> >  	SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
> > -	SAFE_MUNMAP((void *)stop, sizeof(int));
> > +	SAFE_MUNMAP(flags, sizeof(int) * 3);
> >  }
> 
> >  static struct tst_test test = {
> > @@ -271,7 +312,7 @@ static struct tst_test test = {
> >  	.max_runtime = 180,
> >  	.options = (struct tst_option[]) {
> >  		{"n:", &str_num_messages, "Number of messages to send (default: 1000)"},
> > -		{"l:", &str_num_iterations, "Number iterations per message (default: 10000)"},
> > +		{"l:", &str_num_iterations, "Number iterations per message (default: " TST_TO_STR(MAXNREPS) ")"},
> >  		{},
> very nit: too long line

Feel free to fix the minor nits and push the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
