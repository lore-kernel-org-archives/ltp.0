Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFZmj-0000uZ-DJ
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 22:01:53 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFZmi-00065m-J0
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 22:01:53 +0000
Received: by gxk7 with SMTP id 7so12613gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 14:01:47 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 8 Nov 2010 14:01:46 -0800
Message-ID: <AANLkTin+-8g9XECkPeCehfo154VWu-VkfYG69oanANY0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [RFC] Move testcases/mce-test to testcases/kernel/mce-test
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
To: LTP list <ltp-list@lists.sourceforge.net>

    According to the README...

The MCE test suite is a collection of tools and test scripts for
testing the Linux kernel MCE processing features. The goal is to cover
most Linux kernel MCE processing code paths and features with
automation tests.

    Logically it seems like this component should be under
testcases/kernel instead of testcases.
Thanks,
-Garrett

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
