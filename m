Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDdgB-0005mD-48
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 17:32:59 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 254DFABA6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Feb 2014 17:32:47 +0000 (UTC)
Date: Wed, 12 Feb 2014 18:32:20 +0100
From: chrubis@suse.cz
Message-ID: <20140212173219.GD4905@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PLEASE READ] Test Writing Guidelines
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
Just FYI I'm adding chapters to the Test Writing Guidelines a bit by
bit. Also the latest version is available on the github wiki at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

(Note that the file is maintained under the main LTP git and only synced
 to the wiki. So send patches agains the ltp git repo, do not edit the
 wiki.)

Everybody, especially these who develop of fix testcases frequenty,
please have a look at the document. It's still not final but it includes
fair amount of information about LTP test API and best coding practices.

Moreover if something there feels wrong don't hesitate and come discuss
it on the LTP mailing list.

-- 
Cyril Hrubis
chrubis@suse.cz

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
