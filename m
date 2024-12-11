Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAE5E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 09:53:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2446B3E7D1A
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:53:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3923D3E7D06
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:52:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A6EF310007C7
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:52:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB3E81F38C;
 Wed, 11 Dec 2024 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733910764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=henwRg90rlJ1o1dR3z2gapB+gdfNM9s16pqNoRucSu0=;
 b=VNLLsIfspLwM2IoxMnyIoVY+onIqH6kaKJCcJfMAH9bKvMW5VyyI1UzDxPR05/qEV+euPo
 NntMf7hEolJFkgWhijycz2zzjLU0ULEsQoqA1LjEunLccU5Xa+DipJa6MxyOgFVZNjTGqD
 q0edgC0ObHUdrotKkWHy7FEnguUq1N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733910764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=henwRg90rlJ1o1dR3z2gapB+gdfNM9s16pqNoRucSu0=;
 b=nVSWsOWPUAtKHEpmURxI8rSgQjeqgDEmzbBRkkzJsd8VYf5ZHHpjpQiJhYJWq7HqYNdOie
 u8+RnE/bUoksbZCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733910764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=henwRg90rlJ1o1dR3z2gapB+gdfNM9s16pqNoRucSu0=;
 b=VNLLsIfspLwM2IoxMnyIoVY+onIqH6kaKJCcJfMAH9bKvMW5VyyI1UzDxPR05/qEV+euPo
 NntMf7hEolJFkgWhijycz2zzjLU0ULEsQoqA1LjEunLccU5Xa+DipJa6MxyOgFVZNjTGqD
 q0edgC0ObHUdrotKkWHy7FEnguUq1N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733910764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=henwRg90rlJ1o1dR3z2gapB+gdfNM9s16pqNoRucSu0=;
 b=nVSWsOWPUAtKHEpmURxI8rSgQjeqgDEmzbBRkkzJsd8VYf5ZHHpjpQiJhYJWq7HqYNdOie
 u8+RnE/bUoksbZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9910513983;
 Wed, 11 Dec 2024 09:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BzJWJOxgWWceUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 11 Dec 2024 09:52:44 +0000
Date: Wed, 11 Dec 2024 10:52:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z1lg6tNdAzzL2UAh@rei.lan>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-5-chrubis@suse.cz>
 <20241211001106.GE386508@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211001106.GE386508@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] lib/tst_res_.c: Add TBROK handler + more
 verbose errors
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
> > We use the tst_res_ helper for tst_brk_ as well so we need to be able to
> > handle TBROK type as well.
> 
> How can we call tst_brk_() via tst_res_() ?
> 	tst_res_(argv[1], atoi(argv[2]), type, "%s", msg);

In the end both of these functions increment counters, but in this case
we need to return to the shell so we cannot call tst_brk() in the
helper. It's a very special situation here.

> Also we have TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN check to not
> add TBROK to tst_res_().

That only works when the value is constant, if you pass via variable
that is not constant at build time you can pass whatever you want. Which
is another reason why it makes sense to relax the constraints.

> ...
> > -	else if (!strcmp(argv[3], "TINFO"))
> > +	} else if (!strcmp(argv[3], "TINFO")) {
> >  		type = TINFO;
> > -	else if (!strcmp(argv[3], "TDEBUG"))
> > +	} else if (!strcmp(argv[3], "TDEBUG")) {
> >  		type = TDEBUG;
> > -	else
> > +	} else if (!strcmp(argv[3], "TBROK")) {
> > +		type = TBROK;
> > +	} else {
> > +		printf("Wrong type '%s'\n", argv[3]);
> >  		goto help;
> 
> Also tst_brk allows only TBROK and TCONF in C:
> 
> #define tst_brk(ttype, arg_fmt, ...)						\
> 	({									\
> 		TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(!((ttype) &			\
> 			(TBROK | TCONF | TFAIL)));				\
> 		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
> 	})

See above.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
