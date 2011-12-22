Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rdhff-0006tN-BF
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 12:22:51 +0000
Date: Thu, 22 Dec 2011 13:32:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222123232.GF26303@saboteur.suse.cz>
References: <145b91763d3c2670cd736cc7fa3072c9a6db219a.1311676572.git.czhang@redhat.com>
	<1324551871-825-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324551871-825-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v2] syscalls/getrusage04: new testcase
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> 
> getrusage04 - accuracy of getrusage() with RUSAGE_THREAD
> 
> This program is used for testing the following upstream commit:
> 761b1d26df542fd5eb348837351e4d2f3bc7bffe.
> 
> getrusage() returns cpu resource usage with accuracy of 10ms
> when RUSAGE_THREAD is specified to the argument who. Meanwhile,
> accuracy is 1ms when RUSAGE_SELF is specified. This bad accuracy
> of getrusage() caused a big impact on some application which is
> critical to accuracy of cpu usage. The upstream fix removed
> casts to clock_t in task_u/stime(), to keep granularity of
> cputime_t over the calculation.
> 
> Note that the accuracy on powerpc and s390x systems is always
> 10ms when either RUSAGE_THREAD or RUSAGE_SELF specified, so
> this test won't be executed on those platforms.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/syscalls/getrusage/getrusage04.c |  132 +++++++++++++++++++++
>  1 files changed, 132 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/getrusage/getrusage04.c

Could you please also add line into corresponding runtest file?

-- 
Cyril Hrubis
chrubis@suse.cz

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
