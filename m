Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shyju.pv@huawei.com>) id 1T5Elm-0002wQ-5j
	for ltp-list@lists.sourceforge.net; Sat, 25 Aug 2012 11:43:14 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T5Elh-0005OY-2V
	for ltp-list@lists.sourceforge.net; Sat, 25 Aug 2012 11:43:14 +0000
From: Shyju PV <shyju.pv@huawei.com>
References: <mailman.414062.1338991083.27891.ltp-list@lists.sourceforge.net>
In-Reply-To: <mailman.414062.1338991083.27891.ltp-list@lists.sourceforge.net>
Date: Sat, 25 Aug 2012 17:12:09 +0530
Message-ID: <043301cd82b6$a9809f10$fc81dd30$@pv@huawei.com>
MIME-Version: 1.0
Content-Language: en-us
Subject: [LTP] sendto syscall fails because of the error value missmatch
	from 3.6-rc1 kernel onwards
Reply-To: shyju.pv@huawei.com
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
Cc: 'Sanil kumar' <sanil.kumar@huawei.com>, nagamani.mantha@huawei.com

LTP_Version: 2012-06-14 
LTP Test case: sendto01 
Description : Verifies the sendto syscall errorno for various failure cases 
Failure Analysis : when the invalid flag is set, The error no EOPNOTSUPP
(95) and syscall returns 0 .instead LTP expects EPIPE (32) and the syscall
return value as -1. 
Fix : Modify  the LTP code with respect the the system return values of the
latest kernel(3.6-rc1) 
Test case passed in Kernel 3.5 
Failed from  3.6-rc1,rc2and rc3 

Test output :: <<<test_output>>> 
incrementing stop 
sendto01    1  TPASS  :  bad file descriptor successful 
sendto01    2  TPASS  :  invalid socket successful 
sendto01    3  TPASS  :  invalid send buffer successful 
sendto01    4  TPASS  :  connected TCP successful 
sendto01    5  TPASS  :  not connected TCP successful 
sendto01    6  TPASS  :  invalid to buffer length successful 
sendto01    7  TPASS  :  invalid to buffer successful 
sendto01    8  TPASS  :  UDP message too big successful 
sendto01    9  TPASS  :  local endpoint shutdown successful 
sendto01   10  TFAIL  :  invalid flags set ; returned -1 (expected 0), errno
95 
(expected 32) 
<<<execution_status>>> 
initiation_status="ok" 
duration=0 termination_type=exited termination_id=1 corefile=no 
cutime=0 cstime=0 
<<<test_end>>> 
INFO: ltp-pan reported some tests FAIL

Shyju


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
