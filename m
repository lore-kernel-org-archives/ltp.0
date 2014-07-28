Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1XBtVw-0003tq-ML
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 22:35:28 +0000
Received: from mail-oi0-f43.google.com ([209.85.218.43])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XBtVv-0008WV-Ua
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 22:35:28 +0000
Received: by mail-oi0-f43.google.com with SMTP id u20so6719696oif.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Jul 2014 15:35:22 -0700 (PDT)
From: "Gary S. Robertson" <gary.robertson@linaro.org>
Date: Mon, 28 Jul 2014 17:05:02 -0500
Message-Id: <1406585102-31700-1-git-send-email-gary.robertson@linaro.org>
Subject: [LTP] [PATCH] prio-wake: eliminate deprecated usleep calls
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
Cc: mike.holmes@linaro.org

From: "Gary S. Robertson" <gary.robertson@linaro.org>

Replaced deprecated usleep calls with calls to rt_nanosleep,
which has no potentially adverse interactions with signals.

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 testcases/realtime/func/prio-wake/prio-wake.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/func/prio-wake/prio-wake.c b/testcases/realtime/func/prio-wake/prio-wake.c
index 18c0405..f34ae30 100644
--- a/testcases/realtime/func/prio-wake/prio-wake.c
+++ b/testcases/realtime/func/prio-wake/prio-wake.c
@@ -108,10 +108,10 @@ void *master_thread(void *arg)
 
 	/* make sure children are started */
 	while (running_threads < rt_threads)
-		usleep(1000);
+		rt_nanosleep(1000000);
 	/* give the worker threads a chance to get to sleep in the kernel
 	 * in the unlocked broadcast case. */
-	usleep(1000);
+	rt_nanosleep(1000000);
 
 	start = rt_gettime() - beginrun;
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
