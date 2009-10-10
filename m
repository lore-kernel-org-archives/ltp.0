Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MwhKr-0003nR-7w
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 19:10:33 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MwhKq-0006S0-7M
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 19:10:33 +0000
Received: by pxi9 with SMTP id 9so7615542pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 10 Oct 2009 12:10:25 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 10 Oct 2009 12:10:25 -0700
Message-ID: <364299f40910101210p799083ebj993c9a60c22ef195@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Remove testcases/kernel/syscalls/ptrace/simple_tracer
	from the build
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
To: LTP list <ltp-list@lists.sourceforge.net>

Mike added simple_tracer for debugging purposes, but it doesn't
compile by default:

ptrace03.c: In function 'main':
ptrace03.c:182: warning: format '%d' expects type 'int', but argument
3 has type 'long int'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I//scratch/ltp-install6/include -I../../../../include
-L//scratch/ltp-install6/lib   ptrace04.c  -laio -lltp -o ptrace04
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I//scratch/ltp-install6/include -I../../../../include
-L//scratch/ltp-install6/lib   simple_tracer.c  -laio -lltp -o
simple_tracer
In file included from simple_tracer.c:25:
syscalls.h:6:23: error: _syscalls.h: No such file or directory
make[4]: *** [simple_tracer] Error 1
make[4]: Leaving directory
`/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/ptrace'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel/syscalls'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/scratch/ltp-dev2/ltp/testcases'
make: *** [testcases-all] Error 2

After talking to him, he had no intention of it compiling by default:

On Saturday 10 October 2009 02:22:51 Garrett Cooper wrote:
> In file included from simple_tracer.c:25:
> syscalls.h:6:23: error: _syscalls.h: No such file or directory
> make[4]: *** [simple_tracer] Error 1

i know simple_tracer fails without manual intervention, but i didnt think it
was compiled by default.  i guess your new code changes that ?
-mike

So let's remove it from the build.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/syscalls/ptrace/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/ptrace/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- testcases/kernel/syscalls/ptrace/Makefile   9 Oct 2009 17:55:59
-0000       1.7
+++ testcases/kernel/syscalls/ptrace/Makefile   10 Oct 2009 19:09:20 -0000
@@ -20,10 +20,30 @@

 include $(top_srcdir)/include/mk/testcases.mk

-# ptrace06 is a broken test ; it hangs the target consistently, chewing up CPU.
-# See: `Issue 3 - ptrace06 hung for 7 hours' --
+# - ptrace06 is a broken test ; it hangs the target consistently, chewing up
+#   CPU. See: `Issue 3 - ptrace06 hung for 7 hours' --
 # http://sourceforge.net/mailarchive/forum.php?thread_name=364299f40910062300s65c43c93w9cccdfe8835c2334%40mail.gmail.com&forum_name=ltp-list
+# - simple_tracer is a utility that Mike Frysinger added that shouldn't be
+#   compiled by default:
+#
+# gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
+# -I//scratch/ltp-install6/include -I../../../../include
+#  -L//scratch/ltp-install6/lib   simple_tracer.c  -laio -lltp -o
+#  simple_tracer
+#  In file included from simple_tracer.c:25:
+#  syscalls.h:6:23: error: _syscalls.h: No such file or directory
+#  make[4]: *** [simple_tracer] Error 1
+#  make[4]: Leaving directory
+#  `/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/ptrace'
+#  make[3]: *** [all] Error 2
+#  make[3]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel/syscalls'
+#  make[2]: *** [all] Error 2
+#  make[2]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel'
+#  make[1]: *** [all] Error 2
+#  make[1]: Leaving directory `/scratch/ltp-dev2/ltp/testcases'
+#  make: *** [testcases-all] Error 2
+#

-MAKE_TARGETS           := $(filter-out ptrace06,$(patsubst
$(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*.c)))
+MAKE_TARGETS           := $(filter-out ptrace06
simple_tracer,$(patsubst $(abs_srcdir)/%.c,%,$(wildcard
$(abs_srcdir)/*.c)))

 include $(top_srcdir)/include/mk/generic_leaf_target.mk

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
