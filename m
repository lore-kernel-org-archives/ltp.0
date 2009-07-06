Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lmr@redhat.com>) id 1MNiJ0-0006DB-T6
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 07:08:02 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNiIy-0005E4-HA
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 07:08:02 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6677xQs031874
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 03:07:59 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6677x7Z014734
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 03:07:59 -0400
Received: from [10.16.10.45] (vpn-10-45.bos.redhat.com [10.16.10.45])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6677vhM022856
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 03:07:58 -0400
From: Lucas Meneghel Rodrigues <lmr@redhat.com>
Date: Mon, 06 Jul 2009 04:07:56 -0300
Message-Id: <1246864076.2865.35.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [LTP] LTP Build - Would it be possible to handle testcase build
 failures without failing all the build process?
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
To: LTP <ltp-list@lists.sourceforge.net>

LTP does have a large amount of testcases, and most of the testcases are
independent from each other, thus IMHO, a single compilation failure
should not fail the whole build process, instead, the tests that could
not be compiled should be marked as BROKEN, and should not be executed
during LTP execution. 

Do we have any plans to handle individual build failures in a way that
doesn't fail the whole build process? 

Thanks for your attention!

Lucas


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
