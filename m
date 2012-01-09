Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1RkEDZ-0006ff-Hs
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 12:20:49 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkEDT-0002BJ-SP
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 12:20:49 +0000
Date: Mon, 09 Jan 2012 07:20:37 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <ff2ef870-69f8-4f45-838e-cddcbc05ba0e@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4fbee0c2-b343-4fae-a25d-f1570bd6cd3b@zmail13.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] mem/tunable: new testcase about overcommiting
	memory
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
To: ltp-list@lists.sourceforge.net, Caspar Zhang <czhang@redhat.com>

> 
> hi,
> please review the patch, any comments are welcome.
> 
>  There are two tunables overcommit_memory and overcommit_ratio under
>  /proc/sys/vm/, which can control memory overcommitment.
> 
>  The overcommit_memory contains a flag that enables memory
>  overcommitment, it has three values:
>  - When this flag is 0, the kernel attempts to estimate the amount
>    of free memory left when userspace requests more memory.
>  - When this flag is 1, the kernel pretends there is always enough
>    memory until it actually runs out.
>  - When this flag is 2, the kernel uses a "never overcommit" policy
>    that attempts to prevent any overcommit of memory.
> 
>  The overcommit_ratio tunable defines the amount by which the kernel
>  overextends its memory resources in the event that overcommit_memory
>  is set to the value of 2. The value in this file represents a
>  percentage added to the amount of actual RAM in a system when
>  considering whether to grant a particular memory request.
>  The general formula for this tunable is:
>  CommitLimit = SwapTotal + MemTotal overcommit_ratio
>  CommitLimit, SwapTotal and MemTotal can read from /proc/meminfo.
> 
>  The program is designed to test the two tunables:
>  When overcommit_memory = 0, allocatable memory can't overextends
>  the amount of free memory. I choose the three cases:
>  a. less than free_total:    free_total / 2, alloc should pass.
>  b. greater than free_total: free_total * 2, alloc should fail.
>  c. equal to sum_total:      sum_tatal,      alloc should fail
> 
>  When overcommit_memory = 1, it can alloc enough much memory, I
>  choose the three cases:
>  a. less than sum_total:    sum_total / 2, alloc should pass
>  b. equal to sum_total:     sum_total,     alloc should pass
>  c. greater than sum_total: sum_total * 2, alloc should pass
>  * note: sum_total = SwapTotal + MemTotal
> 
>  When overcommit_memory = 2, the total virtual address space on
>  the system is limited to CommitLimit(Swap+RAM*overcommit_ratio)
>  commit_left(allocatable memory) = CommitLimit - Committed_AS
>  a. less than commit_left:    commit_left / 2, alloc should pass
>  b. greater than commit_left: commit_left * 2, alloc should fail
>  c. overcommit limit:         CommitLimit,     alloc should fail
>  * note: CommitLimit is the current overcommit limit.
>         Committed_AS is the amount of memory that system has used.
>  it couldn't choose 'equal to commit_left' as a case, because
>  commit_left rely on Committed_AS, but the Committed_AS is not
>  stable.
> 
>  References:
>  - Documentation/sysctl/vm.txt
>  - Documentation/vm/overcommit-accounting
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/mem/tunable/Makefile            |   42 ++++
>  testcases/kernel/mem/tunable/overcommit_memory.c |  272
>  ++++++++++++++++++++++
>  2 files changed, 314 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/tunable/Makefile
>  create mode 100644 testcases/kernel/mem/tunable/overcommit_memory.c
hi, anyone can comment the patch?

Best,
Zhouping

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
