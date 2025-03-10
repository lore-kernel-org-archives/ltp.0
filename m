Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B653C282DE
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 10:27:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74BD23CA241
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 11:27:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 707793CA1FE
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 11:27:40 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B95881400B7C
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 11:27:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B55AD1F387;
 Mon, 10 Mar 2025 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741602458;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMWERXagpMcIKs2f0hUtD7aaf3KGo81y68JifdzV2fc=;
 b=kpqnZvTcnNUxEM43XdyE8tnks5uK7Kx+HV3JQ9UHY7ZIcWfryuyK6qzJJEi0i6s0ZtGv2S
 q0KJG0oNeAtyHEbQCZkpoyM1j+PdK/6e4o0V5rgS8xBcikV0fZOC843eJIU1Ppwvs9NEJT
 1sE/kxcUriHx5cY+VUCx5lXz/ppWUIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741602458;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMWERXagpMcIKs2f0hUtD7aaf3KGo81y68JifdzV2fc=;
 b=nMV95CUmJRtB6rliRvZjVLG9HN1BSDimKR+rireQ9adRz9v785fTjGbigz15JSwIMYfw0J
 FoHg8VkLyV8xeyCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741602457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMWERXagpMcIKs2f0hUtD7aaf3KGo81y68JifdzV2fc=;
 b=Q8/zfqS3vZjBSxjIGNgBaFHNSCiMm85AedlbcZBX/rELCBMdUxwHgDuvcE4OnBPaOsnFkQ
 rw5V5A22VwTTUj8xRsw9GYkzliQDf7hqnRkOo45lyc6BzypuNaUrJQq05dHMzlwyYDbcar
 evGFwwpbGLsZ/WdneUKD5pQ3hHbg3HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741602457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMWERXagpMcIKs2f0hUtD7aaf3KGo81y68JifdzV2fc=;
 b=GAq9MQYT2T8NYWRhG25kDG7rnWeb6J5HVxdUwNtRlRhhnA4ulhDgIoIvKXPelg5439iO4t
 CIgCdtLnxgf+9iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 532AB139E7;
 Mon, 10 Mar 2025 10:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c6ZtE5m+zmcHaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Mar 2025 10:27:37 +0000
Date: Mon, 10 Mar 2025 11:27:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250310102731.GC396000@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-5-pvorel@suse.cz>
 <Z8shfrkfVkwsCOTw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z8shfrkfVkwsCOTw@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 4/5] shell lib: Add basic support for test
 cleanup
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

Hi Cyril, all,

Note: subject wrongly mentions cleanup instead of setup

s/cleanup/setup/

> > diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> > index b13bab37c3..68f9a0daa9 100644
> > --- a/testcases/lib/tst_env.sh
> > +++ b/testcases/lib/tst_env.sh
> > @@ -35,7 +35,3 @@ tst_brk_()

> >  alias tst_res="tst_res_ $tst_script_name \$LINENO"
> >  alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> > -
> > -if [ -n "$TST_CLEANUP" ]; then
> > -	trap $TST_CLEANUP EXIT
> > -fi
> > diff --git a/testcases/lib/tst_exec.sh b/testcases/lib/tst_exec.sh
> > new file mode 100755
> > index 0000000000..dcf40fd5bb
> > --- /dev/null
> > +++ b/testcases/lib/tst_exec.sh
> > @@ -0,0 +1,19 @@
> > +#!/bin/sh
> > +# Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
> > +# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
> > +
> > +. tst_env.sh
> > +
> > +. "$1"
> > +
> > +if [ -n "$TST_CLEANUP" ]; then
> > +	trap $TST_CLEANUP EXIT
> > +fi
> > +
> > +if [ -n "$TST_SETUP" ]; then
> > +    $TST_SETUP
> > +fi
> > +
> > +tst_test
> > +
> > +# vim: set ft=sh ts=4 sts=4 sw=4 expandtab :

> Please do not add the vim formatting hints.

Ah, sorry (editor macro when creating new file, I forget to delete it).

> > diff --git a/testcases/lib/tst_loader.sh b/testcases/lib/tst_loader.sh
> > index 62c9cc6d8f..e2d1bd7daf 100644
> > --- a/testcases/lib/tst_loader.sh
> > +++ b/testcases/lib/tst_loader.sh
> > @@ -3,11 +3,8 @@
> >  # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>

> >  # This is a loader for shell tests that use the C test library.
> > -#

> >  if [ -z "$LTP_IPC_PATH" ]; then
> > -	tst_run_shell $(basename "$0") "$@"
> > +	tst_run_shell tst_exec.sh $(basename "$0") "$@"
> >  	exit $?
> > -else
> > -	. tst_env.sh
> >  fi

> Do we really need the tst_exec.sh?

> Doesn't it work if we add what is in the tst_exec here?

Do you mean to avoid this change:

-	tst_run_shell $(basename "$0") "$@"
+	tst_run_shell tst_exec.sh $(basename "$0") "$@"

and put the content here? I'll try it during this week.

> The whole point of [ -z "$LTP_IPC_PATH" ]; is to detect when we are
> being re-executed by the tst_run_shell, so the else branch (which
> isn't really needed, because we do exit in the if) was when the test did
> run.

+1. I figured this later after doing more debugging (preparation for internal
SUSE talk).

> If you change the tests to be in functions and source the tst_loader.sh
> at the end it should just work.

+1
Thanks for your review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
