Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Njo6S-0003Ij-Fb
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 06:18:40 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Njo6R-0004YF-CC
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 06:18:40 +0000
Received: by pxi1 with SMTP id 1so1969376pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Feb 2010 22:18:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100223050701.GB11102@linux.vnet.ibm.com>
References: <20100223050701.GB11102@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2010 22:18:33 -0800
Message-ID: <364299f41002222218h472f3f2dpd5cd33f9467e121d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Container Test should not run on older distro kernel
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
To: LTP <ltp-list@lists.sourceforge.net>, yanegomi@gmail.com, serue@us.ibm.com

On Mon, Feb 22, 2010 at 9:07 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> Hi All,
>
> I ran feb'10 intermediate release on RHEL5.4. And found that it is
> running pidns testcase which is not at all require.
>
> Garret is it require to disable check_pidns_enabled.c which has been
> masked for now ? I think we will need this file as it does more than
> kernel version comparison.
>
> can someone look into it please ?
>
> Here are the failures which i am getting:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ...
> COMMAND: =A0 =A0/opt/ltp/bin/ltp-pan =A0-e -S =A0 -a 31429 =A0 =A0 -n 314=
29 =A0-p =A0-f
> /tmp/ltp-wcBkk31437/alltests -l
> /opt/ltp/results/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.log =A0-C
> /opt/ltp/output/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.failed
> LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.log
> FAILED COMMAND File:
> /opt/ltp/output/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.failed
> Running tests.......
> <<<test_start>>>
> tag=3DContainers stime=3D1266918687
> cmdline=3D"container_test.sh"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> /opt/ltp/testcases/bin/container_test.sh: line 13: check_for_unshare:
> command not found
> Uts namespaces not enabled in kernel. =A0Not running utsns tests.
> ipc namespaces not enabled in kernel. =A0Not running ipcns tests.
> Running pidns tests.
> pid_namespace1 =A0 =A00 =A0TINFO =A0: =A0PIDNS test is running inside con=
tainer
>
> pid_namespace1 =A0 =A01 =A0TFAIL =A0: =A0FAIL: Got unexpected result of c=
pid=3D31542
> ppid=3D31541
>
> pid_namespace2 =A0 =A00 =A0TINFO =A0: =A0Checking session id & group id i=
nside
> container
>
> pid_namespace2 =A0 =A01 =A0TFAIL =A0: =A0Got unexpected result ofGroup ID=
 =3D 31544
> & Session ID =3D 31544
>
> pid_namespace3 =A0 =A00 =A0TINFO =A0: =A0 Checking pid for parent ns and
> container-init
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Parent namespace pid =3D 31545,container p=
arent pid =3D
> 31545,and container pid =3D 31546
> pid_namespace3 =A0 =A01 =A0TFAIL =A0: =A0mount failed :
>
> pid_namespace3 =A0 =A02 =A0TPASS =A0: =A0Got the proc file directory crea=
ted by
> parent ns 31545
> pid_namespace4 =A0 =A01 =A0TFAIL =A0: =A0got unexpected result of cpid=3D=
31548
> ppid=3D31547
> pid_namespace4 =A0 =A01 =A0TFAIL =A0: =A0Container init is killed by SIGK=
ILL !!!
> pidns05 =A0 =A0 1 =A0TFAIL =A0: =A0FAIL: Got unexpected result of cpid=3D=
31551
> ppid=3D31550
>
> pidns05 =A0 =A0 1 =A0TFAIL =A0: =A0Unable to create 5 containers
>
> pidns06 =A0 =A0 0 =A0TINFO =A0: =A0Parent: Passing the pid of the process=
 31552
> pidns06 =A0 =A0 1 =A0TFAIL =A0: =A0Unexpected result for Container: =A0in=
it
> pid=3D31553 parent pid=3D31552
>
> pidns30 =A0 =A0 1 =A0TBROK =A0: =A0parent: mq_open() failed (Permission d=
enied)
> pidns31 =A0 =A0 1 =A0TBROK =A0: =A0parent: mq_open() failed (Permission d=
enied)
> pidns10 =A0 =A0 1 =A0TBROK =A0: =A0cinit: pidns is not created.
> pidns10 =A0 =A0 1 =A0TBROK =A0: =A0parent: container was terminated by Un=
known
> signal 0
> pidns12 =A0 =A0 0 =A0TINFO =A0: =A0parent: PID is 31558
> pidns12 =A0 =A0 1 =A0TBROK =A0: =A0cinit: pidns is not created.
> pidns12 =A0 =A0 1 =A0TBROK =A0: =A0parent: container did not respond!
> pidns13 =A0 =A0 1 =A0TBROK =A0: =A0cinit1: pidns is not created.
> pidns13 =A0 =A0 1 =A0TBROK =A0: =A0cinit2: pidns is not created.
> pidns16 =A0 =A0 1 =A0TBROK =A0: =A0pidns is not created.
> pidns16 =A0 =A0 0 =A0TINFO =A0: =A0sig_handler is signalled from pid =A03=
1563
> pidns16 =A0 =A0 0 =A0TINFO =A0: =A0Container: Resumed after receiving SIG=
USR1 from
> parentNS
> pidns16 =A0 =A0 2 =A0TBROK =A0: =A0Unexpected value for Sending-ProcessID=
 when
> signal handler called 31564
>
> pidns16 =A0 =A0 0 =A0TINFO =A0: =A0Container: Resumed after sending SIGUS=
R1 from
> container itself
> pidns16 =A0 =A0 1 =A0TPASS =A0: =A0container init continued successfuly, =
after
> handling signal -USR1
>
> pidns17 =A0 =A0 1 =A0TBROK =A0: =A0cinit: pidns is not created.
>
> <----- stuck here, i never get the shell back here :(.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Well, it shouldn't be run on any kernels without container support
properly enabled, not just old kernels. I readded it from an old copy
in CVS.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
