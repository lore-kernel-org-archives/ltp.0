Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <will.deacon@arm.com>) id 1PpkTo-0006yF-Uw
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 16:43:52 +0000
Received: from service87.mimecast.com ([94.185.240.25])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1PpkTn-0000KS-98
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 16:43:52 +0000
From: "Will Deacon" <will.deacon@arm.com>
References: <1297088926-21505-1-git-send-email-will.deacon@arm.com>
In-Reply-To: <1297088926-21505-1-git-send-email-will.deacon@arm.com>
Date: Wed, 16 Feb 2011 16:43:40 -0000
Message-ID: <000b01cbcdf8$aaaba430$0002ec90$@deacon@arm.com>
MIME-Version: 1.0
Content-Language: en-gb
Subject: Re: [LTP] [PATCH] Fix rt_sigtimedwait ordering test
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
To: Will Deacon <Will.Deacon@arm.com>, ltp-list@lists.sourceforge.net

Hello,

> The rt_sigtimedwait test invokes test_masked_matching_rt, which
> spawns two children who send consecutive RT signals to the parent.
> The test then checks (via sigwaitinfo) that the RT signals are
> delivered in the correct order: namely that the lower signal is taken
> first.
> 
> This test can fail due to a race condition where the parent issues
> the sigwaitinfo syscall before the first child has signalled the
> parent but after the second child has (due to context switching).
> This results in the signals being received in the reverse order.
> 
> This patch inserts waitpid syscalls to the parent thread so that the
> sigwaitinfo call is only issued after the children have exited.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

I've not heard anything further on this, but it does fix a real issue
on the platform I'm using. Do you need anything more from me for this
to be considered for committing?

Cheers,

Will




------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
