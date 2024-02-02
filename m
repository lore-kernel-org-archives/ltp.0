Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D59C4828F
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 16:17:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 665373CF86E
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 17:17:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 604603CD0EA
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 17:17:04 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A00D51001F20
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 17:17:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1C4622127;
 Fri,  2 Feb 2024 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706890622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N59LAkZ3xN2tgHltDiOP3zAUg1RZUemusoaZgTOGOvk=;
 b=lOx54VxCZCsJHQMVbca3mKgHIGBhVjHXGwTym4EraUe9JsSqLtrsyQVoQjjsDWl9k/zXzO
 VV+4/TOMz+oBKUOv7lR5YWD9hUvX+77PHVEP2gUrlkSXUCrZZK5jBGRuQn5DfrlyE42VKO
 K4ZqHd0M1ZP7c2h3FLlVbUlGBwIuu0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706890622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N59LAkZ3xN2tgHltDiOP3zAUg1RZUemusoaZgTOGOvk=;
 b=JOnZVOe/iIf3EQE2Q4fhVAQLxUhzW+J8tuYLEYXcw8pLBoX9fPioBm6n5GLBUndNMtP48f
 OptHFZUNxMe5p0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706890621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N59LAkZ3xN2tgHltDiOP3zAUg1RZUemusoaZgTOGOvk=;
 b=3XF0GD5lfwRpOl+s8Z8cWCoO+4usgaBrRLMVzPk/C43ZhDUoxM6R2vGHJ57o1Vbbt3nJ/I
 EJz4ZnOyCPycdiI7A5AXzD1CWV2L8fwIVbyGIIOPvMdzdCvf7dDZYOk7ls0NWmX94u3NlS
 nWkY6cMhut0lzXOMyKVAYaiURvnS/4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706890621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N59LAkZ3xN2tgHltDiOP3zAUg1RZUemusoaZgTOGOvk=;
 b=DqHqeEv5gUC+FES+NQ6OR46kSOlQTEt4x47qfojk13edyjNtzQ2zqnVH6Tb63wdoqNnP/r
 g4LSAjnLXlfIsbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1EFE13A58;
 Fri,  2 Feb 2024 16:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hr5KNn0VvWWFPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 02 Feb 2024 16:17:01 +0000
Date: Fri, 2 Feb 2024 17:17:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zb0ViyiktMshIdOR@yuki>
References: <20240118150742.10792-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240118150742.10792-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3XF0GD5l;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DqHqeEv5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[10.22%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: F1C4622127
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add readlink04 test
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

On Thu, Jan 18, 2024 at 04:07:42PM +0100, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This test has been extracted from symlink01 and it verifies that
> readlink() is working correctly on symlink() generated files.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                              |  2 +-
>  testcases/kernel/syscalls/readlink/.gitignore |  1 +
>  .../kernel/syscalls/readlink/readlink04.c     | 57 +++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/readlink/readlink04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6e2407879..339697533 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1125,9 +1125,9 @@ readahead02 readahead02
>  readdir01 readdir01
>  readdir21 readdir21
>  
> -readlink01A symlink01 -T readlink01
>  readlink01 readlink01
>  readlink03 readlink03
> +readlink04 readlink04
>  
>  #readlinkat test cases
>  readlinkat01 readlinkat01
> diff --git a/testcases/kernel/syscalls/readlink/.gitignore b/testcases/kernel/syscalls/readlink/.gitignore
> index 307817f4d..53e65eb5b 100644
> --- a/testcases/kernel/syscalls/readlink/.gitignore
> +++ b/testcases/kernel/syscalls/readlink/.gitignore
> @@ -1,2 +1,3 @@
>  /readlink01
>  /readlink03
> +/readlink04
> diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
> new file mode 100644
> index 000000000..8d7d038bb
> --- /dev/null
> +++ b/testcases/kernel/syscalls/readlink/readlink04.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that readlink() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include "tst_test.h"
> +
> +static void test_readlink(void)
> +{
> +	char *symname = "my_symlink0";
> +
> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
> +
> +	char path[PATH_MAX];
> +	struct stat path_link;
> +
> +	SAFE_READLINK(symname, path, PATH_MAX);
> +	TST_EXP_PASS(lstat(path, &path_link));
> +
> +	SAFE_UNLINK(symname);
> +}

Isn't this already tested in readlink01?

And actually the readlink01 is doing this better by comparing the string
returned from readlink() against the one we passed to the sysmlink()
syscall previously. The lastat() check is indirectly asserting that we
got right value as well, however simple memcmp() is better.

> +static void test_readlink_no_path(void)
> +{
> +	char *symname = "my_symlink1";
> +
> +	SAFE_SYMLINK("bc+eFhi!k", symname);
> +
> +	char path[PATH_MAX];
> +	struct stat path_link;
> +
> +	SAFE_READLINK(symname, path, PATH_MAX);
> +	TST_EXP_FAIL(lstat(path, &path_link), ENOENT);
> +
> +	SAFE_UNLINK(symname);
> +}

Maybe it would be easier to add this to symlink01 as well?

In reality it probably does not make much difference if we readlink a
symlink to an existing or non-existing file though...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
