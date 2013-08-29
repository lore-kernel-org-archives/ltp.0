Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1VF2hm-0007zp-4r
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:56:10 +0000
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VF2hk-0002Xf-BB
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:56:10 +0000
Received: by mail-lb0-f176.google.com with SMTP id y6so732288lbh.35
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Aug 2013 06:56:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 29 Aug 2013 15:55:47 +0200
Message-Id: <1377784548-1036-2-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
References: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 1/2] realtime parser: remove unused and depricated
	imports
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
Cc: patches@linaro.org

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/realtime/scripts/parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/scripts/parser.py b/testcases/realtime/scripts/parser.py
index b90233c..6b2dc73 100644
--- a/testcases/realtime/scripts/parser.py
+++ b/testcases/realtime/scripts/parser.py
@@ -26,7 +26,7 @@
 ##                                                                            ##
 ################################################################################
 
-import sys,os,string,re
+import sys
 
 class Log:
     def __init__(self,filename):
-- 
1.8.1.2


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
