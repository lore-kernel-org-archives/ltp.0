Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WS9Y9-0005vD-Hh
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 18:24:41 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WS9Y7-0002q2-N7
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 18:24:41 +0000
Date: Mon, 24 Mar 2014 19:24:02 +0100
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140324192402.23951c04@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] Question: How does the test know when time expires?
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
To: "ltp-list@" <lists.sourceforge.net ltp-list@lists.sourceforge.net>

My test is intended to be run for awhile, and if nothing bad happens
during that time, the test pass.

I've seen that duration can be set on the command line for runltp. If I
use this, how will my test case know when it is time to finish its
testing?

Regards
Mats Liljegren

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
