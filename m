Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <olli.vertanen@symbio.com>) id 1TlCYZ-0003bn-Cm
	for ltp-list@lists.sourceforge.net; Wed, 19 Dec 2012 05:51:03 +0000
Received: from mail.fi.symbio.com ([89.236.120.22])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TlCYW-00031o-Hi
	for ltp-list@lists.sourceforge.net; Wed, 19 Dec 2012 05:51:03 +0000
Message-ID: <50D15482.4080601@symbio.com>
Date: Wed, 19 Dec 2012 14:45:38 +0900
From: Olli Vertanen <olli.vertanen@symbio.com>
MIME-Version: 1.0
Subject: [LTP] ltplite.sh and tmpdir permissions
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

Hi!

A bit confusion feature: runltp adjusts tmpdir permissions to 777, but 
for some reasons this has been dropped from runltplite.sh. Thus for me, 
some tests fail when run from ltplite.sh, but succeed when run from runltp.

Bug or feature or something else?

br, Olli


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
