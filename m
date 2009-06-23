Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pradeepkumars@in.ibm.com>) id 1MJ5nO-0007DR-2X
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 13:12:18 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ5nL-0004Wl-R2
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 13:12:18 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5NDC52F029882
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 18:42:05 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NDC5942048166
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 18:42:05 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5NDC5Sk016035
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 23:12:05 +1000
Received: from d23ml066.in.ibm.com (d23ml066.in.ibm.com [9.124.105.43])
	by d28av05.in.ibm.com (8.13.1/8.12.11) with ESMTP id n5NDC5WP016024
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 23:12:05 +1000
Message-ID: <OF7F605455.F06BC5F9-ON652575DE.0046FE13-652575DE.00488F83@in.ibm.com>
From: Pradeep K Surisetty <pradeepkumars@in.ibm.com>
Date: Tue, 23 Jun 2009 18:39:29 +0530
MIME-Version: 1.0
Subject: [LTP] : personality test case build fails
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
Cc: Subrata Modak1 <subrata.modak@in.ibm.com>, James Takahashi <jmtt@us.ibm.com>


Here is the list of platforms on which "personality test case" fails.

Platforms:
e326,x366

kernel:
2.6.16.60-0.46.6-smp

Build Failure:

cc -I../../../../include -Wall    personality01.c  -L../../../../lib -lltp
-o personality01
/tmp/cc2aVCsG.o: In function `main':
personality01.c:(.text+0x58): undefined reference to `personality'
personality01.c:(.text+0xb6): undefined reference to `personality'
personality01.c:(.text+0x1a5): undefined reference to `personality'
collect2: ld returned 1 exit status
make: *** [personality01] Error 1

Subrata,
Can you point me, if any work around exists for this.

-Pradeep


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
