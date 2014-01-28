Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W88Ct-0006FC-0S
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 12:55:59 +0000
Date: Tue, 28 Jan 2014 13:55:28 +0100
From: chrubis@suse.cz
Message-ID: <20140128125528.GA5824@rei>
References: <1386128618-28341-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386128618-28341-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] sigaction:16-1: leave it untested on the Linux
 kernel less than 2.6.22
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> As the Linux signal(7) said:
> POSIX semaphore interfaces: sem_wait(3) and sem_timedwait(3) (since Linux 2.6.22; beforehand, always failed with EINTR).
> 
> So, on Linux, we just leave this untested when the kernel version
> is less than 2.6.22.
> 

The patch is good, but my original point still stands. I do not like
that the test is disabled by default. I wouldn't add the filter-broken
target to all target but rather left it on user whether to filter them
or not. And update the README to have this kind of information (the
README should probably be rewritten anyways).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
