Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sandipb@yahoo-inc.com>) id 1QOwhW-0000gZ-9H
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 18:51:30 +0000
Received: from mrout2-b.corp.re1.yahoo.com ([69.147.107.21])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QOwhV-0007tz-Ef
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 18:51:30 +0000
Received: from orthus.eglbp.corp.yahoo.com
	(hurtsnowdance-dr.eglbp.corp.yahoo.com [10.66.78.119])
	by mrout2-b.corp.re1.yahoo.com (8.14.4/8.14.4/y.out) with ESMTP id
	p4OIUVuf064333 for <ltp-list@lists.sourceforge.net>;
	Tue, 24 May 2011 11:30:32 -0700 (PDT)
Received: from [10.66.100.14] (vpn-client-100-14.eglbp.corp.yahoo.com
	[10.66.100.14])
	by orthus.eglbp.corp.yahoo.com (Postfix) with ESMTP id CB0351BD8034
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 May 2011 11:30:30 -0700 (PDT)
Message-ID: <4DDBF945.50008@yahoo-inc.com>
Date: Wed, 25 May 2011 00:00:29 +0530
From: Sandip Bhattacharya <sandipb@yahoo-inc.com>
MIME-Version: 1.0
Subject: [LTP] fork13 failure on RHEL 6.0
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

I am getting repeated failures on RHEL 6.0 for the fork13 test. Has
anybody else run this test on RHEL 6? This is with the latest patch for
fork13.c incorporated into the source.

Here is the output that I am getting. The "wait return value" error is
intermittent.

    <<<test_start>>>
    tag=fork13 stime=1306261161
    cmdline="fork13 -c 2 -i 1000000"
    contacts=""
    analysis=exit
    <<<test_output>>>
    fork13      1  TFAIL  :  Unexpected pid sequence: previous fork: pid=14676, current fork: pid=14676 for iteration=75939.
    fork13      1  TFAIL  :  Wait return value: expected pid=14678, got 21800, iteration 78525.
    incrementing stop
    <<<execution_status>>>
    initiation_status="ok"
    duration=13 termination_type=exited termination_id=1 corefile=no
    cutime=258 cstime=2550
    <<<test_end>>>

I understand that this is a test to check a pid reuse race condition. So
if this test fails, is it very naive to assume that the kernel doesn't have the
patch which fixes this issue? [1] Or could there be a problem with the
test itself?

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5fdee8c4a5e1800489ce61963208f8cc55e42ea1

Thanks,
  Sandip


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
