Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VMctX-0003ne-Da
	for ltp-list@lists.sourceforge.net; Thu, 19 Sep 2013 11:59:39 +0000
Date: Thu, 19 Sep 2013 13:59:59 +0200
From: chrubis@suse.cz
Message-ID: <20130919115958.GB13055@rei>
References: <1379492909-19596-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379492909-19596-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] mk/module.mk: add Makefile to build kernel
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
> top_srcdir      ?= ../../../..
> 

Why aren't you including env_pre.mk here?

It contains mostly compatibility hack for older Make.

Does it break something?

> REQ_VERSION_MAJOR       := 2
> REQ_VERSION_PATCH       := 6
> 
> MODULE_NAMES    := Module01 Module02 ...
> MAKE_TARGETS    := test01 test02 ...
> 
> include $(top_srcdir)/include/mk/module.mk



> +ifeq ($(WITH_MODULES),yes)
> +
> +ifneq ($(REQ_VERSION_MAJOR),)
> +SKIP ?= $(shell test $(LINUX_VERSION_MAJOR) -gt $(REQ_VERSION_MAJOR); echo $$?)
> +
> +ifeq ($(SKIP),1)
> +SKIP := $(shell test $(LINUX_VERSION_MAJOR) -eq $(REQ_VERSION_MAJOR); echo $$?)
> +ifeq ($(SKIP),0)
> +SKIP := $(shell test $(LINUX_VERSION_PATCH) -ge $(REQ_VERSION_PATCH); echo $$?)
> +endif
> +endif
> +
> +else
> +SKIP ?= 0
> +endif
> +
> +endif
> +
> +ifeq ($(SKIP),0)
> +MAKE_TARGETS	+= $(addsuffix .ko, $(MODULE_NAMES))

As Jan pointed out, it will be a bit more complicated here. If the
module build fails, we need to skip it in the install phase as well.

So here we sould add special case if the make target is install and if
the module does not exists do not add it to MAKE_TARGETS...

> +endif
> +
> +# Ignoring the exit status of commands is done to be forward compatible with
> +# kernel internal API changes. The user-space test will return TCONF, if it
> +# doesn't find the module (i.e. it wasn't built either due to kernel-devel
> +# missing or module build failure).
> +%.ko: %.c
> +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> +	-rm -rf *.mod.c *.o modules.order .tmp* .*.ko .*.cmd Module.symvers
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +endif

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
