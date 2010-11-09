Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PFdCy-0004Gd-Ue
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 01:41:12 +0000
Received: from out08.sjc.mx.trendmicro.com ([216.99.131.45])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PFdCw-0008WT-05
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 01:41:12 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <Act3O838preomyfuTIOsmPN0ITLHHQ==>	<000001cb773b$ce4f9950$6aeecbf0$@co.jp>
	<AANLkTinebjz8OJ+7ajN3W5-EqW54SYUMYBF5J6OxnGvc@mail.gmail.com>
In-Reply-To: <AANLkTinebjz8OJ+7ajN3W5-EqW54SYUMYBF5J6OxnGvc@mail.gmail.com>
Date: Tue, 9 Nov 2010 10:41:00 +0900
Message-ID: <000601cb7faf$2975a010$7c60e030$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] About "realtime" build failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, November 09, 2010 6:51 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About "realtime" build failure
> =

> On Fri, Oct 29, 2010 at 12:35 AM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> > I applied patches which are the effort of various people.
> > And I could overcome configuration error and keyctl01's build error.
> > (Thanks!!)
> > After that, librttest.c build failed:
> > ------------
> > make[3]: Leaving directory
> > `/home/LTP/ltp-dev-20101028/testcases/network/xinetd'
> > make[2]: Leaving directory
> `/home/LTP/ltp-dev-20101028/testcases/network'
> > make[2]: Entering directory
> `/home/LTP/ltp-dev-20101028/testcases/realtime'
> > make -C lib -f
> "/home/LTP/ltp-dev-20101028/testcases/realtime/lib/Makefile"
> > all
> > make[3]: Entering directory
> > `/home/LTP/ltp-dev-20101028/testcases/realtime/lib'
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
> > -I/home/LTP/ltp-dev-20101028/testcases/realtime/lib/../include
> > -I../../../include -I../../../include =A0-c -o librttest.o
> librttest.c
> > librttest.c: In function `init_pi_mutex':
> > librttest.c:569: warning: implicit declaration of function
> > `pthread_mutexattr_setprotocol'
> > librttest.c:569: error: `PTHREAD_PRIO_INHERIT' undeclared (first
> use in this
> > function)
> > librttest.c:569: error: (Each undeclared identifier is reported only
> once
> > librttest.c:569: error: for each function it appears in.)
> > librttest.c:572: warning: implicit declaration of function
> > `pthread_mutexattr_getprotocol'
> > make[3]: *** [librttest.o] Error 1
> > make[3]: Leaving directory
> > `/home/LTP/ltp-dev-20101028/testcases/realtime/lib'
> > make[2]: *** [lib/librealtime.a] Error 2
> > make[2]: Leaving directory
> `/home/LTP/ltp-dev-20101028/testcases/realtime'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases'
> > make: *** [testcases-all] Error 2
> > ------------
> >
> > "realtime" became to be build by the patch of Makefile:
> > ------------
> > --- a/testcases/Makefile
> > +++ b/testcases/Makefile
> > =A0@@ -38,7 +38,12 @@ FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D b=
allista
> kdump mce-test
> > open% pounder21
> > =A0# XXX (garrcoop): kdump was in this list.
> > =A0# XXX (garrcoop): open_hpi_testsuite was in this list.
> > =A0ifeq ($(UCLINUX),1)
> > =A0-FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D DOTS realtime
> > =A0+FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D realtime
> > =A0+endif
> > =A0+
> > =A0+# DOTS requires javac
> > =A0+ifeq ($(strip $(JAVAC)),)
> > =A0+FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D DOTS
> > =A0endif
> >
> > =A0#
> > ------------
> >
> > "realtime" added to build.
> > Perhaps this revision caused this failure, I think.
> =

>     DOTS is garbage, bitrotted code. If no one has any opposes the
> change, then I'll remove it from LTP in 3 days time.
> Thanks,
> -Garrett



Make error occured in my environment with recent git "ltp-aa8f37a.tar.gz".

RHEL5.5 --- x86 / x86_64 / ia64
RHEL4.8 --- x86 / x86_64 / ia64

------------<RHEL4.8 - x86>
make -C "testcases" \
	-f "/home/LTP/ltp-dev-20101108/testcases/Makefile" all
make[1]: Entering directory `/home/LTP/ltp-dev-20101108/testcases'
make[2]: Entering directory `/home/LTP/ltp-dev-20101108/testcases/DOTS'
cd src;make
make[3]: Entering directory `/home/LTP/ltp-dev-20101108/testcases/DOTS/src'
mkdir -p ../classes/dots/framework
cd dots/framework; make
make[4]: Entering directory
`/home/LTP/ltp-dev-20101108/testcases/DOTS/src/dots/framework'
javac -d ../../../classes -classpath ../../../classes DotsConfig.java
make[4]: javac: Command not found
make[4]: *** [all] Error 127
make[4]: Leaving directory
`/home/LTP/ltp-dev-20101108/testcases/DOTS/src/dots/framework'
make[3]: *** [framework] Error 2
make[3]: Leaving directory `/home/LTP/ltp-dev-20101108/testcases/DOTS/src'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-dev-20101108/testcases/DOTS'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-dev-20101108/testcases'
make: *** [testcases-all] Error 2
------------

------------<RHEL5.5 - x86>
make -C lib -f "/home/LTP/ltp-dev-20101108/testcases/realtime/lib/Makefile"
all
make[3]: Entering directory
`/home/LTP/ltp-dev-20101108/testcases/realtime/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101108/testcases/realtime/lib/../include
-I../../../include -I../../../include  -c -o librttest.o librttest.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101108/testcases/realtime/lib/../include
-I../../../include -I../../../include  -c -o libstats.o libstats.c
if [ -z "librttest.o libstats.o" ] ; then \
		echo "Cowardly refusing to create empty archive"; \
		exit 1; \
	fi
ar -rc "librealtime.a" librttest.o libstats.o
ranlib "librealtime.a"
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101108/testcases/realtime/lib'
make[3]: Entering directory
`/home/LTP/ltp-dev-20101108/testcases/realtime/func'
make[4]: Entering directory
`/home/LTP/ltp-dev-20101108/testcases/realtime/func/async_handler'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101108/testcases/realtime/include
-I../../../../include -I../../../../include
-L/home/LTP/ltp-dev-20101108/testcases/realtime/lib -L../../../../lib
async_handler.c   -lrealtime -lpthread -lrt -lm -o async_handler
/home/LTP/ltp-dev-20101108/testcases/realtime/lib/librealtime.a(librttest.o)
: In function `atomic_add':
/home/LTP/ltp-dev-20101108/testcases/realtime/lib/../include/librttest.h:117
: undefined reference to `__sync_add_and_fetch_4'
collect2: ld returned 1 exit status
make[4]: *** [async_handler] Error 1
make[4]: Leaving directory
`/home/LTP/ltp-dev-20101108/testcases/realtime/func/async_handler'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101108/testcases/realtime/func'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-dev-20101108/testcases/realtime'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-dev-20101108/testcases'
make: *** [testcases-all] Error 2
------------

"DOTS" and "realtime" make failed in above log.


I looked for difference between The "Makefile" of old git
(ltp-7e2cbbd.tar.gz) =

and "Makefile" of recent git (ltp-aa8f37a.tar.gz):
------------
[root@RHEL48-LTP-x86 LTP]# diff -u ltp-dev-20101026/testcases/Makefile
ltp-dev-20101108/testcases/Makefile
--- ltp-dev-20101026/testcases/Makefile 2010-10-26 16:27:34.000000000 +0900
+++ ltp-dev-20101108/testcases/Makefile 2010-11-09 06:52:31.000000000 +0900
@@ -27,7 +27,8 @@
 # XXX (garrcoop):
 # 1. ballista is broken (working on it).
 # 2. kdump shouldn't be compiled by default, because it's runtime based and
-#    WILL crash the build host (the tests need to be fixed to just build,
not run).
+#    WILL crash the build host (the tests need to be fixed to just build,
not
+#    run).
 # 3. mce-test doesn't fit cleanly in the build, yet.
 # 4. pounder21 is just broken.
 FILTER_OUT_DIRS                :=3D ballista kdump mce-test open% pounder21
@@ -36,8 +37,13 @@
 # original list of disabled items...
 # XXX (garrcoop): kdump was in this list.
 # XXX (garrcoop): open_hpi_testsuite was in this list.
-ifneq ($(UCLINUX),1)
-FILTER_OUT_DIRS                +=3D audit-test DOTS realtime
+ifeq ($(UCLINUX),1)
+FILTER_OUT_DIRS                +=3D realtime
+endif
+
+# DOTS requires javac
+ifeq ($(strip $(JAVAC)),)
+FILTER_OUT_DIRS                +=3D DOTS
 endif

 #
[root@RHEL48-LTP-x86 LTP]#
------------

I tried to make the recent git with the old git's "Makefile".
And it succeeded.

>    DOTS is garbage, bitrotted code. If no one has any opposes the change, =

>then I'll remove it from LTP in 3 days time.

I understand.
How about "realtime"? Is "realtime" test necessary in LTP "run test" ?

If "realtime" is necessary, they need revises.
If it is necessary and prospect to its revise are not in sight, =

it had better to be filtered again, and be removed filtering at revision, =

I think.
Sorry to bother you when you're so busy.


Regards--

-Tomonori Mitani



---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
