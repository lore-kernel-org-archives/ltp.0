Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC73BCF6D28
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 14:06:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BEEF3C5AB3
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 16:06:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3ED53C4C41
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 16:06:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3DABD2009FC
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 16:06:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E35A21C58;
 Wed,  2 Oct 2024 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727877982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFcDzNb3OIsyUeEI7N944TWDTLk1SS9K3nFzNSGbP14=;
 b=IV6OQe5cClnVv9ehcLVfQSO9SBZI0wYLP1QvMBjHGCxDxW0xynn78SJtMEEFEcOY161DOw
 Qm8CpYeFHmwtRBhEe0CqtdYoG4YP418PS4zqs3uHHp5MRzYj2w5Mcf2HumTgL7MsERZW+g
 WPYgavVXN0H9u9e1dkZjYam7r3dUuRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727877982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFcDzNb3OIsyUeEI7N944TWDTLk1SS9K3nFzNSGbP14=;
 b=BMazIsGbCsolGULnofIypNSLLTOm4Lxco9B3bI8hzwq2ZmeIaU2c+yCDgNvXBSNn4ZGjs5
 oWSLzc6UI2pZgfCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IV6OQe5c;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BMazIsGb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727877982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFcDzNb3OIsyUeEI7N944TWDTLk1SS9K3nFzNSGbP14=;
 b=IV6OQe5cClnVv9ehcLVfQSO9SBZI0wYLP1QvMBjHGCxDxW0xynn78SJtMEEFEcOY161DOw
 Qm8CpYeFHmwtRBhEe0CqtdYoG4YP418PS4zqs3uHHp5MRzYj2w5Mcf2HumTgL7MsERZW+g
 WPYgavVXN0H9u9e1dkZjYam7r3dUuRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727877982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFcDzNb3OIsyUeEI7N944TWDTLk1SS9K3nFzNSGbP14=;
 b=BMazIsGbCsolGULnofIypNSLLTOm4Lxco9B3bI8hzwq2ZmeIaU2c+yCDgNvXBSNn4ZGjs5
 oWSLzc6UI2pZgfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CE7313974;
 Wed,  2 Oct 2024 14:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OvcDV5T/WZdKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 02 Oct 2024 14:06:22 +0000
Date: Wed, 2 Oct 2024 16:05:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv1TGNKz_c2txqLx@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-4-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-4-39558204ddf0@suse.com>
X-Rspamd-Queue-Id: 4E35A21C58
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 04/13] Add listmount01 test
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
> This test verifies that listmount() is properly recognizing a mounted
> root directory using LSMT_ROOT flag.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                  |  2 +
>  testcases/kernel/syscalls/listmount/.gitignore    |  1 +
>  testcases/kernel/syscalls/listmount/Makefile      |  7 +++
>  testcases/kernel/syscalls/listmount/listmount.h   | 26 ++++++++++
>  testcases/kernel/syscalls/listmount/listmount01.c | 63 +++++++++++++++++++++++
>  5 files changed, 99 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a9fc8c432..48db6259b 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -730,6 +730,8 @@ linkat02 linkat02
>  
>  listen01 listen01
>  
> +listmount01 listmount01
> +
>  listxattr01 listxattr01
>  listxattr02 listxattr02
>  listxattr03 listxattr03
> diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
> new file mode 100644
> index 000000000..5257b298c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listmount/.gitignore
> @@ -0,0 +1 @@
> +listmount01
> diff --git a/testcases/kernel/syscalls/listmount/Makefile b/testcases/kernel/syscalls/listmount/Makefile
> new file mode 100644
> index 000000000..8cf1b9024
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listmount/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/listmount/listmount.h b/testcases/kernel/syscalls/listmount/listmount.h
> new file mode 100644
> index 000000000..93766cd33
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listmount/listmount.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef LISTMOUNT_H
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "lapi/mount.h"
> +#include "lapi/syscalls.h"
> +
> +static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
> +			 uint64_t list[], size_t num, unsigned int flags)
> +{
> +	struct mnt_id_req req = {
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.mnt_id = mnt_id,
> +		.param = last_mnt_id,
> +	};
> +
> +	return tst_syscall(__NR_listmount, &req, list, num, flags);
> +}
> +
> +#endif
> diff --git a/testcases/kernel/syscalls/listmount/listmount01.c b/testcases/kernel/syscalls/listmount/listmount01.c
> new file mode 100644
> index 000000000..ab74b776b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listmount/listmount01.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that listmount() is properly recognizing a mounted
> + * root directory using LSMT_ROOT flag.
> + *
> + * [Algorithm]
> + *
> + * - move into a new unshared namespace
> + * - mount() a root inside temporary folder and get its mount ID
> + * - get list of mounted IDs using listmount(LSMT_ROOT, ..)
> + * - verify that the root mount ID is the only mount ID present inside the list
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "listmount.h"
> +#include "lapi/stat.h"
> +#include "lapi/sched.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define LISTSIZE 32
> +
> +static uint64_t root_id;
> +
> +static void run(void)
> +{
> +	uint64_t list[LISTSIZE];
> +
> +	TST_EXP_POSITIVE(listmount(LSMT_ROOT, 0, list, LISTSIZE, 0));
> +	if (TST_RET == -1)
> +		return;

This is purely cosmetic but this should be if (!TST_PASS).


The rest looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
