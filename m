Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shyju.pv@huawei.com>) id 1T5wcf-0008Kz-8V
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 10:32:45 +0000
Received: from szxga01-in.huawei.com ([119.145.14.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T5wcW-00059h-G2
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 10:32:45 +0000
From: shyju pv <shyju.pv@huawei.com>
Date: Mon, 27 Aug 2012 10:30:34 +0000
Message-ID: <E061084CB90FCE4F89232A6CF839683B32BC7591@SZXEML507-MBS.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Test case send01 fails in kernel version 3.6-rc1, rc2 and rc3
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: shyju pv <shyju.pv@huawei.com>

Hi,

sendt01 test cases fails from 3.6-rc1,rc2 and rc3

Bug descreption:
-------------------------
LTP_Version: 2012-06-14
LTP Test case: send01
Description : Verifies the send syscall errorno for various failure cases
Failure Analysis :  when the invalid flag set , The system gives error no
EOPNOTSUPP (95) whereas LTP expects EFAULT(14)
Fix : Modify  the LTP code with respect the the system return values of the
latest kernel(3.6-rc1)
Test case passed in Kernel 3.5
Failed from  3.6-rc1,rc2and rc3

Execution Log
---------------------
<<<test_output>>>
incrementing stop
send01      1  TPASS  :  bad file descriptor successful
send01      2  TPASS  :  invalid socket successful
send01      3  TPASS  :  invalid send buffer successful
send01      4  TPASS  :  UDP message too big successful
send01      5  TPASS  :  local endpoint shutdown successful
send01      6  TFAIL  :  invalid flags set ; returned -1 (expected -1),
errno
95 (expected 14)
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
