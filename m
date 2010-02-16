Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TEgHq-0001Eh-89
	for ltp-list@lists.sourceforge.net; Thu, 20 Sep 2012 12:55:22 +0000
Date: Tue, 16 Feb 2010 04:25:42 +0100
From: chrubis@suse.cz
Message-ID: <20100216032542.GB7902@saboteur.suse.cz>
References: <4FF3EE1B.1060508@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FF3EE1B.1060508@windriver.com>
Subject: Re: [LTP] POSIX: does case mmap/27-1 valid?
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The posix test case mmap/27-1 try to test c lib implementation which
> doesn't support MAP_FIXED and MAP_PRIVATE.
> When MAP_FIXED is defined then the case quits  with  UNTESTED.
> If MAP_FIXED and other flags are not defined, then the case try to
> test mmap with MAP_FIXED.
> But at this time MAP_FIXED is not defined, how the case can be
> compiled? Then I suppose this case is NOT valid.

There are several invalid testcases in the mmap directory. I've started
to cleanup the testcases but haven't had time finish yet (I've got more
important work meanwhile). So stay tuned I'll get to them again
hopefully soon.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
