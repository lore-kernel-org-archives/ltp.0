Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SsAzN-0000we-7h
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 11:03:17 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SsAzL-0002HM-Jv
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 11:03:17 +0000
Received: by pbbrq2 with SMTP id rq2so5703683pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 Jul 2012 04:03:09 -0700 (PDT)
Message-ID: <50093AD7.9040602@casparzhang.com>
Date: Fri, 20 Jul 2012 19:02:47 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <cover.1342777340.git.jstancek@redhat.com>
In-Reply-To: <cover.1342777340.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 0/2] numa_helper: get nodes with mem/cpu/both
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 07/20/2012 06:19 PM, Jan Stancek wrote:
> numa_helper has been used for syscalls testcases, which
> care about nodes with memory. Based on discussion here:
> http://article.gmane.org/gmane.linux.ltp/16325
> it was deemed, that 'flag' extension would be useful,
> to allow tests to ask for nodes with memory/cpu/both.
>
> This patch series is introducing flag to get_allowed_nodes().
>
> For example, a config like this one:
>    # numactl -H
>    available: 3 nodes (2,4-5)
>    node 2 cpus: 0
>    node 2 size: 511 MB
>    node 2 free: 88 MB
>    node 4 cpus:
>    node 4 size: 256 MB
>    node 4 free: 34 MB
>    node 5 cpus:
>    node 5 size: 255 MB
>    node 5 free: 59 MB
>
> would return:
>    nodes (flag=0): 2 4 5 (any)
>    nodes (flag=1): 2 4 5 (mem)
>    nodes (flag=2): 2     (cpus)
>    nodes (flag=3): 2     (mem and cpus)
>
> Tested with:
> numactl-devel-0.9.8-7.el5
> numactl-devel-2.0.3-9.el6
> numactl-devel-2.0.7-6.el7
>
> numa_node_to_cpus() is broken in older libnuma < 1, so cpumap
> is used instead.
>
> Next step (not part of this series) is to move it outside
> syscalls area, so it can be used by other testcases.
>
> Jan Stancek (2):
>    numa_helper: add flag to get_allowed_nodes()
>    update testcases to use flag for get_allowed_nodes()
>
>   .../syscalls/get_mempolicy/get_mempolicy01.c       |    5 +-
>   testcases/kernel/syscalls/mbind/mbind01.c          |    5 +-
>   .../kernel/syscalls/move_pages/move_pages02.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages03.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages04.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages05.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages06.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages07.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages08.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages09.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages10.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages11.c      |    5 +-
>   .../syscalls/move_pages/move_pages_support.c       |    8 +-
>   testcases/kernel/syscalls/numa/lib/numa_helper.c   |  211 +++++++++++++++-----
>   testcases/kernel/syscalls/numa/lib/numa_helper.h   |    8 +-
>   15 files changed, 203 insertions(+), 84 deletions(-)
>
>

Thanks Jan for your patches! I want to test the patchset on all arches 
and on major releases, so would you mind if I hold on pushing until I 
finish the testing next week?

Also during that period, any comments from anyone is welcomed.

Thanks,
Caspar


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
