Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W2lNk-0005JA-By
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 17:33:00 +0000
Date: Mon, 13 Jan 2014 18:32:30 +0100
From: chrubis@suse.cz
Message-ID: <20140113173230.GC1945@rei>
References: <52CFC6D1.4060006@oracle.com>
	<1389605723-17937-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389605723-17937-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 1/2] lib: tst_get_unused_uid, tst_get_unused_gid
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
> @@ -0,0 +1,86 @@
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
> + */
> +
> +#include <grp.h>
> +#include <limits.h>
> +#include <pwd.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +uid_t tst_get_unused_uid(void)
> +{
> +	struct passwd pwd;
> +	struct passwd *result;
> +	char *buf;
> +	size_t bufsize;

I've changed the bufsize to long, because size_t is unsigned.

Side note: I wonder why ltp has only -Wall and not -Wall -W which prints
warnings when signed and unsigned types are compared...

> +	int s;
> +	uid_t uid;
> +
> +	bufsize = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	if (bufsize == -1)
> +		bufsize = 16384;
> +
> +	buf = malloc(bufsize);
> +	if (buf == NULL)
> +		return -1;
> +
> +	for (uid = 0; uid <= UINT_MAX - 1; uid++) {
> +		s = getpwuid_r(uid, &pwd, buf, bufsize, &result);
> +		if (result == NULL) {

I've added a free(buf) here otherwise we will leak memory.

> +			if (s == 0)
> +				return uid;
> +			else
> +				return -1;
> +		}
> +	}
> +
> +	free(buf);
> +	return -1;
> +}

And the same for the second one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
