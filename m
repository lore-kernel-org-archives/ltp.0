Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1Waium-0007IM-3a
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 09:47:28 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1Waiuj-00025h-IV
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 09:47:28 +0000
Date: Thu, 17 Apr 2014 11:47:11 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140417114711.4268c826@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] How to handle background load
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

There are several options to runltp for creating background loads, e.g.
-n, -i and -m. For some test cases this is valuable, for others it
doesn't (or at least shouldn't) matter for yet others they are a big
no-no.

Is there any way a test case can express what kinds of load that is
recommended and/or not compatible with the test case?

It would be nice if runltp could dynamically adapt the load being used
depending on which test case that is scheduled. Does it do this
already, or are there any plans in this area?

Regards
Mats Liljegren

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
