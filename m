Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WYCu5-0006Np-Aw
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 11:12:21 +0000
Date: Thu, 10 Apr 2014 13:11:37 +0200
From: chrubis@suse.cz
Message-ID: <20140410111137.GA24517@rei>
References: <1395402240-6619-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1395402240-6619-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395402240-6619-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] lib/tst_fs_has_free.c: add tst_fs_has_free()
 to determine filesystem's free space
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
> +#include <sys/vfs.h>
> +#include "test.h"
> +
> +int tst_fs_has_free(void (*cleanup)(void), const char *path, int required_kib)
> +{
> +	struct statfs sf;
> +
> +	if (statfs(path, &sf)) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "tst_fs_has_free: failed to statfs(%s)", path);
> +	}
> +
> +	return (sf.f_bfree * sf.f_bsize / 1024) >= required_kib ? 1 : 0;

The f_bfree is unsigned long (via typedef to the fsblkcnt_t) so if I'm
counting right on 32bit system the multiplication will overflow on > 4TB
filesystem.

If we do the multiplication first we should cast the b_free to 64 bit
unsigned integer.

The rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
