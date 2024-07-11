Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300A0C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 12:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9F783CF472
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 14:13:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 943C23CF46B
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 14:12:55 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A056F20D19D
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 14:12:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5BA21A80;
 Thu, 11 Jul 2024 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720699973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrBvlzmIOoMCkqMUsdcS8liQCvk8L9ts2XQHBwuHom0=;
 b=qfBfmPlR628eaauyllOyItp+t2mYz/86FmzOrnazhlrA8+B1oD+mgYBM3GMtNva3eH2lw7
 rVVVa4B13Hw5fg6TRV4K2T5YV71+NtPWQy5YxRNp7Z1DQHHGBflMUxem+eZ8AtxY5cXm/E
 RHB006opNIUtZjxovNuGPMb/cqSRFPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720699973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrBvlzmIOoMCkqMUsdcS8liQCvk8L9ts2XQHBwuHom0=;
 b=xDFlBN9RW2nT/nLDpK/NQ6Cpiqh7TqLKXv9SJSk/LiyXVdNbr3bF95Rfh4jnC5vi1daDqA
 hOT6qiCTZqq+HpAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qfBfmPlR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xDFlBN9R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720699973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrBvlzmIOoMCkqMUsdcS8liQCvk8L9ts2XQHBwuHom0=;
 b=qfBfmPlR628eaauyllOyItp+t2mYz/86FmzOrnazhlrA8+B1oD+mgYBM3GMtNva3eH2lw7
 rVVVa4B13Hw5fg6TRV4K2T5YV71+NtPWQy5YxRNp7Z1DQHHGBflMUxem+eZ8AtxY5cXm/E
 RHB006opNIUtZjxovNuGPMb/cqSRFPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720699973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrBvlzmIOoMCkqMUsdcS8liQCvk8L9ts2XQHBwuHom0=;
 b=xDFlBN9RW2nT/nLDpK/NQ6Cpiqh7TqLKXv9SJSk/LiyXVdNbr3bF95Rfh4jnC5vi1daDqA
 hOT6qiCTZqq+HpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CEC9136AF;
 Thu, 11 Jul 2024 12:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uW9NHUXMj2bCZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jul 2024 12:12:53 +0000
Date: Thu, 11 Jul 2024 14:12:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zo_MP7ymBzHmq511@yuki>
References: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
 <20240521-fchmodat2-v1-3-191b4a986202@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240521-fchmodat2-v1-3-191b4a986202@suse.com>
X-Rspamd-Queue-Id: 8C5BA21A80
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] Add fchmodat2_01 test
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
> diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2.h b/testcases/kernel/syscalls/fchmodat2/fchmodat2.h
> new file mode 100644
> index 000000000..676d491cf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef FCHMODAT2_H

Missing #define FCHMODAT2_H

> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "tst_safe_file_at.h"
> +
> +static inline int fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
> +{
> +	int ret;
> +
> +	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
> +			__func__, dfd, filename, mode, flags);
> +
> +	return ret;
> +}


This should probably go into lapi.

> +static inline void verify_mode(int dirfd, const char *path, mode_t mode)
> +{
> +	struct stat st;
> +
> +	SAFE_FSTATAT(dirfd, path, &st, AT_SYMLINK_NOFOLLOW);
> +	TST_EXP_EQ_LI(st.st_mode, mode);
> +}
> +
> +#endif
> diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> new file mode 100644
> index 000000000..9f4960a0c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that fchmodat2() syscall is properly working with
> + * AT_SYMLINK_NOFOLLOW on regular files.
> + */
> +
> +#include "fchmodat2.h"
> +#include "lapi/fcntl.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FNAME "myfile"
> +
> +static int fd_dir = -1;
> +
> +static void run(void)
> +{
> +	SAFE_CHMOD(MNTPOINT"/"FNAME, 0640);
> +
> +	TST_EXP_PASS(fchmodat2(fd_dir, FNAME, 0700, AT_SYMLINK_NOFOLLOW));
> +	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> +}
> +
> +static void setup(void)
> +{
> +	fd_dir = SAFE_OPEN(MNTPOINT, O_PATH | O_DIRECTORY, 0640);
> +
> +	SAFE_TOUCH(MNTPOINT"/"FNAME, 0640, NULL);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_dir != -1)
> +		SAFE_CLOSE(fd_dir);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "6.6",
> +	.mntpoint = MNTPOINT,
> +	.format_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},
> +};
> 
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
