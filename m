Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NPD7F-0007SF-Qn
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2009 10:46:21 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NPD7B-000775-Na
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2009 10:46:21 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBSAghdq029115
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:42:43 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBSAfql21462408
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:41:52 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBSAk5Il020557
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:46:05 +1100
Message-ID: <4B388C68.9000304@linux.vnet.ibm.com>
Date: Mon, 28 Dec 2009 16:16:00 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/2 ] LTP Memory controller smarter check for
 enable/disable functionality
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
To: LTP <ltp-list@lists.sourceforge.net>
Cc: iranna.ankad@in.ibm.com, svishuku@in.ibm.com

Hi All,

Current memory controller implelementation in LTP does not check if 
memory controller is enabled or not. It only check for memory contorller 
kernel support. It may happen that some distro would have disabled 
functionality. e.g:

mhs21a:/opt/ltp # cat /proc/cgroups  | grep -e num_ -e memory -e freezer
#subsys_name    hierarchy    num_cgroups    enabled
memory    0    1    0
freezer    0    1    1
mhs21a:/opt/ltp #


Here 4th parameter shows the exact support for functionality as 
enabled/disabled. As here clearly it shows that memory controller is 
disabled and freezer is enabled.

My patch supports for this functionality.

[PATCH 1/2 ] : Added check for all controller to LTP.
[PATCH 2/2 ] : Added check to memory controller functiona,regression & 
stress testcase scripts.

Comments are welcome.

It has been tested and here are the result.

Without applying patch:

===========================================

<<snip>>
<<<execution_status>>>
initiation_status="ok"
duration=124 termination_type=exited termination_id=0 corefile=no
cutime=2046 cstime=4111
<<<test_end>>>
<<<test_start>>>
tag=memcg_regression stime=1261991350
cmdline="memcg_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
mount: wrong fs type, bad option, bad superblock on xxx,
        missing codepage or helper program, or other error
        (for several filesystems (e.g. nfs, cifs) you might
        need a /sbin/mount.<type> helper program)
        In some cases useful info is found in syslog - try
        dmesg | tail  or so

memcg_regression_test    1  TFAIL  :  failed to mount memory subsytem
mount: wrong fs type, bad option, bad superblock on xxx,
        missing codepage or helper program, or other error
        (for several filesystems (e.g. nfs, cifs) you might
        need a /sbin/mount.<type> helper program)
        In some cases useful info is found in syslog - try
        dmesg | tail  or so
<<snip>>

==============================================




And with patch:


===========================================
<<snip>>

Running tests.......
<<<test_start>>>
tag=memcg_regression stime=1261996253
cmdline="memcg_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
WARNING:
Kernel does not support for memory resource controller
Skipping all memcgroup testcases....
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=memcg_function stime=1261996253
cmdline="    memcg_function_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
WARNING:
Kernel does not support for memory resource controller
Skipping all memcgroup testcases....
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=memcg_stress stime=1261996253
cmdline="    memcg_stress_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
WARNING:
Kernel does not support for memory resource controller
Skipping all memcgroup testcases....
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20091130
<<snip>>
=============================================

Thanks
Rishi


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
