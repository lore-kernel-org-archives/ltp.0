Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VKSND-00054w-UY
	for ltp-list@lists.sourceforge.net; Fri, 13 Sep 2013 12:21:19 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VKSNB-0006Rs-TK
	for ltp-list@lists.sourceforge.net; Fri, 13 Sep 2013 12:21:19 +0000
Message-ID: <52330323.6020702@oracle.com>
Date: Fri, 13 Sep 2013 16:20:51 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
Subject: [LTP] ACPI test
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
To: linux-acpi@vger.kernel.org
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi All!

I'm reviewing Linux Test Project's test concerning ACPI and a little bit 
lost with the following test: 
https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/device-drivers/acpi. 
It's quite outdated...

Pardon my technical knowledge on this subject but could you guide me to 
solve the following questions about the test and ACPI:

* Is it necessary to use block device to test ACPI functionality as test 
does?

* How can I verify data which I get from acpi_driver_data() using random 
acpi device handle? The test is using its own 'acpi_ec' structure and 
trying to cast return void pointer from that function to it, but in the 
kernel, this structure is slightly different and defined internally.

May be you have some thoughts how ACPI test should look like? Any help 
is appreciated.

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
