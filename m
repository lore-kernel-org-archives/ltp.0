Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C623C3DA41
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDF533D3944
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:18:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FCC13D0681
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:18:36 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A4BF660086D
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:18:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3B9621BAF;
 Tue,  9 Jul 2024 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720520314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8XQ3t22j/xZ1atTsFTHpeq7Y/qeGpSH0ohvd6S1EHU=;
 b=glnQMkb3VdAeW3/xyABARkkO2WkOcCNujEmU0b3i33s0MO+tvSbzmpsqb5yGNbfxXE4hGq
 88qlme2uK/XE5bL7HqdZPxRuhGokZnNBu/UbY3hAKTwChU1lWcKnWyKuSFJOynkZUNcIrM
 3b7qaSoM8Y6IM8IzLzzZhFyb7xfebGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720520314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8XQ3t22j/xZ1atTsFTHpeq7Y/qeGpSH0ohvd6S1EHU=;
 b=+JpukOZ2WhbQdtDfnkpwjaTw0L6OtkSjkgx9YmEYFTTr60d3w4JowamBT/Fxs5/LB1wK8B
 jDFbU7Y/BzG83tDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0CKNmGSL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7OtM21UI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720520313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8XQ3t22j/xZ1atTsFTHpeq7Y/qeGpSH0ohvd6S1EHU=;
 b=0CKNmGSLlhmoqzH2lqTqsYhMkG4i9/o7NK7Sk1f+Kl2ATO2BPdhfg4mAucyfAtRdMrd8EV
 BG60eZLhmksB5tYNJrUI5EodwdkSjBS1LSYwl6z2QEDMNdAkjteJ53shvGxujMkLf11qzO
 CFQqD8PkfnCNtnlmvnXJ9X4Ozw0BD54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720520313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8XQ3t22j/xZ1atTsFTHpeq7Y/qeGpSH0ohvd6S1EHU=;
 b=7OtM21UIv9ZyYzPo62kTPcEoaeM5hZVL0E3WKdBQc13jQBWsuDJZKcjfyKRLcjmGmPxBZ2
 yHR28UCZsGQkI1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B42541369A;
 Tue,  9 Jul 2024 10:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VfEJK3kOjWZ9SwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jul 2024 10:18:33 +0000
Date: Tue, 9 Jul 2024 12:18:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zo0OcFwaCQC0E91b@yuki>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
 <20240516-listmount_statmount-v3-5-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516-listmount_statmount-v3-5-2ff4ba29bba7@suse.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C3B9621BAF
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 05/11] Add listmount02 test
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
> This test verifies that listmount() is properly reading groups of
> mount IDs.
> ---
>  runtest/syscalls                                  |   1 +
>  testcases/kernel/syscalls/listmount/.gitignore    |   1 +
>  testcases/kernel/syscalls/listmount/listmount02.c | 106 ++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bce04c0cf..8831c0aec 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -707,6 +707,7 @@ linkat02 linkat02
>  listen01 listen01
>  
>  listmount01 listmount01
> +listmount02 listmount02
>  
>  listxattr01 listxattr01
>  listxattr02 listxattr02
> diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
> index 5257b298c..30bbf9f02 100644
> --- a/testcases/kernel/syscalls/listmount/.gitignore
> +++ b/testcases/kernel/syscalls/listmount/.gitignore
> @@ -1 +1,2 @@
>  listmount01
> +listmount02
> diff --git a/testcases/kernel/syscalls/listmount/listmount02.c b/testcases/kernel/syscalls/listmount/listmount02.c
> new file mode 100644
> index 000000000..cd742bd64
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listmount/listmount02.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that listmount() is properly reading groups of mount IDs.

This description could be way better. The code below tests that both the
oneshoot and the iterator API for listmount() return the same array.
I.e. by passing non-zero as the second argument of the listmount() you
ask only for the ids that are listed only after that id.

> + * [Algorithm]
> + *
> + * * move into a new unshared namespace
> + * * mount() our new root inside temporary folder
> + * * generate a full mounts tree inside root folder
> + * * read the full list of mounted IDs using listmount(LSMT_ROOT, ..)
> + * * read the list of mounted IDs using groups of fixed size
> + * * compare the first mount list with the second mount list

Here as well, dashes please.

> + */
> +
> +#include "listmount.h"
> +#include "lapi/sched.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define BIND_MOUNTS 7
> +#define GROUPS_SIZE 3
> +#define LISTSIZE (1 << BIND_MOUNTS)

So each bind mount doubles the number of mounted filesystems? I suppose
that we copy the whole hierarchy below the current mount point. I guess
that this should be explained in the Algorithm section.

> +static void run(void)
> +{
> +	ssize_t ret;
> +	size_t id, tot_ids, count = 0;
> +	uint64_t mount_ids[LISTSIZE];
> +	uint64_t list[LISTSIZE];
> +
> +	for (int i = 0; i < BIND_MOUNTS; i++)
> +		SAFE_MOUNT("/", "/", NULL, MS_BIND, NULL);
> +
> +	tst_res(TINFO, "Reading all %d mount IDs in once", LISTSIZE);
> +
> +	TST_EXP_POSITIVE(listmount(LSMT_ROOT, 0, mount_ids, LISTSIZE, 0));
> +	if (TST_RET == -1)
> +		goto end;
> +
> +	tot_ids = (size_t)TST_RET;
> +
> +	if (tot_ids != LISTSIZE) {
> +		tst_res(TFAIL, "listmount() returned %lu but %d was expected",
> +			tot_ids, LISTSIZE);
> +		goto end;
> +	}
> +
> +	tst_res(TINFO, "Reading groups of %d mount IDs", GROUPS_SIZE);
> +
> +	while (count < LISTSIZE) {
> +		id = count ? list[count - 1] : 0;
> +		ret = listmount(LSMT_ROOT, id, list + count, GROUPS_SIZE, 0);
> +
> +		tst_res(TDEBUG, "listmount(LSMT_ROOT, %lu, list + %lu, %d, 0)",
> +			id, count, GROUPS_SIZE);
> +
> +		if (ret == -1) {
> +			tst_res(TFAIL, "listmount() failed with %s", tst_strerrno(errno));
> +			goto end;
> +		}
> +
> +		count += ret;
> +
> +		if (TST_RET < GROUPS_SIZE)
> +			break;
> +	}
> +
> +	for (size_t i = 0; i < LISTSIZE; i++) {
> +		if (mount_ids[i] != list[i]) {
> +			tst_res(TFAIL, "Mount ID differs at %ld index", i);
> +			goto end;
> +		}
> +	}
> +
> +	tst_res(TPASS, "All mount IDs have been correctly read");
> +
> +end:
> +	SAFE_UMOUNT("/");

Hmm, shouldn't we umount BIND_MOUNT times here?

I suppose that if we fail to umount everything that we did mount
previously, the test will fail quite soon with just a few (-i)
iterations, since the amount of mounts doubles with each bind mount.

> +}
> +
> +static void setup(void)
> +{
> +	SAFE_UNSHARE(CLONE_NEWNS);
> +	SAFE_CHROOT(MNTPOINT);
> +
> +	SAFE_MOUNT("", "/", NULL, MS_REC | MS_SHARED, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.min_kver = "6.8",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,

Again I do not think that it makes much sense to run this for all
filesystems here.

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
