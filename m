Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDFUk-0007LS-Pw
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:43:34 +0000
Date: Tue, 11 Feb 2014 16:42:59 +0100
From: chrubis@suse.cz
Message-ID: <20140211154258.GB15043@rei.Home>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1388048842-28373-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1388048842-28373-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/5] rpc-tirpc-full-test-suite: enabled build of
 the rpc test cases
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
> Nothing from rpc-tirpc-full-test-suite is built during LTP compilation,
> but some of the rpc test cases are needed to run runtest/rpc and
> runtest/stress.part3 (executed by ltpstress.sh).
> 
> Therefore:
>  * Added necessary Makefiles to enable building and installation
>    of these test scripts (from 'rpc_ts_wizard.sh -allrpc')
>  * Since rpc-tirpc-full-test-suite initially used the '.bin' suffix
>    to mark binaries (and LTP doesn't) I removed this suffix from
>    the scripts.
> 
> It seems that runtest/tirpc is not executed automatically (maybe it's not
> used at all now) therefore I've not touched the tirpc part of the suite.

That is probably because it's currently broken, but it should either be
fixed or removed.

> diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile
> new file mode 100644
> index 0000000..91f9324
> --- /dev/null
> +++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile
> @@ -0,0 +1,27 @@
> +#
> +#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +top_srcdir		?= ../../../..
> +top_rpcsrcdir		?= $(abs_srcdir)
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_rpcsrcdir)/Makefile.inc
> +
> +INSTALL_TARGETS		:= rpc_ts_run.sh rpc*basic*_lib.sh
> +
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc
> new file mode 100644
> index 0000000..1fafbd4
> --- /dev/null
> +++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc
> @@ -0,0 +1,3 @@
> +INSTALL_BASE_DIR	:= testcases/network/rpc
> +CUR_DIR			:= $(shell echo $(abs_srcdir) | sed 's/.*testcases\/network\/rpc\///')

This is a bit messy. Why don't we install the binaries to the same
directory rest of the binaries go?

Ah, some of the binaries are named as 1-basic etc and there are
collisions. I would consider renaming these binaries with more
descriptive names...

> +INSTALL_DIR		:= $(INSTALL_BASE_DIR)/$(CUR_DIR)

> diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile
> new file mode 100644
> index 0000000..c2d4b55
> --- /dev/null
> +++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile
> @@ -0,0 +1,27 @@
> +#
> +#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +top_srcdir		?= ../../../../..
> +top_rpcsrcdir		?= ../
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_rpcsrcdir)/Makefile.inc
> +
> +INSTALL_TARGETS		:= rpc_*.sh
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk


> diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile
> new file mode 100644
> index 0000000..3bbbb8d
> --- /dev/null
> +++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile
> @@ -0,0 +1,28 @@
> +#
> +#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +top_srcdir		?= ../../../../..
> +top_rpcsrcdir		?= ../
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_rpcsrcdir)/Makefile.inc
> +
> +CPPFLAGS	+= -I/usr/include/tirpc
> +LDLIBS		+= -ltirpc -lpthread

The -ltirpc needs a configure check.

> +include $(top_srcdir)/include/mk/generic_trunk_target.mk

> diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
> new file mode 100644
> index 0000000..c2cea11
> --- /dev/null
> +++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +top_srcdir		?= ../../../../../../../..
> +top_rpcsrcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_rpcsrcdir)/Makefile.inc
> +include ../Makefile.inc

In such simple case I would consider adding the LDLIBS += -lnsl directly
here instead of the include. But it's fine anyway.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
