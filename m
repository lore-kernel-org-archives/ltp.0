Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUxKw-00010F-M9
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 11:58:38 +0000
Date: Tue, 1 Apr 2014 13:58:00 +0200
From: chrubis@suse.cz
Message-ID: <20140401115800.GB12474@rei.suse.cz>
References: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1395044011-31911-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140331150821.GB9824@rei.suse.cz>
	<533A864A.4040109@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <533A864A.4040109@cn.fujitsu.com>
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
> >> Make performance_counter01 run default. This performance_counter01 case
> >> is to use perf_event_open() to test hardware CPU events.
> >>
> >> Do not let performance_counter02 run defalult. This test need to know
> >> an upper bound on the number of hardware counters, which varies in
> >> different platforms. So if knowing this value, user can execute:
> >> ./performance_counter02 -C (upper bound) to run this test.
> > The test seems to default to 8. Can we just make it return TCONF if
> > there are less than 8 hw counters? Having tests that are not executed by
> > default is pointless.
> Here I actually do not know how to get the number of hardware counters.
> I had googled this issue, but do not find any method to get the number.

Hmm. I've looked at the interface and I wonder if we can do something as
setting on the exclusive bit and create HW perf counters untill the
perf_event_open() starts to fail, but that is just guess, the perf
interface looks quite complicated.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
