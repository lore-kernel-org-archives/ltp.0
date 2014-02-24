Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHuHX-0003MS-It
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 12:05:11 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C071FABEA
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Feb 2014 12:05:03 +0000 (UTC)
Date: Mon, 24 Feb 2014 13:04:57 +0100
From: chrubis@suse.cz
Message-ID: <20140224120457.GA23596@rei>
References: <1393233450-22698-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393233450-22698-1-git-send-email-jack@suse.cz>
Subject: Re: [LTP] [PATCH 1/2] syscalls/inotify: Test generation of overflow
	events
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
> Test whether overflow event is properly generated when we don't read
> inotify descriptor and generate enough events.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

You are missing runtest files and it would be better to update
syscalls/.gitignore too.

I've wrote a short introduction on writing LTP testcases (it's not
finished yet but it contains quite a lot of good information). And there
is a contribution checklist at the bottom:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

> ---
>  testcases/kernel/syscalls/inotify/inotify05.c | 224 ++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify05.c
> 
> diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
> new file mode 100644
> index 000000000000..82329aae3a88
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify05.c
> @@ -0,0 +1,224 @@
> +/*
> + * Copyright (c) 2014 SUSE Linux.  All Rights Reserved.
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
> + *     Check that inotify overflow event is properly generated
> + *
> + * ALGORITHM
> + *     Generate enough events without reading them and check that overflow
> + *     event is generated.
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
> +#include "inotify.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "inotify05";
> +int TST_TOTAL = 1;
> +
> +#if defined(HAVE_SYS_INOTIFY_H)
> +#include <sys/inotify.h>
> +
> +/* size of the event structure, not counting name */
> +#define EVENT_SIZE  (sizeof (struct inotify_event))
> +#define EVENT_BUF_LEN (EVENT_SIZE * 16)
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +#define BUF_SIZE 256
> +static char fname[BUF_SIZE];
> +static char buf[BUF_SIZE];
> +static int fd, fd_notify;
> +static int wd;
> +static int max_events;
> +
> +static char event_buf[EVENT_BUF_LEN];
> +
> +int main(int ac, char **av)
> +{
> +	int lc, i;
> +	char *msg;
> +	int len, stop;
> +
> +	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		/*
> +		 * generate events
> +		 */
> +		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
> +
> +		for (i = 0; i < max_events; i++) {
> +			SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +			SAFE_READ(cleanup, 1, fd, buf, BUF_SIZE);
> +			SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +			SAFE_WRITE(cleanup, 1, fd, buf, BUF_SIZE);
> +		}
> +
> +		SAFE_CLOSE(cleanup, fd);
> +
> +		stop = 0;
> +		while (!stop) {
> +			/*
> +			 * get list on events
> +			 */
> +			len = read(fd_notify, event_buf, EVENT_BUF_LEN);
> +			if (len < 0) {
> +				tst_brkm(TBROK | TERRNO, cleanup,
> +					 "read(%d, buf, %zu) failed",
> +					 fd_notify, EVENT_BUF_LEN);
> +			}
> +
> +			/*
> +			 * check events
> +			 */
> +			i = 0;
> +			while (i < len) {
> +				struct inotify_event *event;
> +
> +				event = (struct inotify_event *)&event_buf[i];
> +				if (event->mask != IN_ACCESS &&
> +				    event->mask != IN_MODIFY &&
> +				    event->mask != IN_OPEN &&
> +				    event->mask != IN_Q_OVERFLOW) {
> +					tst_resm(TFAIL,
> +						 "get event: wd=%d mask=%x "
> +						 "cookie=%u (expected 0) len=%u",
> +						 event->wd, event->mask,
> +						 event->cookie, event->len);
> +					stop = 1;
> +					break;
> +				}
> +				if (event->mask == IN_Q_OVERFLOW) {
> +					if (event->len != 0 ||
> +					    event->cookie != 0 ||
> +					    event->wd != -1) {
> +						tst_resm(TFAIL,
> +						 	 "invalid overflow event: "

There is a space before the tab.

> +							 "wd=%d mask=%x "
> +							 "cookie=%u len=%u",
> +							 event->wd, event->mask,
> +							 event->cookie,
> +							 event->len);
> +						stop = 1;
> +						break;
> +					}
> +					if ((int)(i + EVENT_SIZE) != len) {
> +						tst_resm(TFAIL,
> +						 	 "overflow event is not last");

Here as well.

> +						stop = 1;
> +						break;
> +					}
> +					tst_resm(TPASS, "get event: wd=%d "
> +						 "mask=%x cookie=%u len=%u",
> +						 event->wd, event->mask,
> +						 event->cookie, event->len);
> +					stop = 1;
> +					break;
> +				}
> +				i += EVENT_SIZE + event->len;
> +			}
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	sprintf(fname, "tfile_%d", getpid());
> +	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
> +	SAFE_WRITE(cleanup, 1, fd, buf, BUF_SIZE);
> +	SAFE_CLOSE(cleanup, fd);

I've created SAFE_FILE_PRINT() and SAFE_FILE_SCANF() to simplify reading
and writing files with printf and scanf like interface. See
include/safe_file_ops.h

> +	if ((fd_notify = syscall(__NR_inotify_init1, O_NONBLOCK)) < 0) {
> +		if (errno == ENOSYS) {
> +			tst_brkm(TCONF, cleanup,
> +				 "inotify is not configured in this kernel.");
> +		} else {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "inotify_init failed");
> +		}
> +	}
> +
> +	if ((wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS)) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
> +			 fd_notify, fname);
> +	};
> +
> +	fd = SAFE_OPEN(cleanup, "/proc/sys/fs/inotify/max_queued_events", O_RDONLY);
> +	SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
> +	if (sscanf(buf, "%d", &max_events) != 1) {
> +		tst_brkm(TBROK, cleanup,
> +			 "cannot parse max_queued_events file");
> +	}
> +	SAFE_CLOSE(cleanup, fd);

SAFE_FILE_SCANF() ;)

> +}
> +
> +static void cleanup(void)
> +{
> +	if (myinotify_rm_watch(fd_notify, wd) < 0) {
> +		tst_resm(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
> +			 fd_notify, wd);
> +
> +	}
> +
> +	if (close(fd_notify) == -1) {
> +		tst_resm(TWARN, "close(%d) failed", fd_notify);
> +	}
> +
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}
> +
> +#else
> +
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
> +}
> +
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
