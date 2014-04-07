Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <andi@firstfloor.org>) id 1WWynY-0001Qx-1c
	for ltp-list@lists.sourceforge.net; Mon, 07 Apr 2014 01:56:32 +0000
Received: from one.firstfloor.org ([193.170.194.197])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WWynW-0006nd-ND
	for ltp-list@lists.sourceforge.net; Mon, 07 Apr 2014 01:56:32 +0000
Date: Mon, 7 Apr 2014 03:39:32 +0200
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20140407013932.GU22728@two.firstfloor.org>
References: <533D3BC7.8010309@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <533D3BC7.8010309@oracle.com>
Subject: Re: [LTP] numastats updates
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, cl@linux-foundation.org, linux-numa@vger.kernel.org

On Thu, Apr 03, 2014 at 02:45:27PM +0400, Stanislav Kholmanskikh wrote:
> In LTP we have a test - numa01.sh (https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/numa/numa01.sh)

numactl has similar tests

> 
> In general, this script does something like:
>   * numastat > /tmp/before
>   * starts a binary with the specified numa memory policy using
> numactl (or a like):
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
> Is there a direct or indirect way to force the kernel to update the
> NUMA statistics?

Not currently. It depends on how much memory you have and subsequent
operations. I guess would need to add one.


-Andi

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees_APR
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
