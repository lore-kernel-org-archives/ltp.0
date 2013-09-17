Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VLy22-0006bH-51
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 16:21:42 +0000
Date: Tue, 17 Sep 2013 18:21:59 +0200
From: chrubis@suse.cz
Message-ID: <20130917162159.GA14998@rei>
References: <1379418720-26529-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379418720-26529-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3 2/2] device-drivers: block: fixes
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/device-drivers/block/Makefile b/testcases/kernel/device-drivers/block/Makefile
> new file mode 100644
> index 0000000..455354f
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/block/Makefile
> @@ -0,0 +1,30 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +top_srcdir	?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +SUBDIRS		= block_dev_user
> +
> +SKIP		= $(shell test "$(MAKECMDGOALS)" = "clean" -o \
> +	"$(WITH_MODULES)" = "yes"; echo $$?)
> +
> +ifeq ($(SKIP),0)
> +SUBDIRS		+= block_dev_kernel
> +endif

I wonder if it wouldn't be easier to enter the directory and make the
kernel part Makefile to be noop if there is no kernel-devel package or
if the kernel version is not new enough.

Ideally the makefile in the kernel part should look like:


top_srcdir	?= ../../../..

include $(top_srcdir)/include/mk/env_pre.mk

REQ_VERSION_MAJOR       = 3
REQ_VERSION_PATCH       = 7

MODULE_NAME = ltp_foo_bar

include $(top_srcdir)/include/mk/module.mk


And the rest of the magic should be in the module.mk file.

Then:

1) make in the dir is noop if devel package is missing or
   version is too old

   - the parent Makefile has only subdirs defined, no need
     for additional magic there

2) module is build

3) if module was build installed

>  /*
> - * Module under test: linux/block/genhd.c
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.

I would add a copyright line for the name in the MODULE_AUTHOR() too.


The rest of the changes looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
