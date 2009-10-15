Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MyVmM-0003yu-Ro
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 19:14:26 +0000
Date: Thu, 15 Oct 2009 21:14:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091015191417.GA791@schrodinger.suse.cz>
References: <20091014115618.7801.69877.sendpatchset@subratamodak.linux.ibm.com>
	<20091015162356.GB4152@schrodinger.suse.cz>
	<20091015173026.GA25999@schrodinger.suse.cz>
	<364299f40910151155x646bcf38naa53e5af4aad75b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <364299f40910151155x646bcf38naa53e5af4aad75b3@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Re: compile fails for libcpuset.c on
	SLES-11	s390x with ltp-full-20090930
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>, Mark Ver <markver@us.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
>     This logic is covered in include/mk/testcases.mk as follows:
> 
> include $(top_srcdir)/include/mk/env_pre.mk
> 
> # For linux_syscall_numbers.h
> CPPFLAGS                += -I$(abs_top_builddir)/testcases/kernel/include
> 
> INSTALL_DIR             := testcases/bin
> 
> LDLIBS                  += -lltp
> 
>     There's no reason why we have to go back to the hackish Makefile's
> -- we can just include testcases.mk if it's not included already (I
> admit, a smallhandful of testcases/... Makefile's didn't do this, but
> I did this on need-to-have basis).

I still would rather have one place to store all commonly used headers eg.
$(topdir)/include. And stroring makefile "libraries" in $(topdir)/include/mk/
is IMHO not cleanest solution, may be it sould have it's onw directory in
$(topdir).

Anyway fixed patch attached.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--Kj7319i9nmIyA2yE
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="get_set_memopolicy_syscall_missing.patch"

Index: delme/testcases/kernel/include/powerpc.in
===================================================================
--- delme.orig/testcases/kernel/include/powerpc.in
+++ delme/testcases/kernel/include/powerpc.in
@@ -3,6 +3,8 @@ timer_settime 241
 timer_delete 244
 clock_settime 245
 clock_gettime 246
+get_mempolicy 260
+set_mempolicy 261
 splice 283
 tee 284
 vmsplice 285
Index: delme/testcases/kernel/include/powerpc64.in
===================================================================
--- delme.orig/testcases/kernel/include/powerpc64.in
+++ delme/testcases/kernel/include/powerpc64.in
@@ -3,6 +3,8 @@ timer_settime 241
 timer_delete 244
 clock_settime 245
 clock_gettime 246
+get_mempolicy 260
+set_mempolicy 261
 splice 283
 tee 284
 vmsplice 285
Index: delme/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
===================================================================
--- delme.orig/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ delme/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -48,6 +48,9 @@
 #include "cpuset.h"
 #include "common.h"
 
+#include "test.h"
+#include "linux_syscall_numbers.h"
+
 /* Bump version, and update Change History, when libcpuset API changes */
 #define CPUSET_VERSION 3
 
Index: delme/testcases/kernel/include/s390x.in
===================================================================
--- delme.orig/testcases/kernel/include/s390x.in
+++ delme/testcases/kernel/include/s390x.in
@@ -1,3 +1,5 @@
+get_mempolicy 269
+set_mempolicy 270
 openat 288
 mkdirat (__NR_openat + 1)
 mknodat (__NR_openat + 2)
Index: delme/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
===================================================================
--- delme.orig/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
+++ delme/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
@@ -18,11 +18,12 @@
 #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 # Garrett Cooper, July 2009
+# Cyril Hrubis, October 2009
 #
 
 top_srcdir 		?= ../../../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS			+= -lm -lcontrollers
 

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Kj7319i9nmIyA2yE--

