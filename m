Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F46C47DA2
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 14:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B0C23CE30F
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 15:49:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E97B3CC959
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 15:49:13 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 145FC60086B
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 15:49:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C8D92228E;
 Wed, 17 Jan 2024 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705502952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NwAOEfyepSTKsvYF/Rl+v8vH9uHTnF/WcsOGK4pjdM=;
 b=v8I9FJdbrZpb9OIxl/I+LpRGtvy1a8+G/vJK5UGjcQAEvQ92PFxphCDHAYaVuaveQOHtSC
 D90SqB0Jg8odaXew4h8Vppz9bShEZIcHKXf2MGWZBjwejx27siBvHtkdMNeTGFmWGgL0U/
 kznEaNvQPv/cjCXmV6MZyHAUTgojQ6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705502952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NwAOEfyepSTKsvYF/Rl+v8vH9uHTnF/WcsOGK4pjdM=;
 b=TcvHD4QTlvsg1bLnnT8ocV5ynrFhAlhgLesmaB7EOWRdpkoR2olP5q9eycM+ragp+dkHlw
 cR/f8AmWlUkGVzCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705502952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NwAOEfyepSTKsvYF/Rl+v8vH9uHTnF/WcsOGK4pjdM=;
 b=v8I9FJdbrZpb9OIxl/I+LpRGtvy1a8+G/vJK5UGjcQAEvQ92PFxphCDHAYaVuaveQOHtSC
 D90SqB0Jg8odaXew4h8Vppz9bShEZIcHKXf2MGWZBjwejx27siBvHtkdMNeTGFmWGgL0U/
 kznEaNvQPv/cjCXmV6MZyHAUTgojQ6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705502952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NwAOEfyepSTKsvYF/Rl+v8vH9uHTnF/WcsOGK4pjdM=;
 b=TcvHD4QTlvsg1bLnnT8ocV5ynrFhAlhgLesmaB7EOWRdpkoR2olP5q9eycM+ragp+dkHlw
 cR/f8AmWlUkGVzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F8E13800;
 Wed, 17 Jan 2024 14:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BnWOO+fop2X+CwAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 14:49:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 889E8A0803; Wed, 17 Jan 2024 15:49:11 +0100 (CET)
Date: Wed, 17 Jan 2024 15:49:11 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240117144911.umxdzskqkncvxxgz@quack3>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240115125351.7266-3-chrubis@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[22.23%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] syscalls: readahead01: Make use of tst_fd
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 15-01-24 13:53:49, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/readahead/readahead01.c   | 52 ++++++++++---------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> index bdef7945d..e86a73e3e 100644
> --- a/testcases/kernel/syscalls/readahead/readahead01.c
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2012 Linux Test Project, Inc.
> + * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
>   */
>  
>  /*\
> @@ -30,43 +31,44 @@
>  
>  static void test_bad_fd(void)
>  {
> -	char tempname[PATH_MAX] = "readahead01_XXXXXX";
> -	int fd;
> +	int fd[2];
> +
> +	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
> +	             "readahead() with fd = -1");
>  
> -	tst_res(TINFO, "%s -1", __func__);
> -	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
> +	SAFE_PIPE(fd);
> +	SAFE_CLOSE(fd[0]);
> +	SAFE_CLOSE(fd[1]);
>  
> -	tst_res(TINFO, "%s O_WRONLY", __func__);
> -	fd = mkstemp(tempname);
> -	if (fd == -1)
> -		tst_res(TFAIL | TERRNO, "mkstemp failed");
> -	SAFE_CLOSE(fd);
> -	fd = SAFE_OPEN(tempname, O_WRONLY);
> -	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
> -	SAFE_CLOSE(fd);
> -	unlink(tempname);
> +	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
> +	             "readahead() with invalid fd");
>  }
>  
> -static void test_invalid_fd(void)
> +static void test_invalid_fd(struct tst_fd *fd)
>  {
> -	int fd[2];
>  
> -	tst_res(TINFO, "%s pipe", __func__);
> -	SAFE_PIPE(fd);
> -	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> -	SAFE_CLOSE(fd[0]);
> -	SAFE_CLOSE(fd[1]);
> +	switch (fd->type) {
> +	/* These succeed */
> +	case TST_FD_FILE:
> +	case TST_FD_MEMFD:
> +	case TST_FD_PROC_MAPS:
> +		return;
> +	default:
> +		break;
> +	}
>  
> -	tst_res(TINFO, "%s socket", __func__);
> -	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> -	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> -	SAFE_CLOSE(fd[0]);
> +	int exp_errnos[] = {EBADF, EINVAL, ESPIPE};
> +
> +	TST_EXP_FAIL_ARR(readahead(fd->fd, 0, getpagesize()), exp_errnos,
> +			"readahead() on %s", tst_fd_desc(fd));
>  }
>  
>  static void test_readahead(void)
>  {
>  	test_bad_fd();
> -	test_invalid_fd();
> +
> +	TST_FD_FOREACH(fd)
> +		test_invalid_fd(&fd);
>  }
>  
>  static void setup(void)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
