Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgbLe-0003NY-QJ
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 12:14:10 +0000
Date: Fri, 30 Dec 2011 13:24:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111230122435.GA24428@saboteur.suse.cz>
References: <1325227940-9971-1-git-send-email-Song.Li@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1325227940-9971-1-git-send-email-Song.Li@windriver.com>
Subject: Re: [LTP] [PATCH] sched_setparam/2-1.c and sched_setparam/2-2.c
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
To: Song.Li@windriver.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> There is no guarantee that the LOOP of the child proecess
> can be certainly big enough on any device at any time.
> So if set_affinity function is available,
> use it to bind the test processes to a single CPU
> rather than using the LOOP.
> 
> Signed-off-by: Song.Li <Song.Li@windriver.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
