Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0104EC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 932CD3CECA2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:16:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B333C5D1E
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:16:29 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73BEF200A1F
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:16:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81B141FD65;
 Wed, 24 Jan 2024 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706105787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsKUzrA5JYhkn5aLdAgFaJJBd1gW/6h4GwaFctQcCI=;
 b=Z+mvgIhpuFLCnQRJR6Hglqs1NiVlWVvuLKZXGmcZ7vdHh84YpL/hFlfhJPhg4TETFvT1U6
 9ECrGyllpTuxFW7enwpUnYXKtLuBgOAOwtlMmyFzGxWH9daxbM/fSryCuy8ZaV0xQ3ijbr
 oSPWn86/WIAaFzqi9vh5ZQOTlP0KmfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706105787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsKUzrA5JYhkn5aLdAgFaJJBd1gW/6h4GwaFctQcCI=;
 b=iQWtaKyUIIbhDo6TxCyhwxhg2xOlwe8xUEWwQcEkE2qhTYxQHjeyCuLmUF0cTfKNHyNd6s
 +RY5ivE2ljZZw7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706105787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsKUzrA5JYhkn5aLdAgFaJJBd1gW/6h4GwaFctQcCI=;
 b=Z+mvgIhpuFLCnQRJR6Hglqs1NiVlWVvuLKZXGmcZ7vdHh84YpL/hFlfhJPhg4TETFvT1U6
 9ECrGyllpTuxFW7enwpUnYXKtLuBgOAOwtlMmyFzGxWH9daxbM/fSryCuy8ZaV0xQ3ijbr
 oSPWn86/WIAaFzqi9vh5ZQOTlP0KmfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706105787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsKUzrA5JYhkn5aLdAgFaJJBd1gW/6h4GwaFctQcCI=;
 b=iQWtaKyUIIbhDo6TxCyhwxhg2xOlwe8xUEWwQcEkE2qhTYxQHjeyCuLmUF0cTfKNHyNd6s
 +RY5ivE2ljZZw7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B591333E;
 Wed, 24 Jan 2024 14:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z7MSBbsbsWWhVgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 14:16:27 +0000
Date: Wed, 24 Jan 2024 15:16:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240124141625.GC299755@pevik>
References: <20240124125813.6611-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124125813.6611-1-chrubis@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[17.69%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Avoid tst_brk(TCONF,
 ...) on older distros
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> All the lapi/ functions does call tst_syscall() that does
> tst_brk(TCONF, ...) on ENOSYS which exits the testrun prematurely on older
> distributions.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  lib/tst_fd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/lib/tst_fd.c b/lib/tst_fd.c
> index ea84e1c85..ab7de81aa 100644
> --- a/lib/tst_fd.c
> +++ b/lib/tst_fd.c
> @@ -139,7 +139,7 @@ static void open_timerfd(struct tst_fd *fd)

>  static void open_pidfd(struct tst_fd *fd)
>  {
> -	fd->fd = pidfd_open(getpid(), 0);
> +	fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
Actually at least here tst_syscall() needs to be called or it fails on older
distros due missing ENOSYS check in raw syscall():

tst_fd.c:144: TBROK: pidfd_open(): ENOSYS (38)

Other syscall() are probably skipped due tst_brk(), but I would replace them
anyway.

Also, I wonder if we can avoid tst_brk() because it quits the test.

Kind regards,
Petr

>  	if (fd->fd < 0)
>  		tst_brk(TBROK | TERRNO, "pidfd_open()");
>  }
> @@ -194,7 +194,7 @@ static void open_io_uring(struct tst_fd *fd)
>  {
>  	struct io_uring_params uring_params = {};

> -	fd->fd = io_uring_setup(1, &uring_params);
> +	fd->fd = syscall(__NR_io_uring_setup, 1, &uring_params);
>  	if (fd->fd < 0) {
>  		tst_res(TCONF | TERRNO,
>  			"Skipping %s", tst_fd_desc(fd));
> @@ -210,7 +210,7 @@ static void open_bpf_map(struct tst_fd *fd)
>  		.max_entries = 1,
>  	};

> -	fd->fd = bpf(BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
> +	fd->fd = syscall(__NR_bpf, BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
>  	if (fd->fd < 0) {
>  		tst_res(TCONF | TERRNO,
>  			"Skipping %s", tst_fd_desc(fd));
> @@ -219,7 +219,7 @@ static void open_bpf_map(struct tst_fd *fd)

>  static void open_fsopen(struct tst_fd *fd)
>  {
> -	fd->fd = fsopen("ext2", 0);
> +	fd->fd = syscall(__NR_fsopen, "ext2", 0);
>  	if (fd->fd < 0) {
>  		tst_res(TCONF | TERRNO,
>  			"Skipping %s", tst_fd_desc(fd));
> @@ -228,7 +228,7 @@ static void open_fsopen(struct tst_fd *fd)

>  static void open_fspick(struct tst_fd *fd)
>  {
> -	fd->fd = fspick(AT_FDCWD, "/", 0);
> +	fd->fd = syscall(__NR_fspick, AT_FDCWD, "/", 0);
>  	if (fd->fd < 0) {
>  		tst_res(TCONF | TERRNO,
>  			"Skipping %s", tst_fd_desc(fd));
> @@ -237,7 +237,7 @@ static void open_fspick(struct tst_fd *fd)

>  static void open_open_tree(struct tst_fd *fd)
>  {
> -	fd->fd = open_tree(AT_FDCWD, "/", 0);
> +	fd->fd = syscall(__NR_open_tree, AT_FDCWD, "/", 0);
>  	if (fd->fd < 0) {
>  		tst_res(TCONF | TERRNO,
>  			"Skipping %s", tst_fd_desc(fd));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
