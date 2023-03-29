Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E922C6FD18
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 06:28:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C70C53CCAC8
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 08:28:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDD0C3C2C74
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 08:28:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE54060075C
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 08:28:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 732871FE08;
 Wed, 29 Mar 2023 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680071303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVeshJm9eD/KtC0CCcIyc0USe9bv3pcKUBMj9dTnzL8=;
 b=ZmM3OO1saJLTkrXmTvq1fo7ebv5tBNKZDRWN0O02GtN4aSMh9nWTPLgAVhcLzhpCjIFQEI
 majKi6E0OfKfiQ6/dsf94CCbBxbHgNyRiyNnAtGXE1Qx6c5s3nTVq2ifV6S+c7jT/Ihc59
 xQm2hB+2DTdYPlcNilIWDctgzuUQf78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680071303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVeshJm9eD/KtC0CCcIyc0USe9bv3pcKUBMj9dTnzL8=;
 b=4nM+1Naxh9JzYw8dPBKOmrOPx+poQWjlwnijIN7yNBt33Y/RrfRyZ3F1LuVtdqudi0omn8
 teahyXfFbBQ876Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E9FF139D3;
 Wed, 29 Mar 2023 06:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id auRFFofaI2S5HwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 29 Mar 2023 06:28:23 +0000
Date: Wed, 29 Mar 2023 08:28:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230329062821.GA834115@pevik>
References: <20230307085139.3574-1-wegao@suse.com>
 <20230318045253.10119-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230318045253.10119-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] kill01: New case cgroup kill
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

Hi Wei,

NOTE: it's slightly easier to review if you write sum of changes from previous version.

...
> +++ b/lib/tst_cgroup.c
> @@ -94,9 +94,10 @@ enum cgroup_ctrl_indx {
>  	CTRL_MISC,
>  	CTRL_PERFEVENT,
>  	CTRL_DEBUG,
> -	CTRL_RDMA
> +	CTRL_RDMA,
> +	CTRL_PSEUDO
>  };
> -#define CTRLS_MAX CTRL_RDMA
> +#define CTRLS_MAX CTRL_PSEUDO

Maybe CTRL_PSEUDO should be added as a separate commit with a proper description
why it's needed.

...
> +static const struct cgroup_file cgroup_pseudo_ctrl_files[] = {
> +	{ }
> +};
> +
>  #define CTRL_NAME_MAX 31
>  #define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
>  	x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
> @@ -281,6 +287,7 @@ static struct cgroup_ctrl controllers[] = {
>  	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
>  	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
>  	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
> +	CGROUP_CTRL_MEMBER(cgroup_pseudo, CTRL_PSEUDO),
>  	{ }
>  };

> @@ -826,6 +833,10 @@ void tst_cg_require(const char *const ctrl_name,
>  	if (options->needs_ver != TST_CG_V2)
>  		cgroup_mount_v1(ctrl);

> +	if (!strcmp(ctrl->ctrl_name, "cgroup_pseudo")) {
> +		ctrl->ctrl_root = roots;
> +	}

tst_cgroup.c:836: WARNING: braces {} are not necessary for single statement blocks
=> please remove { }

Also strcmp for "cgroup_pseudo" is checked 3x in tst_cg_require(), why not creating
a variable and use it in if ()?
int cgroup_pseudo = !strcmp(ctrl->ctrl_name, "cgroup_pseudo");

> +
>  	if (!ctrl->ctrl_root) {
>  		tst_brk(TCONF,
>  			"'%s' controller required, but not available",
> @@ -848,13 +859,15 @@ mkdirs:
>  			ctrl->ctrl_name);
>  	}

> -	if (cgroup_ctrl_on_v2(ctrl)) {
> -		if (root->we_mounted_it) {
> -			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
> -					   cgsc, "+%s", ctrl->ctrl_name);
> -		} else {
> -			tst_file_printfat(root->mnt_dir.dir_fd,
> -					  cgsc, "+%s", ctrl->ctrl_name);
> +	if (strcmp(ctrl->ctrl_name,"cgroup_pseudo")) {
nit: missing space after comma. I actually found by searching for previous
strcmp line (with comma) and it found just 2 places instead of 3, but make check
would report it for you:

make check-tst_cgroup
tst_cgroup.c:836: WARNING: braces {} are not necessary for single statement blocks
tst_cgroup.c:862: ERROR: space required after that ',' (ctx:VxV)
tst_cgroup.c:879: ERROR: space required after that ',' (ctx:VxV)

> +		if (cgroup_ctrl_on_v2(ctrl)) {
> +			if (root->we_mounted_it) {
> +				SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
> +						cgsc, "+%s", ctrl->ctrl_name);
> +			} else {
> +				tst_file_printfat(root->mnt_dir.dir_fd,
> +						cgsc, "+%s", ctrl->ctrl_name);
> +			}
>  		}
>  	}

> @@ -863,15 +876,17 @@ mkdirs:
>  	else
>  		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;

> -	if (cgroup_ctrl_on_v2(ctrl)) {
> -		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> -				   cgsc, "+%s", ctrl->ctrl_name);
> -	} else {
> -		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> -				   "cgroup.clone_children", "%d", 1);
> +	if (strcmp(ctrl->ctrl_name,"cgroup_pseudo")) {
> +		if (cgroup_ctrl_on_v2(ctrl)) {
> +			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> +					cgsc, "+%s", ctrl->ctrl_name);
> +		} else {
> +			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> +					"cgroup.clone_children", "%d", 1);

> -		if (ctrl->ctrl_indx == CTRL_CPUSET)
> -			cgroup_copy_cpuset(root);
> +			if (ctrl->ctrl_indx == CTRL_CPUSET)
> +				cgroup_copy_cpuset(root);
> +		}
>  	}

>  	cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
> @@ -1049,8 +1064,10 @@ static void cgroup_group_add_dir(const struct tst_cg_group *const parent,
>  		if (!parent || dir->dir_root->ver == TST_CG_V1)
>  			continue;

> -		SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
> -				   "+%s", ctrl->ctrl_name);
> +		if (strcmp(ctrl->ctrl_name, "cgroup_pseudo")) {
> +			SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
> +					"+%s", ctrl->ctrl_name);
> +		}
>  	}

>  	for (i = 0; cg->dirs[i]; i++)
> diff --git a/runtest/controllers b/runtest/controllers
> index 8d1b936bf..2f69a8ec2 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -23,6 +23,7 @@ memcontrol01 memcontrol01
>  memcontrol02 memcontrol02
>  memcontrol03 memcontrol03
>  memcontrol04 memcontrol04
> +kill01 kill01

>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/cgroup/kill/.gitignore b/testcases/kernel/controllers/cgroup/kill/.gitignore
> new file mode 100644
> index 000000000..4f9649e27
> --- /dev/null
> +++ b/testcases/kernel/controllers/cgroup/kill/.gitignore
> @@ -0,0 +1 @@
> +/kill01
> diff --git a/testcases/kernel/controllers/cgroup/kill/Makefile b/testcases/kernel/controllers/cgroup/kill/Makefile
> new file mode 100644
> index 000000000..bf5aea9e7
> --- /dev/null
> +++ b/testcases/kernel/controllers/cgroup/kill/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../../../
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/controllers/cgroup/kill/kill01.c b/testcases/kernel/controllers/cgroup/kill/kill01.c
> new file mode 100644
> index 000000000..0da6de350
> --- /dev/null
> +++ b/testcases/kernel/controllers/cgroup/kill/kill01.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test is copied from kernel self test case
nit: I'd just wrote kselftest instead of "kernel self test case".

> + * tools/testing/selftests/cgroup/test_kill.c

BTW am I correct that you converted only test_cgkill_simple() ?
There are 2 other: test_cgkill_tree() and test_cgkill_forkbomb(),
I have no idea if they are worth to be implemented or should be implemented now.
But maybe it'd be worth to mention that only simple test case was backported.


> + *
> + */
> +
> +#include <errno.h>
> +#include <linux/limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/wait.h>
nit: only <sys/wait.h> is needed (others either imported by tst_test.h or needed
in the original kselftest but not in LTP port).

> +
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"
> +
> +#define MAX_PID_NUM 100
> +#define pid_num MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
> +#define buf_len (20 * pid_num)
constants should be upper case (PID_NUM and BUF_LEN).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
