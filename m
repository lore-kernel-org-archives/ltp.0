Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDtGJ-0003rx-UI
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 10:11:20 +0000
Date: Thu, 13 Feb 2014 11:11:10 +0100
From: chrubis@suse.cz
Message-ID: <20140213101110.GA1737@rei.suse.cz>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
	<5757763.zAWEHsmlGc@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5757763.zAWEHsmlGc@vapier>
Subject: Re: [LTP] [PATCH 4/4] lib: add tst_res_r.c
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, ltp-list@lists.sourceforge.net, vasily.isaenko@oracle.com

Hi!
> yes, even with -W -Wall -Wextra.  please stamp this horrible habit out of your

The -W is older name for -Wextra (look at -Wextra in gcc man page).

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
