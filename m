Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WZymO-00085k-7a
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 08:31:44 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WZymL-0005b7-Sj
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 08:31:44 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Tue, 15 Apr 2014 10:31:14 +0200
Message-ID: <1397550675-25420-1-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <20140414174105.GA26543@rei>
References: <20140414174105.GA26543@rei>
MIME-Version: 1.0
Subject: [LTP] [PATCH] utils/Makefile: Move ffsb configure to configure.ac
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
Cc: Fathi Boudra <fathi.boudra@linaro.org>


I have now tried moving configure call from utils/Makefile to configure.ac, and
it compiles both natively as well as a cross-compile. I also managed to start
the fs_ext4 test case. Not sure whether this tells anything about ffsb since
I'm not sure what it is, but it looked like it was related to ext4.

/Mats

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
