Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WnTqv-0007cA-AH
	for ltp-list@lists.sourceforge.net; Thu, 22 May 2014 14:20:13 +0000
Date: Thu, 22 May 2014 16:20:00 +0200
From: chrubis@suse.cz
Message-ID: <20140522142000.GA12154@rei.suse.cz>
References: <1400751666-30218-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400751666-30218-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_fs_link_count.c: add two new test
 interfaces
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
> diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
> new file mode 100644
> index 0000000..16722e0
> --- /dev/null
> +++ b/lib/tst_fs_link_count.c
> @@ -0,0 +1,71 @@
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
> +#include "test.h"
> +
> +int tst_fs_get_max_hardlinks(const char *filesystem)
> +{
> +	if (strcmp(filesystem, "ext2") == 0 ||
> +	    strcmp(filesystem, "ext3") == 0) {
> +#if defined(HAVE_EXT4_USE_FOR_EXT23)
> +		tst_resm(TINFO, "kernel config option CONFIG_EXT4_USE_FOR_EXT23"
> +			 " is enabled, so ext4 file system driver will be used "
> +			 "for %s file system mounts", filesystem);
> +		return 65000;
> +#else
> +		return 32000;
> +#endif
> +	} else if (strcmp(filesystem, "ext4") == 0) {
> +		return 65000;
> +	} else if (strcmp(filesystem, "xfs") == 0) {
> +		return -1;
> +	} else if (strcmp(filesystem, "btrfs") == 0) {
> +		return 65535;
> +	} else {
> +		tst_resm(TINFO, "Currently we do not have knowledge about "
> +			 "filesystem %s, or it is not a valid filesystem "
> +			 "name", filesystem);
> +		return -1;
> +	}
> +}

I think that it would be better to try to actually reach the limit and
stop at some sane number (here it would be 65535).

Because trying to guess the limit from the filesystem type is too
fragile.

I would simply change the function to take a path and then call link()
in loop either till we get error or the maximal number of tries has been
reached. Then we can simply return the maxium or inifinity if limit
wasn't reached.

> diff --git a/m4/ltp-ext-filesystem.m4 b/m4/ltp-ext-filesystem.m4
> new file mode 100644
> index 0000000..bbc0a54
> --- /dev/null
> +++ b/m4/ltp-ext-filesystem.m4
> @@ -0,0 +1,38 @@
> +dnl
> +dnl Copyright (c) 2014 Fujitsu Ltd.
> +dnl Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_EXT_FILESYSTEM
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_EXT_FILESYSTEM],[dnl
> +	AC_MSG_CHECKING([check kernel config option CONFIG_EXT4_USE_FOR_EXT23])
> +
> +	has_ext4_use_for_ext23=no
> +	if grep "CONFIG_EXT4_USE_FOR_EXT23=y" /boot/config-$(uname -r); then
> +		has_ext4_use_for_ext23=yes
> +	fi
> +
> +	if test "$has_ext4_use_for_ext23" = "yes"; then
> +		AC_DEFINE(HAVE_EXT4_USE_FOR_EXT23,1,[Define to 1 if kernel config option CONFIG_EXT4_USE_FOR_EXT23 is defined])
> +		AC_MSG_RESULT(yes)
> +	else
> +		AC_MSG_RESULT(no)
> +	fi
> +])

This check is wrong in two ways.

1. This should really be runtime check not compile time check
2. Even then /boot/config-$(uname -r) doesn't say much about kernel
   you use

I guess that only way how to get this information correctly would be to
digg out the information from the /sys/. There is, for example
/sys/fs/ext4/ which contains all the devices that used by ext4 driver.
So if we mount ext2 fs and /sys/fs/ext4/ contains the device, we know
that EXT4_USE_FOR_EXT2 is on.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
