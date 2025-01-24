Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C2BC02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 08:09:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 433723C4E9C
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 09:09:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A09F33C286F
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 09:09:06 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 020627A916F
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 09:09:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 023BF21172;
 Fri, 24 Jan 2025 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737706145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12Jrs1pymzVG46pFexnCEkZ1twTWipE50UpgzmY4+KM=;
 b=TuloWyLqA+O0LVPm7BmvBnCu7GL+vxp+43muA9Q9GvK4oECH/WrN/nhU3vN+M+cK0uJF4J
 F4okuIAqqgbOAk+MP7zotCmlsM9Omt9x+OR3GuFdW1LzEgVpffN4Vrs3nigwGLLKkDdSQr
 axOh80vi0oUmld7vd0ymOr9DGdcfRK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737706145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12Jrs1pymzVG46pFexnCEkZ1twTWipE50UpgzmY4+KM=;
 b=VryLp0Opu2q2dmFKCV60fTewbEe/1xiLi/e4S896ebksWJlxKfDszQfvZOk+kR9NoVbQQN
 PG+419iDDDyvmUCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737706145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12Jrs1pymzVG46pFexnCEkZ1twTWipE50UpgzmY4+KM=;
 b=TuloWyLqA+O0LVPm7BmvBnCu7GL+vxp+43muA9Q9GvK4oECH/WrN/nhU3vN+M+cK0uJF4J
 F4okuIAqqgbOAk+MP7zotCmlsM9Omt9x+OR3GuFdW1LzEgVpffN4Vrs3nigwGLLKkDdSQr
 axOh80vi0oUmld7vd0ymOr9DGdcfRK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737706145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12Jrs1pymzVG46pFexnCEkZ1twTWipE50UpgzmY4+KM=;
 b=VryLp0Opu2q2dmFKCV60fTewbEe/1xiLi/e4S896ebksWJlxKfDszQfvZOk+kR9NoVbQQN
 PG+419iDDDyvmUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8E2E139CB;
 Fri, 24 Jan 2025 08:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JdqQM6BKk2d7cQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jan 2025 08:09:04 +0000
Date: Fri, 24 Jan 2025 09:09:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250124080903.GC159953@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122172440.506677-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122172440.506677-6-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.49 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.999]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.19)[-0.972]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] fanotify21: Test reporting fd open errors
 with FAN_REPORT_FD_ERROR
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> Expect to get -EROFS as event->fd.
> Expect to get -ESRCH instead of FAN_NOPIDFD.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify21.c     | 61 ++++++++++++++++---
>  1 file changed, 51 insertions(+), 10 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index 4324019fa..8765767f2 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -57,7 +57,7 @@ static struct test_case_t {
>  	{
>  		"return invalid pidfd for event created by terminated child",
>  		1,
> -		FAN_NOPIDFD,
> +		1,
>  		0,
>  	},
>  	{
> @@ -72,6 +72,8 @@ static int fanotify_fd;
>  static char event_buf[BUF_SZ];
>  static struct pidfd_fdinfo_t *self_pidfd_fdinfo;

> +static int fd_error_unsupported;
> +
>  static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
>  {
>  	char *fdinfo_path;
> @@ -121,6 +123,15 @@ static void do_fork(void)
>  static void do_setup(void)
>  {
>  	int pidfd;
> +	int init_flags = FAN_REPORT_PIDFD;
> +
> +	if (tst_variant) {
> +		fanotify_fd = -1;
> +		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
> +		if (fd_error_unsupported)
> +			return;
> +		init_flags |= FAN_REPORT_FD_ERROR;
> +	}

>  	SAFE_TOUCH(TEST_FILE, 0666, NULL);

> @@ -132,7 +143,7 @@ static void do_setup(void)
>  	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
>  						    TEST_FILE);

> -	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDWR);
> +	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
>  	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
>  			   TEST_FILE);

> @@ -150,8 +161,17 @@ static void do_test(unsigned int num)
>  {
>  	int i = 0, len;
>  	struct test_case_t *tc = &test_cases[num];
> +	int nopidfd_err = tc->want_pidfd_err ?
> +			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
> +	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;

> -	tst_res(TINFO, "Test #%d: %s", num, tc->name);
> +	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
> +			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
Thanks for printing also tst_variant, it helps reviewing the test
(number of the results increased from 20 to 110).

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
