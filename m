Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSRv1-0005b4-My
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 15:06:03 +0000
Date: Mon, 2 Mar 2015 16:05:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302150514.GD27832@rei>
References: <1425024732-30751-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1425024732-30751-7-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1425024732-30751-7-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 7/9] power_management: install
 lib/pm_sched_mc.py into testcases/bin directory
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> -vpath %.c $(srcdir):$(top_srcdir)/lib
> -
> -INSTALL_TARGETS		:= lib/*.py *.py *.sh
> +INSTALL_TARGETS 	:= *.py *.sh
>  
>  MAKE_DEPS		+= $(APICMDS_DIR)/tst_kvercmp
>  
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/power_management/lib/Makefile b/testcases/kernel/power_management/lib/Makefile
> new file mode 100644
> index 0000000..2aadac0
> --- /dev/null
> +++ b/testcases/kernel/power_management/lib/Makefile
> @@ -0,0 +1,25 @@
> +#
> +# Copyright (c) 2015 Fujitsu Ltd.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +top_srcdir 		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS 	:= *.py
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
> index 5aa3948..72822b7 100755
> --- a/testcases/kernel/power_management/pm_cpu_consolidation.py
> +++ b/testcases/kernel/power_management/pm_cpu_consolidation.py
> @@ -7,7 +7,8 @@ import os
>  import sys
>  import time
>  LIB_DIR = "%s/lib" % os.path.dirname(__file__)
> -sys.path.append(LIB_DIR)
> +if os.path.exists(LIB_DIR):
> +    sys.path.append(LIB_DIR)
>  from optparse import OptionParser
>  from pm_sched_mc import *

So nothing gets installed into lib/ anymore, right?

Why not just delete the line? Or am I missing something?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
