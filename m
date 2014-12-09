Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XyKTB-0004hl-9T
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 13:04:49 +0000
Date: Tue, 9 Dec 2014 14:04:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141209130429.GB1576@rei.suse.de>
References: <tencent_18E2F5FD3ACC10A855AF6945@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_18E2F5FD3ACC10A855AF6945@qq.com>
Subject: Re: [LTP] Could you help me to analyse the LTP output
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
To: Troy-lee <798528972@qq.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> accept04_01    1  TBROK  :  accept4_01.c:121: Connect Error: errno=ENETUNREACH(101): Network is unreachable
> accept04_01    2  TBROK  :  accept4_01.c:121: Remaining cases broken

This looks like loopback device is not configured correctly.

> access06		2
> <<<test_start>>>
> tag=access06 stime=946685015
> cmdline="access06"
> contacts=""
> analysis=exit
> <<<test_output>>>
> access06    0  TINFO  :  Using test device LTP_DEV=''
> access06    1  TBROK  :  ../include/safe_macros.h:297: tst_device.c:180: stat(,0xbedc0640) failed: errno=ENOENT(2): No such file or directory
> access06    2  TBROK  :  ../include/safe_macros.h:297: Remaining cases broken

This looks like runltp failure. The LTP_DEV was not prepared correctly.

What distribution/kernel version/LTP version is this?

> connect01		2
> <<<test_start>>>
> tag=connect01 stime=946685141
> cmdline="connect01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> connect01    1  TPASS  :  bad file descriptor successful
> connect01    2  TPASS  :  invalid socket buffer successful
> connect01    3  TPASS  :  invalid salen successful
> connect01    4  TPASS  :  invalid socket successful
> connect01    5  TBROK  :  connect01.c:237: socket setup failed connect test 4: errno=EINVAL(22): Invalid argument
> connect01    6  TBROK  :  connect01.c:237: Remaining cases broken
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=2 corefile=no
> cutime=0 cstime=4
> <<<test_end>>>
> 
> fcntl07_64		2
> <<<test_start>>>
> tag=fcntl07_64 stime=946685258
> cmdline="fcntl07_64"
> contacts=""
> analysis=exit
> <<<test_output>>>
> /udisk/ltp/testcases/bin/fcntl07_64: line 1: syntax error: unexpected word (expecting ")")

This is really strange. The fcntl07_64 is a binary compiled from C
source and this is an error from shell.

> fstatfs01		1
> <<<test_start>>>
> tag=fstatfs01 stime=946687988
> cmdline="fstatfs01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> fstatfs01    1  TPASS  :  fstatfs() on a file - f_type=858458f6
> fstatfs01    2  TFAIL  :  fstatfs01.c:92: fstatfs() on a pipe: TEST_ERRNO=ENOSYS(38): Function not implemented

This is a bug in kernel. The fstatfs() on a pipe was accidentally
disabled and then reenabled back.

See BUGS section in:

http://man7.org/linux/man-pages/man2/statfs.2.html

> getegid02		2
> <<<test_start>>>
> tag=getegid02 stime=946688011
> cmdline="getegid02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> getegid02    1  TBROK  :  getegid02.c:66: geteuid() returned unexpected value 0
> getegid02    2  TBROK  :  getegid02.c:66: Remaining cases broken
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=2 corefile=no
> cutime=0 cstime=15
> <<<test_end>>>
> 
> 
> getegid02_16	2
> <<<test_start>>>
> tag=getegid02_16 stime=946688012
> cmdline="getegid02_16"
> contacts=""
> analysis=exit
> <<<test_output>>>
> getegid02_16    1  TBROK  :  getegid02.c:66: geteuid() returned unexpected value 0
> getegid02_16    2  TBROK  :  getegid02.c:66: Remaining cases broken

This looks like a system configuration problem. The test tries to get
entry from /etc/passwd for root user but fails to do so.

> getrusage03		2
> <<<test_start>>>
> tag=getrusage03 stime=946688040
> cmdline="getrusage03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> getrusage03    0  TINFO  :  allocate 100MB
> getrusage03    1  TBROK  :  safe_macros.c:152: getrusage03.c:343: malloc(104857600) failed: errno=ENOMEM(12): Cannot allocate memory
> getrusage03    2  TBROK  :  safe_macros.c:152: Remaining cases broken

This one should be pretty self explaining. Not enough memory and/or
turned off memory overcommit.

> ioctl03			2
> <<<test_start>>>
> tag=ioctl03 stime=946688083
> cmdline="     ioctl03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> ioctl03     1  TBROK  :  ioctl03.c:102: opening /dev/net/tun failed: errno=ENOENT(2): No such file or directory
> ioctl03     2  TBROK  :  ioctl03.c:102: Remaining cases broken
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=2 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>
> 
> 
> inotify01		36
> <<<test_start>>>
> tag=inotify01 stime=946688085
> cmdline="inotify01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> inotify01    1  TCONF  :  inotify01.c:224: inotify is not configured in this kernel.
> inotify01    2  TCONF  :  inotify01.c:224: Remaining cases not appropriate for configuration
> inotify01    0  TWARN  :  inotify01.c:243: inotify_rm_watch (-1, 0) failed: errno=ENOSYS(38): Function not implemented
> inotify01    0  TWARN  :  inotify01.c:248: close(-1) failed

This is a bug in the test when inotify is not compiled in kernel. The
test tries to do a cleanup but fails to do so because the initialization
wasn't done.

I will fix that.

> move_pages03	1
> <<<test_start>>>
> tag=move_pages03 stime=946688201
> cmdline="cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod 04755 move_pages03 && move_pages.sh 03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> chown: unknown user root

Again looks like something is wrong with /etc/passwd

> mq_notify01		1
> <<<test_start>>>
> tag=mq_notify01 stime=946688214
> cmdline="mq_notify01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
> RESULT: return value(ret)=-1 errno=38 (Function not implemented)
> EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
> RESULT: return value(ret)=-1 errno=38 (Function not implemented)
> EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
> RESULT: return value(ret)=-1 errno=38 (Function not implemented)
> mq_notify01    0  TINFO  :  (case00) START
> mq_notify01    1  TFAIL  :  mq_notify01.c:208: mq_open failed: TEST_ERRNO=ENOSYS(38): Function not implemented
> mq_notify01    0  TINFO  :  (case00) END => NG
> mq_notify01    0  TINFO  :  (case01) START
> mq_notify01    2  TFAIL  :  mq_notify01.c:208: mq_open failed: TEST_ERRNO=ENOSYS(38): Function not implemented
> mq_notify01    0  TINFO  :  (case01) END => NG
> mq_notify01    0  TINFO  :  (case02) START
> mq_notify01    3  TFAIL  :  mq_notify01.c:208: mq_open failed: TEST_ERRNO=ENOSYS(38): Function not implemented
> mq_notify01    0  TINFO  :  (case02) END => NG
> mq_notify01    0  TINFO  :  (case03) START
> mq_notify01    0  TINFO  :  (case03) END => NG
> mq_notify01    0  TINFO  :  (case04) START
> mq_notify01    0  TINFO  :  (case04) END => NG
> mq_notify01    0  TINFO  :  (case05) START
> mq_notify01    0  TINFO  :  (case05) END => NG
> mq_notify01    0  TINFO  :  (case06) START
> mq_notify01    4  TFAIL  :  mq_notify01.c:208: mq_open failed: TEST_ERRNO=ENOSYS(38): Function not implemented
> mq_notify01    0  TINFO  :  (case06) END => NG
> mq_notify01    5  TFAIL  :  mq_notify01.c:354: mq_notify failed
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>

These tests are broken if mq_* syscalls are not compiled in kernel and
should be fixed as well.

> nanosleep02		1
> <<<test_start>>>
> tag=nanosleep02 stime=946688438
> cmdline="nanosleep02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> nanosleep02    0  TWARN  :  nanosleep02.c:209: This test could fail if the system was under load
> nanosleep02    0  TWARN  :  nanosleep02.c:211: due to the limitation of the way it calculates the
> nanosleep02    0  TWARN  :  nanosleep02.c:212: system call execution time.
> nanosleep02    1  TFAIL  :  nanosleep02.c:215: Remaining sleep time 3995059 usec doesn't match with the expected 3999263 usec time
> nanosleep02    1  TFAIL  :  nanosleep02.c:163: child process exited abnormally; status = 1280
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>

No idea here. Will need to be analysed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
