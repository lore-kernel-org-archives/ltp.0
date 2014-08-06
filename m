Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XEzlP-0000rL-Ku
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 11:52:15 +0000
Date: Wed, 6 Aug 2014 13:51:24 +0200
From: chrubis@suse.cz
Message-ID: <20140806115124.GA18689@rei>
References: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
	<20140715084501.GA19089@rei> <53D7C780.3080906@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53D7C780.3080906@gmx.de>
Subject: Re: [LTP] [PATCH] fix fanotify syscall (again)
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
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > What about we drop the myfanotify*() functions now since we check if
> > fanotify.h exists now, use fanotify*() in the testcases and define the
> > syscall wrappers only when fanotify.h is not available (see for example
> > include/lapi/renameat.h)?
> 
> Attached is the updated patch which does exactly this.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
