Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C5ECCD183
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 14:44:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A70EE3CEBE1
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 16:44:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 239AA3CEBCA
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 16:44:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 64ECE1A00782
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 16:44:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7E691F393;
 Mon, 13 Oct 2025 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760366677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzquYih7uNBRgeT5yrBrWfhdgfB8Bjd97aOUWgjZ+Ik=;
 b=1kvafONHf5PGvIkFQ7OhkK9TAD7ZavtKjpn+QRTsVOD95OwqfNr3OWqIGOu+yEy8DaEsaw
 14PMT7X7dpMhATytNhebc0nty5yqwQrsR94zi/Lcg1dgKxcs/NACHGfLmbsPRxDw4DwzM8
 Mwe/fefMRVY136K6vdONJ84ig80EWWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760366677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzquYih7uNBRgeT5yrBrWfhdgfB8Bjd97aOUWgjZ+Ik=;
 b=z/hCrI8VOWWdV2nVzsbY9LU5ji93QtZ8Abh27TePyExKZq8qX9oP4e+JBSUanRwXv5di9F
 Aejf7+dwv2sFpRBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1kvafONH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z/hCrI8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760366677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzquYih7uNBRgeT5yrBrWfhdgfB8Bjd97aOUWgjZ+Ik=;
 b=1kvafONHf5PGvIkFQ7OhkK9TAD7ZavtKjpn+QRTsVOD95OwqfNr3OWqIGOu+yEy8DaEsaw
 14PMT7X7dpMhATytNhebc0nty5yqwQrsR94zi/Lcg1dgKxcs/NACHGfLmbsPRxDw4DwzM8
 Mwe/fefMRVY136K6vdONJ84ig80EWWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760366677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzquYih7uNBRgeT5yrBrWfhdgfB8Bjd97aOUWgjZ+Ik=;
 b=z/hCrI8VOWWdV2nVzsbY9LU5ji93QtZ8Abh27TePyExKZq8qX9oP4e+JBSUanRwXv5di9F
 Aejf7+dwv2sFpRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A788413874;
 Mon, 13 Oct 2025 14:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BmL9J1UQ7WhyKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 Oct 2025 14:44:37 +0000
Date: Mon, 13 Oct 2025 16:45:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aO0QiVqDqgxhU6rE@yuki.lan>
References: <20251010-file_attr_eopnotsupp-v1-1-a93df1980ac7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251010-file_attr_eopnotsupp-v1-1-a93df1980ac7@suse.com>
X-Rspamd-Queue-Id: B7E691F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: add file_attr05 test
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
> Verify that `file_getattr` and `file_setattr` are correctly raising
> EOPNOTSUPP when filesystem doesn't support them.
> 
> Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set]
> return -EOPNOTSUPP".
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                  |  1 +
>  testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
>  testcases/kernel/syscalls/file_attr/file_attr05.c | 64 +++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 4b284f279..b8a1988e1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -250,6 +250,7 @@ file_attr01 file_attr01
>  file_attr02 file_attr02
>  file_attr03 file_attr03
>  file_attr04 file_attr04
> +file_attr05 file_attr05
>  
>  #posix_fadvise test cases
>  posix_fadvise01                      posix_fadvise01
> diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
> index 3fcb9004d..42f830a7e 100644
> --- a/testcases/kernel/syscalls/file_attr/.gitignore
> +++ b/testcases/kernel/syscalls/file_attr/.gitignore
> @@ -2,3 +2,4 @@ file_attr01
>  file_attr02
>  file_attr03
>  file_attr04
> +file_attr05
> diff --git a/testcases/kernel/syscalls/file_attr/file_attr05.c b/testcases/kernel/syscalls/file_attr/file_attr05.c
> new file mode 100644
> index 000000000..127ca35ae
> --- /dev/null
> +++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that `file_getattr` and `file_setattr` are correctly raising
> + * EOPNOTSUPP when filesystem doesn't support them.
> + *
> + * Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set] return
> + * -EOPNOTSUPP".
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FILEPATH (MNTPOINT "/ltp_file")
> +#define BLOCKS 1024
> +#define PROJID 16
> +
> +static struct file_attr *attr_set;
> +static struct file_attr *attr_get;
> +
> +static void run(void)
> +{
> +	TST_EXP_FAIL(file_setattr(AT_FDCWD, FILEPATH,
> +			   attr_set, FILE_ATTR_SIZE_LATEST, 0), EOPNOTSUPP);
> +
> +	TST_EXP_FAIL(file_getattr(AT_FDCWD, FILEPATH,
> +			   attr_get, FILE_ATTR_SIZE_LATEST, 0), EOPNOTSUPP);
> +}
> +
> +static void setup(void)
> +{
> +	int block_size;
> +
> +	SAFE_TOUCH(FILEPATH, 0777, NULL);
> +
> +	block_size = tst_dev_block_size(MNTPOINT);

Isn't this wrong?

See:

commit f4af1fb44161d719695c3ce1bcad61d6f3638ba8
Author: Martin Doucha <mdoucha@suse.cz>
Date:   Tue Sep 23 17:32:24 2025 +0200

    file_attr02: Enable reflinks and fix blocksize detection

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
