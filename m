Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Muf08-0003nT-Tl
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 04:16:44 +0000
Received: from mail-pz0-f192.google.com ([209.85.222.192])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Muf04-0003Xp-3X
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 04:16:44 +0000
Received: by pzk30 with SMTP id 30so2649653pzk.24
	for <ltp-list@lists.sourceforge.net>;
	Sun, 04 Oct 2009 21:16:34 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 4 Oct 2009 21:16:33 -0700
Message-ID: <364299f40910042116v40757ceene9d99a9a241b23a7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Remove ballista binary files
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

Just before doing a CVS diff I noticed that these binary files made it
back into the repository:

testcases/ballista/ballista/blexer
testcases/ballista/ballista/bparser
testcases/ballista/ballista/mut.out

This change removes them again:

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

cvs diff: testcases/ballista/ballista/blexer was removed, no
comparison available
cvs diff: testcases/ballista/ballista/bparser was removed, no
comparison available
cvs diff: testcases/ballista/ballista/mut.out was removed, no
comparison available

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
