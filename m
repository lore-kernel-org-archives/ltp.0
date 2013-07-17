Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UzRO5-0007UP-F2
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 13:03:21 +0000
Date: Wed, 17 Jul 2013 15:05:02 +0200
From: chrubis@suse.cz
Message-ID: <20130717130502.GD25145@rei>
References: <20130625124854.GD31268@rei>
	<1373983611-10136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373983611-10136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2] syscalls/swapon: fix for variable page size
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
> +{
> +	int fd, counter;
> +	char *buf;
> +
> +	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
> +	if (fd < 0)
> +        	return -1;

There are spaces before the tabs in the return -1; line.

> +	/* Filling a memory buffer with provided pattern */
> +	buf = malloc(bs);
> +	if (buf == NULL) { 
> +		close(fd);
> +
> +		return -1;
> +	}
> +
> +	for (counter = 0; counter < bs; counter++)
> +		buf[counter] = pattern;
> +
> +	/* Filling the file */
> +	for (counter = 0; counter < bcount; counter++) 
> +		if (write(fd, buf, bs) != bs) {
> +			free(buf);
> +			close(fd);

What about unlink(path)?

I known that this is most likely being cleaned up in the test cleanup on
tst_rmkdir() but doing it here as well will not harm.

> +			return -1;
> +		}

The LKML conding style prefers curly brackets around blocks that are
spawns over several lines.

> +
> +	free(buf);
> +	if (close(fd) < 0)
> +		return -1;
> +
> +	return 0;
> +}

There are also some trailing whitespaces. The checkpatch.pl (script
shipped with linux kernel) can find and report these.

> diff --git a/testcases/kernel/syscalls/swapon/Makefile b/testcases/kernel/syscalls/swapon/Makefile
> index 7ff50f1..a272224 100644
> --- a/testcases/kernel/syscalls/swapon/Makefile
> +++ b/testcases/kernel/syscalls/swapon/Makefile
> @@ -25,4 +25,9 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> +FILTER_OUT_MAKE_TARGETS         := libswapon
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +$(MAKE_TARGETS): %: %.o libswapon.o
> +
> diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
> new file mode 100644
> index 0000000..8add3e6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/swapon/libswapon.c
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> + *
> + */
> +
> +#include "test.h"
> +#include "libswapon.h"
> +
> +/* 
> + * Make a swap file
> + */
> +void make_swapfile(void (cleanup)(void), char *swapfile)
> +{
> +	char cmd_buffer[256];
> +
> +	if (!tst_cwd_has_free(sysconf(_SC_PAGESIZE)*10)) {
> +		tst_brkm(TBROK, cleanup,
> +			"Insufficient disk space to create swap file");
> +	}
> +
> +	/* create file */
> +	if (tst_fill_file(swapfile, 0, 
> +			sysconf(_SC_PAGESIZE), 10) != 0) {
> +		tst_brkm(TBROK, cleanup, "Failed to create swapfile");
> +	}
> +
> +	/* make the file swapfile */
> +	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
> +			"mkswap %s > /dev/null 2>&1", swapfile) < 0) {
> +		tst_brkm(TBROK, cleanup, 
> +			"snprintf() failed to create mkswap command string");
> +	}
> +
> +	if (system(cmd_buffer) != 0) {
> +		tst_brkm(TBROK, cleanup, "Failed to make swapfile %s via command %s",
> +			swapfile, cmd_buffer);
> +	}

What about using tst_run_cmd() instead?

The only difference would be not being able to redirect the output of
the command (as this is done by shell). But we can modify the
tst_run_cmd to redirect stdout and stderr if needed.

> +}

The rest of the patch looks good but there are spaces before tabs and
trailing whitespaces. Please clean these up and resend.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
