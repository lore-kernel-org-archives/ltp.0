Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NbMDS-00042K-1u
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 22:54:58 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NbMDR-0002MV-64
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 22:54:57 +0000
Received: by pzk37 with SMTP id 37so2716051pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Sat, 30 Jan 2010 14:54:51 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 30 Jan 2010 14:54:51 -0800
Message-ID: <364299f41001301454l58c05f9en874521cb14829f66@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Noise from `parameters.sh'
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

    Please fix the typos and the permission denied item in the testcase.
Thanks,
-Garrett

gcooper@orangebox /scratch/ltp $ tail -f
/tmp/tmp.BvZJxbLPl2/tmp/tmp.qOm2VoKTOg/output/controllers-output.log

[...]

TEST 7: CPU CONTROLLER STRESS TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes
/tmp/tmp.BvZJxbLPl2/tmp/tmp.qOm2VoKTOg/testcases/bin/parameters.sh:
line 56: /dev/cpuctl/group_def/cpu.rt_runtime_us: Permission denied
Succesfully launched def task 30410 too
TASKS FIRED
^C
gcooper@orangebox /scratch/ltp $ ls/dev/cpuctl/group_def/cpu.rt_runtime_us^Cl
gcooper@orangebox /scratch/ltp $ ls -l /dev/cpuctl/group_def/cpu.rt_runtime_us
ls: cannot access /dev/cpuctl/group_def/cpu.rt_runtime_us: No such
file or directory
gcooper@orangebox /scratch/ltp $ ls -l /dev/cpuctl/group_def/
total 0
-rw-r--r-- 1 root root 0 Jan 30 14:50 cpu.shares
-rw-r--r-- 1 root root 0 Jan 30 14:50 notify_on_release
-rw-r--r-- 1 root root 0 Jan 30 14:50 tasks

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
