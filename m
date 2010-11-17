Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PIbO3-0003jq-GR
	for ltp-list@lists.sourceforge.net; Wed, 17 Nov 2010 06:20:55 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PIbO2-000482-P7
	for ltp-list@lists.sourceforge.net; Wed, 17 Nov 2010 06:20:55 +0000
Received: by yxd5 with SMTP id 5so953880yxd.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Nov 2010 22:20:49 -0800 (PST)
From: Garrett Cooper <yanegomi@gmail.com>
Date: Tue, 16 Nov 2010 22:20:46 -0800
Message-Id: <3247F8F0-6E6A-47F7-A284-71CCAF3A7752@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Subject: [LTP] [RFC] remove testcases/kernel/syscalls/libevent test suite
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

	There are more recent versions of libevent upstream with appropriate feature tests. If folks want to run those feature tests, they should use the ones that come with the source package.
Thoughts?
-Garrett
------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
