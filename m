Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shwetabh.goel@calsoftinc.com>) id 1NmmLQ-0001za-Ql
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 11:02:24 +0000
Received: from inbox235.nyi.net ([66.111.15.35])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NmmLP-0004PS-Ql
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 11:02:24 +0000
Received: from imss.calsofthq.com (imss.calsofthq.com [172.16.0.44])
	by mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id o23AZY5k029719
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 16:05:34 +0530
Received: from imss.calsofthq.com (localhost.localdomain [127.0.0.1])
	by localhost.calsofthq.com (Postfix) with ESMTP id AE4A21BE10AB
	for <ltp-list@lists.sourceforge.net>;
	Wed,  3 Mar 2010 16:10:27 +0530 (IST)
Received: from mail.calsofthq.com (mail.calsofthq.com [172.16.0.7])
	by imss.calsofthq.com (Postfix) with ESMTP id 933AC1BE1092
	for <ltp-list@lists.sourceforge.net>;
	Wed,  3 Mar 2010 16:10:27 +0530 (IST)
Received: from [172.17.6.83] (shwetabhg.calsofthq.com [172.17.6.83])
	(authenticated bits=0)
	by mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id o23AZXCR029710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 16:05:33 +0530
Message-ID: <4B8E3B7F.8050301@calsoftinc.com>
Date: Wed, 03 Mar 2010 16:05:43 +0530
From: Shwetabh <shwetabh.goel@calsoftinc.com>
MIME-Version: 1.0
Subject: [LTP] Missing test tools in recent ltp builds
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
To: ltp-list@lists.sourceforge.net

Hi,

In recent ltp releases, I see quite a few test cases breaking since 
their required tools
are not being copied over to /opt/ltp/testcases/. I believe this 
behaviour started since
ltp started compiling and copying the files to /opt/ltp. Here is an example:

----<<snip>>-----------
remove test cases which require the block device.
You can specify it with option -b
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 27204     -n 27204  -p  -f 
/tmp/ltp-gcfmm27210/alltests -l 
/opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log  -C 
/opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log
FAILED COMMAND File: 
/opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
Running tests.......
<<<test_start>>>
tag=CPUHOTPLUG stime=1267586681
cmdline="(cd $LTPROOT/testcases/kernel/hotplug/cpu_hotplug/; ./runtests.sh)"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
sh: line 0: cd: /opt/ltp/testcases/kernel/hotplug/cpu_hotplug/: No such 
file or directory
sh: ./runtests.sh: No such file or directory
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=127 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100228

        ###############################################################"

             Done executing testcases."
             LTP Version:  LTP-20100228
        ###############################################################"

[root@localhost runtest]# cd /opt/ltp/testcases/
[root@localhost testcases]# ls
bin  data
[root@localhost testcases]# pwd
/opt/ltp/testcases
[root@localhost testcases]# ls -l
total 76
drwxr-xr-x 7 root root 69632 Mar  2 22:24 bin
drwxr-xr-x 2 root root  4096 Mar  2 22:19 data

--------------------

Please advice if I am doing something wrong here. Do I manually have to 
copy the tools from tarballs' testcases/kernel directory?
If so, shouldn't this be done by make install?

-- 
Regards,
Shwetabh


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
