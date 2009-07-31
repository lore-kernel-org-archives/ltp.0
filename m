Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWvtr-0003DD-34
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 17:28:11 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWvtn-0004qk-C2
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 17:28:11 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-ZQXM8M1q9cwIk/Ur3gEV"
Date: Fri, 31 Jul 2009 22:57:26 +0530
Message-Id: <1249061247.5203.31.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been Released for JULY
	2009
Reply-To: subrata@linux.vnet.ibm.com
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
To: ltp-list <ltp-list@lists.sf.net>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sachin Sant <sachinp@in.ibm.com>, Praveen <praveen@primesoftsolutionsinc.com>, Mimi Zohar <zohar@us.ibm.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Jiri Palecek <jpalecek@web.de>, "M. Mohan Kumar" <mohan@in.ibm.com>, rohit verma <rohit.170309@gmail.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Gowrishankar <gowrishankar.m@in.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Cai Qian <qcai@redhat.com>, Naresh Kamboju <naresh.kernel@gmail.com>, Peter Oberparleiter <oberpapr@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>


--=-ZQXM8M1q9cwIk/Ur3gEV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e8.ny.us.ibm.com id
	n6VHRjMj029977

Dear All,

The Linux Test Project test suite has been released for the month of
JULY 2009. Please see ltp/INSTALL file carefully, as, there has been
multiple changes for building/installing the test suite.

The latest version of the test-suite contains 3000+ tests for the Linux
OS and can be found at:
http://ltp.sourceforge.net/,
Latest happenings in LTP can also be found at:
http://ltp.sourceforge.net/wiki/,
http://ltp.sourceforge.net/wikiArchives.php, and,
IRC: irc.freenode.org #ltp.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
JULY 2009 Highlights:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
     1. Addition of TOMOYO Security Tests,=20
     2. Addition of 22 test scenarios for CPU Controller tests,=20
     3. Work on LTP Makefiles,=20
     4. LTP=C5=9B representation at OLS 2009, Montreal, Canada,
------------------------------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
JULY 2009 LTP Contributors:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=20
     1. Garrett Cooper,=20
     2. Naresh Kamboju,=20
     3. Henry Yei,=20
     4. Lucio Correia,=20
     5. Matt Helsley,=20
     6. Sachin Sant,=20
     7. Gowrishankar,=20
     8. Jiri Palecek,=20
     9. Sripathi Kodi,=20
    10. M=C3=A1rton N=C3=A9meth,=20
    11. Sukadev Bhattiprolu,=20
    12. Serge E. Hallyn,=20
    13. M. Mohan Kumar,=20
    14. Tetsuo Handa,=20
    15. Wang Yong,=20
    16. Praveen,=20
    17. Michal Simek,=20
    18. Shi Weihua,=20
    19. Mike Frysinger,=20
    20. CAI Qian,=20
    21. Wei Yongjun,=20
    22. Rohit Verma,=20
    23. Mimi Zohar,=20
    24. Robert Paulsen,
------------------------------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Note(s) from the Maintainer:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Garrett continued his surge towards making the Makefiles look more
elegant. Hope we should be able to push them to the main tree in August
or September 09 release. So far he has worked on more than 600+
Makefiles.

LTP received renewed attention through the
Paper(http://ltp.sourceforge.net/documentation/technical_papers/Putting_L=
TP_to_Test.pdf) and Tutorial at OLS 2009. New testcases poured in this mo=
nth as well, and, i am hoping that people will open up more and contribut=
e more in terms of new test cases.

Our web site also contains other information such as:
- A Linux test tools matrix
- Technical papers
- How To's on Linux testing
- Code coverage analysis tool.

We would encourage the community to post results to
ltp-results@lists.sf.net,
patches, new tests, bugs or comments/questions to ltp-list@lists.sf.net,
http://sourceforge.net/tracker/?func=3Dadd&group_id=3D3382&atid=3D103382 =
(for
New Bug(s)),
http://sourceforge.net/tracker/?func=3Dadd&group_id=3D3382&atid=3D303382 =
(for
New Patch(s)),
http://sourceforge.net/tracker/?func=3Dadd&group_id=3D3382&atid=3D353382 =
(for
New Feature Request(s))

Happy testing,=20
Regards--=20
Subrata,

--=-ZQXM8M1q9cwIk/Ur3gEV
Content-Disposition: attachment; filename=July-2009_Changelog.txt
Content-Type: text/plain; name=July-2009_Changelog.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e8.ny.us.ibm.com id
	n6VHRjMj029977

1) Log Message:
I have noticed failure under open_posix_testsuite for mq_unlink/speculati=
ve/7-2.c and fixed. After changing the uninitialized to initialized char =
array of mqname[] test case got PASSED. I have attached patch and below. =
Please review the same. Signed-off-by: Naresh Kamboju < naresh.kernel@gma=
il.com >.

Modified File(s):
ltp/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/specu=
lative/7-2.c

2) Log Message:
It looks like the io_*.sh files are now not needed since the test source =
has been modified to check for an autoconf definition. This patch modifie=
s the syscalls runtest file to call those test directly. (io_cancel, io_d=
estroy01, io_getevents01, io_setup01, io_submit01). As the scripts are no=
t needed any more, can we remove the following?
ltp/testcases/kernel/syscalls/io_cancel01.sh
ltp/testcases/kernel/syscalls/io_destroy01.sh
ltp/testcases/kernel/syscalls/io_getevents0101.sh
ltp/testcases/kernel/syscalls/io_setup01.sh
ltp/testcases/kernel/syscalls/io_submit01.sh
These scripts were not being copied into testcases/bin anyway and so AFAI=
K, were not being run correctly by pan anyway. Signed-off-by: Henry Yei <=
hyei@mvista.com>.

Modified Files:
ltp/runtest/syscalls

3) Log Message:
Fix eventfd2_03 build failure on powerpc architecture. I've found a failu=
re when building ltp-full-20090630 on powerpc:=20
eventfd2_03.c:48:2: error: #error Cannot detect your architecture!
eventfd2_03.c: In function =E2=80=98eventfd2=E2=80=99:
eventfd2_03.c:54: error: =E2=80=98__NR_eventfd2=E2=80=99 undeclared (firs=
t use in this function)
eventfd2_03.c:54: error: (Each undeclared identifier is reported only onc=
e
eventfd2_03.c:54: error: for each function it appears in.)
eventfd2_03.c: In function =E2=80=98main=E2=80=99:
eventfd2_03.c:129: warning: implicit declaration of function =E2=80=98wai=
tpid=E2=80=99
This patch fixes the failure, the test program identifier and adds a kern=
el version check. Signed-off-by Lucio Correia <ljhc@br.ibm.com>.

Modified Files:
ltp/testcases/kernel/include/powerpc.in
ltp/testcases/kernel/include/powerpc64.in
ltp/testcases/kernel/syscalls/eventfd2/eventfd2_03.c

4) Log Message:
netns: Report version of iproute2 tools in ver_linux: Report the version =
of the ip route tools in ver_linux with ip -V. The version is important t=
o the netns testcases for example. Since it would be useful for other tes=
tcases add it to the ver_linux script. Signed-off-by: Matt Helsley <matth=
ltc@us.ibm.com>.

Modified Files:
ltp/ver_linux

5) Log Message:
netns: Add ip tools check to netns tests: Use ip -V to exclude the networ=
k namespace testcases since they require version  ("snapshot") ss080725 o=
r higher to set the network namespace of interfaces used for testing. Sig=
ned-off-by: Matt Helsley <matthltc@us.ibm.com>.=20

Modified Files:
ltp/testcases/kernel/containers/netns/runnetnstest.sh

6) Log Message:
Fix Security/Filecaps Build failure: inh_capped.c:70: error: too many arg=
uments to function =E2=80=98tst_exit=E2=80=99. Signed-off-by : Sachin San=
t <sachinp@in.ibm.com>.

Modified Files:
ltp/testcases/kernel/security/filecaps/inh_capped.c
ltp/testcases/kernel/security/filecaps/verify_caps_exec.c

7) Log Message:
I have divided rt_sigaction01.c test case in to three test cases
1. rt_sigaction01.c (Functionality)
2. rt_sigaction02.c (EFAULT)
3. rt_sigaction03.c (EINVAL)
In these test cases rt_sigaction use signal number from SIGRTMIN (34) to =
SIGRTMAX (64).The Real Time (RT) signals will start from 34 to 64 as per =
signal.h because sigaction is testing from 1 to 30 signals I hope. If you=
 want to test 1 to 64 signals by rt_sigaction signal number 9 and 19 i.e =
SIGKILL and SIGTERM will FAIL, because as per Specifications we should no=
t use SIGKILL and SIGTERM signals with rt_sigaction/sigaction. long sys_r=
t_sigaction (int sig, const struct sigaction *act, struct sigaction *oact=
, size_t sigsetsize). SIGSETSIZE is different for different architectures=
 that is taken care for ARM, PowerPC, X86 and MIPS in this patch. Subrata=
, Coding style is not as LTP, I did not get much time to fix this. If you=
 are using any indent for LTP, please share I will use those script to fi=
x coding style. If any body is interested to fix coding style issue pleas=
e welcome... :-). I have attached fix patch and below. Please review the =
same.
/*******************************************************/
Test Start Time: Fri Jul  3 07:52:04 2009
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
rt_sigaction01                 PASS       0
rt_sigaction02                 PASS       0
rt_sigaction03                 PASS       0
-----------------------------------------------
Total Tests: 3
Total Failures: 0
Kernel Version: 2.6.23.17-alp_nl-pc-g56b4520c-dirty
Machine Architecture: i686
Hostname: 43.88.101.228
************************************************************/
Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >.

Modified Files:
ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
Added Files:
ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c

8) Log Message:
cgroups: conditionally enable building cgroup tests: controllers tests ge=
ts included into default ltp build if "/proc/cgroup" exists. It stops the=
 ltp build in realtime kernel environment where kernel is new and support=
s cgroups, but necessary file "linux/cgroupstats.h" may not exist in the =
base OS (like RHEL5.3). So configure command enables the build, but actua=
l build fails, due to missing header file. Below patch proposes new symbo=
l LTP_CHECK_CGROUPSTATS to check for header file "linux/cgroupstats.h" an=
d include controllers in the list of tests to build. Tested the patch in =
non-RT as well as RT environment for the changes. Signed-off-by: Gowrisha=
nkar <gowrishankar.m@in.ibm.com>.

Modified Files:
ltp/configure.ac
ltp/testcases/kernel/Makefile
Added Files:
ltp/m4/ltp-cgroupstats.m4

9) Log Message:
Fix failures of the clock_nanosleep01 test: The failures were caused by s=
trange interpretation of POSIX by the test:
  - POSIX says CLOCK_THREAD_CPUTIME_ID is an invalid value for the clock_=
id parameter, and results in an EINVAL,
  - POSIX doesn't specify that the remaining time should be set in any wa=
y (eg. zeroed) on successful completion,
Also, the test deletes some of the superfluous uses of the TEST macro. Si=
gned-off-by: Jiri Palecek <jpalecek@web.de>.

Modified Files:
ltp/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c

10) Log Message:
Here is the patch to remove the unneeded scripts for the io_* tests, whic=
h should be used in conjunction with the previous patch for the syscalls =
patch. Signed-off-by: Henry Yei <hyei@mvista.com>.

Removed Files:
ltp/testcases/kernel/syscalls/io_cancel/run-io_cancel.sh
ltp/testcases/kernel/syscalls/io_destroy/run-io_destroy.sh
ltp/testcases/kernel/syscalls/io_getevents/run-io_getevents.sh
ltp/testcases/kernel/syscalls/io_setup/run-io_setup.sh
ltp/testcases/kernel/syscalls/io_submit/run-io_submit.sh

11) Log Message:
ballista should clean out all generated binaries. A few generated files w=
eren't being pruned with clean (blexer, bparser). This patch fixes that. =
Signed-off-by: Garrett Cooper <yanegomi@gmail.com>.

Modified Files:
ltp/testcases/ballista/ballista/Makefile

12) Log Message:
Make IDcheck.sh DESTDIR aware and less strict: The end goal of this patch=
 is to make IDcheck.sh more rootfs- / cross- compilation friendly, such t=
hat it can be run from the primary compile instance, and instead of attem=
pting to manipulate the target system data, manipulate the sys-root / roo=
tfs data through the use of DESTDIR and by relaxing certain checks. Most =
of the checks were unnecessary anyhow (am i root?), etc and can be easily=
 remedied by just relying on the other checks made by touch(1)'ing files =
and the post-process operation, as ENOPERM will be returned if one cannot=
 access the configuration file of interest. Also, use awk for all operati=
ons instead of grep because it will reduces the potential for random fail=
ures when dealing with /etc/group and /etc/passwd files, and we can switc=
h over to one subroutine instead of multiple subroutines for checks. Sign=
ed-off-by: Garrett Cooper <yanegomi@gmail.com>.

Modified Files:
ltp/IDcheck.sh

13) Log Message:
Missing limits.h include and test.h style in system_specific_process_info=
.c: 1. test.h is in .../include/. Thus #include should be #include "test.=
h", not #include <test.h>. 2. limits.h should be explicitly stated becaus=
e certain constants are used in system_specific_process_info.c (SHRT_MAX =
for instance). Signed-off-by: Garrett Cooper <yanegomi@gmail.com>.=20

Modified Files:
ltp/lib/system_specific_process_info.c

14) Log Message:
realtime: fix parameter name clash in pi-test7 due to memlock option adde=
d: Below patch just renames the parameter name for number of mid priority=
 threads in pi-test7 from -m to -x. Original one clashes with our common =
memlock option used across all RT tests. Also, pi-test7 is already disabl=
ed in our default run profile, so this patch can silently update the test=
 without any impact on any other test. Testing Informations: Tested pi-te=
st7 binary with the patch for the changes. Signed-off-by: Gowrishankar <g=
owrishankar.m@in.ibm.com>.

Modified Files:
ltp/testcases/realtime/func/pi-tests/testpi-7.c

15) Log Message:
realtime: Fix the pass criterion of pi_perf test case: The pass criterion=
 in pi_perf test case is wrong. It compares the minimum amount of time ta=
ken by the low priority thread with the maximum amount of time taken by t=
he high priority thread to calculate the PI delay. Obviously, these min a=
nd max don't necessarily happen in the same iteration, resulting in a num=
ber of false failures. The correct way is to compare the time taken by lo=
w and high priority threads in each iteration and then find the maximum d=
elay experienced by high priority thread across the iterations. This patc=
h implements the change. Additionally, this patch removes lock_wait_dat a=
rray, which is not needed anymore as well as makes a couple of messages e=
asier to understand. This patch changes the messages displayed by this te=
st case slightly. They look like the following now:
Low prio thread started
High prio thread started
Busy 0 started
Busy 1 started
Busy 2 started
Busy 3 started
Time taken for high prio thread to get the lock once released by low prio=
 thread
Min delay =3D 10 us
Max delay =3D 36 us
Average delay =3D 17.06 us
Standard Deviation =3D 8.11 us
Quantiles:
99.0% < 36
Criteria: High prio lock wait time < (Low prio lock held time + 200 us)
Result: PASS
I have tested this by running 1000 iterations of pi_perf test on a couple=
 of machines. Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>.

Modified Files:
ltp/testcases/realtime/func/pi_perf/pi_perf.c

16) Log Message:
ltp-posix-mmap_18-1.c: I have noticed FAIL and fixed mmap/18-1.c under op=
en posix testsuite. I have fixed this test case by changing the seteuid()=
 from root to non-root. To get resource limit setrlimit(). STEPS: mmap: E=
AGAIN: Lock all the memory by mlockall(). Set resource limit setrlimit().=
 Change the user to non-root then only setrmilit is applicable. I have at=
tached the patch and below. Please review the same.
/*****************************************************************/
[mmap]# ./18-1.test
Test Pass: mmap/18-1.c Get EAGAIN: Resource temporarily unavailable
/*****************************************************************/
Signed-off-by: Naresh Kamboju <naresh.kernel@gmail.com>.

Modified Files:
ltp/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c

17) Log Message:
Add autoconf tests for taskstats members not present on older kernels: Th=
is patch adds autoconf checks for some build failures reported by Cyril H=
rubis. Please note I have not tested this on an old kernel. Also, it corr=
ects the names of the preprocessor macros defined by autoconf. The remain=
ing issue (the cgroupstats.h file) should be solved using the autoconf te=
st that was committed recently. Signed-off-by: Jiri Palecek <jpalecek@web=
.de>.=20

Modified Files:
ltp/include/config.h.default
ltp/m4/ltp-taskstats.m4
ltp/testcases/kernel/controllers/cgroup/getdelays.c

18) Log Message:
This is v4l-test 0.16 for LTP. Changes: Iterate through all available inp=
uts in VIDIOC_G_STD and VIDIOC_S_STD test cases. Signed-off-by: M=C3=A1rt=
on N=C3=A9meth <nm127@freemail.hu>.

Modified Files:
ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
ltp/testcases/kernel/device-drivers/v4l/user_space/README
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_ENUMINPUT.=
c
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_STD.c
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h
ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.html
Added Files:
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.c
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.h

19) Log Message:
Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, "Serge E. Hallyn" <seru=
e@us.ibm.com> & "M. Mohan Kumar" <mohan@in.ibm.com> wanted to get this re=
moved.

Removed Files:
ltp/testcases/kernel/containers/pidns/pidns14.c

20) Log Message:
Fix some bashisms: this patch reflects the comments by various people to =
the previous versions. It uses "+=3D1" instead of postincrement because o=
f dash, ['s boolean expressions, printf for the formatting. I've left the=
 unzip pushd/popd and the signal names issue completely. Signed-off-by: J=
iri Palecek <jpalecek@web.de>.

Modified Files:
ltp/runalltests.sh ltp/testcases/commands/cron/cron02
ltp/testcases/commands/cron/cron03
ltp/testcases/commands/cron/cron_allow01
ltp/testcases/commands/cron/cron_deny01
ltp/testcases/commands/su/su01
ltp/testcases/kernel/containers/netns/child.sh
ltp/testcases/kernel/containers/netns/child_1.sh
ltp/testcases/kernel/containers/netns/childipv6.sh
ltp/testcases/kernel/containers/netns/childns.sh
ltp/testcases/kernel/containers/netns/delchild.sh
ltp/testcases/kernel/containers/netns/par_ftp.sh
ltp/testcases/kernel/containers/netns/parent.sh
ltp/testcases/kernel/containers/netns/parent_1.sh
ltp/testcases/kernel/containers/netns/parent_2.sh
ltp/testcases/kernel/containers/netns/parentns.sh
ltp/testcases/kernel/containers/netns/paripv6.sh
ltp/testcases/kernel/containers/netns/rename_net.sh
ltp/testcases/kernel/power_management/runpwtests.sh
ltp/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
ltp/testcases/kernel/syscalls/ioctl/test_ioctl
ltp/testcases/misc/tcore_patch_test_suites/tcore.sh
ltp/testcases/network/iproute/ip_tests.sh
ltp/testcases/network/nfs/nfs03/nfs03

21) Log Message:
Addition of TOMOYO Security Tests to LTP. Contributed by Tetsuo Handa <pe=
nguin-kernel@I-love.SAKURA.ne.jp>.

Added Files:
ltp/testcases/kernel/security/tomoyo/Makefile
ltp/testcases/kernel/security/tomoyo/README
ltp/testcases/kernel/security/tomoyo/include.h
ltp/testcases/kernel/security/tomoyo/newns.c
ltp/testcases/kernel/security/tomoyo/testall.sh
ltp/testcases/kernel/security/tomoyo/tomoyo_file_test.c

22) Log Message:
Here is a patch for utimensat_test.sh to change the hardcoded tmp directo=
ry to use the LTP variable TMPDIR which may bet set by the user to point =
to other than /tmp. Signed-off-by: Henry Yei <hyei@mvista.com>.

Modified Files:
ltp/testcases/kernel/syscalls/utimensat/utimensat_tests.sh

23) Log Message:
Whenever system called utimes, the error message returned was EINVAL, bec=
ause the member variable of struct timeval was not initialized, so initia=
lize it. Signed-off-by:=E3=80=80WangYong=E3=80=80<wangyong2009@cn.fujitsu=
.com>.

Modified Files:
ltp/testcases/kernel/syscalls/utimes/utimes01.c

24) Log Message:
Add some more documentation. Signed-off-by: Praveen <praveen@primesoftsol=
utionsinc.com>.

Modified Files:
ltp/testcases/commands/ade/file/file_test.sh

25)Log Message:
This changeset does the following:
IDcheck.sh:
1. Fixes the DESTDIR !=3D [ "", "/" ] behavior.
2. Spew out less awk errors if files don't exist by instead short-circuit=
ing the logic to detect whether or not the file exists in the fe subrouti=
ne.=20
Makefile:
This adds SKIP_IDCHECK behavior, by request of Michal <michal.simek@petal=
ogix.com>, so it's no longer required for make install, and can be disabl=
ed by entering specifying the variable SKIP_IDCHECK=3D1 when calling make=
 install, e.g...
make \
[make-options-and-variables] \
SKIP_IDCHECK=3D1 \
install
Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
Tested-by Michal Simek <michal.simek@petalogix.com>

Modified File(s):
ltp/Makefile
ltp/IDcheck.sh

26)Log Message:
Fix the amd64 compile as discussed on the list because of assumptions mad=
e on syscall size. This doesn't fix the runtime issue with segfaulting at=
 the end of the test on amd64. Please see the thread titled `Compile fail=
ure with rt_sigaction on amd64'.

Modified File(s):
ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c

27)Log Message:
Accidentally committed the commented line under test that causes the segf=
ault :\.

Modified File(s):
ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c

28)Log Message:
Original message from Shi Weihua <shiwh@cn.fujitsu.com>: In case cpuset, =
the file cpuset_syscall_test.o was not deleted after "make clean". This c=
hange is a modified version of the original patch submitted.

Modified File(s):
ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile

29)Log Message:
Previous `fix' wasn't correct. Fix similar to way noted by Shi Weihua <sh=
iwh@cn.fujitsu.com>.

Modified File(s):
ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile

30) Log Message:
This patch fixes the following build error on mips, mips-el toolchain: "r=
uncc.a: could not read symbols: Archive has no index; run ranlib to add o=
ne." Signed-off-by: Henry Yei <hyei@mvista.com>.  Take the existing patch=
 provided by Henry Yei in the email thread, `[LTP] [PATCH] network/lb6/Ma=
kefile, mips, mips-el toolchain needs explicit RANLIB call to build', and=
 modify slightly to allow for improved cross-compilation. Signed-off-by: =
Garrett Cooper <yanegomi@gmail.com>.

Modified File(s):
ltp/testcases/network/lib6/Makefile

31) Log Message:
Extend the test result to a bit field so we can extend the output further=
. Signed-off-by: Mike Frysinger <vapier@users.sourceforge.net>.

Modified File(s):
ltp/include/test.h
ltp/lib/tst_res.c

32) Log Message:
Convert errno handling to new tst errno helpers. Signed-off-by: Mike Frys=
inger <vapier@users.sourceforge.net>.

Modified File(s):
ltp/testcases/kernel/syscalls/mmap/mmap09.c

33) Log Message:
There is no point in having an empty arch .in file. Signed-off-by: Mike F=
rysinger <vapier@users.sourceforge.net>.

Removed File(s):
ltp/testcases/kernel/include/microblaze.in

34) Log Message:
Move leading __NR_ to script to make all the .in files simpler. Signed-of=
f-by: Mike Frysinger <vapier@users.sourceforge.net>.

Modified File(s):
ltp/testcases/kernel/include/arm.in
ltp/testcases/kernel/include/hppa.in
ltp/testcases/kernel/include/i386.in
ltp/testcases/kernel/include/ia64.in
ltp/testcases/kernel/include/powerpc.in
ltp/testcases/kernel/include/powerpc64.in
ltp/testcases/kernel/include/regen.sh
ltp/testcases/kernel/include/s390.in
ltp/testcases/kernel/include/s390x.in
ltp/testcases/kernel/include/sh.in
ltp/testcases/kernel/include/sparc.in
ltp/testcases/kernel/include/sparc64.in
ltp/testcases/kernel/include/x86_64.in

35) Log Message:
fix gcc warning: parse_opts.c:582: warning: format not a string literal a=
nd no format arguments. Signed-off-by: Mike Frysinger <vapier@users.sourc=
eforge.net>.

Modified File(s):
ltp/lib/parse_opts.c

36) Log Message:
Fix shadowed declaration of basename(3) in testcases/kernel/fs/fsx-linux/=
fsx-linux.c: This is the 21st century, and yes we have a basename(3) libc=
all in string.h. This attached patch fixes that so -Wshadow passes: Signe=
d-off-by: Garrett Cooper <yanegomi@gmail.com>.

Modified File(s):
ltp/testcases/kernel/fs/fsx-linux/fsx-linux.c

37) Log Message:
Fix bad strerror calls in testcases/kernel/syscalls/waitid01.c: For whate=
ver reason the original author was using int casts to the strerror string=
s. That's just plain wrong. This corrects the issue by feeding back the p=
roper strerror output, which reduces noise at compile time and results in=
 the same desired behavior (because we shouldn't be negative testing stre=
rror(3) in waitid01.c: Signed-off-by: Garrett Cooper <yanegomi@gmail.com>.

Modified File(s):
ltp/testcases/kernel/syscalls/waitid/waitid01.c

38) Log Message:
Trim trailing whitespace. Signed-off-by: Mike Frysinger <vapier@users.sou=
rceforge.net>.

Modified File(s):
ltp/include/dataascii.h
ltp/include/databin.h
ltp/include/file_lock.h
ltp/include/forker.h
ltp/include/libtestsuite.h
ltp/include/open_flags.h
ltp/include/pattern.h
ltp/include/random_range.h
ltp/include/search_path.h
ltp/include/str_to_bytes.h
ltp/include/string_to_tokens.h
ltp/include/test.h
ltp/include/tlibio.h
ltp/include/usctest.h
ltp/include/write_log.h
ltp/lib/dataascii.c
ltp/lib/databin.c
ltp/lib/datapid.c
ltp/lib/file_lock.c
ltp/lib/forker.c
ltp/lib/get_high_address.c
ltp/lib/libtestsuite.c
ltp/lib/open_flags.c
ltp/lib/parse_opts.c
ltp/lib/pattern.c
ltp/lib/random_range.c
ltp/lib/rmobj.c
ltp/lib/search_path.c
ltp/lib/self_exec.c
ltp/lib/str_to_bytes.c
ltp/lib/string_to_tokens.c
ltp/lib/system_specific_hugepages_info.c
ltp/lib/system_specific_process_info.c
ltp/lib/tlibio.c
ltp/lib/tst_cwd_has_free.c
ltp/lib/tst_kvercmp.c
ltp/lib/tst_res.c
ltp/lib/tst_sig.c
ltp/lib/tst_tmpdir.c
ltp/lib/write_log.c

39) Log Message:
Use strrchr() rather than deprecated rindex(). Signed-off-by: Mike Frysin=
ger <vapier@users.sourceforge.net>.

Modified File(s):
ltp/lib/libtestsuite.c

40) Log Message:
Drop special uClibc handling of LIO_WAIT_TYPES since it doesnt matter. Si=
gned-off-by: Mike Frysinger <vapier@users.sourceforge.net>.

Modified File(s):
ltp/include/tlibio.h

41) Log Message:
Add a standard "all" target. Signed-off-by: Mike Frysinger <vapier@users.=
sourceforge.net>.

Modified File(s):
ltp/lib/Makefile

42) Log Message:
1. Fix the utimes testcase so that it passes with the appropriate non-har=
dcoded directory, as provided by Wang Yong <wangyong2009@cn.fujitsu.com>=20
2. Fix a compiler warning by using an intermediary const char* variable, =
as NULL and (const char*) NULL casting was still causing compiler warning=
s in gcc 4.3.2.=20
Signed-off-by: Garrett Cooper <yanegomi@gmail.com>.

Modified File(s):
ltp/testcases/kernel/syscalls/utimes/utimes01.c

43) Log Message:
lcov: add support for the linux-2.6.31 upstream gcov kernel support. Sign=
ed-off-by: Peter Oberparleiter <oberpapr@users.sourceforge.net>.

Modified File(s):
ltp/utils/analysis/lcov/bin/lcov
ltp/utils/analysis/lcov/man/lcov.1

44) Log Message:
lcov: improve lcov -l output. Signed-off-by: Peter Oberparleiter <oberpap=
r@users.sourceforge.net>.

Modified File(s):
ltp/utils/analysis/lcov/bin/lcov

45) Log Message:
lcov: fix kernel capture for new gcov-kernel version - fix problems when =
compiling without O=3D. Signed-off-by: Peter Oberparleiter <oberpapr@user=
s.sourceforge.net>.

Modified File(s):
ltp/utils/analysis/lcov/bin/lcov

46) Log Message:
Fix compiler error for testcases/kernel/syscalls/eventfd2/eventfd2_03.c n=
oted by CAI Qian w.r.t. the intermediate July release, as...
1. The necessary headers weren't being pulled in for waitpid.
2. gcc was complaining about -Wunused with cleanup.
3. The wrong format argument was being passed to printf.
Fix for 3 and suggestions on coding style made by Mike Frysinger.
Signed-off-by: Garrett Cooper <yanegomi@gmail.com>.

Modified File(s):
ltp/testcases/kernel/syscalls/eventfd2/eventfd2_03.c

47) Log Message:
Problem with last commit was that Mike was indeed right, this would break=
 some architectures depending on bit width with warnings. Gmail's default=
 font (some San Serif font) is really hard to read sometimes so it's hard=
 to discern I from l, unless one looks carefully. Signed-off-by (for the =
last time): Garrett Cooper <yanegomi@gmail.com>.

Modified File(s):
ltp/testcases/kernel/syscalls/eventfd2/eventfd2_03.c

48) Log Message:
Fix the system call number of exit_group01. The system call number is dep=
end on the system architecture, not always 252. This patch fixed the prob=
lem. Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>.

Modified File(s):
ltp/testcases/kernel/syscalls/exit_group/exit_group01.c

49) Log Message:
Fix the failure of get_mempolicy01 test case: Test case get_mempolicy01 f=
ailure because of the the nodemask is not used when from_node is NONE typ=
e. If the from_node is NONE, nodemask_equal() is not need. Signed-off-by:=
 Wei Yongjun <yjwei@cn.fujitsu.com>.

Modified Files:
ltp/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c

50) Log Message:
[PATCHv2] Fix to set the signal handler of SIGINT in mq_timedreceive01: T=
he test case mq_timedreceive01 does not register the signal handler of SI=
GINT, so the problam will be terminated by SIGINT from child process. Thi=
s patch fixed the problem. And also fixed the following compile warning. =
mq_timedreceive01.c: In function =E2=80=98do_test=E2=80=99: mq_timedrecei=
ve01.c:379: warning: null argument where non-null required (argument 5). =
Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>,

Modified Files:
ltp/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c

51) Log Message:
rohit verma <rohit.170309@gmail.com> reported: I am running waitid02.c (l=
tp-full-20090630/testcases/kernel/syscalls/waitid/ ) test case on 2.6.29 =
kernel. Test case gives following error: "Error. is your system >2.6.9 ?"=
; Subrata Modak <subrata@linux.vnet.ibm.com> fixed this.=20

Modified Files:
ltp/testcases/kernel/syscalls/waitid/waitid02.c

52) Log Message:
- Replace bashisms: source, uid, substr, '&>' - redirection, '=3D=3D'.=20
- To create a file using 'sudo -u', some platforms require 'user' to exis=
t.
- Document verifying PCR-10 fails on Ubuntu on reboot due to kexec.
- Determine if the entire boot-aggregate hash value is zero, not just the=
 first couple of characters.
- Add a space before the continuation mark on wrapped lines.
- Explicity verify file open return codes, making sure that only one open=
 succeeded (tpm_policy.sh: test02).
Signed-off-by: Mimi Zohar <zohar@us.ibm.com>.

Modified Files:
ltp/testcases/kernel/security/integrity/ima/README
ltp/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
ltp/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
ltp/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
ltp/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
ltp/testcases/kernel/security/integrity/ima/tests/ima_violations.sh

53) Log Message:
This is v4l-test 0.17 for LTP. Changes: Test cases added for VIDIOC_ENUM_=
FRAMESIZES and VIDIOC_G_JPEGCOMP. New V4L2_PIX_FMT_* formats also used in=
 test cases. Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>.

Modified Files:
ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
ltp/testcases/kernel/device-drivers/v4l/user_space/README
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_FMT.c
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h
ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c
ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.html
ltp/testcases/kernel/device-drivers/v4l/user_space/doc/results.html
Added Files:
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_ENUM_FRAME=
SIZES.c
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_ENUM_FRAME=
SIZES.h
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_JPEGCOMP.c
ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_JPEGCOMP.h

54) Log Message:
sync_file_range01 testcase BUG and PATCH: The testcase sync_file_range01 =
uses a file descriptor (variable sfd) in its second test, expcting to see=
 an ESPIPE error. Unfortunately, the code's open of that file descriptor =
somehow ended up within a set of curly braces encompasing an error path, =
not the mainline code where it should be. Thus, sfd is never set, In prac=
tice this leaves sfd set to zero. That is actually stdin and stdin can wo=
rk for the testcase but it is not guaranteed. In fact it mostly works, bu=
t it hapens to fail sometimes. The attached patch causes the open for sfd=
 (to /dev/null) to actually get invoked. Signed-off-by: Robert Paulsen <r=
paulsen@us.ibm.com>.

Modified Files:
ltp/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c

55) Log Message:
Add new testcases for cpu controller: My workmate Miao Xie (miaox@cn.fuji=
tsu.com) has created some testcases for cgroup's subsystem "cpu" in the l=
ast year. And, He catched some kernel bugs through these testcases. So we=
 think you glad to push them into LTP. There are total 22 testcases that =
have been added. These testcases contain the basis operation test and par=
t functionality test of cpu controller. Signed-off-by: Shi Weihua <shiwh@=
cn.fujitsu.com>.

Modified Files:
ltp/testcases/kernel/controllers/Makefile
ltp/testcases/kernel/controllers/test_controllers.sh
Added Files:
ltp/testcases/kernel/controllers/cpuctl_fj/Makefile
ltp/testcases/kernel/controllers/cpuctl_fj/README
ltp/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c
ltp/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_simple_echo.c
ltp/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh

56) Log Message:
I have notice HUNG status for pthread_equal/2-1.c under posix test suite.=
 conformance/interfaces/pthread_equal/2-1.test:execution:HUNG. This becau=
se of while(do_it)loop is behaving as while(1). do_it updated value from =
one thread is not reflecting in the other thread because the type is not =
proper. I have changed the type from char -> volatile int. I have shared =
results before and after this patch.
Before PATCH: conformance/interfaces/pthread_equal/2-1.test:execution:HUN=
G,
After PATCH:  conformance/interfaces/pthread_equal/2-1.test:execution:PAS=
S,
I have attached patch and below. Please review the same. Signed-off-by: N=
aresh Kamboju <naresh.kernel@gmail.com>.

Modified Files:
ltp/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2=
-1.c


--=-ZQXM8M1q9cwIk/Ur3gEV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--=-ZQXM8M1q9cwIk/Ur3gEV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-ZQXM8M1q9cwIk/Ur3gEV--


