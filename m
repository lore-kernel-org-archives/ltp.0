Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VOsTn-0001nN-3l
	for ltp-list@lists.sourceforge.net; Wed, 25 Sep 2013 17:02:23 +0000
Date: Wed, 25 Sep 2013 19:02:41 +0200
From: chrubis@suse.cz
Message-ID: <20130925170241.GA7024@rei>
References: <1379676132-23574-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379676132-23574-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] mk/module.mk: add Makefile to build kernel
 modules
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
> Makefile example:
> 
> top_srcdir	?= ../../../..
> 
> include $(top_srcdir)/include/mk/testcases.mk
> 
> REQ_VERSION_MAJOR	:= 2
> REQ_VERSION_PATCH	:= 6
> 
> MODULE_NAMES	:= Module01 Module02 ...
> MAKE_TARGETS	:= test01 test02 ...
> 
> include $(top_srcdir)/include/mk/module.mk
> include $(top_srcdir)/include/mk/generic_leaf_target.mk

Looks good.

> ---
>  include/mk/module.mk |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 69 insertions(+), 0 deletions(-)
>  create mode 100644 include/mk/module.mk
> 
> diff --git a/include/mk/module.mk b/include/mk/module.mk
> new file mode 100644
> index 0000000..9304e4c
> --- /dev/null
> +++ b/include/mk/module.mk
> @@ -0,0 +1,69 @@
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
> +#
> +# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> +#
> +# Include it to build kernel modules.
> +# MODULE_NAMES, REQ_VERSION_MAJOR and REQ_VERSION_PATCH must be defined
> +# beforehand.
> +#
> +
> +ifneq ($(KERNELRELEASE),)
> +
> +obj-m := $(addsuffix .o, $(MODULE_NAMES))
> +
> +else
> +
> +# prerequisites
> +$(if $(ENV_PRE_LOADED),,\
> +	$(error You must load env_pre.mk before including this file))
> +
> +$(if $(MODULE_NAMES),,\
> +	$(error You must define MODULE_NAMES))
> +
> +$(if $(REQ_VERSION_MAJOR),,\
> +	$(error You must define REQ_VERSION_MAJOR))
> +
> +$(if $(REQ_VERSION_PATCH),,\
> +	$(error You must define REQ_VERSION_MINOR))
> +
> +export ENV_PRE_LOADED
> +export top_srcdir := $(abs_srcdir)/$(top_srcdir)

I fail to see what are these two exports are for.

For what reason do we need to redefine top_srcdir?

> +ifeq ($(MAKECMDGOALS),clean)
> +SKIP := 0
> +endif
> +
> +SKIP ?= $(shell [ "$(WITH_MODULES)" = yes ] && \
> +	[ $(LINUX_VERSION_MAJOR) -gt $(REQ_VERSION_MAJOR) ] || \
> +	[ $(LINUX_VERSION_MAJOR) -eq $(REQ_VERSION_MAJOR) -a \
> +	  $(LINUX_VERSION_PATCH) -ge $(REQ_VERSION_PATCH) ]; echo $$?)
> +
> +ifeq ($(SKIP),0)
> +MODULE_FILES := $(addsuffix .ko, $(MODULE_NAMES))
> +MAKE_TARGETS += $(if $(filter $(MAKECMDGOALS),install),\
> +	$(wildcard $(MODULE_FILES)),$(MODULE_FILES))
> +endif
> +
> +# Ignoring the exit status of commands is done to be forward compatible with
> +# kernel internal API changes. The user-space test will return TCONF, if it
> +# doesn't find the module (i.e. it wasn't built either due to kernel-devel
> +# missing or module build failure).
> +%.ko: %.c
> +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> +	-rm -rf *.mod.c *.o modules.order .tmp* .*.ko .*.cmd Module.symvers

I think that we don't have to ignore the retval from 'rm -rf' as the -f
causes the rm ignore nonexistent files anyway. But that is minor.

> +endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
