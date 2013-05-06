Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <riku.voipio@linaro.org>) id 1UZLNn-00031U-GE
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:23:11 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UZLNm-0002zK-38
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:23:11 +0000
From: riku.voipio@linaro.org
Date: Mon,  6 May 2013 16:22:57 +0300
Message-Id: <1367846581-18599-1-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH 0/4 v2] Add Aarch64 support to ltp
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

From: Riku Voipio <riku.voipio@linaro.org>

Hi,

The following patches add support for Aarch64 in LTP.
v2: adapt to latest upstream code and include generated linux_syscall_numbers.h


Riku Voipio (4):
  Add aarch64 support
  [v2] Set invalid syscall as -1 instead of 0
  Aarch64: include updated linux_syscall_numbers.h
  set 16kb incrediment for Aarch64

 testcases/kernel/include/aarch64.in              |  257 ++++
 testcases/kernel/include/linux_syscall_numbers.h | 1608 ++++++++++++++++------
 testcases/kernel/include/order                   |    1 +
 testcases/kernel/include/regen.sh                |    5 +-
 testcases/kernel/mem/shmt/shmt09.c               |    4 +-
 5 files changed, 1467 insertions(+), 408 deletions(-)
 create mode 100644 testcases/kernel/include/aarch64.in

-- 
1.7.10.4


------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
