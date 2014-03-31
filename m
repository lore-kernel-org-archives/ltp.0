Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUdpZ-0003pj-2T
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 15:08:57 +0000
Date: Mon, 31 Mar 2014 17:08:21 +0200
From: chrubis@suse.cz
Message-ID: <20140331150821.GB9824@rei.suse.cz>
References: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1395044011-31911-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395044011-31911-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/3] performance_counters: make
 performance_counters run default
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Make performance_counter01 run default. This performance_counter01 case
> is to use perf_event_open() to test hardware CPU events.
> 
> Do not let performance_counter02 run defalult. This test need to know
> an upper bound on the number of hardware counters, which varies in
> different platforms. So if knowing this value, user can execute:
> ./performance_counter02 -C (upper bound) to run this test.

The test seems to default to 8. Can we just make it return TCONF if
there are less than 8 hw counters? Having tests that are not executed by
default is pointless.

Also what about moving these tests to syscalls? I see no reason not to.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
