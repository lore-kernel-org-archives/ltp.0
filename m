Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFA2C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 12:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17CB3CFAF9
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 13:23:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16FAF3CE1C3
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 13:23:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F3FD5601E90
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 13:23:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1819721ED1;
 Thu, 25 Jan 2024 12:23:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D628E13649;
 Thu, 25 Jan 2024 12:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MtBWMspSsmWzDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 12:23:38 +0000
Date: Thu, 25 Jan 2024 13:23:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240125122337.GA398849@pevik>
References: <20240125110510.751445-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240125110510.751445-1-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1819721ED1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> When tested fs has zero fsid (e.g. fuse) and events are reported
> with fsid+fid, watching different filesystems with the same group is
> not supported.

> Try to setup a bogus mark on test tmp dir, in addition to the mark
> on the tested filesystem, to check if marks on different filesystems
> are supported.

> Run on all filesystem to test both fs with zero fsid (e.g. fuse) and
> fs with valid fsid.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Hi Amir,

> Petr,

> The fanotify tests changes that you already picked from my github [1]
> have to do with fixing new test failures in v6.7 and v6.8-rc1, dues to
> the fact that each of those kernel versions added new filesystems that
> support fanotify events with fid+fsid.

> This is the only change to test new functionality in v6.8-rc1, namely,
> that for fs with zero fsid (e.g. fuse), an fanotify group can watch a
> single fs instance.

This patch would have to be rebased, to be applicable of the previous one (which
touches more tests) in your branch.

I also wonder what I did wrong, the branch works after reboot, tested on:
1) mainline kernel 6.8.0-rc1 in rapido-linux
2) openSUSE kernel 6.8.0-rc1-2.gf4ba5db-default
3) 6.7.0-9.gaedda80-default

> To fix the problem that you reported with this test on exfat [2],
> I needed to make a distiction between the fs that do not support mount
> mark with fid due to having zero fsid (e.g. fuse) and those fs that
> do not support decoding fid (e.g. exfat).

> It is not urgent to merge this change to the upcoming code freeze -
> it's up to you, but since I already tested it I am posting it now.

I'll probably merge it after LTP release.

Kind regards,
Petr

> Thanks,
> Amir.

> [1] https://github.com/amir73il/ltp/commits/fanotify_fsid/
> [2] https://lore.kernel.org/ltp/CAOQ4uxh1VwoMK_ssjdcxo_sk4cw0pD_FcXZ6Lb2=XHLf21kGAw@mail.gmail.com/T/#mf15d751e8f77a497ee4387b0791219e800cde7ea

>  testcases/kernel/syscalls/fanotify/fanotify.h |  6 +++++-
>  .../kernel/syscalls/fanotify/fanotify01.c     | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index e0d178bcc..554940a7e 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -166,20 +166,23 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
>  {
>  	int fd;
>  	int rval = 0;
> +	int err = 0;

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

>  	if (fname && fanotify_mark(fd, FAN_MARK_ADD | mark_flags, event_flags, AT_FDCWD, fname) < 0) {
> +		err = errno;
>  		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
>  			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
>  		} else if (errno != EINVAL) {
> @@ -194,6 +197,7 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,

>  	SAFE_CLOSE(fd);

> +	errno = err;
>  	return rval;
>  }

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

>  static unsigned long long event_set[EVENT_MAX];
> @@ -328,6 +329,17 @@ pass:

>  	}

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

>  static void cleanup(void)
> @@ -368,6 +386,7 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_PATH,
> +	.all_filesystems = 1,
>  };

>  #else

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
