Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3z-0001ZM-QF
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:27 +0000
Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3y-0006rT-Qu
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:27 +0000
Received: by mail-lb0-f182.google.com with SMTP id v20so2333721lbc.41
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:20 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:59 +0200
Message-Id: <1375729379-16469-7-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
References: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 6/6] Remove reference to "java",
	missed in commit 78596957
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
 testscripts/test_realtime.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testscripts/test_realtime.sh b/testscripts/test_realtime.sh
index ad5075f..0d424fc 100755
--- a/testscripts/test_realtime.sh
+++ b/testscripts/test_realtime.sh
@@ -128,7 +128,7 @@ find_test()
             ;;
         all)
         # Run all tests which have run_auto.sh
-            TESTLIST="func stress java perf"
+            TESTLIST="func stress perf"
             ;;
         list)
         # This will only display subdirs which have run_auto.sh
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
