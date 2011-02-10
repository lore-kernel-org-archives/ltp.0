Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PnYrh-0002ne-11
	for ltp-list@lists.sourceforge.net; Thu, 10 Feb 2011 15:55:29 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PnYrg-0008V6-0I
	for ltp-list@lists.sourceforge.net; Thu, 10 Feb 2011 15:55:28 +0000
Received: by wwi18 with SMTP id 18so1421066wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Feb 2011 07:55:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110210085232.GA9285@hpt.nay.redhat.com>
References: <20110210085232.GA9285@hpt.nay.redhat.com>
Date: Thu, 10 Feb 2011 07:55:21 -0800
Message-ID: <AANLkTimk_+8o+QQdjzweLmhB=qzzO2TGYADmEuBQtZom@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On Thu, Feb 10, 2011 at 12:52 AM, Han Pingtian <phan@redhat.com> wrote:
> cpuset_syscall_test now depends on numa lib:
>
> make[1]: Entering directory `/root/ltp/testcases/kernel/controllers/cpuse=
t/cpuset_syscall_test'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I/root/ltp/testcas=
es/kernel/include -I../../../../../include -I../../../../../include =A0 -L/=
root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_=
lib -L/root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../=
../libcontrollers -L../../../../../lib =A0cpuset_syscall_test.c =A0 -lltp -=
lcpu_set -lcontrollers -lltp -o cpuset_syscall_test
> /root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpus=
et_lib/libcpu_set.a(libcpuset.o): In function `cpuset_addr2node':
> /root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3455=
: undefined reference to `get_mempolicy'
> /root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpus=
et_lib/libcpu_set.a(libcpuset.o): In function `cpuset_membind':
> /root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3439=
: undefined reference to `set_mempolicy'
> /root/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpus=
et_lib/libcpu_set.a(libcpuset.o): In function `cpuset_unpin':
> /root/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c:3752=
: undefined reference to `set_mempolicy'
> collect2: ld returned 1 exit status
> make[1]: *** [cpuset_syscall_test] Error 1
> make[1]: Leaving directory `/root/ltp/testcases/kernel/controllers/cpuset=
/cpuset_syscall_test'
> make: *** [all] Error 2
>
> This patch fixes this problem
>
> Signed-off-by: Han Pingtian <phan@redhat.com>
> ---
> =A0.../cpuset/cpuset_syscall_test/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Make=
file b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> index edc6265..17331fb 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> @@ -25,3 +25,5 @@ top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../../../=
..
> =A0include $(top_srcdir)/include/mk/testcases.mk
> =A0include $(abs_srcdir)/../Makefile.inc
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D $(NUMA_LIBS)
> --

For consistency this should be placed before generic_leaf_target.mk
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
