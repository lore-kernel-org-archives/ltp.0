Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4BCC6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 10:42:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44BED3CFB33
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 11:42:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B005C3CBA62
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 11:42:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C9334200BDE
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 11:42:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FACB5D47E;
 Tue, 26 Mar 2024 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711449727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=583WpYo6LlsZEqWBCmPLakYrYc5Ubqe8Pu9Kta7rUT4=;
 b=GDMbgEQWgTtQZ1r6VkMvSsCqKa9OCxIWXTmyDiHTwSImyYCZrjfQLSKew7zglGaWY6OU9m
 4Ra4CDIxuSXsDYsLlANkdXrzPqbiQluDQUAP0KJJqG8+8BqhH8KeWABiW4I1QtypA+5ECe
 QRRDY9TyBA+v9uwGR3Dat8Y5gxd5D7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711449727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=583WpYo6LlsZEqWBCmPLakYrYc5Ubqe8Pu9Kta7rUT4=;
 b=8eBnOK/GIDWWS1KWteNOMvw3vVA0DyUN8OVyXOKai420PKl7UnjeGaMgQGrdqmSgs894PR
 UOEQZt2o247XEJBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711449725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=583WpYo6LlsZEqWBCmPLakYrYc5Ubqe8Pu9Kta7rUT4=;
 b=pEsmQuRII2lYli9sjNEgtcRrhHbP2LoGqZpqLztk5qzpI8Kn6Wr6jyWAaxjcGaefRbh6KE
 SaENukg9o2wfifeA+DBEnl+lUxHGnsmhu0LPDTtCTFczpMxo3cDQw3uarfQ6EKm84mZ2bf
 3OS8KrWhBYY5X9Xpd2OW963UF0bD5zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711449725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=583WpYo6LlsZEqWBCmPLakYrYc5Ubqe8Pu9Kta7rUT4=;
 b=Sohzyuto30IdmqevQ3gNUMpqwytrudfHTcewXhDelVOfL1spvpoUcJGdr1YpTkkWHwZmwu
 Z8+uLmnmtQUA4NDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 362B313306;
 Tue, 26 Mar 2024 10:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KV4fDH2mAmbsBAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Mar 2024 10:42:05 +0000
Date: Tue, 26 Mar 2024 11:41:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZgKmScOuuiobsEdj@yuki>
References: <20240320102204.475230-1-pvorel@suse.cz>
 <20240320102204.475230-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320102204.475230-4-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.25 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,linux.ibm.com,redhat.com,gmail.com,suse.cz]; 
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.45)[97.51%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Co-developed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * Do not include library header in fanotify14 (not needed)
> 
>  .../kernel/syscalls/fanotify/fanotify14.c      | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> index d02d81495..82725f317 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -47,6 +47,7 @@ static int pipes[2] = {-1, -1};
>  static int fanotify_fd;
>  static int ignore_mark_unsupported;
>  static int filesystem_mark_unsupported;
> +static int se_enforcing;
>  static unsigned int supported_init_flags;
>  
>  struct test_case_flags_t {
> @@ -283,9 +284,18 @@ static void do_test(unsigned int number)
>  
>  	tst_res(TINFO, "Testing %s with %s",
>  		tc->mark.desc, tc->mask.desc);
> -	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> -					 tc->mask.flags, dirfd, path),
> -					 tc->expected_errno);
> +
> +	if (tc->pfd && se_enforcing) {
> +		const int exp_errs[] = {tc->expected_errno, EACCES};
> +
> +		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> +				 tc->mask.flags, dirfd, path),
> +				 exp_errs);
> +	} else {
> +		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> +						 tc->mask.flags, dirfd, path),
> +						 tc->expected_errno);
> +	}

This looks like the test library is not flexible enough to make this
simpler. Maybe having the ARRAY_SIZE() in the TST_EXP_FAIL_ARR wasn't a
good idea after all. Or maybe we just need TST_EXP_FAIL_ARR2() that
would take the array size explicitly, then we could do:


	const int exp_errs[] = {tc->expected_errno, EACESS}

	TST_EXP_FAIL_ARR2(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
                           tc->mask.flags, dirfd, path), exp_errs,
			   se_enforcing ? 1 : 2);

>  	/*
>  	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
> @@ -334,6 +344,8 @@ static void do_setup(void)
>  	SAFE_FILE_PRINTF(FILE1, "0");
>  	/* Create anonymous pipes to place marks on */
>  	SAFE_PIPE2(pipes, O_CLOEXEC);
> +
> +	se_enforcing = tst_selinux_enforcing();
>  }
>  
>  static void do_cleanup(void)
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
