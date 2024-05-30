Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EBCC25B74
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 10:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78EB23D0734
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 12:53:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16D903D067C
 for <ltp@lists.linux.it>; Thu, 30 May 2024 12:52:44 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D93B11A0BC5B
 for <ltp@lists.linux.it>; Thu, 30 May 2024 12:52:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 757FA20786;
 Thu, 30 May 2024 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717066362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5j7Rs9O1gx1OcRX5/3bc7UjXBbZijyRRwWpqFp0cWKA=;
 b=DHjXfwmoOW4p6QdP8nwkHz9lzIUH6lf59jqKSoP599nhk1JmXyPtJoLq3KMrrxTgSlOTRV
 HxDGPnbQf1kPq5qlYc07MyMK34fk//7Yyd/1kJ4S/T0DA+zmxSkrM/5Yb83/xiCjymarcq
 07h4EGLhH6pxgzHEJN+ABdYVnZ4VMWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717066362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5j7Rs9O1gx1OcRX5/3bc7UjXBbZijyRRwWpqFp0cWKA=;
 b=nJMg5KJIkyivbSMXfGjXSSceihnQ/a0LfUn35NIWAMckH3XJa6vVZ4TTCYQkFvyX1wwGrt
 yZiHkPoHzZ6d4wBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DHjXfwmo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nJMg5KJI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717066362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5j7Rs9O1gx1OcRX5/3bc7UjXBbZijyRRwWpqFp0cWKA=;
 b=DHjXfwmoOW4p6QdP8nwkHz9lzIUH6lf59jqKSoP599nhk1JmXyPtJoLq3KMrrxTgSlOTRV
 HxDGPnbQf1kPq5qlYc07MyMK34fk//7Yyd/1kJ4S/T0DA+zmxSkrM/5Yb83/xiCjymarcq
 07h4EGLhH6pxgzHEJN+ABdYVnZ4VMWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717066362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5j7Rs9O1gx1OcRX5/3bc7UjXBbZijyRRwWpqFp0cWKA=;
 b=nJMg5KJIkyivbSMXfGjXSSceihnQ/a0LfUn35NIWAMckH3XJa6vVZ4TTCYQkFvyX1wwGrt
 yZiHkPoHzZ6d4wBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61CDD13A42;
 Thu, 30 May 2024 10:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B8QlF3paWGZKMQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 30 May 2024 10:52:42 +0000
Date: Thu, 30 May 2024 12:52:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZlhacuOD8hYVLYS6@yuki>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 757FA20786
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add ioctl_ficlone03 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  inotify_init1_01 inotify_init1_01
>  inotify_init1_02 inotify_init1_02
> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
> index 3d25fdfb2..d0b470714 100644
> --- a/testcases/kernel/syscalls/ioctl/.gitignore
> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
> @@ -24,3 +24,4 @@
>  /ioctl_sg01
>  /ioctl_ficlone01
>  /ioctl_ficlone02
> +/ioctl_ficlone03
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> new file mode 100644
> index 000000000..c6f9806a3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that ioctl() FICLONE feature correctly raises exceptions
> + * when it's supposed to.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +
> +#define MNTPOINT "mnt"
> +
> +static int invalid_fd = -1;
> +static int rw_file = -1;
> +static int ro_file = -1;
> +static int wo_file = -1;
> +static int dir_fd = -1;
> +static int immut_fd = -1;
> +static int mnt_file = -1;
> +
> +static struct tcase {
> +	int *src_fd;
> +	int *dst_fd;
> +	int errno_exp;
> +	char *msg;
> +} tcases[] = {
> +	{&invalid_fd, &rw_file, EBADF, "invalid source"},
> +	{&rw_file, &invalid_fd, EBADF, "invalid destination"},

Can we move these invalid_fd tests into a separate test and use tst_fd
to loop over all kinds of invalid input and output file descriptors?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
