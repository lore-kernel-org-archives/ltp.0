Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QOwtN-0007rJ-ST
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 19:03:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QOwtM-0008Rt-VE
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 19:03:45 +0000
Message-ID: <4DDC00FA.4050206@redhat.com>
Date: Wed, 25 May 2011 03:03:22 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4DDBF945.50008@yahoo-inc.com>
In-Reply-To: <4DDBF945.50008@yahoo-inc.com>
Subject: Re: [LTP] fork13 failure on RHEL 6.0
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
To: Sandip Bhattacharya <sandipb@yahoo-inc.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 05/25/2011 02:30 AM, Sandip Bhattacharya wrote:
> I am getting repeated failures on RHEL 6.0 for the fork13 test. Has
> anybody else run this test on RHEL 6? This is with the latest patch for
> fork13.c incorporated into the source.
> 
> Here is the output that I am getting. The "wait return value" error is
> intermittent.
> 
>     <<<test_start>>>
>     tag=fork13 stime=1306261161
>     cmdline="fork13 -c 2 -i 1000000"
>     contacts=""
>     analysis=exit
>     <<<test_output>>>
>     fork13      1  TFAIL  :  Unexpected pid sequence: previous fork: pid=14676, current fork: pid=14676 for iteration=75939.
>     fork13      1  TFAIL  :  Wait return value: expected pid=14678, got 21800, iteration 78525.
>     incrementing stop
>     <<<execution_status>>>
>     initiation_status="ok"
>     duration=13 termination_type=exited termination_id=1 corefile=no
>     cutime=258 cstime=2550
>     <<<test_end>>>
> 
> I understand that this is a test to check a pid reuse race condition. So
> if this test fails, is it very naive to assume that the kernel doesn't have the
> patch which fixes this issue? [1] Or could there be a problem with the
> test itself?
> 
> [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5fdee8c4a5e1800489ce61963208f8cc55e42ea1

Hi, the above commit was not included in RHEL6.0 kernel, which caused
the test producing TFAIL. The test itself was OK.

Thanks,
Caspar

------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
