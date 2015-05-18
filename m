Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YuJfR-0002Cy-P7
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 11:57:09 +0000
Date: Mon, 18 May 2015 13:56:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150518115627.GF4104@rei>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
	<5551F71E.7090400@huawei.com> <20150512134858.GA11906@rei.suse.de>
	<55530639.2070806@huawei.com> <20150513081458.GA3409@rei.suse.de>
	<55559C6A.9090001@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55559C6A.9090001@huawei.com>
Subject: Re: [LTP] [PATCH] open/open12: compile error
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhuyanpeng@huawei.com, zhanyongming@huawei.com

Hi!
> The 'MS_STRICTATIME' flag is not defined in old kernel.Now add
                                                  ^
						  libc

The system headers are supplied by glibc.

> it into include/lapi/mount.h and include it in testcase source.
> 
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
> Cat /usr/include/x86_64-linux-gnu/sys/mount.h in Ubuntu14 and find
> 'MS_STRICTATIME' flag:
> MS_STRICTATIME = 1 << 24,     /* Always perform atime updates.  */
> 
> So add it into include/lapi/mount.h
> And thank you for your advice,My idea is wrong.
> 
>  include/lapi/mount.h                    |   26 ++++++++++++++++++++++++++
>  testcases/kernel/syscalls/open/open12.c |    1 +
>  2 files changed, 27 insertions(+), 0 deletions(-)
>  create mode 100644 include/lapi/mount.h
> 
> diff --git a/include/lapi/mount.h b/include/lapi/mount.h
> new file mode 100644
> index 0000000..c71a638
> --- /dev/null
> +++ b/include/lapi/mount.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>

              ^
	      Should be your name and current year. :)

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
> + */
> +
> +#ifndef __MOUNT_H__
> +#define __MOUNT_H__
> +
> +#ifndef MS_STRICTATIME
> +#define MS_STRICTATIME  1 << 24
> +#endif
> +
> +#endif /* __MOUNT_H__ */
> diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
> index e665368..af3fab3 100644
> --- a/testcases/kernel/syscalls/open/open12.c
> +++ b/testcases/kernel/syscalls/open/open12.c
> @@ -31,6 +31,7 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  #include "lapi/fcntl.h"
> +#include "lapi/mount.h"
> 
>  #define MNTPOINT	"mntpoint"
>  #define TEST_FILE	MNTPOINT"/test_file"
> -- 
> 1.6.0.2

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
