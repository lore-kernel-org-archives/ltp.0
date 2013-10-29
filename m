Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHeg-0000Pe-Tq
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:54 +0000
Received: from mail-oa0-f54.google.com ([209.85.219.54])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHeg-0007Pa-7m
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:54 +0000
Received: by mail-oa0-f54.google.com with SMTP id o20so628812oag.27
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:48 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:34 -0700
Message-Id: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 0/9] ltp-networking on ubuntu
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
Cc: linaro-networking@linaro.org

Hi
I want to do ltp-networking test with ubuntu rootfs on the arndale board, but some of them can't test success. So I do several changes based on the ltp release 20130904. Could you help to review them?

Vincent Hsu (9):
  ltp-networking/nfs: Setting the NFS to version 3 by default. NFSv3 is
        more compatibled with recent linux distributions.
  ltp-networking/nfs: don't use absolute path for showmount. showmount
       does not locate at /user/sbin/showmount on Ubuntu 12.04.
  ltp-networking/tcp_cmds/finger: finger an unknown host test will
    return     1 even if execution success on Ubuntu 12.04
  ltp-networking/tcp_cmds/netstat: netstat cmds will return 1 even if
    no     output in stderr on Ubuntu 12.04
  ltp-networking/tcp_cmds/tcpdump:     1. RHOST IP won't appear in
    network interfaces. It should be LHOST.     2. Host commad can't
    fetch IP in no DNS enviroment. use ping intead of        it
  ltp-networking/iproute:     ip02: set original mtu size back. this
    test will set mtu to 300.     ip05: if there is nott only one route
    using "head" command will get           wrong result.
  ltp-networking/iptables: "iptables -L -t nat" lists 4 chains not
    3 chains on Ubuntu 12.04
  ltp-networking: standardize test result message
  ltp-networking/rpc: gave precise test name

 testcases/network/iproute/ip_tests.sh              |    6 +++++-
 testcases/network/iptables/iptables_tests.sh       |   22 +++++++++++++-------
 testcases/network/multicast/mc_cmds/mc_cmds        |    9 ++++++--
 testcases/network/multicast/mc_commo/mc_commo      |    8 +++++--
 testcases/network/multicast/mc_member/mc_member    |    8 +++++--
 testcases/network/multicast/mc_opts/mc_opts        |    8 +++++--
 testcases/network/nfs/fsx-linux/fsx.sh             |    9 +++++---
 testcases/network/nfs/nfs01/nfs01                  |    9 +++++---
 testcases/network/nfs/nfs02/nfs02                  |   11 ++++++----
 testcases/network/nfs/nfs03/nfs03                  |    9 +++++---
 testcases/network/nfs/nfs04/nfs04                  |    2 +-
 testcases/network/nfs/nfslock01/nfslock01          |    7 +++++--
 testcases/network/nfs/nfsstat01/nfsstat01          |    9 +++++---
 testcases/network/nfs/nfsstress/nfsstress          |   11 ++++++----
 testcases/network/rpc/basic_tests/rpc01/rpc01      |    7 +++++--
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |    9 +++++---
 testcases/network/rpc/basic_tests/rup/rup01        |    9 +++++---
 testcases/network/rpc/basic_tests/rusers/rusers01  |    7 +++++--
 testcases/network/tcp_cmds/finger/finger01         |    4 ++--
 testcases/network/tcp_cmds/netstat/netstat01       |    3 ++-
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |    4 ++--
 21 files changed, 117 insertions(+), 54 deletions(-)

--
1.7.9.5


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
