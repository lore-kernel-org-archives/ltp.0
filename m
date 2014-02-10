Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WCvDO-0000JC-Jf
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 18:04:18 +0000
Date: Mon, 10 Feb 2014 19:03:43 +0100
From: chrubis@suse.cz
Message-ID: <20140210180343.GB4186@rei>
References: <1386071053-2350-1-git-send-email-jjaburek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386071053-2350-1-git-send-email-jjaburek@redhat.com>
Subject: Re: [LTP] [PATCH] cmdlib/end_testcase: don't call tst_cleanup,
 exit on pass
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Calling tst_cleanup explicitly causes the EXIT trap to be emptied,
> removing possible user-defined cleanup routines. It also doesn't make
> sense - tst_setup does NOT always set an EXIT trap, only when $TCtmp
> is set. And even then, the trap is correctly executed *after*
> end_testcase (with this change applied). Removing explicit tst_cleanup
> in end_testcase helps scenarios where no trap was set in tst_setup
> with the test author being responsible for trapping cleanup.
> 
> At least 18 tests already re-define entire end_testcase() exactly
> because of this inability to execute custom cleanup.
> Applying this change also makes (at least) ssh tests perform correct
> cleanup on test failure.
> 
> As for the 'exit 0' change - it makes sense from the looks and name
> of the function. The following tests use end_testcase without arguments:
> 
> network/tcp_cmds/arp/arp01
> network/tcp_cmds/echo/echo01
> network/tcp_cmds/finger/finger01
> network/tcp_cmds/ftp/ftp01
> network/tcp_cmds/ftp/ftp02
> network/tcp_cmds/ftp/ftp03
> network/tcp_cmds/ftp/ftp04
> network/tcp_cmds/ftp/ftp05
> network/tcp_cmds/host/host01
> network/tcp_cmds/netstat/netstat01
> network/tcp_cmds/perf_lan/perf_lan
> network/tcp_cmds/ping/ping01
> network/tcp_cmds/rcp/rcp01
> network/tcp_cmds/rdist/rdist01
> network/tcp_cmds/rsh/rsh01
> network/tcp_cmds/rwho/rwho01
> network/tcp_cmds/sendfile/sendfile01
> network/tcp_cmds/tcpdump/tcpdump01
> 
> and all except one use it only as the last line in the test.
> 
> The one exception is network/tcp_cmds/perf_lan/perf_lan, which uses
> end_testcase in a trapped handler as well, but - again - as a last cmd.
> The 'exit 0' change would actually improve the test, since it's
> apparently meant to end when interrupt_testcase is called.

Looks good, pushed, thanks.

PS: It looks to me like the cmdlib.sh wasn't finished. I've recently
    started to prototype new shell library (modeled more closely to
    the LTP C interface). See:
    http://sourceforge.net/p/ltp/mailman/message/31941597/

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android&trade; apps run on BlackBerry&reg;10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
