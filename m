Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E81CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:48:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33D873E4E38
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:48:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFC073E2238
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:48:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5159B1000A09
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:48:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 927B66B8CE;
 Tue, 16 Jun 2026 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781596114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXBM81syTk9um4QSVXxOHuz+mqGHXC4Iixa5zCUoYic=;
 b=joDKoDUOqxPWL/ZKJ1iuJKlmx2cUbWxIMMNzftguSLIubPpS89dgtEyjVdm+XCv+FY/5+a
 XRbwEF1EsRwEX1SJfgJVFPJfVIrlApTJ4FRuA9bn09UJom8xJxauGQGlXUtZh1lfCNG2pg
 6mxkX/ZeVjEd5ZJDJZ16JqI3lhIBhgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781596114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXBM81syTk9um4QSVXxOHuz+mqGHXC4Iixa5zCUoYic=;
 b=NOcqtx+QhpQR4EqBkPNKMiMFTdQmx7DYM1B0niduzIV39sa0U/eBhRo7El1xAPYpeMdtTJ
 nMAeaB6Ra3EGC0Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781596113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXBM81syTk9um4QSVXxOHuz+mqGHXC4Iixa5zCUoYic=;
 b=UzsZRoqmHDb6H3F+brnq2Z9Sllmv7BT3vl+Q7eumPLC/XMhSHZ9KZPpNzrJ2tC1llXuXQ3
 oAP+YWbFregY6tlKx5IjcdwWudReBZdk2mA6n8PhYtzsCUmFzra+wT5X/Rk51cpDjGZ64H
 Uv4jk164F4wPXK2aNFGFtAmi8JospFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781596113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXBM81syTk9um4QSVXxOHuz+mqGHXC4Iixa5zCUoYic=;
 b=UN60bFnbyKUkd1wuUllU0Jo6ARjYQfUE+vEhxTA70lJFjcCLtQRjD9fAB/ukc8MyPBsIQL
 yjBK2YYRGRT1SkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 895F7779A8;
 Tue, 16 Jun 2026 07:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zkSGIdH/MGo0UAAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 07:48:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 32701A12D3; Tue, 16 Jun 2026 09:48:33 +0200 (CEST)
Date: Tue, 16 Jun 2026 09:48:33 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <qfx2oitsw2jcnxp4rn437uverjfbq6wnxkxs7kp6dydwupur2l@eblrbeqcagzu>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-3-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615180629.7148-3-anonymemeow@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] fanotify21: Stop relying on exited child for
 pidfd error
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 16-06-26 02:06:26, AnonymeMeow wrote:
> fanotify21 used to verify the pidfd error case by generating an event
> from a child process and reading the event after the child had exited.
> This is no longer a stable way to trigger a pidfd error, because newer
> kernels can report pidfds for exited event processes.
> 
> Read the event from a child process in a descendant PID namespace
> instead. The reader cannot get the pidfd in the parent PID namespace
> from fanotify, so pidfd creation will fail and the test can verify
> FAN_NOPIDFD, or -ESRCH with FAN_REPORT_FD_ERROR.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify21.c     | 55 ++++++++-----------
>  1 file changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index 4d2115469..bd1a43513 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -42,7 +42,6 @@ struct pidfd_fdinfo_t {
>  
>  static struct test_case_t {
>  	char *name;
> -	int fork;
>  	int want_pidfd_err;
>  	int remount_ro;
>  } test_cases[] = {
> @@ -50,18 +49,15 @@ static struct test_case_t {
>  		"return a valid pidfd for event created by self",
>  		0,
>  		0,
> -		0,
>  	},
>  	{
> -		"return invalid pidfd for event created by terminated child",
> -		1,
> +		"return invalid pidfd for reader in descendant PID namespace",
>  		1,
>  		0,
>  	},
>  	{
>  		"fail to open rw fd for event created on read-only mount",
>  		0,
> -		0,
>  		1,
>  	},
>  };
> @@ -72,6 +68,11 @@ static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
>  
>  static int fd_error_unsupported;
>  
> +static struct tst_clone_args clone_args = {
> +	.flags = CLONE_NEWPID,
> +	.exit_signal = SIGCHLD,
> +};
> +
>  static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
>  {
>  	char *fdinfo_path;
> @@ -100,24 +101,6 @@ static void generate_event(void)
>  	SAFE_CLOSE(fd);
>  }
>  
> -static void do_fork(void)
> -{
> -	int status;
> -	pid_t child;
> -
> -	child = SAFE_FORK();
> -	if (child == 0) {
> -		SAFE_CLOSE(fanotify_fd);
> -		generate_event();
> -		exit(EXIT_SUCCESS);
> -	}
> -
> -	SAFE_WAITPID(child, &status, 0);
> -	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> -		tst_brk(TBROK,
> -			"child process terminated incorrectly");
> -}
> -
>  static void do_setup(void)
>  {
>  	int pidfd;
> @@ -165,6 +148,8 @@ static void do_test(unsigned int num)
>  	int nopidfd_err = tc->want_pidfd_err ?
>  			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
>  	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
> +	pid_t reader_pid;
> +	int reader_exit_status;
>  
>  	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
>  			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
> @@ -178,15 +163,20 @@ static void do_test(unsigned int num)
>  	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
>  		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
>  
> +	generate_event();
> +
>  	/*
> -	 * Generate the event in either self or a child process. Event
> -	 * generation in a child process is done so that the FAN_NOPIDFD case
> -	 * can be verified.
> +	 * Read the event in either self or a child process in a descendant
> +	 * PID namespace. A reader in a descendant PID namespace cannot obtain
> +	 * the pidfd of the event process in the parent PID namespace so that
> +	 * the FAN_NOPIDFD case can be verified.
>  	 */
> -	if (tc->fork)
> -		do_fork();
> -	else
> -		generate_event();
> +	if (tc->want_pidfd_err && (reader_pid = SAFE_CLONE(&clone_args))) {
> +		SAFE_WAITPID(reader_pid, &reader_exit_status, 0);
> +		if (!WIFEXITED(reader_exit_status) || WEXITSTATUS(reader_exit_status))
> +			tst_brk(TBROK, "reader process exited incorrectly");
> +		return;
> +	}
>  
>  	/*
>  	 * Read all of the queued events into the provided event
> @@ -274,7 +264,7 @@ static void do_test(unsigned int num)
>  			goto next_event;
>  		} else if (tc->want_pidfd_err && info->pidfd == nopidfd_err) {
>  			tst_res(TPASS,
> -				"pid: %u terminated before pidfd was created, "
> +				"pid: %u is invisible in reader PID namespace, "
>  				"pidfd set to the value of: %d, as expected",
>  				(unsigned int)event->pid,
>  				nopidfd_err);
> @@ -343,6 +333,9 @@ next_event:
>  		if (event_pidfd_fdinfo)
>  			free(event_pidfd_fdinfo);
>  	}
> +
> +	if (tc->want_pidfd_err)
> +		exit(0);
>  }
>  
>  static void do_cleanup(void)
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
