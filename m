Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3t-0006tH-NM
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:21 +0000
Received: from mail-lb0-f181.google.com ([209.85.217.181])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3q-00076n-B4
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:21 +0000
Received: by mail-lb0-f181.google.com with SMTP id o10so2355182lbi.40
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:56 +0200
Message-Id: <1375729379-16469-4-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
References: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 3/6] realtime tests: added additional install targets
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
 testcases/realtime/func/pi-tests/Makefile |    2 +-
 testcases/realtime/perf/latency/Makefile  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/Makefile b/testcases/realtime/func/pi-tests/Makefile
index 5273952..7a7a57a 100644
--- a/testcases/realtime/func/pi-tests/Makefile
+++ b/testcases/realtime/func/pi-tests/Makefile
@@ -22,7 +22,7 @@
 
 top_srcdir		?= ../../../..
 
-INSTALL_TARGETS		:= run_auto.sh
+INSTALL_TARGETS		:= run_auto.sh parse-testpi1.py parse-testpi2.py
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 
diff --git a/testcases/realtime/perf/latency/Makefile b/testcases/realtime/perf/latency/Makefile
index eea054d..e8f3345 100644
--- a/testcases/realtime/perf/latency/Makefile
+++ b/testcases/realtime/perf/latency/Makefile
@@ -22,7 +22,7 @@
 
 top_srcdir		?= ../../../..
 
-INSTALL_TARGETS		:= run_auto.sh
+INSTALL_TARGETS		:= run_auto.sh cpunoise.sh cpunoise2000.sh disknoise.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
