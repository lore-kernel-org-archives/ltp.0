Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQyoT-0004fB-Iy
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 12:12:25 +0000
Date: Tue, 1 Oct 2013 14:12:42 +0200
From: chrubis@suse.cz
Message-ID: <20131001121242.GA23458@rei.suse.cz>
References: <20130926122235.GF14003@rei.suse.cz>
	<1380280420-12280-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130930171154.GA6339@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130930171154.GA6339@rei.suse.cz>
Subject: Re: [LTP] [PATCH V2 5/7] cpuset/cpuset_memory_test: fixes
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> 
> Looks good.
> 
> I will try to apply the patchset and run the tests tomorrow.

I've tested the patset (all 8 patches) and it works fine.

I've got a failure on cpuset_memory_pressure_testset.sh:

cpuset10    5  TFAIL  :  root group's memory_pressure didn't have memory pressure rate.
/opt/ltp/testcases/bin/cpuset_memory_pressure_testset.sh: line 195:
15280 Killed                  ./cpuset_memory_pressure $usemem
cpuset10    6  TFAIL  :  root group's memory_pressure didn't have memory pressure rate.

however the changes you did to the test are more or less cosmetic.

Now I would like to see a bit more verbose git log for
"cpuset_memory_spread_test: number of nodes and sync" patch (You should
write commit logs verbose enough so that peroson who wasn't involved in
the fix would understand how the changes fix the prolem).

And with the fixes to the reorganization patch and then I'm fine with
the whole series.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
