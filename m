Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wd0Th-0000Zo-4d
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 16:56:57 +0000
Date: Wed, 23 Apr 2014 18:56:04 +0200
From: chrubis@suse.cz
Message-ID: <20140423165604.GE16286@rei.suse.cz>
References: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib/tst_fs_has_free.c: add
 tst_fs_has_free() to determine filesystem's free space
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -int tst_cwd_has_free(int required_kib)
> -{
> -	struct statfs sf;
> -	statfs(".", &sf);
> -
> -	/* check that we have enough blocks to create swap file */
> -	return ((float)sf.f_bfree) / (1024 / sf.f_bsize) >=
> -	    required_kib ? 1 : 0;
> -}
> diff --git a/lib/tst_fs_has_free.c b/lib/tst_fs_has_free.c
> new file mode 100644
> index 0000000..16169ba
> --- /dev/null
> +++ b/lib/tst_fs_has_free.c
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/*
> + * DESCRIPTION
> + * 	Check if the mounted file system has enough free space,
> + * 	if it is, tst_fs_has_free() returns 1, otherwise 0.
> + */
> +
> +#include <stdint.h>	/* for uint64_t */
                           ^
			   This comment falls into the
			   "Commenting the obvious" category.
			   Please remove it.

> +#include <sys/vfs.h>
> +#include "test.h"
> +
> +int tst_fs_has_free(void (*cleanup)(void), const char *path,
> +	uint64_t required_kib)
> +{
> +	struct statfs sf;
> +
> +	if (statfs(path, &sf)) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "tst_fs_has_free: failed to statfs(%s)", path);
> +	}
> +
> +	return ((uint64_t)sf.f_bfree * sf.f_bsize / 1024) >=
> +		required_kib ? 1 : 0;

This line is too long, maybe this would be more readable as regular if.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
