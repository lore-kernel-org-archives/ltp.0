Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <olli.vertanen@symbio.com>) id 1ThyN9-0006mT-Lo
	for ltp-list@lists.sourceforge.net; Mon, 10 Dec 2012 08:05:55 +0000
Received: from mail.fi.symbio.com ([89.236.120.22])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ThyN3-0006NZ-NU
	for ltp-list@lists.sourceforge.net; Mon, 10 Dec 2012 08:05:55 +0000
Message-ID: <50C597BF.3000807@symbio.com>
Date: Mon, 10 Dec 2012 17:05:19 +0900
From: Olli Vertanen <olli.vertanen@symbio.com>
MIME-Version: 1.0
Subject: [LTP] Running from tmpfs
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

I'd like to know if LTP tests can be run entirely from tmpfs? My system 
has rootfs mounted read-only, and I would like to avoid remounting it. 
Do you have tests that require write access to rootfs?

I've succeeded in running the runltplite.sh set of tests from tmpfs, but 
to accomplish this with runalltests.sh minor modifications to the script 
is required.

So, I started wondering, is the limitation because of inherit properties 
of the tests, or just poor paramerization of the script.

Thanks!

Olli Vertanen

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
