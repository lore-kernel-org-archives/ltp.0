Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEB0C8302D
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 08:43:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EA223C57BB
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 10:43:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C1693C5616
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 10:43:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 72A631A0091B
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 10:43:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D26B721162;
 Mon, 30 Jun 2025 08:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751273011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMUsOTKCB5zQ2rsCEUlx+JEGlyI3wvZv/oVceV5TcAw=;
 b=fHoKNi4phaahyICxEmQAUmJg0hPTwE6mnN09T8yMTJxkSlcfvUzLx6QijZdEGrqYVBY0EZ
 V7wMW9tkMnBnFVLu6bTT6Emm9nlVRT2g0V2X5AZ/upGmK+GMdC30PqNW+1HDvURE1yMNhC
 zdRhcZS4DEhQFixh1u3r2caUbob44/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751273011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMUsOTKCB5zQ2rsCEUlx+JEGlyI3wvZv/oVceV5TcAw=;
 b=QxBlNZ+EXUpZI05ZZRdQ6H6GmTPx0JDWD+1s0Jqb47L+lYewvCo7prR+pUvG5tGNpoj7gy
 HoDBtHMAtt/wVFBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751273010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMUsOTKCB5zQ2rsCEUlx+JEGlyI3wvZv/oVceV5TcAw=;
 b=HaViosMVRb1F37qswZ3NgRj6T7K7lE/lfuO65pY4N0TL8WMVP+O9QG53bNycMx7Tp4QQod
 TTI4VBOPTNk8ONKx9T+NSn50abVrwipj7LeqHGcwNHDz10QJcNUbwewdRok2Xdm4f3PKy9
 a+YpvcdXHWbsMBeXLLI0wTqo0B8Hn+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751273010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMUsOTKCB5zQ2rsCEUlx+JEGlyI3wvZv/oVceV5TcAw=;
 b=k2iD5OCqU+imu0RZlnbQh06Tw2Nr7lEnxMxyFVjrQRBhP1gGXzVeDa/6omMony2c4ww9Gq
 NKHpCULdg5SHk/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFD0F1399F;
 Mon, 30 Jun 2025 08:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0JvLLjJOYmgWAgAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 08:43:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 6193BA08D2; Mon, 30 Jun 2025 10:43:30 +0200 (CEST)
Date: Mon, 30 Jun 2025 10:43:30 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <s2aegvbcdocjtusdvm2nq5n5cmjv7odkhljx3mvfxvk2nmegw7@6jgpfhnzhjj6>
References: <20250628113334.228198-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250628113334.228198-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Fix regression on kernels < v6.8
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat 28-06-25 13:33:34, Amir Goldstein wrote:
> There was a test regression in case the TMPDIR has a zero fsid.
> 
> Kernels < v6.8 do not allow setting inodes marks on such fs, while
> kernels >= v6.8 do allow to set inode marks but on on a single fs.
> 
> Adjust the test expectation in those two different cases.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/ltp/CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com/
> Fixes: db197b7b5 ("fanotify01: fix test failure when running with nfs TMPDIR")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks for fixing this up. The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Petr,
> 
> I reproduced this but with TMPDIR set to ntfs-3g mount path,
> which has zero fsid link nfs.
> 
> Tested that fix works on new (upstream) and old v6.6 kernels.
> 
> Thanks,
> Amir.
> 
>  testcases/kernel/syscalls/fanotify/fanotify01.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index f514dc1df..df50d84a1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -75,6 +75,7 @@ static char fname[BUF_SIZE];
>  static char buf[BUF_SIZE];
>  static int fd_notify;
>  static int fan_report_fid_unsupported;
> +static int tmpfs_report_fid_unsupported;
>  static int mount_mark_fid_unsupported;
>  static int inode_mark_fid_xdev;
>  static int filesystem_mark_unsupported;
> @@ -335,9 +336,11 @@ pass:
>  	 * When tested fs has zero fsid (e.g. fuse) and events are reported
>  	 * with fsid+fid, watching different filesystems is not supported.
>  	 */
> -	ret = report_fid ? inode_mark_fid_xdev : 0;
> -	TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
> -					 AT_FDCWD, "."), ret);
> +	if (!tmpfs_report_fid_unsupported) {
> +		ret = report_fid ? inode_mark_fid_xdev : 0;
> +		TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
> +						 AT_FDCWD, "."), ret);
> +	}
>  
>  	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
>  	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
> @@ -373,8 +376,11 @@ static void setup(void)
>  		inode_mark_fid_xdev = EXDEV;
>  	}
>  
> -	if (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".")) {
> -		inode_mark_fid_xdev = (errno == ENODEV) ? EXDEV : errno;
> +	tmpfs_report_fid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FID, ".");
> +	if (!tmpfs_report_fid_unsupported &&
> +	    fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".") &&
> +	    (errno == ENODEV || errno == EXDEV)) {
> +		inode_mark_fid_xdev = EXDEV;
>  		tst_res(TINFO | TERRNO, "TMPDIR does not support reporting events with fid from multi fs");
>  	}
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
