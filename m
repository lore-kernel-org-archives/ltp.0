Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5Yt3-00058E-1p
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 05:58:29 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Ysw-0003Sz-IV
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 05:58:28 +0000
Received: by pzk26 with SMTP id 26so4481299pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 21:58:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFB7192512.13ED74E7-ON85257664.001981A6-85257664.001F3BB6@us.ibm.com>
References: <mailman.103093.1257283106.5825.ltp-list@lists.sourceforge.net>
	<OFB7192512.13ED74E7-ON85257664.001981A6-85257664.001F3BB6@us.ibm.com>
Date: Tue, 3 Nov 2009 21:58:16 -0800
Message-ID: <364299f40911032158s4356a90bkf06686f7aea01b87@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build Fails on some archs
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Nov 3, 2009 at 9:41 PM, Mark Ver <markver@us.ibm.com> wrote:
>
> I seem to be getting 2 different build problems on s390x:
>
> On SLES-10 SP3, the make attempt gets nowhere (still need to check if
> reproducible on a different system):
> ...
> config.status: executing depfiles commands
> config.status: executing libtool commands
> h91distr02:~/ltp-full-20091031 # make all
> make: *** No rule to make target `/$*', needed by `pan-all'. =A0Stop.
> h91distr02:~/ltp-full-20091031 #
>
>
> On RHEL5.4 and SLES-11 am getting build problem with the controllers
> subdirs, =A0ex:
>
> SLES-11:
> ...
> make[3]: Entering directory
> `/root/ltp-full-20091031/testcases/kernel/controllers'
> make[4]: Entering directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cgroup'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> =A0-I/root/ltp-full-20091031/testcases/kernel/include
> -I/root/ltp-full-20091031/testcases/kernel/controllers/cgroup/../libcontr=
ollers
> -I../../../../include -I../../../../include
> -L/root/ltp-full-20091031/testcases/kernel/controllers/cgroup/../libcontr=
ollers
> -L../../../../lib =A0fork_processes.c =A0 -lltp -lcontrollers -o fork_pro=
cesses
> /usr/lib64/gcc/s390x-suse-linux/4.3/../../../../s390x-suse-linux/bin/ld:
> cannot find -lcontrollers
> collect2: ld returned 1 exit status
> make[4]: *** [fork_processes] Error 1
> make[4]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cgroup'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp-full-20091031/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-full-20091031/testcases'
> make: *** [testcases-all] Error 2
>
> RHEL5.4:
> ...
> make[3]: Entering directory
> `/root/ltp-full-20091031/testcases/kernel/controllers'
> make[4]: Entering directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> =A0-I/root/ltp-full-20091031/testcases/kernel/include
> -I/root/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj/../libco=
ntrollers
> -Wall -O2 -Wextra -I../../../../include -I../../../../include
> -L/root/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj/../libco=
ntrollers
> -L../../../../lib =A0cgroup_fj_proc.c =A0 -lltp -lcontrollers -o cgroup_f=
j_proc
> /usr/bin/ld: cannot find -lcontrollers
> collect2: ld returned 1 exit status
> make[4]: *** [cgroup_fj_proc] Error 1
> make[4]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp-full-20091031/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-full-20091031/testcases'
> make: *** [testcases-all] Error 2
>
> Also should I expect the same result if I retry the compile with the
> following?
> =A0 =A0 =A0 =A0 make clean
> =A0 =A0 =A0 =A0 make autotools
> =A0 =A0 =A0 =A0 ./configure
> =A0 =A0 =A0 =A0 make all
>
> Cause RHEL5.4 and SLES-11 get the same error but a different complaint th=
an
> what they got on the original build attempt:
> ...
> make[5]: Entering directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset_sysca=
ll_test'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> =A0-I/root/ltp-full-20091031/testcases/kernel/include -I../../../../../in=
clude
> -I../../../../../include
> -L/root/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset_sysc=
all_test/../cpuset_lib
> -L../../../../../lib =A0cpuset_syscall_test.c =A0 -lltp -lcpu_set -o
> cpuset_syscall_test
> cpuset_syscall_test.c: In function =E2get_mempolicy=E2:
> cpuset_syscall_test.c:67: error: =E2__NR_get_mempolicy=E2 undeclared (fir=
st use
> in this function)
> cpuset_syscall_test.c:67: error: (Each undeclared identifier is reported
> only once
> cpuset_syscall_test.c:67: error: for each function it appears in.)
> cpuset_syscall_test.c: In function =E2mbind=E2:
> cpuset_syscall_test.c:73: error: =E2__NR_mbind=E2 undeclared (first use i=
n this
> function)
> cpuset_syscall_test.c: In function =E2set_mempolicy=E2:
> cpuset_syscall_test.c:78: error: =E2__NR_set_mempolicy=E2 undeclared (fir=
st use
> in this function)
> cpuset_syscall_test.c: In function =E2process_options=E2:
> cpuset_syscall_test.c:100: warning: unused variable =E2file=E2
> cpuset_syscall_test.c: In function =E2test_mbind=E2:
> cpuset_syscall_test.c:177: warning: format =E2%lx=E2 expects type =E2long=
 unsigned
> int=E2, but argument 2 has type =E2void *=E2
> make[5]: *** [cpuset_syscall_test] Error 1
> make[5]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset_sysca=
ll_test'
> make[4]: *** [all] Error 2
> make[4]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers/cpuset'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/ltp-full-20091031/testcases/kernel/controllers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp-full-20091031/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-full-20091031/testcases'
> make: *** [testcases-all] Error 2

Mark,
    Someone else reported similar recently. Can you please tell us
what version of Gnu make you're using?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
