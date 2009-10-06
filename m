Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MvCPp-0000bW-59
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 15:57:29 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvCPk-0000WT-W8
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 15:57:29 +0000
Received: by pxi39 with SMTP id 39so4187070pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Oct 2009 08:57:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910051008m75f86892n1e32b26dfb76b697@mail.gmail.com>
References: <364299f40910051008m75f86892n1e32b26dfb76b697@mail.gmail.com>
Date: Tue, 6 Oct 2009 08:57:18 -0700
Message-ID: <364299f40910060857m5ed618abyde133ed3c6d0628@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Issue 1 - indefinite hang with cgroup_regression_test.sh
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
To: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Oct 5, 2009 at 10:08 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> Hi all,
> =A0 =A0I'm just reporting issues as I go and will go back and fix things
> from my end as far as missing installation files are concerned, but
> these are bugs that will need to be fixed in the individual scripts
> that I've noted.
> Thanks,
> -Garrett
>
> <<<test_start>>>
> tag=3Dcgroup stime=3D1254736274
> cmdline=3D" =A0 =A0 =A0 cgroup_regression_test.sh"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> cgroup_regression_test =A0 =A01 =A0TPASS =A0: =A0no kernel bug was found
> /scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
> 121: =A02884 Terminated =A0 =A0 =A0 =A0 =A0 =A0 =A0./fork_processes
> cgroup_regression_test =A0 =A02 =A0TPASS =A0: =A0notify_on_release is inh=
erited
> cgroup_regression_test =A0 =A03 =A0TCONF =A0: =A0CONFIG_SCHED_DEBUG is no=
t enabled
> cgroup_regression_test =A0 =A04 =A0TCONF =A0: =A0CONFIG_LOCKDEP is not en=
abled
> cgroup_regression_test =A0 =A05 =A0TPASS =A0: =A0no kernel bug was found
> /scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
> 296: 12285 Terminated =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep 100
> /scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
> 316: ./test_6_1.sh: No such file or directory
> /scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
> 325: 12304 Terminated =A0 =A0 =A0 =A0 =A0 =A0 =A0./test_6_2
> cgroup_regression_test =A0 =A06 =A0TPASS =A0: =A0no kernel bug was found
> /scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
> 363: 13326 Terminated =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep 100 < cgroup/0
> /scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
> 384: 13345 Terminated =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep 100 < cgroup/0
> cgroup_regression_test =A0 =A07 =A0TPASS =A0: =A0no kernel bug was found

Even when I fixed the installed files, I'm seeing indefinite hangs in
cgroup_regression_test:

cgroup_regression_test    1  TPASS  :  no kernel bug was found
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
121: 26499 Terminated              ./fork_processes
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
cgroup_regression_test    3  TCONF  :  CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test    4  TCONF  :  CONFIG_LOCKDEP is not enabled
mount: xxx already mounted or cgroup/ busy
cgroup_regression_test    5  TFAIL  :  mount freezer and devices failed
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
324:  1801 Terminated              ./test_6_2
cgroup_regression_test    6  TPASS  :  no kernel bug was found
umount: cgroup/: not mounted
mount: xxx already mounted or cgroup/ busy
cgroup_regression_test    7  TFAIL  :  failed to mount freezer
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
384: 11610 Terminated              sleep 100 < cgroup/0
cgroup_regression_test    7  TPASS  :  no kernel bug was found
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D17888 termination_type=3Dsignaled termination_id=3D15 corefile=
=3Dno
cutime=3D300 cstime=3D1560
<<<test_end>>>
<<<test_start>>>

I'm not surprised after looking at the script because there are a
number of wait(1) call's that wait on spawned PID's and I'm not sure
whether or not they are being handled appropriately.

Perhaps the script should be rewritten to either:

a) Not use wait; a while loop with kill 0 should work better.
b) Install an alarm / trap call (not possible with bourne shell).
c) Be written in another language (C or python -- that seems to be our
other language, as per power_management), that is capable of
non-blocking based waits.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
