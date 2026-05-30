Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD0CD5BD0
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 11:22:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7DA23E48FA
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 13:22:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B104B3CD545
 for <ltp@lists.linux.it>; Sat, 30 May 2026 13:21:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70A51600049
 for <ltp@lists.linux.it>; Sat, 30 May 2026 13:21:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0547B6B6BB;
 Sat, 30 May 2026 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780140100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0pE+6NSgFzEcZBQqCFwRrE/aJSpnxFE9j3atfRTGoQ=;
 b=UDSQbE80+HtEsVps8uDtMbsSK+FgbaA1RxkssGjWpjuCB46KJE9BGPgXlC/PA5np+Lp+ZU
 lgA0DQ/I4IZ4782EJbFwEPw/8RoPItQ9HvUg4+HtJZ4HwKSHwI5x+aIXAhx8G3xu+CwdFR
 7edKHdNGdABE46EnEpe8DIbSwgZVahk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780140100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0pE+6NSgFzEcZBQqCFwRrE/aJSpnxFE9j3atfRTGoQ=;
 b=6G9Ex9RFOQwyB5LCZUPiBIKbHCuxeb2JU+v2SHrwSzBmMeJevxZtybuGMXxj2xiXOfUCwU
 Uye0rHQDdTTnT/Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UDSQbE80;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6G9Ex9RF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780140100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0pE+6NSgFzEcZBQqCFwRrE/aJSpnxFE9j3atfRTGoQ=;
 b=UDSQbE80+HtEsVps8uDtMbsSK+FgbaA1RxkssGjWpjuCB46KJE9BGPgXlC/PA5np+Lp+ZU
 lgA0DQ/I4IZ4782EJbFwEPw/8RoPItQ9HvUg4+HtJZ4HwKSHwI5x+aIXAhx8G3xu+CwdFR
 7edKHdNGdABE46EnEpe8DIbSwgZVahk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780140100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0pE+6NSgFzEcZBQqCFwRrE/aJSpnxFE9j3atfRTGoQ=;
 b=6G9Ex9RFOQwyB5LCZUPiBIKbHCuxeb2JU+v2SHrwSzBmMeJevxZtybuGMXxj2xiXOfUCwU
 Uye0rHQDdTTnT/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E883A779A7;
 Sat, 30 May 2026 11:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oY1wN0PIGmq9KQAAD6G6ig
 (envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:21:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 88B8AA0EBD; Sat, 30 May 2026 13:21:35 +0200 (CEST)
Date: Sat, 30 May 2026 13:21:35 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <n6ft5dxkww6q6lex5uyhtwoi3uakda2v3czpmq4dxj2oiqsvmg@mc5x4gslvule>
References: <20260528151938.909301-1-amir73il@gmail.com>
 <20260528151938.909301-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260528151938.909301-2-amir73il@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0547B6B6BB
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_COUNT_THREE(0.00)[3]; FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify21: fix test failure when running
 iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 28-05-26 17:19:38, Amir Goldstein wrote:
> Peter reported that fanotify21 -i2 fails.
> Fix this by always remounting ro/rw before every test.
> Use a bind mount, where remount works regardless of base fs.
> 
> Reported-by: pvorel@suse.cz
> Link: https://lore.kernel.org/linux-fsdevel/20260527072312.GA231966@pevik/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Ah, nice trick. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Petr,
> 
> This is a simplified version of AnonymeMeow's patch.
> 
> Thanks,
> Amir.
> 
>  .../kernel/syscalls/fanotify/fanotify21.c      | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index c95895c93..fd18d7e29 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -123,6 +123,9 @@ static void do_setup(void)
>  	int pidfd;
>  	int init_flags = FAN_REPORT_PIDFD;
>  
> +	/* Bind mount so remount ro/rw always work */
> +	SAFE_MOUNT(MOUNT_PATH, MOUNT_PATH, "none", MS_BIND, NULL);
> +
>  	if (tst_variant) {
>  		fanotify_fd = -1;
>  		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
> @@ -171,15 +174,9 @@ static void do_test(unsigned int num)
>  		return;
>  	}
>  
> -	if (tc->remount_ro) {
> -		/* SAFE_MOUNT fails to remount FUSE */
> -		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> -			  MS_REMOUNT|MS_RDONLY, NULL) != 0) {
> -			tst_brk(TFAIL,
> -				"filesystem %s failed to remount readonly",
> -				tst_device->fs_type);
> -		}
> -	}
> +	/* remount ro/rw the bind mount */
> +	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
> +		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
>  
>  	/*
>  	 * Generate the event in either self or a child process. Event
> @@ -355,6 +352,9 @@ static void do_cleanup(void)
>  
>  	if (self_pidfd_fdinfo)
>  		free(self_pidfd_fdinfo);
> +
> +	/* Unmount the bind mount */
> +	SAFE_UMOUNT(MOUNT_PATH);
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
