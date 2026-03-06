Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720A4FCB618
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 15:48:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CC143D9EF0
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 16:48:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A98673C1B73
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 16:48:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1083E1400B6B
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 16:48:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE275BCD9;
 Fri,  6 Mar 2026 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772812084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6rB6SA2KY+YAqbuNoUMdXN41E8KcgEQjr4J2QHvZSE=;
 b=yPttqRBWcJht8lSLrUM1RfrdRtgGb2n8jV3EOLASC/8j2YkKVh1ee7lbngq0u+61GMAqv3
 FBD4HbM4Qh4TqKE7a8K5nQ0JFAcb+34/nj/pHafcSIaxnRR+ugwyilPpyklZbmy0WuvuQm
 M94veNEdeI15XEcQUl6s7XLXzsllUEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772812084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6rB6SA2KY+YAqbuNoUMdXN41E8KcgEQjr4J2QHvZSE=;
 b=z8nHZqRhWeXMRAgh5O14RrNQIU7DNUTNAQZhy7AV8pzKalLUQLnLn69fyoQZvwXAcf4KYA
 GWGX28gyY4u/HZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772812084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6rB6SA2KY+YAqbuNoUMdXN41E8KcgEQjr4J2QHvZSE=;
 b=yPttqRBWcJht8lSLrUM1RfrdRtgGb2n8jV3EOLASC/8j2YkKVh1ee7lbngq0u+61GMAqv3
 FBD4HbM4Qh4TqKE7a8K5nQ0JFAcb+34/nj/pHafcSIaxnRR+ugwyilPpyklZbmy0WuvuQm
 M94veNEdeI15XEcQUl6s7XLXzsllUEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772812084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6rB6SA2KY+YAqbuNoUMdXN41E8KcgEQjr4J2QHvZSE=;
 b=z8nHZqRhWeXMRAgh5O14RrNQIU7DNUTNAQZhy7AV8pzKalLUQLnLn69fyoQZvwXAcf4KYA
 GWGX28gyY4u/HZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0133B3EA75;
 Fri,  6 Mar 2026 15:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TSdEADT3qmk/FAAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 06 Mar 2026 15:48:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A2255A09D8; Fri,  6 Mar 2026 16:47:59 +0100 (CET)
Date: Fri, 6 Mar 2026 16:47:59 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <t4o7qgmw3rpcslrj7gmxsqg3ugk5kwoyis7lg4fwr42kf7sfn4@26l4i43m7zbc>
References: <20260303105510.14305-1-mdoucha@suse.cz>
 <20260306121336.GA519430@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260306121336.GA519430@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_LAST(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: Trace oom_kill_process() instead of
 load_module()
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
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri 06-03-26 13:13:36, Petr Vorel wrote:
> Hi all,
> 
> > The load_module() function is available only if the kernel was built
> > with CONFIG_MODULES enabled. Trace a function that's unconditionally
> > available instead.
> 
> +1, that's obviously better than require CONFIG_BINFMT_SCRIPT or anything else.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> @Amir @Jan will you add your ack, please?

Sure, whatever works for you in this case :)

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Kind regards,
> Petr
> 
> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > Reported-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify25.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
> > index c982f3225..db52e6a87 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify25.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
> > @@ -24,10 +24,10 @@ static const struct traceconfig {
> >  	const char *filename;
> >  	const char *wdata;
> >  } trace_cmds[] = {
> > -	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
> > -	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
> > -	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
> > -	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
> > +	{EVENTS_SYSFILE, "p:ltp_oom_kill_process_0 oom_kill_process"},
> > +	{MNTPOINT "/events/kprobes/ltp_oom_kill_process_0/enable", "1"},
> > +	{MNTPOINT "/events/kprobes/ltp_oom_kill_process_0/enable", "0"},
> > +	{EVENTS_SYSFILE, "-:ltp_oom_kill_process_0"},
> >  	{}
> >  };
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
