From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Mar 2019 15:53:01 -0400 (EDT)
Subject: [LTP] Travis failures
In-Reply-To: <20190318175549.GB3892@dell5510>
References: <20190318175549.GB3892@dell5510>
Message-ID: <806790692.10036950.1552938781363.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Cyril,
> 
> quite often I see in my travis builds liblitpnuma.a related failures [1] (one
> random out-of-tree build), which gets fixed by restarting it. Any idea why?

Looks like when it gets built via ./libs it works, but if it's pulled
as dependency first, it fails:

# make -C $(pwd)/../ltp-build/testcases/kernel/syscalls/set_mempolicy/ -f $(pwd)/testcases/kernel/syscalls/set_mempolicy/Makefile top_srcdir=$(pwd) top_builddir=$(pwd)/../ltp-build
make: Entering directory `/root/ltp-build/testcases/kernel/syscalls/set_mempolicy'
make -C "/root/ltp-build/libs/libltpnuma" -f "/root/ltp-build/libs/libltpnuma/Makefile" all
make[1]: Entering directory `/root/ltp-build/libs/libltpnuma'
make[1]: /root/ltp-build/libs/libltpnuma/Makefile: No such file or directory
make[1]: *** No rule to make target `/root/ltp-build/libs/libltpnuma/Makefile'.  Stop.
make[1]: Leaving directory `/root/ltp-build/libs/libltpnuma'
make: *** [/root/ltp-build/libs/libltpnuma/libltpnuma.a] Error 2
make: Leaving directory `/root/ltp-build/testcases/kernel/syscalls/set_mempolicy'

Maybe something like this to fix it?

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 131854e..55cf4da 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -43,13 +43,13 @@ LDLIBS              += -lltp

 ifdef LTPLIBS

-LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/lib, $(LTPLIBS))
+LTPLIBS_DIRS = $(LTPLIBS)
 LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),lib$(LIB)/lib$(LIB))))

 MAKE_DEPS += $(LTPLIBS_FILES)

 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
-       $(MAKE) -C "$^" -f "$^/Makefile" all
+       $(MAKE) -C "$(addprefix $(abs_top_builddir)/libs/lib, $^)" -f "$(addprefix $(abs_top_srcdir)/libs/lib, $^)/Makefile" all

 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))


> 
> Kind regards,
> Petr
> 
> make[4]: Leaving directory
> '/usr/src/ltp-build/testcases/kernel/syscalls/splice'
> make[4]: Entering directory
> '/usr/src/ltp-build/testcases/kernel/syscalls/set_mempolicy'
> make -C "/usr/src/ltp-build/libs/libltpnuma" -f
> "/usr/src/ltp-build/libs/libltpnuma/Makefile" all
> make[5]: Entering directory '/usr/src/ltp-build/libs/libltpnuma'
> make[5]: /usr/src/ltp-build/libs/libltpnuma/Makefile: No such file or
> directory
> make[5]: *** No rule to make target
> '/usr/src/ltp-build/libs/libltpnuma/Makefile'.  Stop.
> make[5]: Leaving directory '/usr/src/ltp-build/libs/libltpnuma'
> /usr/src/ltp/include/mk/testcases.mk:52: recipe for target
> '/usr/src/ltp-build/libs/libltpnuma/libltpnuma.a' failed
> make[4]: *** [/usr/src/ltp-build/libs/libltpnuma/libltpnuma.a] Error 2
> make[4]: Leaving directory
> '/usr/src/ltp-build/testcases/kernel/syscalls/set_mempolicy'
> /usr/src/ltp/include/mk/generic_trunk_target.inc:93: recipe for target 'all'
> failed
> make[3]: *** [all] Error 2
> make[3]: Leaving directory '/usr/src/ltp-build/testcases/kernel/syscalls'
> /usr/src/ltp/include/mk/generic_trunk_target.inc:93: recipe for target 'all'
> failed
> make[2]: *** [all] Error 2
> make[2]: Leaving directory '/usr/src/ltp-build/testcases/kernel'
> /usr/src/ltp/include/mk/generic_trunk_target.inc:93: recipe for target 'all'
> failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory '/usr/src/ltp-build/testcases'
> /usr/src/ltp/Makefile:119: recipe for target 'testcases-all' failed
> make: *** [testcases-all] Error 2
> make: Leaving directory '/usr/src/ltp-build'
> 
> [1] https://api.travis-ci.org/v3/job/507981762/log.txt
> 
