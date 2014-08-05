Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XEggG-0001eg-4E
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:29:40 +0000
Date: Tue, 5 Aug 2014 17:28:49 +0200
From: chrubis@suse.cz
Message-ID: <20140805152849.GB17966@rei.suse.cz>
References: <1407139174-14098-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1407139174-14098-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cgroup/cgroup_regression_test.sh: fix an issue
 about removing directories
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> After running test_$cur cases successfully, executing
> "rmdir -p cgroup/*" outputs "rmdir: failed to
> remove cgroup/*: No such file or directory" error
> message, this is because cgroup is an empty directory
> here. Fix it.

I've pushed the one line version from Mike. Thank you both.

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
