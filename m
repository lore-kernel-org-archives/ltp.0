Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PrQFV-0002DT-J7
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 07:32:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PrQFU-0006bm-7e
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 07:32:01 +0000
Date: Mon, 21 Feb 2011 15:35:48 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110221073548.GD2904@hpt.nay.redhat.com>
References: <20110210085232.GA9285@hpt.nay.redhat.com>
	<AANLkTimk_+8o+QQdjzweLmhB=qzzO2TGYADmEuBQtZom@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <AANLkTimk_+8o+QQdjzweLmhB=qzzO2TGYADmEuBQtZom@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix build of cpuset_syscall_test
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
Cc: ltp-list@lists.sourceforge.net


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id
	p1L7VrT2028503

Sorry for the delay. Attachment is the updated patch.

Thanks.
> > Signed-off-by: Han Pingtian <phan@redhat.com>
> > ---
> > =A0.../cpuset/cpuset_syscall_test/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 ++
> > =A01 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/=
Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefi=
le
> > index edc6265..17331fb 100644
> > --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefil=
e
> > +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefil=
e
> > @@ -25,3 +25,5 @@ top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../..=
/../..
> > =A0include $(top_srcdir)/include/mk/testcases.mk
> > =A0include $(abs_srcdir)/../Makefile.inc
> > =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > +
> > +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D $(NUMA_LIBS)
> > --
>=20
> For consistency this should be placed before generic_leaf_target.mk
> Thanks,
> -Garrett
>=20
--=20
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-build-of-cpuset_syscall_test.patch"

From d5b38cc7013a7a5e9bfec198efaa1b7a026dc2c9 Mon Sep 17 00:00:00 2001
From: Han Pingtian <phan@redhat.com>
Date: Thu, 10 Feb 2011 16:44:37 +0800
Subject: [PATCH] Fix build of cpuset_syscall_test

cpuset_syscall_test now depends on numa lib:

make[1]: Entering directory `/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/root/ltp/testcases/kernel/include -I../../../../../include -I../../../../../include   -L/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib -L/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../../libcontrollers -L../../../../../lib  cpuset_syscall_test.c   -lltp -lcpu_set -lcontrollers -lltp -o cpuset_syscall_test
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib/libcpu_set.a(libcpuset.o): In function `cpuset_addr2node':
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3455: undefined reference to `get_mempolicy'
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib/libcpu_set.a(libcpuset.o): In function `cpuset_membind':
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3439: undefined reference to `set_mempolicy'
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib/libcpu_set.a(libcpuset.o): In function `cpuset_unpin':
/root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3752: undefined reference to `set_mempolicy'
collect2: ld returned 1 exit status
make[1]: *** [cpuset_syscall_test] Error 1
make[1]: Leaving directory `/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test'
make: *** [all] Error 2

This patch fixes this problem

Signed-off-by: Han Pingtian <phan@redhat.com>
---
 .../cpuset/cpuset_syscall_test/Makefile            |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
index edc6265..6565631 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -24,4 +24,8 @@ top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS                  += $(NUMA_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
-- 
1.7.1


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--BXVAT5kNtrzKuDFl--

