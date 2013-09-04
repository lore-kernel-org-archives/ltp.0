Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VHDGq-000079-LH
	for ltp-list@lists.sourceforge.net; Wed, 04 Sep 2013 13:37:20 +0000
Date: Wed, 4 Sep 2013 15:37:32 +0200
From: chrubis@suse.cz
Message-ID: <20130904133732.GB12344@rei>
References: <20130903101118.GA2100@rei>
	<1378215677-14258-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1378215677-14258-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3.1 2/2] fixes for 16-bit syscalls testcases
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
> diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
> index 9d70612..4c7dceb 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups01.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
> @@ -162,6 +162,9 @@ int main(int ac, char **av)
>  
>  		/* check return code */
>  		if (TEST_RETURN == -1) {
> +			if (TEST_ERRNO == ENOSYS)
> +				LTP_NO_COMPAT16_SYSCALL(setgroups, cleanup);

I'm a bit afraid to be so specific here. Currently we should get to this
branch only if there is no compat syscall defined (as far as I can tell)
but that may change.

I would settle for more vague "Syscall %s() not implemented". The fact
that it's the compat version should be known from the test name.

Or alternatively we can add callback parameter to the ALL CAPS functions
and make sure that the particular error is printed only when compat
syscall is called.

> +/*
> + * Copyright (c) Red Hat Inc., 2008

You should probably add your copyright here, as the content of the file
was changed

> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +/* Author: Masatake YAMATO <yamato@redhat.com> */
> +
> +#ifndef __LTP_COMPAT_16_H__
> +#define __LTP_COMPAT_16_H__
> +
> +#include <errno.h>
> +#include "compat_gid.h"
> +#include "linux_syscall_numbers.h"
> +
> +/* If the platform has __NR_scall32 defined it
> + * means that __NR_scall is a 16-bit version of
> + * scall() syscall
      ^
      should probably be sys_name() now
> + */
> +#ifdef TST_USE_COMPAT16_SYSCALL
> +# define LTP_CREATE_SYSCALL(sys_name, ...) \
> +	if (__NR_##sys_name##32 != __LTP__NR_INVALID_SYSCALL) { \
> +		return ltp_syscall(__NR_##sys_name, ##__VA_ARGS__); \
> +	} else { \
> +		errno = ENOSYS; \
> +		return -1; \
> +	}
> +#else
> +# define LTP_CREATE_SYSCALL(sys_name, ...) \
> +	return sys_name(__VA_ARGS__)
> +#endif
> +
> +#define LTP_NO_COMPAT16_SYSCALL(sys_name, cleanup) \
> +	tst_brkm(TCONF, cleanup,\
> +		"16-bit version of %s() is not supported on your platform", \
> +		#sys_name)
> +
> +int SETGROUPS(size_t gidsetsize, GID_T *list)
> +{
> +	LTP_CREATE_SYSCALL(setgroups, gidsetsize, list);
> +}
> +
> +int GETGROUPS(size_t gidsetsize, GID_T *list)
> +{
> +	LTP_CREATE_SYSCALL(getgroups, gidsetsize, list);
> +}
> +
> +#endif /* __LTP_COMPAT_16_H__ */
> +

Generally this version looks fine to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
