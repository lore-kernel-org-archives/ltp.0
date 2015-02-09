Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YKp9T-0007tT-IY
	for ltp-list@lists.sourceforge.net; Mon, 09 Feb 2015 14:17:27 +0000
Date: Mon, 9 Feb 2015 15:17:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150209141705.GB7605@rei.suse.de>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1423212090-24164-3-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1423212090-24164-3-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 3/6] power_management: install lib/sched_mc.py
 into testcases/bin directory
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
>  testcases/kernel/power_management/Makefile         | 10 ++++-----
>  .../kernel/power_management/cpu_consolidation.py   |  2 --
>  testcases/kernel/power_management/ilb_test.py      |  2 --
>  testcases/kernel/power_management/lib/Makefile     | 25 ++++++++++++++++++++++
>  testcases/kernel/power_management/sched_domain.py  |  2 --
>  5 files changed, 29 insertions(+), 12 deletions(-)
>  create mode 100644 testcases/kernel/power_management/lib/Makefile

Before we install all files into the common bin directory we have to
prefix all of them with reasonable prefix. What about prefixing these
with 'pm_'?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
