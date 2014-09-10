Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <avagin@gmail.com>) id 1XRei8-0000fn-RK
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 10:01:12 +0000
Received: from mail-la0-f50.google.com ([209.85.215.50])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XRei7-0005vi-Mq
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 10:01:12 +0000
Received: by mail-la0-f50.google.com with SMTP id ty20so6003959lab.37
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Sep 2014 03:01:05 -0700 (PDT)
From: Andrey Vagin <avagin@openvz.org>
Date: Wed, 10 Sep 2014 14:00:54 +0400
Message-Id: <1410343254-2349-2-git-send-email-avagin@openvz.org>
In-Reply-To: <1410343254-2349-1-git-send-email-avagin@openvz.org>
References: <1410343254-2349-1-git-send-email-avagin@openvz.org>
Subject: [LTP] [PATCH 2/2] inotify: print event->name accoding with
	event->len
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
Cc: Andrey Vagin <avagin@openvz.org>

Signed-off-by: Andrey Vagin <avagin@openvz.org>
---
 testcases/kernel/syscalls/inotify/inotify02.c |  8 ++++----
 testcases/kernel/syscalls/inotify/inotify04.c | 15 ++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index f4f93fc..69bc0ff 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -216,8 +216,8 @@ int main(int ac, char **av)
 				tst_resm(TFAIL,
 					 "get unnecessary event: "
 					 "wd=%d mask=%x cookie=%u len=%u"
-					 "name=\"%s\"", event->wd, event->mask,
-					 event->cookie, event->len,
+					 "name=\"%.*s\"", event->wd, event->mask,
+					 event->cookie, event->len, event->len,
 					 event->name);
 
 			} else if ((event_set[test_num].mask == event->mask)
@@ -244,10 +244,10 @@ int main(int ac, char **av)
 				if (!fail) {
 					tst_resm(TPASS,
 						 "get event: wd=%d mask=%x "
-						 "cookie=%u len=%u name=\"%s\"",
+						 "cookie=%u len=%u name=\"%.*s\"",
 						 event->wd, event->mask,
 						 event->cookie, event->len,
-						 event->name);
+						 event->len, event->name);
 				} else {
 					tst_resm(TFAIL,
 						 "get event: wd=%d mask=%x "
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 7c3fdef..e8cdbab 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -223,8 +223,8 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL,
 				 "got unnecessary event: "
 				 "wd=%d mask=%x cookie=%u len=%u "
-				 "name=\"%s\"", event->wd, event->mask,
-				 event->cookie, event->len, event->name);
+				 "name=\"%.*s\"", event->wd, event->mask,
+				 event->cookie, event->len, event->len, event->name);
 
 		} else if ((event_set[test_num].mask == event->mask)
 			   &&
@@ -233,18 +233,19 @@ int main(int argc, char **argv)
 			     event->len))) {
 			tst_resm(TPASS,
 				 "got event: wd=%d mask=%x "
-				 "cookie=%u len=%u name=\"%s\"",
+				 "cookie=%u len=%u name=\"%.*s\"",
 				 event->wd, event->mask, event->cookie,
-				 event->len, event->name);
+				 event->len, event->len, event->name);
 
 		} else {
 			tst_resm(TFAIL, "got event: wd=%d mask=%x "
 				 "(expected %x) cookie=%u len=%u "
-				 "name=\"%s\" (expected \"%s\") %d",
+				 "name=\"%.*s\" (expected \"%.*s\") %d",
 				 event->wd, event->mask,
 				 event_set[test_num].mask,
-				 event->cookie, event->len, event->name,
-				 event_set[test_num].name,
+				 event->cookie, event->len,
+				 event->len, event->name,
+				 event_set[test_num].len, event_set[test_num].name,
 				 strcmp(event_set[test_num].name, event->name));
 		}
 		test_num++;
-- 
1.9.3


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
