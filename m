Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87482106F306
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 08:57:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22E343E2AB5
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 09:57:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200F83DCACD
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:57:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BFC56001A2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:57:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9EC25BCF4;
 Thu, 26 Mar 2026 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774515421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nv9njegMSnFqljxMdEA3redlrRc43wt7GN14bJ1AZHs=;
 b=zTZUqvjiQdFAPswtC6OIlc+H87OMxNyFWxpiOl3Fa0KKEJS7wLuk2q8hO99f66mEu7EMBw
 nNS9CYD+f5VLiEzDCm5WjrU1i1/c6fsRf+gPalJ6GGUZTWdm/80Tktq6SBrHHPmAbdpL52
 oDhl7CHez/EtT1cDEXhyVeqWcYbw744=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774515421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nv9njegMSnFqljxMdEA3redlrRc43wt7GN14bJ1AZHs=;
 b=plTnM1JUcZM5CyZNk8YLYE1nk4No/EY1ggj76gG5DRFqSPxZNMxwdcPPbgTIWR0yZFAua7
 elv+FZKA5pXuZ1CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774515421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nv9njegMSnFqljxMdEA3redlrRc43wt7GN14bJ1AZHs=;
 b=zTZUqvjiQdFAPswtC6OIlc+H87OMxNyFWxpiOl3Fa0KKEJS7wLuk2q8hO99f66mEu7EMBw
 nNS9CYD+f5VLiEzDCm5WjrU1i1/c6fsRf+gPalJ6GGUZTWdm/80Tktq6SBrHHPmAbdpL52
 oDhl7CHez/EtT1cDEXhyVeqWcYbw744=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774515421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nv9njegMSnFqljxMdEA3redlrRc43wt7GN14bJ1AZHs=;
 b=plTnM1JUcZM5CyZNk8YLYE1nk4No/EY1ggj76gG5DRFqSPxZNMxwdcPPbgTIWR0yZFAua7
 elv+FZKA5pXuZ1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B96D24A0A3;
 Thu, 26 Mar 2026 08:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIBFLN30xGkzFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 08:57:01 +0000
Date: Thu, 26 Mar 2026 09:57:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acT03xEWLjfMjU9z@yuki.lan>
References: <20260325120629.113245-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325120629.113245-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.h: Convert rest of doc to kerneldoc
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
> +/**
> + * tst_set_timeout() - Sets entire timeout in seconds.
> + *
> + * Allows to sett the overall timeout dynamically during the test setup phase.
                 ^
		 set
> + * The timeout is specified in seconds and defines the total time allowed for a
> + * single test iteration, including the setup, runtime, and teardown phases.

Looking at the code this call increases the timeout part of the overall
timeout. This is used only for rare cases that the test does something
that runs for a long time and cannot be easily interrupted (otherwise it
would set runtime and exit when runtime was exhausted). The description
should explain that instead.

> + * @timeout: A timeout in seconds.
>   */
>  void tst_set_timeout(int timeout);
>  
> +/**
> + * tst_multiply_timeout() - Multiply the timeout with LTP_TIMEOUT_MUL
> + * environment variable.

This is again more complex. We use the timeout multiplier but also
look at the kconfig.

It should be something as:

tst_multiply_timeout() - Uses heuristics to multiply a time interval
based on expected CPU slowdowns.

If a machine is expected to be running slow for some reason a user can
export LTP_TIMEOUT_MUL variable that is used by this call to multiply
the interval. We also attempt to detect various kernel config
(debugging) options that slown down the machine and take them into an
account.

> + * @timeout: A timeout in seconds.

Technically the call just multiplies a number and works for any time
unit. If you pass in minutes, you get multiplied minutes. If you pass in
weeks, you get weeks on output...

> + * Return: timeout multiplied with LTP_TIMEOUT_MUL environment variable.
> + */
>  unsigned int tst_multiply_timeout(unsigned int timeout);
>  
>  /*
> @@ -710,19 +724,40 @@ unsigned int tst_multiply_timeout(unsigned int timeout);
>   */
>  unsigned int tst_remaining_runtime(void);
>  
> -/*
> - * Sets maximal test runtime in seconds.
> +/**
> + * tst_set_runtime() - Sets maximal test runtime in seconds.
> + *
> + * Allows for setting the runtime per test iteration dynamically during the test
> + * setup phase. The runtime is specified in seconds and defines how long the
> + * test is allowed to execute its main workload, excluding the setup and
> + * teardown phases.
> + *
> + * This function is useful for tests where the duration of the main workload can
> + * be controlled or needs to be adjusted dynamically. For example, tests that
> + * run in a loop until the runtime expires can use this function to define how
> + * long they should execute.

Maybe add:

A test that sets a runtime must monitor the remaining time with
tst_remaining_runtime() in the main loop.

> + * @runtime: A timeout in seconds.
>   */
>  void tst_set_runtime(int runtime);
>  
> -/*
> - * Create and open a random file inside the given dir path.
> - * It unlinks the file after opening and return file descriptor.
> +/**
> + * tst_creat_unlinked() - Create and open a random file inside the given
> + * directory path, unlinks the file after opening and return file descriptor.
> + *
> + * @path: Path to the directory.
> + * @flags: :manpage:`open(2)` flags.
> + * @mode: :manpage:`open(2)` mode.
> + *
> + * Return: the file descriptor.
>   */
>  int tst_creat_unlinked(const char *path, int flags, mode_t mode);
>  
> -/*
> - * Returns path to the test temporary directory root (TMPDIR).
> +/**
> + * tst_get_tmpdir_root() - Returns path to the test temporary directory root
> + * (TMPDIR environment variable).
> + *
> + * Return: the path to TMPDIR.
>   */
>  const char *tst_get_tmpdir_root(void);
>  
> @@ -738,13 +773,16 @@ const char *tst_get_tmpdir_root(void);
>   */
>  bool tst_cmd_present(const char *cmd);
>  
> -/*
> - * Validates exit status of child processes
> - */
>  int tst_validate_children_(const char *file, const int lineno,
>  	unsigned int count);
> -#define tst_validate_children(child_count) \
> -	tst_validate_children_(__FILE__, __LINE__, (child_count))
> +
> +/**
> + * tst_validate_children() - Validates exit status of the child processes.
> + *
> + * @count: Number of the child processes.
> + */
> +#define tst_validate_children(count) \
> +	tst_validate_children_(__FILE__, __LINE__, (count))
>  
>  #ifndef TST_NO_DEFAULT_MAIN
>  
> -- 
> 2.53.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
