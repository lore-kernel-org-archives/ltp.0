Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v0C-0007Wx-EA
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:56:08 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v0B-0000g7-GT
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:56:08 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466o7gG023550
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:50:07 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466u1NX108636
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:56:01 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466u0Aa028723
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:56:00 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:25:50 +0530
Message-Id: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [00/12 FAILURE] Reporting LTP run issues on Fedora 13 ppc6
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

Hi,

Recently i did a ltprunall on my Fedora 13 system running on PPC64 box,
and came across some failures/issues. I want to report them to you to
know whether you also have observed similar issues on either PPC64, or
systems that matter to you.

Probably, i am trying to find out whether they are test case issues, or,
issues with the kernel. If they turn out to be testcase issues, then we
would need to fix them quit soon :-)

Since i was not looking into all LTP mails for the last couple of months,
may be some of these issues might have been reported and fixed proposed.
I would apolozise for the noise again.

My system configuration:
[root@mjs22lp1 ~]# uname -a
Linux 2.6.33.1-19.fc13.ppc64 #1 SMP Tue Mar 23 06:32:38 EDT 2010 ppc64 ppc64 ppc64 GNU/Linux
[root@mjs22lp1 ~]# cat /etc/issue
Fedora release 13 (Goddard)
Kernel \r on an \m (\l)

Regards--
Subrata


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
