Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NLXfQ-0001De-3a
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 07:54:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLXfI-0003Ek-J6
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 07:54:28 +0000
Date: Fri, 18 Dec 2009 02:54:13 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1512172575.560341261122853904.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <451745090.560321261122821966.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22437_1287532421.1261122853903"
Subject: Re: [LTP] Build error of "regress.c"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

------=_Part_22437_1287532421.1261122853903
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



----- "Mitani" <mitani@ryobi.co.jp> wrote:

> Hi,
> 
> I ran "make" with "ltp-2009-12-16" and "ltp-2009-12-18" cvs, 
> but it failed:


I met same problem. try this patch.

Thanks,
Caspar

> ------------
> [...]
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall 
> -I../../../include
> -I../../../include
>   -L../../../lib
> -L/home/mitani/LTP/ltp-2009-12-18/testcases/kernel/syscalls/libevent/lib
>  libevent/test/regress.c  -levent -o libevent/test/regress
> libevent/test/regress.c:44:19: error: event.h: No such file or
> directory
> libevent/test/regress.c: In function 'simple_read_cb':
> libevent/test/regress.c:69: warning: implicit declaration of function
> 'event_add'
> libevent/test/regress.c: In function 'multiple_write_cb':
> libevent/test/regress.c:100: warning: implicit declaration of
> function
> 'event_del'
> libevent/test/regress.c: In function 'signal_cb':
> libevent/test/regress.c:159: warning: implicit declaration of
> function
> 'signal_del'
> libevent/test/regress.c: At top level:
> libevent/test/regress.c:164: error: field 'ev' has incomplete type
> [...]
> libevent/test/regress.c:455: warning: implicit declaration of
> function
> 'bufferevent_write'
> libevent/test/regress.c:459: warning: implicit declaration of
> function
> 'bufferevent_free'
> libevent/test/regress.c: In function 'main':
> libevent/test/regress.c:473: warning: implicit declaration of
> function
> 'event_init'
> make[3]: *** [libevent/test/regress] Error 1
> make[3]: Leaving directory
> `/home/mitani/LTP/ltp-2009-12-18/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> [...]
> ------------
> 
> "regress.c" was not compiled before "ltp-2009-12-15" cvs.
> It seems to have been compiled after "ltp-2009-12-16" cvs 
> for the first time.
> 
> 
> The results of "make" are various by environment as follows:
> 
>   (1) RHEL5.4(2.6.18-164.el5) x86    : succeeded
>   (2) RHEL5.4(2.6.18-164.el5) x86_64 : failed
>   (3) RHEL5.4(2.6.18-164.el5) ia64   : failed
>   (4) RHEL4.8(2.6.9-89.ELsmp) x86    : succeeded
> 
> There is "/usr/local/include/event.h" file in the successful system.
> There is not "/usr/local/include/event.h" file in the failed system.
> 
> "/usr/local/include/event.h" file completely accords with 
> "${LTPROOT}/testcases/kernel/syscalls/libevent/event.h" file.
> I think that "${LTPROOT}/testcases/kernel/syscalls/libevent/event.h"
> copied to "/usr/local/include/event.h" when installed.
> 
> However, depending on system, there seems to be the case that 
> this file isn't copied.
> 
> 
> ---
> 
> Instead of "/usr/local/include/event.h", I installed "libevent-devel"
> (libevent-devel-1.1a-3.2.1.x86_64.rpm) to above (2) system.
> Then "/usr/include/event.h" file was installed.
> This "/usr/include/event.h" file does not completely accord with
> "/usr/local/include/event.h".
> But after that, "make" succeeded.
> 
> I don't think that this measure is right. This is the wrong way, I
> think.
> Because, I judge that LTP is going to copy a
> "/usr/local/include/event.h"
> file by oneself.
> 
> 
> 
> Thank you--
> 
> -Tomonori Mitani
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast
> and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------=_Part_22437_1287532421.1261122853903
Content-Type: text/x-patch; name=syscalls-libevent01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=syscalls-libevent01.patch

diff --git a/runtest/syscalls b/runtest/syscalls
index 2acb906..755306a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -465,7 +465,7 @@ lchown01_16 lchown01_16
 lchown02 prep_create_link; lchown02
 lchown02_16 prep_create_link; lchown02_16
 
-libevent01 export LTPROOT; run_libevent.sh
+libevent01 export LTPROOT; $LTPROOT/testcases/bin/libevent/run_libevent.sh
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/testcases/kernel/syscalls/Makefile b/testcases/kernel/syscalls/Makefile
index 34ba9dc..695a0c3 100644
--- a/testcases/kernel/syscalls/Makefile
+++ b/testcases/kernel/syscalls/Makefile
@@ -29,36 +29,37 @@ FILTER_OUT_DIRS		:= libevent
 # pcllib is busted as all heck because of libtool
 FILTER_OUT_DIRS		+= pcllib
 
-# libevent doesn't compile right now... I have no bloody clue what breaks it
-# when doing make clean...
-ifdef DO_NO_COMPILE_ME
 ifeq ($(wildcard $(abs_srcdir)/libevent/test/Makefile),)
 $(warning libevent/test/Makefile does not exist; skipping to avoid compile errors)
 $(warning Please run "make autotools" and "configure" at the top-level LTP)
 $(warning directory if you want to run this test)
 else
 
-LIBEVENT		:= libevent/lib/libevent.a
-
-LIBEVENT_LINK		:= libevent/libevent.a
+LIBEVENT		:= libevent/libevent.a
 
 CLEAN_DEPS		:= libevent-clean
 
-CLEAN_TARGETS		:= $(LIBEVENT) $(LIBEVENT_LINK)
+CLEAN_TARGETS		:= $(LIBEVENT)
 
 INSTALL_DEPS		:= libevent-install
 
-INSTALL_TARGETS		:= libevent/run-libevent.sh libevent/test/test-libevent.sh
+INSTALL_TARGETS		:= libevent/run_libevent.sh libevent/test/test-libevent.sh
 
 LIBEVENT_APPS		:= regress test-eof test-init test-time test-weof
 
+TEST_APPS		:= $(addprefix libevent/test/,$(LIBEVENT_APPS))
+
 MAKE_DEPS		:= libevent-all
 
-MAKE_TARGETS		:= $(addprefix libevent/test/,$(LIBEVENT_APPS))
+MAKE_TARGETS		+= $(TEST_APPS)
 
 libevent libevent/test: %:
 	mkdir -p "$@"
 
+$(TEST_APPS): LDFLAGS += -L$(abs_builddir)/libevent
+$(TEST_APPS): LDLIBS += -levent
+$(TEST_APPS): CPPFLAGS += -I$(abs_builddir)/libevent			   
+
 $(LIBEVENT): $(abs_srcdir)/libevent/Makefile libevent
 	$(MAKE) -C libevent -f "$(firstword $^)" libevent.a
 
@@ -69,7 +70,6 @@ libevent-clean libevent-install: libevent-%: $(abs_srcdir)/libevent/test/Makefil
 	$(MAKE) -C libevent/test -f "$(firstword $^)" $*
 
 endif
-endif
 
 ifeq ($(UCLINUX),1)
 FILTER_OUT_DIRS	+= capget capset chmod chown clone fork getcontext llseek \
--- a/testcases/kernel/syscalls/libevent/run_libevent.sh	2009-11-20 03:08:36.000000000 +0800
+++ b/testcases/kernel/syscalls/libevent/run_libevent.sh	2009-12-15 16:55:12.750261436 +0800
@@ -31,7 +31,7 @@
 	tst_resm TCONF "You need to be root to run these tests"
 	TST_EXIT=0
 else
-	"$LTPROOT/testcases/bin/tests/test-libevent.sh"
+	"$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
 	TST_EXIT=$?
 fi
 tst_cleanup

------=_Part_22437_1287532421.1261122853903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
------=_Part_22437_1287532421.1261122853903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_22437_1287532421.1261122853903--

