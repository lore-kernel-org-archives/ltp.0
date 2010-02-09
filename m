Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NemSv-0000ey-F6
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 09:33:05 +0000
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NemSt-0003zS-U8
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 09:33:05 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o199WlZr026367
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 15:02:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o199WlYK2777102
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 15:02:47 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o199WlBN000901
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 20:32:47 +1100
Message-ID: <4B712BBF.3060704@linux.vnet.ibm.com>
Date: Tue, 09 Feb 2010 15:02:47 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] container_test.sh failure
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi Garret,

With today's cvs getting following error while running the container 
testcases.

...
/opt/ltp/testcases/bin/container_test.sh: line 52: check_mqns_enabled: 
command not found
Posix message queues or ipc namespaces not enabled in kernel.
Not running mqns tests.
/opt/ltp/testcases/bin/container_test.sh: line 61: check_netns_enabled: 
command not found
Network namespaces not enabled in kernel.  Not running netns tests.
<<<execution_status>>>
initiation_status="ok"
duration=10 termination_type=exited termination_id=0 corefile=no
cutime=7 cstime=22
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100131

        ###############################################################"

             Done executing testcases."
             LTP Version:  LTP-20100131
        ###############################################################"

x440:/opt/ltp #

Do you think we need to just do the fix as you did for pidns ? I feel 
check_*_enabled.c does more a lot than just checking kernel version. So 
keeping that file will be a good idea. Please let me know your thought.

-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


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
