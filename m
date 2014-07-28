Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1XBtQQ-0005E9-Ef
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 22:29:46 +0000
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XBtQO-0008L2-Q0
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 22:29:46 +0000
Received: by mail-oa0-f47.google.com with SMTP id g18so9555435oah.6
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Jul 2014 15:29:39 -0700 (PDT)
From: "Gary S. Robertson" <gary.robertson@linaro.org>
Date: Mon, 28 Jul 2014 17:04:08 -0500
Message-Id: <1406585048-31585-1-git-send-email-gary.robertson@linaro.org>
Subject: [LTP] [PATCH] pthread_cond_many: fix uninitialized return in option
	handling
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

Some of the cases in the switch statement in parse_args() did not
initialize the 'handled' variable which is returned by the function.
Added an initialization to the definition of the variable.

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 .../realtime/perf/latency/pthread_cond_many.c      |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/perf/latency/pthread_cond_many.c b/testcases/realtime/perf/latency/pthread_cond_many.c
index f9325b5..1d39100 100644
--- a/testcases/realtime/perf/latency/pthread_cond_many.c
+++ b/testcases/realtime/perf/latency/pthread_cond_many.c
@@ -256,7 +256,7 @@ void usage(void)
 
 int parse_args(int c, char *v)
 {
-	int handled;
+	int handled = 1;
 	switch (c) {
 	case 'h':
 		usage();
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
