Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XnrKz-0002Wj-AY
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 15:57:05 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8F34EAC95
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Nov 2014 15:56:56 +0000 (UTC)
Date: Mon, 10 Nov 2014 16:56:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141110155627.GA23693@rei.suse.de>
References: <1415279528-9684-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415279528-9684-1-git-send-email-jack@suse.cz>
Subject: Re: [LTP] [PATCH] syscalls/fanotify: Verify that inode ignore masks
 are properly reflected
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Verify that when inode has an ignore mask set, it is properly reflected
> when notifying a mountpoint.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  runtest/syscalls                                |    1 +
>  testcases/kernel/syscalls/.gitignore            |    1 +
>  testcases/kernel/syscalls/fanotify/fanotify06.c |  267 +
>  utils/ffsb-6.0-rc2/config.h.in                  |   49 +-
>  utils/ffsb-6.0-rc2/configure                    | 5937 +++++++++++------------

Looks like changes in generated configure file in ffsb slipped into this
patch accidentally.

> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
> @@ -0,0 +1,267 @@
> +/*
> + * Copyright (c) 2014 SUSE.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * Started by Jan Kara <jack@suse.cz>
> + *
> + * DESCRIPTION
> + *     Check that fanotify properly merges ignore mask of an inode and
> + *     mountpoint.
> + */
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +#include "fanotify.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "fanotify06";
> +
> +#if defined(HAVE_SYS_FANOTIFY_H)
> +#include <sys/fanotify.h>
> +
> +#define EVENT_MAX 1024
> +/* size of the event structure, not counting name */
> +#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
> +/* reasonable guess as to size of 1024 events */
> +#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +unsigned int fanotify_prio[] = {
> +	FAN_CLASS_PRE_CONTENT,
> +	FAN_CLASS_CONTENT,
> +	FAN_CLASS_NOTIF
> +};
> +#define FANOTIFY_PRIORITIES (sizeof(fanotify_prio) / sizeof(unsigned int))

We have ARRAY_SIZE() macro for this purpose.

> +#define GROUPS_PER_PRIO 3
> +
> +int TST_TOTAL = GROUPS_PER_PRIO * FANOTIFY_PRIORITIES;
> +
> +#define BUF_SIZE 256
> +static char fname[BUF_SIZE];
> +static int fd;
> +static int fd_notify[FANOTIFY_PRIORITIES][GROUPS_PER_PRIO];
> +
> +static char event_buf[EVENT_BUF_LEN];
> +
> +static void create_fanotify_groups(void)
> +{
> +	unsigned int p, i;
> +	int ret;
> +
> +	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
> +		for (i = 0; i < GROUPS_PER_PRIO; i++) {
> +			fd_notify[p][i] = fanotify_init(fanotify_prio[p] |
> +							FAN_NONBLOCK,
> +							O_RDONLY);
> +			if (fd_notify[p][i] < 0) {
> +				if (errno == ENOSYS) {
> +					tst_brkm(TCONF, cleanup,
> +						 "fanotify is not configured in"
> +						 " this kernel.");
> +				} else {
> +					tst_brkm(TBROK | TERRNO, cleanup,
> +						 "fanotify_init failed");
> +				}
> +			}
> +			/* Add mount mark for each group */
> +			ret = fanotify_mark(fd_notify[p][i],
> +					    FAN_MARK_ADD | FAN_MARK_MOUNT,
> +					    FAN_MODIFY,
> +					    AT_FDCWD, ".");
> +			if (ret < 0) {
> +				tst_brkm(TBROK | TERRNO, cleanup,
> +					 "fanotify_mark(%d, FAN_MARK_ADD | "
> +					 "FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
> +					 " \".\") failed", fd_notify[p][i]);

                                           I usually use single quotes
					   inside of C strings to avoid
					   the need to escape them.


Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
