Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MLAqf-0002X2-VQ
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 07:00:17 +0000
Received: from e28smtp02.in.ibm.com ([59.145.155.2])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MLAqe-0004gR-17
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 07:00:17 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5T70Ai0017485
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2009 12:30:10 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5T70AWI2265182
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2009 12:30:10 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5T709kV015257
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Jun 2009 17:00:09 +1000
Message-ID: <4A48667F.9050101@in.ibm.com>
Date: Mon, 29 Jun 2009 12:30:15 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
Subject: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: ltp-list@lists.sourceforge.net, Subrata Modak <subrata@linux.vnet.ibm.com>, yjwei@cn.fujitsu.com
Cc: mbeeraka@in.ibm.com

Hi
   I am observing this anomaly with these 2 test cases chmod05.c and fchmod05.c.
These 2 test cases are written to test the POSIX standard which says:

  	"If the calling process is not privileged  (Linux:  does  not  have  the
        CAP_FSETID  capability),  and  the group of the file does not match the
        effective group ID of the process or one  of  its  supplementary  group
        IDs,  the  S_ISGID  bit  will be turned off, but this will not cause an
        error to be returned."


So the test case will try to setup a file in which the GID of the test/tmp file will be 
different from the effective group ID of the running process. But this criterion is found to 
be not sufficient condition for the clearing the S_ISGID bit of the file

------------------------------------------------------------
Ex:
There are 2 users nobody (uid=99, gid=99) and bin (uid=1, gid=1)
let as assume temporary file as /tmp/zxcv

Test will Pass if
     Set UID/GID of /tmp/zxcv to            nobody->uid & nobody->GID
     Set eUID/eGID of process to           nobody->uid & bin->GID

Test will Fail if
     Set UID/GID of /tmp/zxcv to            nobody->uid & bin->GID
     Set eUID/eGID of process to           nobody->uid & nobody->GID

I verified supplementary group IDs for both 'nobody' and 'bin' and they are mutually 
exclusive and none of the other is supplementary group ID of the ID being tested
------------------------------------------------------------

Should we treat this as Test case issue or kernel bug?

Thanks
Yeehaw

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
