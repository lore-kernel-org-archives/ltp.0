Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MuvKa-00027n-Qh
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 21:42:56 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MuvKR-0005d9-Oc
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 21:42:56 +0000
Received: by pzk31 with SMTP id 31so183100pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Oct 2009 14:42:42 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 Oct 2009 14:42:41 -0700
Message-ID: <364299f40910051442l63ca59a5p9ed051b4ae1645ed@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Issue 2 : performance_counter01 doesn't proceed
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

Hi again all,
    I'm seeing the following issue with performance_counter01 with the
new Makefile infrastructure:

--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
read(0, 0x7fffe6215d80, 8)              = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) @ 0 (0) ---
^C0) ---
Process 29453 detached

    The output in the log is:

<<<test_start>>>
tag=performance_counter01 stime=1254771052
cmdline="performance_counter01"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=7549 termination_type=signaled termination_id=9 corefile=no
cutime=0 cstime=8
<<<test_end>>>
<<<test_start>>>
tag=performance_counter02 stime=1254778601
cmdline="performance_counter02"
contacts=""
analysis=exit
<<<test_output>>>
perf_counter_open: Bad file descriptor
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>

    Basically it looks like it's trying to open a TTY that it
shouldn't be. Has anyone seen this issue before?
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
