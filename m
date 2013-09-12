Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VK49s-00034k-9g
	for ltp-list@lists.sourceforge.net; Thu, 12 Sep 2013 10:29:56 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VK49q-0007zy-IC
	for ltp-list@lists.sourceforge.net; Thu, 12 Sep 2013 10:29:56 +0000
Message-ID: <52319789.4000609@oracle.com>
Date: Thu, 12 Sep 2013 14:29:29 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <522DDDC5.2070908@oracle.com>
In-Reply-To: <522DDDC5.2070908@oracle.com>
Subject: [LTP] ACPI LTP Test
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
To: Martin Ridgeway <mridge@us.ibm.com>
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hello Martin,

In the Linux Test Project there is a test which you developed. Could you 
please help me with answering a couple of questions concerning this 
test? Right now this test is manual and I'm trying to automate it... 
here the questions:
     * why this test is using block device?
     * I'm not sure what is returning from acpi_driver_data(). The test 
is using its own 'acpi_ec' structure and trying to cast return void 
pointer from that function to it, but in then kernel, this structure is 
slightly different and defined internally.

Many thanks,
Alexey

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
