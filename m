Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WPUVk-0006Cn-0W
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 10:11:12 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WPUVg-0001Tb-LT
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 10:11:11 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 17 Mar 2014 10:11:00 +0000
Message-ID: <0247700D01F14443B9209F90AD938CC524365A3B@sestoex05.enea.se>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Design question around ltp-list
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

I'd like to create a time-boxed test case, i.e. the test will run for a certain amount of time and if nothing goes wrong during this time, the test passed.

This would also need to be recursive. So when starting my test, it in turn will start some test cases to be used as a system load. These loads are simple application that will run until killed. My intention was to start them using ltp-pan.

So imagine my test case is started with ltp-pan, where a running time has been specified. My test case in turn will use ltp-pan to start an application that only exits when killed. What will happen when the first ltp-pan invocation times out? Will it automatically kill child ltp-pan instances, and they in turn kill the load applications?

Or how are you supposed to do such a test case?

/Mats

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
