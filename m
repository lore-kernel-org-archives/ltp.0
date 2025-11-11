Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A49CCFA1A
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 11:06:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 436C93CF66B
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 12:06:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 427B03CD14C
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 12:06:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C6A131A00919
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 12:06:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9151E1F78F;
 Tue, 11 Nov 2025 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762859183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGS+8dzWoCUGeDFWhf6nfHzON0/0mCSSqo7ofMwNLII=;
 b=j2FmDkfMUIB0CqjXxz3+CgGWWKD1gdo7SEqUvEGwSYl8/OikYTEo3BMHDFAGI/6jGsTumR
 W4/gX2aQ4iDmbPrKTd25hqV5kYrs1dVzwfqbm8JPmxm8EwXYQQ2BTxD+3haLuO2ggzAuc9
 TxZamjkrcr9LkkWkmfSH3L6WfjMBuKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762859183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGS+8dzWoCUGeDFWhf6nfHzON0/0mCSSqo7ofMwNLII=;
 b=28KmqJhDv0k3TtHbxiaKdXoasVUIyu60PIHJlABQqfArC+bELpFSUd2XqI4MFrs4aL7sAo
 j/1OyS9e1KqtrEBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j2FmDkfM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=28KmqJhD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762859183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGS+8dzWoCUGeDFWhf6nfHzON0/0mCSSqo7ofMwNLII=;
 b=j2FmDkfMUIB0CqjXxz3+CgGWWKD1gdo7SEqUvEGwSYl8/OikYTEo3BMHDFAGI/6jGsTumR
 W4/gX2aQ4iDmbPrKTd25hqV5kYrs1dVzwfqbm8JPmxm8EwXYQQ2BTxD+3haLuO2ggzAuc9
 TxZamjkrcr9LkkWkmfSH3L6WfjMBuKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762859183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGS+8dzWoCUGeDFWhf6nfHzON0/0mCSSqo7ofMwNLII=;
 b=28KmqJhDv0k3TtHbxiaKdXoasVUIyu60PIHJlABQqfArC+bELpFSUd2XqI4MFrs4aL7sAo
 j/1OyS9e1KqtrEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 775391490A;
 Tue, 11 Nov 2025 11:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +9RMHK8YE2nCUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Nov 2025 11:06:23 +0000
Date: Tue, 11 Nov 2025 12:06:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251111110618.GA42156@pevik>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110024805.31070-2-wegao@suse.com>
X-Rspamd-Queue-Id: 9151E1F78F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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

Hi Wei,

...
>  /*
>   * vfork() + execvp() specified program.
>   *
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 9c21c1728..9305cf39d 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -524,7 +524,7 @@ struct tst_fs {
>   *
>   * @tags: A {} terminated array of test tags. See struct tst_tag for details.
>   *
> - * @needs_cmds: A NULL terminated array of commands required for the test to run.
> + * @needs_cmds: A NULL terminated array of struct tst_cmd required for the test to run.

Please use :ref:`...` formatting to make struct clickable.

 * @needs_cmds: A NULL terminated array of :ref:`struct tst_cmd` required for
 *              the test to run.

>   *
>   * @needs_cgroup_ver: If set the test will run only if the specified cgroup
>   *                    version is present on the system.
> @@ -617,7 +617,7 @@ struct tst_fs {

>  	const struct tst_tag *tags;

> -	const char *const *needs_cmds;
> +	struct tst_cmd *needs_cmds;

>  	const enum tst_cg_ver needs_cgroup_ver;

> @@ -721,6 +721,18 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
>   */
>  const char *tst_get_tmpdir_root(void);

> +/**
> + * tst_cmd_present() - Check if a command is present
> + * @cmd: The name of the command to check for.
> + *
> + * This function iterates through the &tst_test->needs_cmds array. It compares
> + * the given command name with each entry in the array and returns the 'present'

And here please again make it clickable tst_cmd->present. It really helps people
to click and see what you mean by 'present'.

 * the given command name with each entry in the array and returns the
 * &tst_cmd->present flag for the matching command.

If this is the only part to change, it can be done before merge.

> + * flag for the matching command.
> + *
> + * Return: `true` if the command is present, `false` otherwise.
> + */
> +bool tst_cmd_present(const char *cmd);

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
