Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1NNsDW-0000w4-5I
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:15:18 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NNsDN-0000EC-OE
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:15:18 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBOI9dG6032597
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 13:09:39 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBOIF3lD073794
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 13:15:03 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBOIF21H005373
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 16:15:03 -0200
From: poornima nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 24 Dec 2009 23:44:58 +0530
Message-Id: <1261678498.12037.15.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [LTP] [Patch 0/4]Patches to enable Power Management testcases to
 run on Power Platform
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
Cc: ssant@in.ibm.com, Arun <arun@linux.vnet.ibm.com>, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

The existing Power Management testcases in LTP would run only on X
machines. Subset of existing testcases in LTP can run on Power platform
also. So modified some of the functions which is to learn topology of
system from proc/cpuinfo to sysfs.
Only runltp -f power_management_tests command has to be used for testing
Power management features on Power platform. This command will only test
interfaces

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Regards
Poornima




------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
