From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 12:10:47 +0530
Subject: [LTP] [PATCH V2 3/5] syscalls: semctl: Add new test to verify
 the _time_high fields
In-Reply-To: <20200615133125.GC25279@yuki.lan>
References: <5d502fbc7070644ed83c423713941b457c3a7aff.1590057824.git.viresh.kumar@linaro.org>
 <7d7363384b5719fa48a5a5ba71b0aa581ebc91bd.1590131635.git.viresh.kumar@linaro.org>
 <20200615133125.GC25279@yuki.lan>
Message-ID: <20200616064047.7njwpmlmxzyoikwo@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15-06-20, 15:31, Cyril Hrubis wrote:
> > diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
> > index aa211d37f8ee..150f581825c5 100644
> > --- a/testcases/kernel/syscalls/ipc/semctl/Makefile
> > +++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
> > @@ -5,7 +5,10 @@ top_srcdir              ?= ../../../../..
> >  
> >  include $(top_srcdir)/include/mk/testcases.mk
> >  
> > -LDLIBS  += -lltpipc
> > +semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LDLIBS += -lltpipc
> > +semctl08: LDLIBS += -lltpnewipc
> > +
> >  LDFLAGS += -L$(top_builddir)/libs/libltpipc
> > +LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
> 
> This does not apply anymore after my fix. This should be:
> 
> LTPLIBS = ltpipc ltpnewipc
> 
> Which would add a dependency on these libraries in the build system and
> also append the LDFLAGS, then all we need to do is to add the LDLIBS.

diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index 6895fb1967a1..d7002872ab42 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -3,7 +3,7 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
@@ -11,4 +11,4 @@ semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LDLIBS += -lltpi
 semctl08: LDLIBS += -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-LDFLAGS += -L$(top_builddir)/libs/libltpnewipc

This doesn't build for some reason.

make -C "/mnt/ssd/all/work/repos/tools/ltp/libs/libltpipc /mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc" -f "/mnt/ssd/all/work/repos/tools/ltp/libs/libltpipc /mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc/Makefile" all
make[1]: *** /mnt/ssd/all/work/repos/tools/ltp/libs/libltpipc /mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc: No such file or directory.  Stop.
../../../../../include/mk/testcases.mk:52: recipe for target '/mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc/libltpnewipc.a' failed
make: *** [/mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc/libltpnewipc.a] Error 2

-- 
viresh
