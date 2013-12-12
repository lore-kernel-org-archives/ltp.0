Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vr4Sb-0006qI-Fq
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 11:29:41 +0000
Date: Thu, 12 Dec 2013 12:29:05 +0100
From: chrubis@suse.cz
Message-ID: <20131212112905.GA10634@rei.Home>
References: <0457982F240D534B8C4CD82E5311A37E1A3B7B6531@SGSINEXC014.vestas.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0457982F240D534B8C4CD82E5311A37E1A3B7B6531@SGSINEXC014.vestas.net>
Subject: Re: [LTP] LTP mount,mtest05mem and times testcase related problem
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
To: Haresh Chavda <HACAD@vestas.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> We are using LTP "ltp-full-20130503" on linux kernel version 3.10.10-rt7+.
> We found that mount, times and  mtest05mem are failing.
> 
> We got following error by mount syscall,
> mount02     4  TBROK  :  umount of mnt_8649 failed: errno=EBUSY(16): Device or resource busy
> mount02     5  TBROK  :  Remaining cases broken

That looks like two bugs to me. One is that mount() returns unexpected error
(unexpected by the test) and the second is that the test tries to unmount() the
mountpoint even if it wasn't mounted.

Can you try to debug this failure further, I would advice to comment out
following lines to see which test assertion has failed.

      if (umount(mntpoint) == -1)
              tst_brkm(TBROK | TERRNO, cleanup,
                       "umount of %s failed",
                       Mntpoint);


> For times syscall testcase we doesn't get status about TPASS for "times03".
> I feel that "times03" testcase need to be modified to generate TPASS status.

I've tried it myself, the test does not print anything to the stdout, which
should be fixed. But at least the test exit value is zero, which means that the
test passed.

> For mtest05mem syscall we got following error,
> mmstress    0  TINFO  :  test6: Test case tests the race condition between simultaneous fork -exec - exit faults in the same address space.
> mmstress    6  TFAIL  :  TEST 6 Failed
> We found that there are two files named "dummy" in separate folders(mtest05 and cap_bound). So when we build and install LTP, one of the binary "dummy" is replaced by other one.
> The possible solution could be to modify the make file to generate binaries with relevant name.

That one of the install collisions we have in the tree. I will fix this
one, thanks for reporting.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
