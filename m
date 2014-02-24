Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHuMT-0002Bt-U9
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 12:10:17 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B16F9AC91
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Feb 2014 12:10:10 +0000 (UTC)
Date: Mon, 24 Feb 2014 13:10:04 +0100
From: chrubis@suse.cz
Message-ID: <20140224121004.GB23596@rei>
References: <1393233450-22698-1-git-send-email-jack@suse.cz>
	<1393233450-22698-2-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393233450-22698-2-git-send-email-jack@suse.cz>
Subject: Re: [LTP] [PATCH 2/2] syscalls/fanotify: Test generation of
	overflow events
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
> fanotify descriptor and generate enough events.

Missing runtest and .gitignore changes as well.

>  testcases/kernel/syscalls/fanotify/fanotify05.c | 185 ++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify05.c
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
> new file mode 100644
> index 000000000000..a714d9e27a6f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
> @@ -0,0 +1,185 @@
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
> + *     Check that fanotify overflow event is properly generated
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
> +#include "fanotify.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "fanotify05";
> +int TST_TOTAL = 1;
> +
> +#if defined(HAVE_SYS_FANOTIFY_H)
> +#include <sys/fanotify.h>
> +
> +/* Currently this is fixed in kernel... */
> +#define MAX_EVENTS 16384
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +#define BUF_SIZE 256
> +static char fname[BUF_SIZE];
> +static int fd, fd_notify;
> +
> +struct fanotify_event_metadata event;
> +
> +int main(int ac, char **av)
> +{
> +	int lc, i;
> +	char *msg;
> +	int len;
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
> +		for (i = 0; i < MAX_EVENTS + 1; i++) {
> +			sprintf(fname, "fname_%d", i);
> +			fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0644);
> +			SAFE_CLOSE(cleanup, fd);

SAFE_FILE_TOUCH(cleanup, fname, 0, NULL)

> +		}
> +
> +		while (1) {
> +			/*
> +			 * get list on events
> +			 */
> +			len = read(fd_notify, &event, sizeof(event));
> +			if (len < 0) {
> +				if (errno == -EAGAIN) {
> +					tst_resm(TFAIL, "Overflow event not "
> +						 "generated!\n");
> +					break;
> +				}
> +				tst_brkm(TBROK | TERRNO, cleanup,
> +				 	 "read of notification event failed");

Space befor tab.

> +				break;
> +			}
> +			if (event.fd != FAN_NOFD)
> +				close(event.fd);
> +
> +			/*
> +			 * check events
> +			 */
> +			if (event.mask != FAN_OPEN &&
> +			    event.mask != FAN_Q_OVERFLOW) {
> +				tst_resm(TFAIL,
> +					 "get event: mask=%llx (expected %llx)"
> +					 "pid=%u fd=%d",
> +					 (unsigned long long)event.mask,
> +					 (unsigned long long)FAN_OPEN,
> +					 (unsigned)event.pid, event.fd);
> +				break;
> +			}
> +			if (event.mask == FAN_Q_OVERFLOW) {
> +				if (event.fd != FAN_NOFD) {
> +					tst_resm(TFAIL,
> +					 	 "invalid overflow event: "

Here as well.

> +						 "mask=%llx pid=%u fd=%d",
> +						 (unsigned long long)event.mask,
> +						 (unsigned)event.pid,
> +						 event.fd);
> +					break;
> +				}
> +				tst_resm(TPASS,
> +					 "get event: mask=%llx pid=%u fd=%d",
> +					 (unsigned long long)event.mask,
> +					 (unsigned)event.pid, event.fd);
> +					break;
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
> +	if ((fd_notify = myfanotify_init(FAN_CLASS_NOTIF | FAN_NONBLOCK,
> +					 O_RDONLY)) < 0) {

I would move the assigment out of the if conditional here and then do
just if (fd_notify < 0) but that is just aesthetic change.

> +		if (errno == ENOSYS) {
> +			tst_brkm(TCONF, cleanup,
> +				 "fanotify is not configured in this kernel.");
> +		} else {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "fanotify_init failed");
> +		}
> +	}
> +
> +	if (myfanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
> +			    AT_FDCWD, ".") < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
> +			 "FAN_OPEN, AT_FDCWD, \".\") failed",
> +			 fd_notify);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (close(fd_notify) == -1) {
> +		tst_resm(TWARN, "close(%d) failed", fd_notify);
> +	}

And I tend not to add curly brackets around one line statements...

> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}
> +
> +#else
> +
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
> +}
> +
> +#endif
> -- 
> 1.8.1.4
> 

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
