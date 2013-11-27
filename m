Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VlYn7-0003Bx-3t
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 06:40:05 +0000
Received: from mail-pb0-f50.google.com ([209.85.160.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VlYn5-0006Rm-8X
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 06:40:05 +0000
Received: by mail-pb0-f50.google.com with SMTP id rr13so9775353pbb.9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Nov 2013 22:39:57 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Wed, 27 Nov 2013 14:37:50 +0800
Message-Id: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH V2 0/2] fixing over 80 chars
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

Hi,
I've fixed the over 80 characters lines that my patches adds,
but there are other lines over 80 chars in the same file.
eg.
    checkpatch.pl -f testcases/network/iproute/ip_tests.sh
    ....
    WARNING: line over 80 characters
    #575: FILE: network/iproute/ip_tests.sh:575:
    +                       ip maddr show | grep "66:66:00:00:00:66" &>$LTPTMP/tst_ip.err \
    total: 0 errors, 22 warnings, 611 lines checked

BTW, some test files combine spaces and tabs for indentation, and also have
over 80 chars lines.
eg.
    testcases/network/multicast/*
    testcases/network/nfs/*

Maybe you could clean up them when you have time :)

Vincent Hsu (2):
  ltp-networking/tcp_cmds/finger: fix finger test
  ltp-networking/iproute: fix iproute test

 testcases/network/iproute/ip_tests.sh      |    7 ++++++-
 testcases/network/tcp_cmds/finger/finger01 |    9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

--
1.7.9.5


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
