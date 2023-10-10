Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE96CD80A0
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 10:29:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D4C03CD674
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 12:29:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E74C3C894B
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 12:29:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AE741A010B7
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 12:29:37 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 04EFF21847;
 Tue, 10 Oct 2023 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696933777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bo/kHGw0VWFsDjsW3ZDIsAWo5uu/wql3dm/Ruhg+0UM=;
 b=baHxloQdkkVZ6E538/GHCxlpRFPCnXnHe/Ijn/dajDx1sjSWIhIKDVFEPRj9w7gPGpeQog
 yaRgWUczARin5Tx1ky0dcbVk4+joYCLVNrK+nsunML8lbxeMx1i0a4Y9lR+Gu9RrXBcz5P
 YRZn+NC5EXNAqc11ER3MhbkpAY1S3Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696933777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bo/kHGw0VWFsDjsW3ZDIsAWo5uu/wql3dm/Ruhg+0UM=;
 b=QvjF5X+Ceni/HeHslsNNl5+xiCUl9uxX0o8IrVb++H2JggAkkJ/JyWhvTv89SD4AnXxfsW
 Sr5UtoCcxRcJi7Dg==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6FCF72C3F8;
 Tue, 10 Oct 2023 10:29:36 +0000 (UTC)
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-2-chrubis@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2023 11:18:37 +0100
Organization: Linux Private Site
In-reply-to: <20231004124712.3833-2-chrubis@suse.cz>
Message-ID: <87jzruzs6p.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: Add tst_fd_iterate()
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
Reply-To: rpalethorpe@suse.de
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Which allows us to call a function on bunch of different file
> descriptors.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fd.h   |  39 +++++++++++++++
>  include/tst_test.h |   1 +
>  lib/tst_fd.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 include/tst_fd.h
>  create mode 100644 lib/tst_fd.c
>
> diff --git a/include/tst_fd.h b/include/tst_fd.h
> new file mode 100644
> index 000000000..711e043dd
> --- /dev/null
> +++ b/include/tst_fd.h
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#ifndef TST_FD_H__
> +#define TST_FD_H__
> +
> +enum tst_fd_type {
> +	TST_FD_FILE,
> +	TST_FD_DIR,
> +	TST_FD_DEV_ZERO,
> +	TST_FD_PROC_MAPS,
> +	TST_FD_PIPE_IN,
> +	TST_FD_PIPE_OUT,
> +	TST_FD_UNIX_SOCK,
> +	TST_FD_INET_SOCK,
> +	TST_FD_IO_URING,
> +	TST_FD_BPF_MAP,
> +	TST_FD_MAX,
> +};
> +
> +struct tst_fd {
> +	enum tst_fd_type type;
> +	int fd;
> +};
> +
> +/*
> + * Iterates over all fd types and calls the run_test function for each of them.
> + */
> +void tst_fd_iterate(void (*run_test)(struct tst_fd *fd));
> +
> +/*
> + * Returns human readable name for the file descriptor type.
> + */
> +const char *tst_fd_desc(struct tst_fd *fd);
> +
> +#endif /* TST_FD_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 75c2109b9..5eee36bac 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -44,6 +44,7 @@
>  #include "tst_taint.h"
>  #include "tst_memutils.h"
>  #include "tst_arch.h"
> +#include "tst_fd.h"
>  
>  /*
>   * Reports testcase result.
> diff --git a/lib/tst_fd.c b/lib/tst_fd.c
> new file mode 100644
> index 000000000..7b6cb767e
> --- /dev/null
> +++ b/lib/tst_fd.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "lapi/io_uring.h"
> +#include "lapi/bpf.h"
> +
> +#include "tst_fd.h"
> +
> +const char *tst_fd_desc(struct tst_fd *fd)
> +{
> +	switch (fd->type) {
> +	case TST_FD_FILE:
> +		return "regular file";
> +	case TST_FD_DIR:
> +		return "directory";
> +	case TST_FD_DEV_ZERO:
> +		return "/dev/zero";
> +	case TST_FD_PROC_MAPS:
> +		return "/proc/self/maps";
> +	case TST_FD_PIPE_IN:
> +		return "pipe read end";
> +	case TST_FD_PIPE_OUT:
> +		return "pipe write end";
> +	case TST_FD_UNIX_SOCK:
> +		return "unix socket";
> +	case TST_FD_INET_SOCK:
> +		return "inet socket";
> +	case TST_FD_IO_URING:
> +		return "io_uring";
> +	case TST_FD_BPF_MAP:
> +		return "bpf map";
> +	case TST_FD_MAX:
> +	break;
> +	}
> +
> +	return "invalid";
> +}
> +
> +void tst_fd_iterate(void (*run_test)(struct tst_fd *fd))
> +{
> +	enum tst_fd_type i;
> +	struct tst_fd fd;
> +	int pipe[2];
> +	struct io_uring_params uring_params = {};
> +	union bpf_attr array_attr = {
> +		.map_type = BPF_MAP_TYPE_ARRAY,
> +		.key_size = 4,
> +		.value_size = 8,
> +		.max_entries = 1,
> +	};
> +
> +	SAFE_PIPE(pipe);
> +
> +	for (i = 0; i < TST_FD_MAX; i++) {
> +		fd.type = i;
> +
> +		switch (i) {
> +		case TST_FD_FILE:
> +			fd.fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT);
> +			SAFE_UNLINK("fd_file");
> +		break;
> +		case TST_FD_DIR:
> +			SAFE_MKDIR("fd_dir", 0700);
> +			fd.fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
> +			SAFE_RMDIR("fd_dir");
> +		break;
> +		case TST_FD_DEV_ZERO:
> +			fd.fd = SAFE_OPEN("/dev/zero", O_RDONLY);
> +		break;
> +		case TST_FD_PROC_MAPS:
> +			fd.fd = SAFE_OPEN("/proc/self/maps", O_RDONLY);
> +		break;
> +		case TST_FD_PIPE_IN:
> +			fd.fd = pipe[0];
> +		break;
> +		case TST_FD_PIPE_OUT:
> +			fd.fd = pipe[1];
> +		break;
> +		case TST_FD_UNIX_SOCK:
> +			fd.fd = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +		break;
> +		case TST_FD_INET_SOCK:
> +			fd.fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +		break;
> +		case TST_FD_IO_URING:
> +			fd.fd = io_uring_setup(1, &uring_params);
> +			if (fd.fd < 0) {
> +				tst_res(TCONF | TERRNO,
> +					"Skipping %s", tst_fd_desc(&fd));
> +				continue;
> +			}
> +		break;
> +		case TST_FD_BPF_MAP:
> +			fd.fd = bpf(BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
> +			if (fd.fd < 0) {
> +				tst_res(TCONF | TERRNO,
> +					"Skipping %s", tst_fd_desc(&fd));
> +				continue;
> +			}
> +		break;

I don't wish to over complicate this, but how many potential fd types
could there be 100, 1000? Some could have complicated init logic.

I'm wondering if at the outset it would be better to define an interface
struct with name, setup and teardown for each FD type, plus whatever
other meta-data might be useful for filtering.

Then instead of a case statement, we put the structs in an array etc.


> +		case TST_FD_MAX:
> +		break;
> +		}
> +
> +		run_test(&fd);
> +
> +		SAFE_CLOSE(fd.fd);
> +	}
> +}
> -- 
> 2.41.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
