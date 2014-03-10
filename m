Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liljegren.mats2@gmail.com>) id 1WN0bS-0001ZW-Jb
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 13:50:50 +0000
Received: from mail-la0-f45.google.com ([209.85.215.45])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WN0bR-000674-Rf
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 13:50:50 +0000
Received: by mail-la0-f45.google.com with SMTP id hr17so4641649lab.18
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Mar 2014 06:50:43 -0700 (PDT)
Message-ID: <531DC318.7060504@gmail.com>
Date: Mon, 10 Mar 2014 14:50:16 +0100
From: Mats Liljegren <liljegren.mats2@gmail.com>
MIME-Version: 1.0
Subject: [LTP] Testing absence of ticks with nohz_full
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
To: Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Kevin Hilman <khilman@linaro.org>

My company (Enea) wants to create test case(s) that verifies that you 
can run an application without having ticks going on the CPU that the 
application runs on. This would utilize the new nohz_full feature 
available from kernel version 3.10.

I cannot find any existing test case in LTP in this area, so I assume I 
have to create the test case myself.

One catch is that the current nohz_full implementation actually 
generates 1Hz. So part of the test could be to verify that we actually 
get 1Hz rather than full tick speed. It would also be possible to 
support the experimental patch from Kevin Hilman to actually turn ticks 
off for real. The test code code check whether the patch is applied and 
based on it expect 0Hz or 1Hz ticks.

Would LTP be a good place for such tests?

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
