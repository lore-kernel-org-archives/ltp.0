Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <harry.weppner@gmx.net>) id 1WE7Ri-00054l-LG
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 01:20:02 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1WE7Rh-0003M3-JD
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 01:20:02 +0000
Received: from [10.250.31.144] ([152.179.42.173]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MKbZD-1WDHpd2Pyh-001vsN for
	<ltp-list@lists.sourceforge.net>; Fri, 14 Feb 2014 02:19:55 +0100
From: Harry Weppner <harry.weppner@gmx.net>
Mime-Version: 1.0 (1.0)
Date: Thu, 13 Feb 2014 17:19:53 -0800
Message-Id: <37DEC8B3-1B3C-4FD3-99F8-3E5436311195@gmx.net>
Subject: [LTP] runltplite access06 test relies on DEVICE and DEVICE_FS_TYPE
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

Hi there,

using runltplite, access06 is reported as broken because DEVICE and DEVICE_FS_TYPE aren't set. 

Unlike runltp there's no command line option or fallback mechanism implemented in the runltplite script. Should access06 be taken out of runltplite!?

Cheerio, Harry.

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
