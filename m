Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PEQPt-0002bO-Cw
	for ltp-list@lists.sourceforge.net; Fri, 05 Nov 2010 17:49:33 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PEQPp-0002jx-5q
	for ltp-list@lists.sourceforge.net; Fri, 05 Nov 2010 17:49:31 +0000
Received: by pzk34 with SMTP id 34so597157pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Nov 2010 10:49:23 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Date: Fri, 5 Nov 2010 10:49:19 -0700
Message-Id: <B9AFF03C-2075-420E-B99A-E9487463A58B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Subject: [LTP] [RFC] Remove testcases/kernel/syscalls/pcllib
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
To: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>

	Turns out it wasn't being compiled and was broken to begin with (I'm going to commit the bits shortly to disable it from the build). Does anyone object if it remove it?
	I'm game to removing other components if requested.
Thanks,
-Garrett
------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
