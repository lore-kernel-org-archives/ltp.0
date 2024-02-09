Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066D0C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 22:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C9E43CF4ED
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 23:41:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 643CD3CC33D
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 23:41:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 946241A0090A
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 23:41:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EF9D1FD36;
 Fri,  9 Feb 2024 22:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707518478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp/eS23GLpC4iTc3A+7wSbhGE4MaPqmZE6UJZCWfVMg=;
 b=q2uFVliItWA2BdcStcZA+xqLKAZrWhSbEKTsgl4sUDj6xqAWMsrC+jd/yKl0j2yKjwcOdl
 cb8nwJ6sWREX+orY2IF6/IwUBvfbjXCaK1AZyKOPcJeD584D3Lb7jRrDYWUMA1vW+SqsUc
 GgDKPhbqK5Dg+QB7WBDm4QdCk0nv31w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707518478;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp/eS23GLpC4iTc3A+7wSbhGE4MaPqmZE6UJZCWfVMg=;
 b=waStCNl5ufDfT5/2ukMHH5ZFDeuqn40FxA8tFSEvs5qby3kWPsajTCvtW0sexc9hriv/0w
 YVFT3S1IW6Qh19Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707518477;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp/eS23GLpC4iTc3A+7wSbhGE4MaPqmZE6UJZCWfVMg=;
 b=IJeBkrqrGVi6lFn1cWA9QzOVzzQqbTxt3Y+RIbpxzF6w0eNBtWGv11pOZjm+Ke9RP4/Oyv
 5lBBDkSdfm0F3YZ1yvz8Nv8P0K0eiPKwkBb9UOqEGfq0V6PvUtsLmVxOPpwaLRKlRExc5/
 kK46WvwG991V59jCUajiJTH72S8B3Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707518477;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp/eS23GLpC4iTc3A+7wSbhGE4MaPqmZE6UJZCWfVMg=;
 b=PZhTV0Y8hGuzaxigLCk/V9PoztAu9Fpdt2WXjpQzi6NGhqjJwTZkvpVSRfCgEBJBpSD9pz
 ZUCC7KVx5tPelEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF3413353;
 Fri,  9 Feb 2024 22:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ayDoGQyqxmX7dwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 22:41:16 +0000
Date: Fri, 9 Feb 2024 23:41:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240209224114.GA371480@pevik>
References: <20240207152155.10146-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240207152155.10146-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add mkdir10 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

I was thinking if this is filesystem specific (struct inode_operations mkdir
member is in fs/*/*.c - all filesystems), but it looks to me that code which
checks for EEXIST is in may_create() in fs/namei.c, which is VFS. Therefore
there is really no point to use .all_filesystems = 1.

LGTM, just few nits below.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test has been extracted from symlink01 and it verifies that
> mkdir() can't overwrite certain types of files, such as simlinks,
                                                        ^ symlinks

> directories, pipes, devices, etc.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                           |  2 +-
>  testcases/kernel/syscalls/mkdir/.gitignore |  1 +
>  testcases/kernel/syscalls/mkdir/mkdir10.c  | 57 ++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/mkdir/mkdir10.c

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2af7ade9c..7f4edb901 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -757,8 +757,8 @@ mkdir02 mkdir02
>  mkdir03 mkdir03
>  mkdir04 mkdir04
>  mkdir05 mkdir05
> -mkdir05A symlink01 -T mkdir05
This is not the case, but beware runtest/smoketest also use some of symlink
tests you recently rewrite.

>  mkdir09 mkdir09
> +mkdir10 mkdir10
...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mkdir/mkdir10.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
very nit:
Authors: David Fenner, Jon Hendrickson

> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that mkdir() can't overwrite certain generated files, such
> + * as symlinks, pipes, devices, folders, etc.
> + */
> +
> +#include "tst_test.h"
> +
> +#define FILE_FOLDER "myfolder"
> +#define FILE_MYFILE "myfile"
> +#define FILE_FIFO "mypipe"
> +#define FILE_SYMLINK "mylink"
> +#define FILE_DEVICE "/dev/null"
nit: _PATH_DEVNULL from <paths.h> defines "/dev/null".
> +
> +struct tcase {
> +	char *file;
> +	char *msg;
> +};
> +
> +static struct tcase tcases[] = {
> +	{FILE_FOLDER,	"folder already exists"},
> +	{FILE_MYFILE,	"file already exists"},
> +	{FILE_FIFO,		"fifo already exists"},
> +	{FILE_SYMLINK,	"symlink already exists"},
> +	{FILE_DEVICE,	"device already exists"},
very nit: "folder", "file", ...

	TST_EXP_FAIL(mkdir(tc->file, 0777), EEXIST, "%s already exists", tc->msg);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
