Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1VnoP1-0004K0-FW
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 11:44:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VnoP0-0005um-6h
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 11:44:31 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3BiOgF020601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 06:44:24 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3BiL1T032363
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 06:44:22 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 12:44:13 +0100
Message-Id: <1386071053-2350-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH] cmdlib/end_testcase: don't call tst_cleanup,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Calling tst_cleanup explicitly causes the EXIT trap to be emptied,
removing possible user-defined cleanup routines. It also doesn't make
sense - tst_setup does NOT always set an EXIT trap, only when $TCtmp
is set. And even then, the trap is correctly executed *after*
end_testcase (with this change applied). Removing explicit tst_cleanup
in end_testcase helps scenarios where no trap was set in tst_setup
with the test author being responsible for trapping cleanup.

At least 18 tests already re-define entire end_testcase() exactly
because of this inability to execute custom cleanup.
Applying this change also makes (at least) ssh tests perform correct
cleanup on test failure.

As for the 'exit 0' change - it makes sense from the looks and name
of the function. The following tests use end_testcase without arguments:

network/tcp_cmds/arp/arp01
network/tcp_cmds/echo/echo01
network/tcp_cmds/finger/finger01
network/tcp_cmds/ftp/ftp01
network/tcp_cmds/ftp/ftp02
network/tcp_cmds/ftp/ftp03
network/tcp_cmds/ftp/ftp04
network/tcp_cmds/ftp/ftp05
network/tcp_cmds/host/host01
network/tcp_cmds/netstat/netstat01
network/tcp_cmds/perf_lan/perf_lan
network/tcp_cmds/ping/ping01
network/tcp_cmds/rcp/rcp01
network/tcp_cmds/rdist/rdist01
network/tcp_cmds/rsh/rsh01
network/tcp_cmds/rwho/rwho01
network/tcp_cmds/sendfile/sendfile01
network/tcp_cmds/tcpdump/tcpdump01

and all except one use it only as the last line in the test.

The one exception is network/tcp_cmds/perf_lan/perf_lan, which uses
end_testcase in a trapped handler as well, but - again - as a last cmd.
The 'exit 0' change would actually improve the test, since it's
apparently meant to end when interrupt_testcase is called.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/lib/cmdlib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
index d6f43d2..f5f1cb1 100644
--- a/testcases/lib/cmdlib.sh
+++ b/testcases/lib/cmdlib.sh
@@ -86,9 +86,9 @@ tst_setup()
 #=============================================================================
 end_testcase()
 {
-    tst_cleanup
     if [ $# -eq 0 ]; then
         tst_resm TPASS "Test successful"
+        exit 0
     else
         tst_resm TFAIL "Test broken: $*"
         exit 1
-- 
1.8.3.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
