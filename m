Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQffN-0000jg-7g
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 15:45:45 +0000
Date: Mon, 30 Sep 2013 17:46:08 +0200
From: chrubis@suse.cz
Message-ID: <20130930154608.GA5370@rei.suse.cz>
References: <1379676132-23574-1-git-send-email-alexey.kodanev@oracle.com>
	<20130925170241.GA7024@rei> <52497EF2.50204@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52497EF2.50204@oracle.com>
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> Makefile example:
> >>
> >> top_srcdir	?= ../../../..
> >>
> >> include $(top_srcdir)/include/mk/testcases.mk
> >>
> >> REQ_VERSION_MAJOR	:= 2
> >> REQ_VERSION_PATCH	:= 6
> >>
> >> MODULE_NAMES	:= Module01 Module02 ...
> >> MAKE_TARGETS	:= test01 test02 ...
> >>
> >> include $(top_srcdir)/include/mk/module.mk
> >> include $(top_srcdir)/include/mk/generic_leaf_target.mk
>
> I redefine top_srcdir to make it absolute because when "make" cd to 
> kernel build directory and once again include LTP Makefile, the first 
> include of env_pre.mk leads to non-existed file and kernel build stops 
> with error. If top_srcdir absolute, no include errors in the kernel build.
> 
> Actually we don't need this include of env_pre.mk in the kernel build 
> system because it does nothing with the module build and usually it 
> accomplished with the KERNELRELEASE variable or separate kbuild file. 
> But to preserve the LTP Makefile API and also have a chance to build 
> user-space tests, we include it and tell kernel build system that this 
> one have already been loaded (exporting ENV_PRE_LOAD).

Hmm, I think that it may be more clear to put the linux kernel Makefile
part to the Makefile that is in the test directory, so that it will
became:

ifneq ($(KERNELRELEASE),)

obj-m := $(addsuffix .o, $(MODULE_NAMES))

else

top_srcdir ?= ../../../..

include $(top_srcdir)/include/mk/testcases.mk

REQ_VERSION_MAJOR  := 2
REQ_VERSION_PATCH  := 6
MAKE_TARGETS       := test01 test02 ...

include $(top_srcdir)/include/mk/module.mk
include $(top_srcdir)/include/mk/generic_leaf_target.mk

endif

Which moves all the common code into module.mk and just leaves the
kernel recipe in the particular Makefile. That should guarantee that the
LTP build system and kernel build system stay separated and won't
interact. What do you think?

Or to use Kbuild file which should be preffered over Makefile,
unfortunately the documentation does not say which kernel version gets
the support for Kbuild for extrenal modules, so if it's a recent feature
we must go with the Makefile.

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
