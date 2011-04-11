Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q9DuE-0007Qg-E4
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 09:59:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9DuD-0002vf-KO
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 09:59:38 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3B9xVZ3026126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Apr 2011 05:59:31 -0400
Message-ID: <4DA2D0F5.6020109@redhat.com>
Date: Mon, 11 Apr 2011 17:59:17 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Subject: [LTP] hugeshmdt01: -I5 or -i5?
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

The hugeshm* tests in runtest/hugetlb are:

hugeshmat01 hugeshmat01 -i 5
hugeshmat02 hugeshmat02 -i 5
hugeshmat03 hugeshmat03 -i 5

hugeshmctl01 hugeshmctl01 -i 5
hugeshmctl02 hugeshmctl02 -i 5
hugeshmctl03 hugeshmctl03 -i 5

hugeshmdt01 hugeshmdt01 -I 5 <--- *-I or -i?*

hugeshmget01 hugeshmget01 -i 10
hugeshmget02 hugeshmget02 -i 10
hugeshmget03 hugeshmget03 -i 10
hugeshmget05 hugeshmget05 -i 10

I wonder whether hugeshmdt01 should be repeated for 5 times, or 5
seconds? (5 seconds is enough to execute the test for thousands times...
That will produce tens ~ hundreds MB log)

Thanks,
Caspar

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
