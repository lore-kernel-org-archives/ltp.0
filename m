Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RwwmV-0007MI-4M
	for ltp-list@lists.sourceforge.net; Mon, 13 Feb 2012 14:21:27 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RwwmN-00016W-Mr
	for ltp-list@lists.sourceforge.net; Mon, 13 Feb 2012 14:21:27 +0000
Received: by iaby12 with SMTP id y12so5290000iab.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Feb 2012 06:21:14 -0800 (PST)
Message-ID: <4F391C35.5030508@casparzhang.com>
Date: Mon, 13 Feb 2012 22:20:37 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <863d9faeb5d714aa6c06a7a33fd5f2649b8bdb3f.1329134279.git.zliu@redhat.com>
In-Reply-To: <863d9faeb5d714aa6c06a7a33fd5f2649b8bdb3f.1329134279.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2] mem/tunable: new testcase about overcommiting
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
To: ltp-list@lists.sourceforge.net

On 02/13/2012 08:07 PM, Zhouping Liu wrote:
> 
> There are two tunables overcommit_memory and overcommit_ratio under
> /proc/sys/vm/, which can control memory overcommitment.
> 
> The overcommit_memory contains a flag that enables memory
> overcommitment, it has three values:
> - When this flag is 0, the kernel attempts to estimate the amount
>  of free memory left when userspace requests more memory.
> - When this flag is 1, the kernel pretends there is always enough
>  memory until it actually runs out.
> - When this flag is 2, the kernel uses a "never overcommit" policy
>  that attempts to prevent any overcommit of memory.
> 
> The overcommit_ratio tunable defines the amount by which the kernel
> overextends its memory resources in the event that overcommit_memory
> is set to the value of 2. The value in this file represents a
> percentage added to the amount of actual RAM in a system when
> considering whether to grant a particular memory request.
> The general formula for this tunable is:
> CommitLimit = SwapTotal + MemTotal * overcommit_ratio
> CommitLimit, SwapTotal and MemTotal can read from /proc/meminfo.
> 
> The program is designed to test the two tunables:
> 
> When overcommit_memory = 0, allocatable memory can't overextends
> the amount of free memory. I choose the three cases:
> a. less than free_total:    free_total / 2, alloc should pass.
> b. greater than free_total: free_total * 2, alloc should fail.
> c. equal to sum_total:      sum_tatal,      alloc should fail
> 
> When overcommit_memory = 1, it can alloc enough much memory, I
> choose the three cases:
> a. less than sum_total:    sum_total / 2, alloc should pass
> b. equal to sum_total:     sum_total,     alloc should pass
> c. greater than sum_total: sum_total * 2, alloc should pass
> *note: sum_total = SwapTotal + MemTotal
> 
> When overcommit_memory = 2, the total virtual address space on
> the system is limited to CommitLimit(Swap+RAM*overcommit_ratio)
> commit_left(allocatable memory) = CommitLimit - Committed_AS
> a. less than commit_left:    commit_left / 2, alloc should pass
> b. greater than commit_left: commit_left * 2, alloc should fail
> c. overcommit limit:         CommitLimit,     alloc should fail
> *note: CommitLimit is the current overcommit limit.
>       Committed_AS is the amount of memory that system has used.
> it couldn't choose 'equal to commit_left' as a case, because
> commit_left rely on Committed_AS, but the Committed_AS is not stable.
> 
> References:
> - Documentation/sysctl/vm.txt
> - Documentation/vm/overcommit-accounting
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
> hi, all
> 
> v1 -> v2: used SAFE_STRTOL macro.
> 
> please review the patch, any comments are welcome.
> 
>  runtest/mm                                       |    7 +
>  testcases/kernel/mem/tunable/Makefile            |   43 ++++
>  testcases/kernel/mem/tunable/overcommit_memory.c |  275 ++++++++++++++++++++++
>  3 files changed, 325 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/tunable/Makefile
>  create mode 100644 testcases/kernel/mem/tunable/overcommit_memory.c
> 
Acked-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
