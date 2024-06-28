Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA7CC2BD09
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 15:35:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCFCA3D438D
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 17:35:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93E933D063D
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 17:35:21 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A732C610205
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 17:35:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9A772197E;
 Fri, 28 Jun 2024 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719588919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRdchX8YymKGCXN0mbie8zttQM9CBQsNnpYyfuDcZw=;
 b=xv16JzRMa4J0VbvPlCyXxx9dFCL4gn1ZusVJEZuf+9Hk7r+5Cw5KKcM37BUQHSmWIBkDm7
 j7Sb5TAjseIolO2kjeQ+Xr7riVOO1Uz548/6AN2FgJJV44CFCYhlygXrPQdMPD4fil0Hw8
 Az5SDjg0nsxFjORksiifKwM17nr/VRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719588919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRdchX8YymKGCXN0mbie8zttQM9CBQsNnpYyfuDcZw=;
 b=iXwaxTRp5CbceamUYnXefc9pbmH+upgbkRgzrplnT+lhbcYmDtRf+Eo3S68iMLqMfCFsEv
 eeUNMywpRozzghBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719588917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRdchX8YymKGCXN0mbie8zttQM9CBQsNnpYyfuDcZw=;
 b=OXXruzq+8LGOsGV4m9JzO5VGvK5sHuARbT6Uo2sZTpPX/lHOzmO66moYxWZPIRzr5kN4U5
 uVIbyjX0Z7b2wTLd/lpRziMTRWANz3QP0Lar5okaZxfoLyuiH4Smf7Sh650leaxmCnLQQq
 HZPUIvRcdCzt7ESahogVHUBFXRSDdTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719588917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRdchX8YymKGCXN0mbie8zttQM9CBQsNnpYyfuDcZw=;
 b=l3EErt5wG4ZCUUAIQ9d+dUj2Q4OOT36Dyhs79Y4caQ8NoGyYtJy4B3guRfcPuf03yDwg7V
 whFgT8XRUnGqqDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C951A13375;
 Fri, 28 Jun 2024 15:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5/cUMDXYfmbwJgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jun 2024 15:35:17 +0000
Date: Fri, 28 Jun 2024 17:35:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zn7YK-5Ub5NxBtDA@yuki>
References: <20231201005902.15630-1-wegao@suse.com>
 <20240603103553.8318-1-wegao@suse.com>
 <20240603103553.8318-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240603103553.8318-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, linux.it:url,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] ptrace05: Refactor the test using new LTP
 API
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
> +	for (signum = 0; signum <= SIGRTMAX; signum++) {

I would put the code in this for loop into a function so that we save
some indentation as:

	for (signum = 0; signum <= SIGRTMAX; signum++) {
		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
			continue;

		test_signal(sig);
	}
>  
> -		switch (child = fork()) {
> -		case -1:
> -			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
> -		case 0:
> +		child = SAFE_FORK();
>  
> -			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
> -				tst_resm(TINFO, "[child] Sending kill(.., %d)",
> -					 signum);
> -				if (kill(getpid(), signum) < 0) {
> -					tst_resm(TINFO | TERRNO,
> -						 "[child] kill(.., %d) failed.",
> -						 signum);
> -				}
> +		if (child == 0) {
> +			TEST(ptrace(PTRACE_TRACEME, 0, NULL, NULL));

TST_EXP_PASS()?

I guess it would look like:


	if (!child) {
		TST_EXP_PASS(ptrace(PTRACE_TRACEME, 0, NULL, NULL);

		if (!TST_PASS)
			exit(0);

		tst_res(...);

		SAFE_KILL(getpid(), signum);
	} else {
		...
	}

> +			if (TST_RET != -1) {
> +				tst_res(TINFO, "[child] Sending kill(.., %d)",
> +						signum);

Maybe TDEBUG instead of TINFO to avoid overly long output?

And we can use tst_strsig() to print the signal name as well.

> +				SAFE_KILL(getpid(), signum);
>  			} else {
> -
> -				/*
> -				 * This won't increment the TST_COUNT var.
> -				 * properly, but it'll show up as a failure
> -				 * nonetheless.
> -				 */
> -				tst_resm(TFAIL | TERRNO,
> -					 "Failed to ptrace(PTRACE_TRACEME, ...) "
> -					 "properly");
> -
> +				tst_brk(TFAIL | TERRNO,
> +						"Failed to ptrace(PTRACE_TRACEME, ...) "
> +						"properly");
>  			}
> +
>  			/* Shouldn't get here if signum == 0. */
>  			exit((signum == 0 ? 0 : 2));

We do not use the exit value for anything in the new code, so this can
be just exit(0).

> -			break;
> -
> -		default:
> +		}
>  
> -			waitpid(child, &status, 0);
> +		SAFE_WAITPID(child, &status, 0);
>  
> -			switch (signum) {
> -			case 0:
> -				if (WIFEXITED(status)
> -				    && WEXITSTATUS(status) == 0) {
> -					tst_resm(TPASS,
> -						 "kill(.., 0) exited "
> -						 "with 0, as expected.");
> -				} else {
> -					tst_resm(TFAIL,
> -						 "kill(.., 0) didn't exit "
> -						 "with 0.");
> -				}
> -				break;
> -			case SIGKILL:
> -				if (WIFSIGNALED(status)) {
> -					/* SIGKILL must be uncatchable. */
> -					if (WTERMSIG(status) == SIGKILL) {
> -						tst_resm(TPASS,
> -							 "Killed with SIGKILL, "
> -							 "as expected.");
> -					} else {
> -						tst_resm(TPASS,
> -							 "Didn't die with "
> -							 "SIGKILL (?!) ");
> -					}
> -				} else if (WIFEXITED(status)) {
> -					tst_resm(TFAIL,
> -						 "Exited unexpectedly instead "
> -						 "of dying with SIGKILL.");
> -				} else if (WIFSTOPPED(status)) {
> -					tst_resm(TFAIL,
> -						 "Stopped instead of dying "
> -						 "with SIGKILL.");
> -				}
> -				break;
> -				/* All other processes should be stopped. */
> -			default:
> -				if (WIFSTOPPED(status)) {
> -					tst_resm(TPASS, "Stopped as expected");
> +		switch (signum) {
> +		case 0:
> +			if (WIFEXITED(status)
> +					&& WEXITSTATUS(status) == 0) {
> +				tst_res(TPASS,
> +						"kill(.., 0) exited with 0, as expected.");
> +			} else {
> +				tst_brk(TFAIL | TERRNO,
> +						"kill(.., 0) didn't exit with 0.");

We do have tst_strstatus() so that we can print what was the reason
child did exit, please use it this TFAIL message.

> +			}
> +			break;
> +		case SIGKILL:
> +			if (WIFSIGNALED(status)) {
> +				/* SIGKILL must be uncatchable. */
> +				if (WTERMSIG(status) == SIGKILL) {
> +					tst_res(TPASS,
> +							"Killed with SIGKILL, as expected.");
>  				} else {
> -					tst_resm(TFAIL, "Didn't stop as "
> -						 "expected.");
> -					if (kill(child, 0)) {
> -						tst_resm(TINFO,
> -							 "Is still alive!?");
> -					} else if (WIFEXITED(status)) {
> -						tst_resm(TINFO,
> -							 "Exited normally");
> -					} else if (WIFSIGNALED(status)) {
> -						tst_resm(TINFO,
> -							 "Was signaled with "
> -							 "signum=%d",
> -							 WTERMSIG(status));
> -					}
> -
> +					tst_brk(TFAIL | TERRNO,
> +							"Didn't die with SIGKILL (?!) ");
>  				}
> -
> -				break;
> -
> +			} else if (WIFEXITED(status)) {
> +				tst_res(TFAIL | TERRNO,
> +						"Exited unexpectedly instead of dying with SIGKILL.");
> +			} else if (WIFSTOPPED(status)) {
> +				tst_res(TFAIL | TERRNO,
> +						"Stopped instead of dying with SIGKILL.");

And here as well, this whole part can be replaced by just:

		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
			tst_res(TPASS, "Child killed by SIGKILL");
		else
			tst_res(TFAIL, "Child %s", tst_strstatus(status));

Also notice that we shouldn't print errno in this case, so no TERRNO
flag there.

> -
> +			break;
> +			/* All other processes should be stopped. */
> +		default:
> +			if (WIFSTOPPED(status))
> +				tst_res(TPASS, "Stopped as expected");
> +			else
> +				tst_res(TFAIL | TERRNO, "Didn't stop as expected.");

Here as well, make use of the tst_strstatus() please.

> +			break;
>  		}
> -		/* Make sure the child dies a quick and painless death ... */
> -		kill(child, 9);
>  
> +		if (signum != 0 && signum != SIGKILL)
> +			SAFE_PTRACE(PTRACE_CONT, child, NULL, NULL);
>  	}
> -
> -	tst_exit();
> -
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
