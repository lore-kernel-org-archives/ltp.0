Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgLVu-0007oy-JN
	for ltp-list@lists.sourceforge.net; Thu, 29 Dec 2011 19:19:42 +0000
Date: Thu, 29 Dec 2011 20:30:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111229193003.GA330@saboteur.suse.cz>
References: <1324619316-21596-1-git-send-email-Song.Li@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324619316-21596-1-git-send-email-Song.Li@windriver.com>
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

The patch logic is looking good, there are some style problems though.

Please use checkpatch.pl (that is packed with linux kernel) and resend.

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
