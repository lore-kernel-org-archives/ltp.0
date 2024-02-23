Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB0BC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 15:47:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37D073D0135
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 16:47:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 169563CE7BD
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 16:47:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A0EE71000DA1
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 16:47:34 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A13461FC26;
 Fri, 23 Feb 2024 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708703253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VDj6AvHg/gLWK5SyjT3xVcPfqgrZFOuJFsLf71y0pE=;
 b=i8hXhD5PdpFUtezMPT6sCVLgOTehs6BFDvxnIg9ZrX2eOrp3awN4LZS6PYR7uOxwJc8RBb
 VRUuFqImtNV7xwMrzatmd6D6nAb8gLU2znRsv7ndkWx4+tYX0P9UfpNc2Ok5ttbeO8yjEk
 G9H13scbOdi3oK5llwrs2snR9IZLPGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708703253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VDj6AvHg/gLWK5SyjT3xVcPfqgrZFOuJFsLf71y0pE=;
 b=jiaKHhKOsSBfc00uc80igzI8Z99owIPMFjhM1ziIWqQtWEA5roqhk51FqBqn9zWx4NAyyR
 61pn7MDHArVSBhCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708703253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VDj6AvHg/gLWK5SyjT3xVcPfqgrZFOuJFsLf71y0pE=;
 b=i8hXhD5PdpFUtezMPT6sCVLgOTehs6BFDvxnIg9ZrX2eOrp3awN4LZS6PYR7uOxwJc8RBb
 VRUuFqImtNV7xwMrzatmd6D6nAb8gLU2znRsv7ndkWx4+tYX0P9UfpNc2Ok5ttbeO8yjEk
 G9H13scbOdi3oK5llwrs2snR9IZLPGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708703253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VDj6AvHg/gLWK5SyjT3xVcPfqgrZFOuJFsLf71y0pE=;
 b=jiaKHhKOsSBfc00uc80igzI8Z99owIPMFjhM1ziIWqQtWEA5roqhk51FqBqn9zWx4NAyyR
 61pn7MDHArVSBhCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87C3A13776;
 Fri, 23 Feb 2024 15:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mZenHxW+2GWUFgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 15:47:33 +0000
Date: Fri, 23 Feb 2024 16:47:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240223154732.GD1486515@pevik>
References: <20240222153648.2563-1-andrea.cervesato@suse.de>
 <20240222233614.GA1417479@pevik>
 <b42a273b-5f57-4cd0-8dd9-03b14da9b7fd@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b42a273b-5f57-4cd0-8dd9-03b14da9b7fd@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.39 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.09)[64.49%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add stat04 test
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

Hi Andrea,

> > > +	char *symname = "my_symlink0";
> > > +	char *tmpdir = tst_get_tmpdir();
> > > +
> > > +	SAFE_SYMLINK(tmpdir, symname);
> > > +
> > > +	struct stat path;
> > > +	struct stat link;
> > nit: maybe define struct at the top of the function?
> This is common in the first versions of C, but a good practice is to define
> variables as close as possible where they are used in order to improve
> readability.

Fair enough.

> > > +
> > > +	TST_EXP_PASS(stat(tmpdir, &path));
> > > +	free(tmpdir);
> > If SAFE_SYMLINK() fails, free() will not happen. I wonder if we should bother
> > (we'd have to set it NULL and add a cleanup function).

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr

...

> According to Cyril suggestions we are probably done with this patch so it
> can be merged. Isn't it?

Well you free() later in the function. But Cyril's  note sounds reasonable for
me:
	"call it once in the test setup() or use "." instead."

Could you please do it?

Also most of the tests really run tst_get_tmpdir() in the setup() (or cleanup(),
there are exceptions (new API: testcases/kernel/syscalls/pathconf/pathconf01.c,
old API: testcases/kernel/syscalls/symlink/symlink01.c,
testcases/kernel/syscalls/clone/clone02.c), which should be fixed.
IMHO tests which call tst_get_tmpdir() in the run()

Kind regards,
Petr

> Thanks,
> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
