Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NLbB7-0007hf-Eg
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 11:39:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLbB1-0006lx-0f
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 11:39:25 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBIBdDuZ022746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Dec 2009 06:39:13 -0500
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id nBIBdDFV008011
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Dec 2009 06:39:13 -0500
Date: Fri, 18 Dec 2009 06:39:13 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <76281794.565171261136353220.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <272150129.565151261136307450.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22565_1637178922.1261136353212"
Subject: [LTP] [PATCH] fix lib-not-found error when compile for the second
	time
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
To: ltp-list@lists.sourceforge.net

------=_Part_22565_1637178922.1261136353212
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all, I meet a problem, if I compile and install ltp for the first time,
ltp can pass the compilation, but if I don't delete installation direcotry
(originally been /opt/ltp) and try to build ltp for the second time in=20
another ltp source folder, ltp failes in compiling:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases/k=
ernel/include
-I/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases/k=
ernel/controllers/cpuctl/../libcontrollers
-I../../../../include -I../../../../include
-L/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases/k=
ernel/controllers/cpuctl/../libcontrollers
-L../../../../lib  cpuctl_def_task01.c   -lltp -lm -lcontrollers -o
cpuctl_def_task01
cpuctl_def_task01.c: In function =E2=80=98main=E2=80=99:
cpuctl_def_task01.c:90: warning: =E2=80=98num_cpus=E2=80=99 may be used uni=
nitialized in
this function
cpuctl_def_task01.c:90: warning: =E2=80=98test_num=E2=80=99 may be used uni=
nitialized in
this function
cpuctl_def_task01.c:94: warning: =E2=80=98my_group_num=E2=80=99 may be used
uninitialized in this function
/usr/bin/ld: cannot find -lcontrollers
collect2: ld returned 1 exit status
make[5]: *** [cpuctl_def_task01] Error 1
make[5]: Leaving directory
`/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases/ke=
rnel/controllers/cpuctl'
make[4]: *** [all] Error 2
make[4]: Leaving directory
`/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases/ke=
rnel/controllers'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases/ke=
rnel'
make[2]: *** [all] Error 2
make[2]: Leaving directory
`/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases'
make[1]: *** [testcases-all] Error 2
make[1]: Leaving directory
`/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130'
make: *** [build] Error 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After investigating, I find the key to solve the problem:

Suppose we build ltp to /opt/ltp.

In testcases/kernel/controllers/Makefile[1] and testcases/network/sctp/Make=
file[2],=20
library files which need to be built are defined in /opt/ltp/lib:

LIB=09=09=09:=3D $(DESTDIR)/$(libdir)/libcontrollers.a

when compiling&linking objects in controllers/ subdirs, the LDFLAGS paths a=
re:

-L$(topbuilddir)/testcases/kernel/controllers/libcontrollers
-L../../../../lib (see the error messages above)

/opt/ltp/lib isn't included in LDFLAGS paths here.

The first time when you compile ltp, a libcontrollers.a will be generated
under $(topbuilddir)/testcases/kernel/controllers/libcontrollers, so we can
find libcontrollers.a in LDFLAGS paths and the compilation could still pass=
.
But if you don't delete /opt/ltp and try to build ltp in another source=20
directory, error will occur. Since $(LIB) in Makefile[1] and Makefile[2]=20
are already up-to-date, no libcontrollers.a will be generated in=20
$(topbuilddir)/testcases/kernel/controllers/libcontrollers due to makefile
policy. Thus, ltp can't find libcontrollers.a in LDFLAGS paths.

So we can fix this problem in two ways: add $(DESTDIR)/$(libdir)/lib to=20
LDFLAGS or change $(LIB) paths in Makefile[1] and Makefile[2]. Find details
in my attachments.

Thanks,
Caspar

------=_Part_22565_1637178922.1261136353212
Content-Type: application/octet-stream; name=lib-not-found-compile-err.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lib-not-found-compile-err.patch

diff -Naur a/include/mk/env_post.mk b/include/mk/env_post.mk
--- a/include/mk/env_post.mk	2009-11-30 21:50:48.000000000 +0800
+++ b/include/mk/env_post.mk	2009-12-18 18:57:44.085074045 +0800
@@ -35,7 +35,7 @@
 # For config.h, et all.
 CPPFLAGS			+= -I$(top_srcdir)/include -I$(top_builddir)/include
 
-LDFLAGS				+= -L$(top_builddir)/lib
+LDFLAGS				+= -L$(top_builddir)/lib -L$(DESTDIR)/$(libdir)
 
 MAKE_TARGETS			?= $(notdir $(patsubst %.c,%,$(wildcard $(abs_srcdir)/*.c)))
 

------=_Part_22565_1637178922.1261136353212
Content-Type: application/octet-stream; name=lib-not-found-compile-err2.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lib-not-found-compile-err2.patch

diff -Naur a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
--- a/testcases/kernel/controllers/Makefile	2009-10-10 01:55:46.000000000 +0800
+++ b/testcases/kernel/controllers/Makefile	2009-12-18 18:21:07.328136826 +0800
@@ -25,8 +25,8 @@
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= *.sh
-LIB			:= $(DESTDIR)/$(libdir)/libcontrollers.a
 LIBDIR			:= libcontrollers
+LIB 			:= $(LIBDIR)/libcontrollers.a
 FILTER_OUT_DIRS		:= $(LIBDIR)
 
 $(LIBDIR):
diff -Naur a/testcases/network/sctp/Makefile b/testcases/network/sctp/Makefile
--- a/testcases/network/sctp/Makefile	2009-10-10 01:56:05.000000000 +0800
+++ b/testcases/network/sctp/Makefile	2009-12-18 18:23:23.955198972 +0800
@@ -24,10 +24,10 @@
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-LIBSCTP			:= $(DESTDIR)/$(libdir)/libsctp.a
-LIBSCTPUTIL		:= $(DESTDIR)/$(libdir)/libsctputil.a
 LIBSCTPDIR		:= lib
 LIBSCTPUTILDIR		:= testlib
+LIBSCTP			:= $(LIBSCTPDIR)/libsctp.a
+LIBSCTPUTIL		:= $(LIBSCTPUTILDIR)/libsctputil.a
 
 FILTER_OUT_DIRS		:= $(LIBSCTPDIR) $(LIBSCTPUTILDIR)
 

------=_Part_22565_1637178922.1261136353212
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
------=_Part_22565_1637178922.1261136353212
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_22565_1637178922.1261136353212--

