Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A00CCFA1A
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 15:48:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13D6E3CF67D
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 16:48:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C30A3C9ACB
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 16:47:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D113D60062C
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 16:47:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AFB121BB9;
 Tue, 11 Nov 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762876071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exf0Vm7t0dJCmI011IrdRnYlqb/JmXeTv4I7mB7MXEY=;
 b=VlnilNFm9L99/ozEkkjt3KAjKaBzgul6ZSUJ1FB3s+1SowNJ6L4SeROAm4yTsQ491u8dpK
 8w0KyhnpBpIALkDa3iNyj6JYnN2A1CbiUcjOd5eBmAQFcO6UPIZ5BJHVHrVn7Ullq9nthu
 KkoZ+W9WOmOhL2OSlztjoBc7fp0cZbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762876071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exf0Vm7t0dJCmI011IrdRnYlqb/JmXeTv4I7mB7MXEY=;
 b=kM4j9J6PZTptWfISAEgEMMIyAAl8bQZg/AUJZoQO1EGmruby6f4uwgnbMuurB+K0DinMQL
 zSWecHgLs137EaAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762876071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exf0Vm7t0dJCmI011IrdRnYlqb/JmXeTv4I7mB7MXEY=;
 b=VlnilNFm9L99/ozEkkjt3KAjKaBzgul6ZSUJ1FB3s+1SowNJ6L4SeROAm4yTsQ491u8dpK
 8w0KyhnpBpIALkDa3iNyj6JYnN2A1CbiUcjOd5eBmAQFcO6UPIZ5BJHVHrVn7Ullq9nthu
 KkoZ+W9WOmOhL2OSlztjoBc7fp0cZbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762876071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exf0Vm7t0dJCmI011IrdRnYlqb/JmXeTv4I7mB7MXEY=;
 b=kM4j9J6PZTptWfISAEgEMMIyAAl8bQZg/AUJZoQO1EGmruby6f4uwgnbMuurB+K0DinMQL
 zSWecHgLs137EaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39F1514A27;
 Tue, 11 Nov 2025 15:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1x1LDadaE2nSawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Nov 2025 15:47:51 +0000
Date: Tue, 11 Nov 2025 16:47:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251111154749.GB61698@pevik>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-3-pvorel@suse.cz>
 <aRM0Z-IlZSLdB5ho@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRM0Z-IlZSLdB5ho@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] swapon03: Cleanup
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
> > - Remove unused return code in check_and_swapoff() and setup_swap(). The
> >   purpose was to run cleanup() in the end of the setup() if creating
> >   swap fails, but return code is always 0. Also cleanup() should be run
> >   when test exits with tst_brk() anyway.
> > - Change return code from TFAIL to TBROK.
> > - Add missing brackets.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > The same as in v1.
> > I can split this if you like.

> >  testcases/kernel/syscalls/swapon/swapon03.c | 23 +++++++--------------
> >  1 file changed, 7 insertions(+), 16 deletions(-)

> > diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> > index 01a3b6d8ac..d9822c01ef 100644
> > --- a/testcases/kernel/syscalls/swapon/swapon03.c
> > +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> > @@ -25,7 +25,7 @@

> >  static int swapfiles;

> > -static int setup_swap(void)
> > +static void setup_swap(void)
> >  {
> >  	pid_t pid;
> >  	int status;
> > @@ -54,33 +54,27 @@ static int setup_swap(void)
> >  			TST_EXP_PASS_SILENT(swapon(filename, 0));
> >  		}
> >  		exit(0);
> > -	} else
> > +	} else {
> >  		waitpid(pid, &status, 0);
> > +	}

> >  	if (WEXITSTATUS(status))
> > -		tst_brk(TFAIL, "Failed to setup swap files");
> > +		tst_brk(TBROK, "Failed to setup swap files");

> I wonder why do we run this code in a child process to begin with? This

Yes, although this is a general recommendation I was thinking about removing it
as well as.  and first intended to remove it. But then I thought it was easier
to handle 'mkswap' binary failure (run in make_swapfile() which is called via
MAKE_SMALL_SWAPFILE()).

Other reason was that I did already quite a lot of cleanup, thus extending it
even more means more iterations. But sure, I can fix it (and postpone fix in the
first commit to later).

> is probably some leftover from the conversion to the new library. Among
> other things this masks proper results propagation from the
> MAKE_SMALL_SWAPFILE() because there is at least one tst_brk(TCONF, "")
> in there that will be converted to TBROK here.

Ah, You mean:
tst_brk_(file, lineno, TCONF, "Insufficient disk space to create swap file");
Indeed, I overlooked that one. It's always useful to look into the tests we
already converted some time ago :).

> I guess that we want to remove the fork() here and we want SAFE_SWAPON()
> instead of the TST_EXP_PASS_SILENT() so that we do tst_brk() if we fail

FYI we don't have SAFE_SWAPON() but this part of is_swap_supported() could be
factored out as SAFE_SWAPON():

	TEST(tst_syscall(__NR_swapon, filename, 0));
	if (TST_RET == -1) {
		if (errno == EPERM) {
			tst_brk(TCONF, "Permission denied for swapon()");
		} else if (errno == EINVAL && fi_contiguous == 0 && sw_support == 0) {
			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
		} else {
			tst_res(TFAIL | TTERRNO, "swapon() on %s failed", fstype);
			return false;
		}
	}

Also we could use SAFE_MAKE_SMALL_SWAPFILE() instead of MAKE_SMALL_SWAPFILE(),
to catch few errors properly (this is what I did in 3rd commit).

> to setup the swapfile too. The TST_EXP_PASS_SILENT() does not end the
> test on a failure, which is what we want here instead.

Yes, that's the problem now. It could be fixed by calling tst_brk()
instead of TST_EXP_PASS_SILENT() or really create SAFE_SWAPON().
But FYI I'm not sure if there would be use for SAFE_SWAPON(), because I changed
this part in the 3rd commit (this is the main change which expects swapon() to
fail):

-			/* turn on the swap file */
-			TST_EXP_PASS_SILENT(swapon(filename, 0));
+			/* Quit on a first swap file over max, check for EPERM */
+			if (swapon(filename, 0) == -1) {
+				if (errno != EPERM)
+					tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
+				break;
+			}
+			(*swapfiles)++;

and swapon0[12].c swapoff*.c don't need it (they call *MAKE_SWAPFILE*()
functions.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
