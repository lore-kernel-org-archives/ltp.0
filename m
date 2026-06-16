Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F743CD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:56:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D1B23E595D
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:56:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DB4F3E2238
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:55:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD91C200C76
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:55:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2AB6C845;
 Tue, 16 Jun 2026 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781596548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkVIo8mFAJvp0zGyix9R6s2ZnXpz6gkOgc/Gxv+JpIM=;
 b=uGbBNihlPUwk/rf3nblGJGxNtghr8VMHi4RjX5oCMBEs1Y8I2FuGgJDMc5mGRwHFW0Zds5
 rWeQFG6VobQHI8Ohsv98m1p5fbXdLFaD6iXBWGDDk5TRWVzp9OAnZbjzmm4d3p+rwt5UkV
 NNmAtIMabhTxAgp7+pE2w94dzFRJsNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781596548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkVIo8mFAJvp0zGyix9R6s2ZnXpz6gkOgc/Gxv+JpIM=;
 b=nqa0dhg9wbf/ouADcWpjEe8nqCjIdihmceGAapIxsV1nYQoJxLF88hPiEHbKX//AfcS4hl
 rsscHfTRiMzcDNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781596548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkVIo8mFAJvp0zGyix9R6s2ZnXpz6gkOgc/Gxv+JpIM=;
 b=uGbBNihlPUwk/rf3nblGJGxNtghr8VMHi4RjX5oCMBEs1Y8I2FuGgJDMc5mGRwHFW0Zds5
 rWeQFG6VobQHI8Ohsv98m1p5fbXdLFaD6iXBWGDDk5TRWVzp9OAnZbjzmm4d3p+rwt5UkV
 NNmAtIMabhTxAgp7+pE2w94dzFRJsNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781596548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkVIo8mFAJvp0zGyix9R6s2ZnXpz6gkOgc/Gxv+JpIM=;
 b=nqa0dhg9wbf/ouADcWpjEe8nqCjIdihmceGAapIxsV1nYQoJxLF88hPiEHbKX//AfcS4hl
 rsscHfTRiMzcDNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4911E779A8;
 Tue, 16 Jun 2026 07:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w4vWEYQBMWpFWgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 07:55:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id E079CA12D3; Tue, 16 Jun 2026 09:55:47 +0200 (CEST)
Date: Tue, 16 Jun 2026 09:55:47 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <6mmzrxshvigoncgtzpugeevhiup67a45eqjeq2daq42gejyknn@nkxqmcpmylrr>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-5-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615180629.7148-5-anonymemeow@gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] fanotify21: Add test variants for
 FAN_REPORT_TID
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

On Tue 16-06-26 02:06:28, AnonymeMeow wrote:
> Add test variants for FAN_REPORT_PIDFD combined with FAN_REPORT_TID,
> both with and without FAN_REPORT_FD_ERROR. Add PIDFD_THREAD fallback
> definition for old headers.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/lapi/pidfd.h                          |  4 ++
>  .../kernel/syscalls/fanotify/fanotify21.c     | 56 ++++++++++++++-----
>  2 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
> index a3205032c..eb4e3466d 100644
> --- a/include/lapi/pidfd.h
> +++ b/include/lapi/pidfd.h
> @@ -43,6 +43,10 @@ struct pidfd_info {
>  # define PIDFD_NONBLOCK O_NONBLOCK
>  #endif
>  
> +#ifndef PIDFD_THREAD
> +# define PIDFD_THREAD O_EXCL
> +#endif
> +
>  #ifndef PIDFS_IOCTL_MAGIC
>  # define PIDFS_IOCTL_MAGIC	0xFF
>  #endif
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index 22f9767db..fd43c8c1c 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -12,6 +12,7 @@
>   *
>   * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
>   * af579beb666a ("fanotify: add pidfd support to the fanotify API").
> + * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1.
>   */
>  
>  #define _GNU_SOURCE
> @@ -32,6 +33,9 @@
>  #define MOUNT_PATH	"fs_mnt"
>  #define TEST_FILE	MOUNT_PATH "/testfile"
>  
> +#define TST_VARIANT_FD_ERROR (tst_variant & 1)
> +#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)
> +
>  struct pidfd_fdinfo_t {
>  	int pos;
>  	int flags;
> @@ -67,6 +71,7 @@ static char event_buf[BUF_SZ];
>  static struct pidfd_fdinfo_t exp_pidfd_fdinfo;
>  
>  static int fd_error_unsupported;
> +static int thread_pidfd_unsupported;
>  
>  static struct tst_clone_args clone_args = {
>  	.flags = CLONE_NEWPID,
> @@ -90,21 +95,37 @@ static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
>  static void generate_event(void)
>  {
>  	int fd;
> +	int pidfd;
> +
> +	pidfd = TST_VARIANT_PIDFD_THREAD ? SAFE_PIDFD_OPEN(tst_gettid(), PIDFD_THREAD)
> +					 : SAFE_PIDFD_OPEN(tst_getpid(), 0);
> +	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
> +	SAFE_CLOSE(pidfd);
>  
>  	/* Generate a single FAN_OPEN event on the watched object. */
>  	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
>  	SAFE_CLOSE(fd);
>  }
>  
> +static const char *test_variant_name(void)
> +{
> +	switch (tst_variant) {
> +	case 0: return "";
> +	case 1: return "(FAN_REPORT_FD_ERROR)";
> +	case 2: return "(FAN_REPORT_TID)";
> +	case 3: return "(FAN_REPORT_FD_ERROR | FAN_REPORT_TID)";
> +	}
> +	return NULL;
> +}
> +
>  static void do_setup(void)
>  {
> -	int pidfd;
>  	int init_flags = FAN_REPORT_PIDFD;
>  
>  	/* Bind mount so remount ro/rw always work */
>  	SAFE_MOUNT(MOUNT_PATH, MOUNT_PATH, "none", MS_BIND, NULL);
>  
> -	if (tst_variant) {
> +	if (TST_VARIANT_FD_ERROR) {
>  		fanotify_fd = -1;
>  		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
>  		if (fd_error_unsupported)
> @@ -112,6 +133,15 @@ static void do_setup(void)
>  		init_flags |= FAN_REPORT_FD_ERROR;
>  	}
>  
> +	if (TST_VARIANT_PIDFD_THREAD) {
> +		fanotify_fd = -1;
> +		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
> +			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
> +		if (thread_pidfd_unsupported)
> +			return;
> +		init_flags |= FAN_REPORT_TID;
> +	}
> +
>  	SAFE_TOUCH(TEST_FILE, 0666, NULL);
>  
>  	/*
> @@ -125,12 +155,6 @@ static void do_setup(void)
>  	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
>  	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
>  			   TEST_FILE);
> -
> -	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
> -
> -	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
> -
> -	SAFE_CLOSE(pidfd);
>  }
>  
>  static void do_test(unsigned int num)
> @@ -138,19 +162,25 @@ static void do_test(unsigned int num)
>  	int i = 0, len;
>  	struct test_case_t *tc = &test_cases[num];
>  	int nopidfd_err = tc->want_pidfd_err ?
> -			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
> -	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
> +			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
> +	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
>  	pid_t reader_pid;
>  	int reader_exit_status;
>  
>  	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
> -			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
> +		       test_variant_name());
>  
> -	if (fd_error_unsupported && tst_variant) {
> +	if (fd_error_unsupported && TST_VARIANT_FD_ERROR) {
>  		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
>  		return;
>  	}
>  
> +	if (thread_pidfd_unsupported && TST_VARIANT_PIDFD_THREAD) {
> +		FANOTIFY_INIT_FLAGS_ERR_MSG(
> +			FAN_REPORT_PIDFD | FAN_REPORT_TID, thread_pidfd_unsupported);
> +		return;
> +	}
> +
>  	/* remount ro/rw the bind mount */
>  	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
>  		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
> @@ -333,7 +363,7 @@ static struct tst_test test = {
>  	.setup = do_setup,
>  	.test = do_test,
>  	.tcnt = ARRAY_SIZE(test_cases),
> -	.test_variants = 2,
> +	.test_variants = 4,
>  	.cleanup = do_cleanup,
>  	.all_filesystems = 1,
>  	.needs_root = 1,
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
