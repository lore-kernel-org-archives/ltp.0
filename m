Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shivam.mehta@sasken.com>) id 1SlfwK-0001kT-Kv
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 12:41:16 +0000
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SlfwE-0006xx-NO
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 12:41:16 +0000
From: Shivam Mehta <shivam.mehta@sasken.com>
Date: Mon, 2 Jul 2012 18:11:01 +0530
Message-ID: <2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C05@EXGMBX01.sasken.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Fallocate test failing in Zoom-3 board .
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

Hi ,


I am working on the fallocate01  test case it is giving the following error , i actually build the binary executable with android ndk-7b toolchain and my zoom-3 is running with arm-2010q1,may be this may leading to failure if not please give me solution so that i can proceed .

output:
./fallocate01
-------------- blocksize = 86132 =----------------------
--------------  expected size = 65176 =----------------------
-------------- blocksize = 3 =----------------------
-------------- offset = 49152 =----------------------
 ----------------in other-----------------------
-------------- test return is =-1  ---------------------
fallocate01    1  TFAIL  :  fallocate(3, 0, 49152, 4096) failed returned -1: TEST_ERRNO=EFBIG(27): File too large
-------------- blocksize = 86128 =----------------------
--------------  expected size =65176 =----------------------
-------------- blocksize = 4 =----------------------
-------------- offset = 49152 =----------------------
 ----------------in other-----------------------
-------------- test return is =-1  ---------------------
fallocate01    2  TFAIL  :  fallocate(4, 1, 49152, 4096) failed returned -1: TEST_ERRNO=EFBIG(27): File too large
TESTDIR checking ..... /tmp/falB20085




Thanks & Regards

Shivam Mehta

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

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
