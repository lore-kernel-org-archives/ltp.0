Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F1C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B8163D060A
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 12:45:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C2C83D00F8
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:44:50 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 976C91001570
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:44:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A4742199D;
 Fri, 26 Jan 2024 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706269488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4cIi/OA/e+ItBYe9yGksEnVZciMaQB7HNift7a6iSQ=;
 b=SmPNMzKp8dewnZhZ6xVvgQRcs2WOSzr2PbAygxJHOvZhPso51aSaU61CDnrLaUqruDvaxO
 Ha832aZadLGjqYTaZLNFXvjY1M54G/n6d+WeLq+mhWaO92ov2nlxjAdPzoFfHQASyyNjTr
 qpbckEKWTK9OJD3UEvAw9mwDyRyvf+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706269488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4cIi/OA/e+ItBYe9yGksEnVZciMaQB7HNift7a6iSQ=;
 b=XtBYNYh8FZDal7BTb8SpacN2prlDz58vkFBljb4AQdBQnAuB+SYxmygnCjvgzSNg5jKlxT
 AqFR4j8IrOk89oAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706269488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4cIi/OA/e+ItBYe9yGksEnVZciMaQB7HNift7a6iSQ=;
 b=SmPNMzKp8dewnZhZ6xVvgQRcs2WOSzr2PbAygxJHOvZhPso51aSaU61CDnrLaUqruDvaxO
 Ha832aZadLGjqYTaZLNFXvjY1M54G/n6d+WeLq+mhWaO92ov2nlxjAdPzoFfHQASyyNjTr
 qpbckEKWTK9OJD3UEvAw9mwDyRyvf+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706269488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4cIi/OA/e+ItBYe9yGksEnVZciMaQB7HNift7a6iSQ=;
 b=XtBYNYh8FZDal7BTb8SpacN2prlDz58vkFBljb4AQdBQnAuB+SYxmygnCjvgzSNg5jKlxT
 AqFR4j8IrOk89oAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A68E4134C3;
 Fri, 26 Jan 2024 11:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FNyhKC+bs2XcOwAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 26 Jan 2024 11:44:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 50B86A0805; Fri, 26 Jan 2024 12:44:43 +0100 (CET)
Date: Fri, 26 Jan 2024 12:44:43 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240126114443.gicuknh6kayfukdz@quack3>
References: <20240125110510.751445-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240125110510.751445-1-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SmPNMzKp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XtBYNYh8
X-Spamd-Result: default: False [-2.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5A4742199D
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

On Thu 25-01-24 13:05:10, Amir Goldstein wrote:
> When tested fs has zero fsid (e.g. fuse) and events are reported
> with fsid+fid, watching different filesystems with the same group is
> not supported.
> 
> Try to setup a bogus mark on test tmp dir, in addition to the mark
> on the tested filesystem, to check if marks on different filesystems
> are supported.
> 
> Run on all filesystem to test both fs with zero fsid (e.g. fuse) and
> fs with valid fsid.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The test looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Petr,
> 
> The fanotify tests changes that you already picked from my github [1]
> have to do with fixing new test failures in v6.7 and v6.8-rc1, dues to
> the fact that each of those kernel versions added new filesystems that
> support fanotify events with fid+fsid.
> 
> This is the only change to test new functionality in v6.8-rc1, namely,
> that for fs with zero fsid (e.g. fuse), an fanotify group can watch a
> single fs instance.
> 
> To fix the problem that you reported with this test on exfat [2],
> I needed to make a distiction between the fs that do not support mount
> mark with fid due to having zero fsid (e.g. fuse) and those fs that
> do not support decoding fid (e.g. exfat).
> 
> It is not urgent to merge this change to the upcoming code freeze -
> it's up to you, but since I already tested it I am posting it now.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/ltp/commits/fanotify_fsid/
> [2] https://lore.kernel.org/ltp/CAOQ4uxh1VwoMK_ssjdcxo_sk4cw0pD_FcXZ6Lb2=XHLf21kGAw@mail.gmail.com/T/#mf15d751e8f77a497ee4387b0791219e800cde7ea
> 
>  testcases/kernel/syscalls/fanotify/fanotify.h |  6 +++++-
>  .../kernel/syscalls/fanotify/fanotify01.c     | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index e0d178bcc..554940a7e 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -166,20 +166,23 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
>  {
>  	int fd;
>  	int rval = 0;
> +	int err = 0;
>  
>  	fd = fanotify_init(init_flags, O_RDONLY);
> -
>  	if (fd < 0) {
> +		err = errno;
>  		if (errno == ENOSYS)
>  			tst_brk(TCONF, "fanotify not configured in kernel");
>  		if (errno != EINVAL)
>  			tst_brk(TBROK | TERRNO,
>  				"fanotify_init(%x, O_RDONLY) failed",
>  				init_flags);
> +		errno = err;
>  		return -1;
>  	}
>  
>  	if (fname && fanotify_mark(fd, FAN_MARK_ADD | mark_flags, event_flags, AT_FDCWD, fname) < 0) {
> +		err = errno;
>  		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
>  			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
>  		} else if (errno != EINVAL) {
> @@ -194,6 +197,7 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
>  
>  	SAFE_CLOSE(fd);
>  
> +	errno = err;
>  	return rval;
>  }
>  
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index e4398f236..ba09f309d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -77,6 +77,7 @@ static char buf[BUF_SIZE];
>  static int fd_notify;
>  static int fan_report_fid_unsupported;
>  static int mount_mark_fid_unsupported;
> +static int inode_mark_fid_xdev;
>  static int filesystem_mark_unsupported;
>  
>  static unsigned long long event_set[EVENT_MAX];
> @@ -328,6 +329,17 @@ pass:
>  
>  	}
>  
> +
> +	/*
> +	 * Try to setup a bogus mark on test tmp dir, to check if marks on
> +	 * different filesystems are supported.
> +	 * When tested fs has zero fsid (e.g. fuse) and events are reported
> +	 * with fsid+fid, watching different filesystems is not supported.
> +	 */
> +	ret = report_fid ? inode_mark_fid_xdev : 0;
> +	TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
> +					 AT_FDCWD, "."), ret);
> +
>  	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
>  	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
>  			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> @@ -352,6 +364,12 @@ static void setup(void)
>  	mount_mark_fid_unsupported = fanotify_flags_supported_on_fs(FAN_REPORT_FID,
>  								    FAN_MARK_MOUNT,
>  								    FAN_OPEN, fname);
> +	/* When mount mark is not supported due to zero fsid, multi fs inode marks are not supported */
> +	if (mount_mark_fid_unsupported && errno == ENODEV) {
> +		tst_res(TINFO, "filesystem %s does not support reporting events with fid from multi fs",
> +				tst_device->fs_type);
> +		inode_mark_fid_xdev = EXDEV;
> +	}
>  }
>  
>  static void cleanup(void)
> @@ -368,6 +386,7 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_PATH,
> +	.all_filesystems = 1,
>  };
>  
>  #else
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
