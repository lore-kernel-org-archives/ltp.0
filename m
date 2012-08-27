Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shyju.pv@huawei.com>) id 1T65AR-0000A2-NK
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 19:40:11 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T65AP-0004hu-Lr
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 19:40:11 +0000
From: shyju pv <shyju.pv@huawei.com>
Date: Mon, 27 Aug 2012 19:34:51 +0000
Message-ID: <E061084CB90FCE4F89232A6CF839683B32BC7AE2@SZXEML507-MBS.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] sendmsg01 fails  from 3.6-rc1 kernel onward,
 possible ltp test case update needed
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

Hi 
System call sendmsg01 fails from 3.6-rc1 onward.
LTP_Version: 2012-06-14
Testcase : sendmsg01
Description : verifies the sendmsg syscall returns value for various failure
cases
Failure Analysis : System call returns -1 and the test case expect 0
Latest Kernel version in which test case passed :  Kernel 3.5
Test case Failed : Kernel 3.6-rc1,rc2and rc3
Output log :: <<<test_output>>>
incrementing stop
sendmsg01    1  TPASS  :  bad file descriptor successful
sendmsg01    2  TPASS  :  invalid socket successful
sendmsg01    3  TPASS  :  invalid send buffer successful
sendmsg01    4  TPASS  :  connected TCP successful
sendmsg01    5  TPASS  :  not connected TCP successful
sendmsg01    6  TPASS  :  invalid to buffer length successful
sendmsg01    7  TPASS  :  invalid to buffer successful
sendmsg01    8  TPASS  :  UDP message too big successful
sendmsg01    9  TPASS  :  local endpoint shutdown successful
sendmsg01   10  TPASS  :  invalid iovec pointer successful
sendmsg01   11  TPASS  :  invalid msghdr pointer successful
sendmsg01   12  TPASS  :  rights passing successful
sendmsg01   13  TPASS  :  invalid flags set w/ control successful
sendmsg01   14  TFAIL  :  invalid flags set ; returned -1 (expected 0),
errno
95 (expected 95)
sendmsg01   15  TPASS  :  invalid cmsg length successful
sendmsg01   16  TPASS  :  invalid cmsg pointer successful
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL

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
