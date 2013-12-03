Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1Vnn1z-0007Ri-E8
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vnn1y-0001w9-5T
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:39 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3AGVuA002431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:31 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3AGTDL026430
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:30 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 11:16:11 +0100
Message-Id: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 0/5] various tcp_cmds/ssh/* fixes, rewrites
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

Jiri Jaburek (5):
  ssh: unify code style amongst ssh tests
  ssh: remove unused ssh_set_passwd script
  ssh: properly create/remove user home dir, if possible
  ssh: try to prevent invalid PASS when remote cmd fails
  ssh: don't use crypt-based pre-encrypted passwords

 testcases/network/tcp_cmds/ssh/ssh01          | 42 ++++++++++++------------
 testcases/network/tcp_cmds/ssh/ssh01_s1       | 39 +++++++++++++----------
 testcases/network/tcp_cmds/ssh/ssh02          | 39 +++++++++++------------
 testcases/network/tcp_cmds/ssh/ssh02_s1       | 17 +++++-----
 testcases/network/tcp_cmds/ssh/ssh03          | 46 +++++++++++++--------------
 testcases/network/tcp_cmds/ssh/ssh03_s1       | 15 +++++----
 testcases/network/tcp_cmds/ssh/ssh_set_passwd | 28 ----------------
 7 files changed, 103 insertions(+), 123 deletions(-)
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_set_passwd

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
