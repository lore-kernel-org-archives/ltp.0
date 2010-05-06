Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Xu@windriver.com>) id 1O9x4o-0001Ov-7e
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 09:09:02 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9x4i-0003Hm-W1
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 09:09:02 +0000
From: Henry xu <feng.xu@windriver.com>
Date: Thu, 06 May 2010 17:14:04 +0800
Message-Id: <1273137244.26977.134.camel@lishuang-desktop>
Mime-Version: 1.0
Subject: [LTP] ltp inotify03 testcase failed in version of 20100228
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
To: ltp-list <ltp-list@lists.sf.net>

Hi,all

I test inotify03 in  ppc platform and product two fails as
below.
<<<test_start>>>
tag=inotify03 stime=1272626381
cmdline="inotify03 -D /dev/loop0 -T ext3"
contacts=""
analysis=exit
<<<test_output>>>
inotify03    0  TINFO  :  mount /dev/loop0 to mnt_18067 fstype=ext3
inotify03    0  TINFO  :  umount /dev/loop0
inotify03    1  TFAIL  :  get event: wd=1 mask=8000 (expected 2000)
cookie=0 len=0
inotify03    2  TFAIL  :  don't get event: mask=8000
inotify03    3  TPASS  :  inotify_rm_watch (5, 1) return -1 errno=22 :
Invalid argument


when I type "./runltp -s inotify" for inotify test, the inotify03 test
is  not been executed.The information is as below.

I look into the code ,however I could not get why mask is equal to
8000.Could someone give your comments on this case?

thanks in advance!

================================================================
You can specify it with option -b
COMMAND:    /opt/ltp-full/bin/ltp-pan  -e -S   -a 26692     -n 26692  -p
-f /tmp/ltp-rUQUk26698/alltests
-l /opt/ltp-full/results/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.log
-C /opt/ltp-full/output/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.failed
INFO: Restricted to inotify
LOG File: /opt/ltp-full/results/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.log
FAILED COMMAND
File: /opt/ltp-full/output/LTP_RUN_ON-1970_Jan_02-02h_51m_52s.failed
Running tests.......
<<<test_start>>>
tag=inotify_init1_01 stime=96713
cmdline="inotify_init1_01"
contacts=""
analysis=exit
<<<test_output>>>
inotify_init1_01    1  TPASS  :  inotify_init1(O_CLOEXEC) PASSED
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=inotify_init1_02 stime=96714
cmdline="inotify_init1_02"
contacts=""
analysis=exit
<<<test_output>>>
inotify_init1_02    1  TPASS  :  inotify_init1(IN_NONBLOCK) PASSED
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=inotify01 stime=96714
cmdline="inotify01"
contacts=""
analysis=exit
<<<test_output>>>
inotify01    1  TPASS  :  get event: wd=1 mask=4 cookie=0 len=0
inotify01    2  TPASS  :  get event: wd=1 mask=20 cookie=0 len=0
inotify01    3  TPASS  :  get event: wd=1 mask=1 cookie=0 len=0
inotify01    4  TPASS  :  get event: wd=1 mask=10 cookie=0 len=0
inotify01    5  TPASS  :  get event: wd=1 mask=20 cookie=0 len=0
inotify01    6  TPASS  :  get event: wd=1 mask=2 cookie=0 len=0
inotify01    7  TPASS  :  get event: wd=1 mask=8 cookie=0 len=0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=inotify02 stime=96714
cmdline="inotify02"
contacts=""
analysis=exit
<<<test_output>>>
inotify02    1  TPASS  :  get event: wd=1 mask=40000004 cookie=0 len=0
name=""
inotify02    2  TPASS  :  get event: wd=1 mask=100 cookie=0 len=16
name="test_file1"
inotify02    3  TPASS  :  get event: wd=1 mask=20 cookie=0 len=16
name="test_file1"
inotify02    4  TPASS  :  get event: wd=1 mask=8 cookie=0 len=16
name="test_file1"
inotify02    5  TPASS  :  get event: wd=1 mask=40 cookie=4553 len=16
name="test_file1"
inotify02    6  TPASS  :  get event: wd=1 mask=80 cookie=4553 len=16
name="test_file2"
inotify02    7  TPASS  :  get event: wd=1 mask=800 cookie=0 len=0
name=""
inotify02    8  TPASS  :  get event: wd=1 mask=200 cookie=0 len=16
name="test_file2"
inotify02    9  TPASS  :  get event: wd=1 mask=800 cookie=0 len=0
name=""
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100228
        
       ###############################################################"
        
            Done executing testcases."
            LTP Version:  LTP-20100228
       ###############################################################"

=============================================================================

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
