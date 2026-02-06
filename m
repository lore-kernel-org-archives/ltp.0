Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165D8EB28D6
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 08:23:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A67363C938A
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 09:23:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AA763C1CC0
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 09:23:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CBCAE200CFE
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 09:23:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A70C3E6EA;
 Fri,  6 Feb 2026 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770366189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UZ6iTvWxjPK3ATvmiSX851ypmSWKau/VIdgSppYlvQ=;
 b=keWbJjKUMOuoCfs0ggtPF01/NLIGDn8SFXbMt23iZswClnTYo3Akhhdz+hhU3ajPodOOdd
 xCdoZZImV3qsaUEd6mcmqTMidfWiJuubTkWAlc77YA4li9a6bpZ5BcqgehX2t+gYwP9pTw
 +aPl98uAK6SXS+MvPCIAnPx5OR2o99I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770366189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UZ6iTvWxjPK3ATvmiSX851ypmSWKau/VIdgSppYlvQ=;
 b=O89lw/IGRFxxKQTIgMueVM/4H0q6XD08QZYl1Z+RzKpIMWxJwLHslLzXK29gs910ZD8nf7
 jAY8Yzi2GWlwyUCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=keWbJjKU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="O89lw/IG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770366189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UZ6iTvWxjPK3ATvmiSX851ypmSWKau/VIdgSppYlvQ=;
 b=keWbJjKUMOuoCfs0ggtPF01/NLIGDn8SFXbMt23iZswClnTYo3Akhhdz+hhU3ajPodOOdd
 xCdoZZImV3qsaUEd6mcmqTMidfWiJuubTkWAlc77YA4li9a6bpZ5BcqgehX2t+gYwP9pTw
 +aPl98uAK6SXS+MvPCIAnPx5OR2o99I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770366189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UZ6iTvWxjPK3ATvmiSX851ypmSWKau/VIdgSppYlvQ=;
 b=O89lw/IGRFxxKQTIgMueVM/4H0q6XD08QZYl1Z+RzKpIMWxJwLHslLzXK29gs910ZD8nf7
 jAY8Yzi2GWlwyUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA1F13EA63;
 Fri,  6 Feb 2026 08:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id occLLOykhWlmGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Feb 2026 08:23:08 +0000
Date: Fri, 6 Feb 2026 09:23:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260206082303.GA364017@pevik>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <aYWfNaJeXqut0Isb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYWfNaJeXqut0Isb@redhat.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0A70C3E6EA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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

> > > +static void runtime_check(struct tst_kconfig_var *var)
> > > +{
> > > +	size_t i;
> > > +
> > > +	for (i = 0; runtime_checks[i].config; i++) {
> > > +		if (strcmp(runtime_checks[i].config, var->id))
> > > +			continue;
> > > +
> > > +		tst_res(TDEBUG, "Running runtime check for '%s'", var->id);
> > This will not work since Li's change:
> > aa5a6fcdcd ("lib: suppress early TDEBUG output before context initialization")

> > @Li I'm not sure what "unless explicitly enabled" means, but I guess we cannot
> > simple enable it for the test library (following patch). I vote to either revert
> > aa5a6fcdcd or change it (effectively revert it, but keep doc and the rest of the
> > code).

> > I understand having the output in each test is not ideal:

> > utsname01.c:39: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)
> > utsname01.c:40: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)

> > but better more output code than no code.

> Well, I don't like that noisy logging style, that's why I did aa5a6fcdcd.

> Maybe can we add more levels of TDEBUG log to LTP:

>   -D0: no debug logs print
>   -D1: only generic logs print
>   -D2: more veroes logs include library debuginfo

> What do you think?

For the level we would need to track the level state.

Also, we now support
-D
LTP_ENABLE_DEBUG=y (or n to disable)

Now, user would have to always use '-D1' or '-D2' to get logging or not use
getopts. IMHO getopts does not support both '-D' (without value) and '-D1' (with
value).

IMHO that's why ssh supports multiple '-v', e.g. '-v -v -v' or '-vvv' instead of
-v2 or -v3).

Anyway I'd prefer solving this somehow in the code so that users don't have to
bother about log levels, but I have no idea how. Maybe yet another enum
tst_res_flags member? Because aa5a6fcdcd skipped messages, which are likely
useful when run by child process (the test), but not by library process. And I
want to print message which is always run by library process. Maybe to have some
#define in source code, which would force logging even for library process? (not
sure what will be needed more often).

But sure, this would work if there no other way to detect these 2 cases.

OT we have:

in tst_test.c:

	if (context->tdebug)
		tst_res(TINFO, "Restored metadata for PID %d", getpid());

=> shouldn't it use TDEBUG instead of TINFO?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
