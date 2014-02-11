Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDEzS-0005X1-2L
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:11:14 +0000
Date: Tue, 11 Feb 2014 16:10:34 +0100
From: chrubis@suse.cz
Message-ID: <20140211151034.GA15043@rei.Home>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] rpc-tirpc-full-test-suite
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I found that run_rpc_test.sh fails during ltpstress.sh execution. And it fails
> because the rpc-tirpc-full-test-suite is not compiled.
> 
> So I:
> * integrated a part of the rpc-tirpc-full-test-suite into the LTP
>   building process (added Makefiles and etc). This part is the one
>   which was executed by run_rpc_tests.sh.
> 
> * changed the description of the testcases in runtest/.
>   To ease debugging.
> 
> I couldn't find a solution to make 'make' add the '.bin' suffix to the produced
> binaries. Therefore I had to fix some of the test scripts for that fact.

I think that we are better without the bin suffix as it's not standard
suffix for binaries on Linux.

> Does anybody know how to do that?

As far as I know you need to write a custom rule for that because the
one make has by default matches %: %.c and not %.bin: %.c

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
