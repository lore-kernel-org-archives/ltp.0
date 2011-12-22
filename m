Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rddou-0000tr-K2
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 08:16:08 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rddoq-00050L-MQ
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 08:16:08 +0000
Received: by vcbf1 with SMTP id f1so7616471vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Dec 2011 00:15:59 -0800 (PST)
Message-ID: <4EF2E181.4040500@casparzhang.com>
Date: Thu, 22 Dec 2011 15:51:29 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <dd4c6a9b-e905-427d-9a08-a63d96d66983@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <dd4c6a9b-e905-427d-9a08-a63d96d66983@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v6 2/2] mem/tunable: new testcase about
 overcommiting memory
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

On 11/15/2011 09:19 PM, Zhouping Liu wrote:
> hi, Cyril & Garrett
> 
> please feel free to comment the patch.
> 
> There are two tunables overcommit_memory and overcommit_ratio under
> /proc/sys/vm/, which can control memory overcommitment.
> 
> The overcommit_memory contains a flag that enables memory
> overcommitment, it has three values:
> - When this flag is 0, the kernel attempts to estimate the amount
>   of free memory left when userspace requests more memory.
> - When this flag is 1, the kernel pretends there is always enough
>   memory until it actually runs out.
> - When this flag is 2, the kernel uses a "never overcommit" policy
>   that attempts to prevent any overcommit of memory.
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
> b. equal to free_total:     free_total,     alloc should pass.
> c. greater than free_total: free_total * 2, alloc should fail.
> 
> When overcommit_memory = 1, it can alloc enough much memory,
> I choose the three cases:
> a. less than sum_total:    sum_total / 2, alloc should pass.
> b. equal to sum_total:     sum_total,     alloc should pass.
> c. greater than sum_total: sum_total * 2, alloc should pass.
> *note: sum_total = SwapTotal + MemTotal
> 
> When overcommit_memory = 2,
> allocatable memory = CommitLimit - Committed_As
> I define it as commit_left, also I choose three cases:
> a. less than commit_left:    commit_left / 2, alloc should pass.
> b. greater than commit_left: commit_left * 2, alloc should fail.
> c. overcommit limit:         CommitLimit,     alloc should fail.
> *note: CommitLimit is the current overcommit limit.
>       Committed_AS is the amount of memory that system has used.
> why I din't choose 'equal to commit_left' as a case, because in
> this case, the result is not fixed after I tested some times.
> 
> References:
> - Documentation/sysctl/vm.txt
> - Documentation/vm/overcommit-accounting
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>  testcases/kernel/mem/tunable/Makefile            |   42 ++++
>  testcases/kernel/mem/tunable/overcommit_memory.c |  278 ++++++++++++++++++++++
>  2 files changed, 320 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/tunable/Makefile
>  create mode 100644 testcases/kernel/mem/tunable/overcommit_memory.c

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
