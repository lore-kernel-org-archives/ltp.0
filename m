From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 May 2018 12:41:48 +0200
Subject: [LTP] How to build LTP for a kernel different than the one on
 the building machine?
In-Reply-To: <F8498D2F03F2CF40823E11B9D93AD69F3A4DB1DF@SHSMSX101.ccr.corp.intel.com>
References: <F8498D2F03F2CF40823E11B9D93AD69F3A4DB1DF@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20180515104148.GC7220@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm trying to run LTP in my test environment, after some investigation
> I've one question on the building processes of LTP. When building some
> of the test cases binary, it need to access the kernel header, some of
> which may changes between different kernel version. So is there a way
> to build LTP on the building machine with kernel, say v4.14, for a
> test machine with test target v4.16? 

Pointing the LINUX_DIR to a directory with v4.14 compiled kernel should
work, the LTP build system would make use of the kernel build system to
build the modules for us.

However most of the modules we have in LTP tend to fail to compile on
newer kernels, which is ignored by the build system. The problem is that
kernel API changes quite often and we fail to keep up with that.

> In the configure file I see below line about "--with-linux-dir" and "LINUX_DIR":
> 6280 # Check whether --with-linux-dir was given.
> 6281 if test "${with_linux_dir+set}" = set; then :
> 6282   withval=$with_linux_dir; LINUX_DIR="${withval}"
> 6283 else
> 6284   if test -n "$LINUX_VERSION"; then :
> 6285   LINUX_DIR="/lib/modules/$LINUX_VERSION/build"
> 6286 fi
> 6287 fi
> 
> And "LINUX_DIR" is used in and only in "include/mk/module.mk":
> 56 %.ko: %.c .dep_modules ;
> 57
> 58 .dep_modules: $(MODULE_SOURCES)
> 59     @echo "Building modules: $(MODULE_SOURCES)"
> 60     -$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> 61     rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
> 62     @touch .dep_modules
> 
> So the question is, beside kernel module, is there any other cases
> also need kernel headers?

I doubt so.

> If there is, or I want to add some cases which is sensitive to kernel
> header version, how should I create a Makefile for that? And how
> should I build such a test binary when the building machine has a
> kernel version different than the test machine?

That depends on what you are trying to do, generally we do prefer
runtime detection whenever possible.

Can you explain what kind of test are trying to develop?

-- 
Cyril Hrubis
chrubis@suse.cz
