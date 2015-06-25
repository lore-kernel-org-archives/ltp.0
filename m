Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z82EC-0005PL-Hh
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 08:09:44 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z82E8-0006AJ-AC
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 08:09:44 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Thu, 25 Jun 2015 10:14:05 -0600
Message-ID: <1435248845-29155-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Need to install linux-libc-dev for getrandom cases.
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 doc/mini-howto-building-ltp-from-git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mini-howto-building-ltp-from-git.txt b/doc/mini-howto-building-ltp-from-git.txt
index 28825c2..7a1062e 100644
--- a/doc/mini-howto-building-ltp-from-git.txt
+++ b/doc/mini-howto-building-ltp-from-git.txt
@@ -36,7 +36,7 @@ sudo apt-get install build-essential
 sudo apt-get install autoconf automake autotools-dev m4
 sudo apt-get install git
 sudo apt-get install linux-headers-$(uname -r)
-sudo apt-get install libaio-dev libattr1-dev libcap-dev
+sudo apt-get install libaio-dev libattr1-dev libcap-dev linux-libc-dev
 
 # Working directory
 
-- 
1.9.1


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
