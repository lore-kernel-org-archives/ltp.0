Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98A6CCD1AB
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 20:23:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37683CEFD9
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 22:23:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81C8B3CCEEA
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 22:22:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 29A4460090C
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 22:22:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B86D721171;
 Mon, 20 Oct 2025 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760991757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twDLx9ftYDhad3Rk631QJLx57yjQQ0j8cBdYATI3vhw=;
 b=Y5Hee1C1L+vUrZ5zS7U7mGbcZS+zoxrvKkNwKPfx8q6sJFo5j6ky4FlY7zJzTxBEhvLoMh
 Kg2dABKwZaOchPk3C/I6ulOA1Os3ZsV9WKZ6vUGFpsnoTx2FA4r8rJvpVMhXNIACe0lg75
 uZLmSV+JUVQS33wF6W0MQy6rbJKcG68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760991757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twDLx9ftYDhad3Rk631QJLx57yjQQ0j8cBdYATI3vhw=;
 b=8vSSigt3NEzKlTGGE0iCQquXqY7lWfb5U4qG4678i9dp9KX+4fXFSnJeV/oGswh7ZWaM28
 w2GE3LNMElWB5kCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mOf44Rmc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JTGbbqsZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760991753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twDLx9ftYDhad3Rk631QJLx57yjQQ0j8cBdYATI3vhw=;
 b=mOf44RmcqeXbek4KYi8STHX3KzueauerDcYKJoi/NyY/0ZjBmVpXc5V9h2hJXdFNVrNFA/
 Tq3aDbMHGshpXtBEn8WlYboSBVXtIWE75x/Z4gsgKdNw3naakwNRdMdAD0UhMGsQYTEX1v
 zSmBQNm2lmGgd5DmpIis37/xV5rC3OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760991753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twDLx9ftYDhad3Rk631QJLx57yjQQ0j8cBdYATI3vhw=;
 b=JTGbbqsZh86HH7FrJ8/TqYH68YFPLP2clELSRNlqk6EYaNQR6HABzEdjNeabO9jVnSXfIw
 ZZ78lvXASuHB5yDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A48213A8E;
 Mon, 20 Oct 2025 20:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qiFYHAma9mj/bAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Oct 2025 20:22:33 +0000
Date: Mon, 20 Oct 2025 22:22:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20251020202231.GA416401@pevik>
References: <20251017161639.2088158-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017161639.2088158-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: B86D721171
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify24: Verify expected count/offset info in
 pre content events
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
Cc: Kiryl Shutsemau <kas@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,

> To test fix commit 28bba2c2935e2 ("fsnotify: Pass correct offset to
> fsnotify_mmap_perm()"), diversify the offsets and count used for mmap()
> write() and read() and verify that the FAN_PRE_ACCESS events report the
> expected count/offset.

> For the FAN_PRE_ACCESS events generated by execve(), we cannot
> anticipate the exact ranges, so we set 0 count to skip this verification.

> Also add prints of path of the fd passed with the event (not verified
> against expected path).

> Make sure that we take the expected error value for an operation
> (e.g. read) from a matching event type (e.g. FAN_PRE_ACCESS).

Thanks for the update.  LGTM, but it'd be great if some of kernel developers
also had look into it. Few minor notes below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I also restarted failing jobs in github actions:
https://github.com/linux-test-project/ltp/actions/runs/18599812482

Unfortunately due patchwork API limitation, the failing jobs aren't replaced
with successful ones, instead the fixes are appended:
https://patchwork.ozlabs.org/project/ltp/patch/20251017161639.2088158-1-amir73il@gmail.com/

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify24.c     | 167 +++++++++++-------
>  1 file changed, 107 insertions(+), 60 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
> index 27f0663ce..8f2dee55b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify24.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
> @@ -9,6 +9,8 @@
>  /*\
>   * - Test fanotify pre-content events
>   * - Test respond to permission/pre-content events with cutsom error code
> + * - Test count/offset info bug that was fixed by commit
> + *   28bba2c2935e2 "fsnotify: Pass correct offset to fsnotify_mmap_perm()"
>   */

>  #define _GNU_SOURCE
> @@ -44,6 +46,8 @@
>  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP

>  static char fname[BUF_SIZE];
> +static char symlnk[BUF_SIZE];
> +static char fdpath[BUF_SIZE];
>  static char buf[BUF_SIZE];
>  static volatile int fd_notify;
>  static size_t page_sz;
> @@ -55,6 +59,8 @@ static char event_buf[EVENT_BUF_LEN];
>  struct event {
>  	unsigned long long mask;
>  	unsigned int response;
> +	unsigned long pgcount;
> +	unsigned long pgoff;
>  };

>  static struct tcase {
> @@ -68,11 +74,11 @@ static struct tcase {
>  		INIT_FANOTIFY_MARK_TYPE(INODE),
>  		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
> -			{FAN_OPEN_PERM, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
> -			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
> +			{FAN_OPEN_PERM, FAN_ALLOW,0 ,0},
nit: space is usually before comma, not after. I'll fix it before merge.
I also prefer to use designated initializers when there are more struct members
and some of them are zero. But it's up to you, or I can change it later in a
separate patch.

> +			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
> +			{FAN_PRE_ACCESS, FAN_ALLOW,0 ,0},
> +			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
> +			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}

...
> @@ -190,17 +196,19 @@ static void generate_events(struct tcase *tc)
>  	 */
>  	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);

> -	exp_errno = expected_errno(event->response);
> -	event++;
> -
> +	exp_errno = 0;
> +	if (event->mask & FAN_PRE_ACCESS) {
> +		exp_errno = expected_errno(event->response);
> +		event++;
> +	}
>  	exp_ret = exp_errno ? -1 : 1;
> -	errno = 0;
>  	/*
>  	 * FAN_PRE_ACCESS events are reported on map() and write(), but should
>  	 * not be reported when faulting in the user page at offset page_sz*100
>  	 * that is used as an input buffer to the write() syscall.
>  	 */
> -	addr = SAFE_MMAP(NULL, page_sz, PROT_READ, MAP_PRIVATE, fd, page_sz*100);
> +	errno = 0;
> +	addr = SAFE_MMAP(NULL, page_sz*2, PROT_READ, MAP_PRIVATE, fd, page_sz*100);
>  	if (!addr || errno != exp_errno) {
nit (unrelated to this change): I wonder if "!addr" is really needed (addr !=
MAP_FAILED in safe_mmap() should be enough, right?

>  		tst_res(TFAIL, "mmap() got errno %d (expected %d)", errno, exp_errno);
>  		exit(3);
> @@ -208,12 +216,14 @@ static void generate_events(struct tcase *tc)
>  		tst_res(TINFO, "mmap() got errno %d as expected", errno);
>  	}
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
