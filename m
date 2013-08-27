Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEIC3-00084l-Ok
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 12:16:19 +0000
Date: Tue, 27 Aug 2013 14:16:25 +0200
From: chrubis@suse.cz
Message-ID: <20130827121625.GH10995@rei.Home>
References: <521B6875.8010202@oracle.com>
	<1377596129-32367-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377596129-32367-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] syscalls/getgroups: added checks for
 16-bit getgroups() syscall
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
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/getgroups/compat_16.h   |   78 +++++++++++++++++++++
>  testcases/kernel/syscalls/getgroups/getgroups01.c |   22 +++---
>  testcases/kernel/syscalls/getgroups/getgroups03.c |   17 +++--
>  3 files changed, 99 insertions(+), 18 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/getgroups/compat_16.h
> 
> diff --git a/testcases/kernel/syscalls/getgroups/compat_16.h b/testcases/kernel/syscalls/getgroups/compat_16.h
> new file mode 100644
> index 0000000..79d006e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getgroups/compat_16.h
> @@ -0,0 +1,78 @@
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
> +#ifndef __GETGROUPS_COMPAT_16_H__
> +#define __GETGROUPS_COMPAT_16_H__
> +
> +#include "compat_gid.h"
> +#include "linux_syscall_numbers.h"
> +
> +#ifdef TST_USE_COMPAT16_SYSCALL
> +
> +int SETGROUPS(size_t size, const GID_T *list16)
> +{
> +	int r;
> +	int i;
> +
> +	gid_t *list32;
> +	list32 = calloc(size, sizeof(gid_t));
> +	if (list32 == NULL)
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			"calloc() failed to allocate %zu bytes",
> +			size * sizeof(gid_t));
> +
> +	for (i = 0; i < size; i++)
> +		list32[i] = list16[i];
> +
> +	r = setgroups(size, list32);
> +
> +	free(list32);
> +
> +	return r;
> +}

I think that we should just use the 16 bit variant here as well, as
well. It's available if the compat getgroups is and there is no need to
call the 32 bit version.

Or do you want to explicitly assert that the 32 bit syscall returns the
same as the 16 bit? That would make some sense.

> +int GETGROUPS(int size, GID_T *list16)
> +{
> +# if (__NR_getgroups32 != __LTP__NR_INVALID_SYSCALL)
> +	/* __NR_getgroups - 16-bit version of getgroups() syscall */
> +	return ltp_syscall(__NR_getgroups, size, list16);
> +# else
> +	/* The platform has no 16-bit version of getgroups() syscall */
> +	tst_brkm(TCONF, NULL,
> +		"16-bit version of getgroups() is not supported on your arch");
> +# endif /* __NR_getgroups32 */
> +}
> +
> +#else
> +
> +int SETGROUPS(size_t size, const GID_T *list32)
> +{
> +	return setgroups(size, list32);
> +}
> +
> +int GETGROUPS(int size, GID_T *list32)
> +{
> +	return getgroups(size, list32);
> +}
> +
> +#endif /* TST_USE_COMPAT16_SYSCALL */
> +
> +#endif /* __GETGROUPS_COMPAT_16_H__ */

But still it duplicates code in the tree, lets move it into some header
under 'LTP/include/sys/' and move compat_gid.h there as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
