Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <riku.voipio@linaro.org>) id 1UYGXT-0000mp-9i
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 14:00:43 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UYGXR-0002yA-71
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 14:00:43 +0000
From: riku.voipio@linaro.org
Date: Fri,  3 May 2013 16:45:14 +0300
Message-Id: <1367588717-18162-1-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH 0/3] Add Aarch64 support to ltp
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

Riku Voipio (3):
  Add aarch64 support
  Set invalid syscall as -1 instead of 0
  set 16kb incrediment for Aarch64

 testcases/kernel/include/aarch64.in |  257 +++++++++++++++++++++++++++++++++++
 testcases/kernel/include/order      |    1 +
 testcases/kernel/include/regen.sh   |    5 +-
 testcases/kernel/mem/shmt/shmt09.c  |    4 +-
 4 files changed, 263 insertions(+), 4 deletions(-)
 create mode 100644 testcases/kernel/include/aarch64.in

-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
