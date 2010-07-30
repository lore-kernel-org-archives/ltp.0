Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gurudas.pai@oracle.com>) id 1OeidH-0007Of-P7
	for ltp-list@lists.sourceforge.net; Fri, 30 Jul 2010 05:59:47 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OeidH-0000CT-1D
	for ltp-list@lists.sourceforge.net; Fri, 30 Jul 2010 05:59:47 +0000
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by rcsinet10.oracle.com (Switch-3.4.2/Switch-3.4.2) with ESMTP id
	o6U5xeO6022133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 30 Jul 2010 05:59:41 GMT
Received: from acsmt355.oracle.com (acsmt355.oracle.com [141.146.40.155])
	by rcsinet15.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id
	o6U4BedS023280
	for <ltp-list@lists.sourceforge.net>; Fri, 30 Jul 2010 05:59:35 GMT
Message-ID: <4C5267A2.1070800@oracle.com>
Date: Fri, 30 Jul 2010 11:18:18 +0530
From: Gurudas Pai <gurudas.pai@oracle.com>
MIME-Version: 1.0
Subject: [LTP] LTP-20100630:POWER_MANAGEMENT runpwtests.sh fails.
Reply-To: gurudas.pai@oracle.com
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

Hi There,

I am using LTP-20100630 , and while running POWER_MANAGEMENT test
I get following errors,

/opt/ltp/testcases/bin/runpwtests.sh: line 201: get_sched_values: 
command not found


Change log shows get_sched_values.c is removed.

92) Log Message:
1. Remove the .c files and all calls in runpwtests.sh because we can 
achieve the same thing through additional shell test logic.
2. Add the apicmds dependency.
Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Modified Files:
ltp/testcases/kernel/power_management/Makefile
ltp/testcases/kernel/power_management/runpwtests.sh
Removed Files:
ltp/testcases/kernel/power_management/check_kv_arch.c
ltp/testcases/kernel/power_management/get_sched_values.c


So how could I fix this issue.


Thanks,
-guru

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
