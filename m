Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUbNo-000702-Gv
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 12:32:08 +0000
Date: Mon, 31 Mar 2014 14:31:33 +0200
From: chrubis@suse.cz
Message-ID: <20140331123132.GA9441@rei.suse.cz>
References: <5339205E.30801@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5339205E.30801@oracle.com>
Subject: Re: [LTP] numa01
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> numa01.sh does something like:
>   * numastat > /tmp/before
>   * starts a binary with the specified memory policy using numactl (or a 
> like):
>     numactl --interleave=all get_some_memory_with_malloc_and_write_it
>   * `sleep` for few seconds
>   * numastat > /tmp/after
>   * compares /tmp/before and /tmp/after to check that the numa policy 
> was applied the right way
> 
> But the problem is that on a host with many NUMA nodes (8) the process 
> of updating that numastats statistics takes some time. Even 10 seconds 
> may be not enough. Therefore the test fails.
> 
> Does anybody know if there is a direct or indirect way to force the 
> kernel to update the NUMA statistics?

I don't think you can force the statistics to update. I guess that all
we can do is to poll the statistics and wait until it changes the way we
expect (with some timeout).

And the best soulution would be to ask kernel memory management
developers, they should know better (feel free to CC LTP ML).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
