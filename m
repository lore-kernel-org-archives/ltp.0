Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C292DC46467
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 11:44:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34E2F3CB59B
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 12:44:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AD993CB4BA
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 12:44:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 766E62001DB
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 12:44:13 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6417267743
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673869453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGaVx8t1dy8VDi8VlAp0BpFVdzVX4LyAToUYwSFsrwc=;
 b=qhh0z1d9QEUJbUCPF7l6VRRklWtAeO+p68OJff3D+G6dCf3Zz+IwgiqS5n5KxMvutRnqvN
 MyQkThd/SKHmq/dM6GxlagxJEHXmzCHPzELDltbiHmw+NDdGG+PF/AWFbuhAfAmeRWBKT9
 cKstjkrZjSysi+WpgoNH1vOd3lAPHr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673869453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGaVx8t1dy8VDi8VlAp0BpFVdzVX4LyAToUYwSFsrwc=;
 b=AWKSQ4BjSX0EQRK5y+LvPCyWGXi/D4LJyUKx4jgygPcISivkZ0eWKpigfLJNy6JkqtYbVs
 0JKZ+jttovZX+OAw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3D3622C152;
 Mon, 16 Jan 2023 11:44:13 +0000 (UTC)
References: <20230112075731.7769-1-akumar@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 16 Jan 2023 11:42:20 +0000
Organization: Linux Private Site
In-reply-to: <20230112075731.7769-1-akumar@suse.de>
Message-ID: <87k01mwvoz.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setreuid06: Rewrite the test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, with a minor change. See below.

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../kernel/syscalls/setreuid/setreuid06.c     | 108 ++++++------------
>  1 file changed, 34 insertions(+), 74 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
> index 22acd996f..72c7e5e47 100644
> --- a/testcases/kernel/syscalls/setreuid/setreuid06.c
> +++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
> @@ -1,95 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
>   * Ported by John George
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * Test that EPERM is set when setreuid is given an invalid user id.
> +/*\
> + * [Description]
> + *
> + * Verify that setreuid(2) syscall fails with EPERM errno when the calling
> + * process is not privileged and a change other than
> + * (i) swapping the effective user ID with the real user ID, or
> + * (ii) setting one to the value of the other or
> + * (iii) setting the effective user ID to the value of the saved set-user-ID
> + * was specified.
>   */
>  
> -#include <sys/wait.h>
> -#include <limits.h>
> -#include <signal.h>
> -#include <errno.h>
> -#include <unistd.h>
>  #include <pwd.h>
> -#include <sys/param.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "compat_16.h"
> -
> -#define INVAL_USER		 (USHRT_MAX-2)
> -
> -TCID_DEFINE(setreuid06);
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> +#include "tst_uid.h"
> +#include "compat_tst_16.h"
>  
>  static struct passwd *ltpuser;
> +static uid_t other_uid;
>  
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int argc, char **argv)
> +static void setup(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> +	uid_t test_user[1];
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	tst_get_uids(test_user, 0, 1);

We can just pass a pointer to other_uid.

Thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
