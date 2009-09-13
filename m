Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MmoxN-0005j1-52
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:29 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MmoxF-0001sy-I6
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:29 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sun, 13 Sep 2009 18:46:41 +0530
Message-Id: <1252847803.5357.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [Testing 2.6.31] CAN Network device driver and Netlink
	interface
Reply-To: subrata@linux.vnet.ibm.com
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
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: ltp-list <ltp-list@lists.sf.net>, "David S. Miller" <davem@davemloft.net>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,

Good day. CAN has undergone lot of changes since you added the CAN tests
to LTP. Would you like to send us some changes in the CAN tests w.r.t
the changes it had in both 2.6.30 to 2.6.31 kernels:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=39549eef3587f1c1e8c65c88a2400d10fd30ea17,
http://git.kernel.org/linus/429da1cc841bc9f2e762fd7272fc2b80314b890a,

Regards--
Subrata



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
