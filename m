Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <avagin@gmail.com>) id 1XRei5-0000fJ-Gr
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 10:01:09 +0000
Received: from mail-lb0-f181.google.com ([209.85.217.181])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XRei4-0000Vf-Fl
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 10:01:09 +0000
Received: by mail-lb0-f181.google.com with SMTP id z11so7102460lbi.12
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Sep 2014 03:01:01 -0700 (PDT)
From: Andrey Vagin <avagin@openvz.org>
Date: Wed, 10 Sep 2014 14:00:53 +0400
Message-Id: <1410343254-2349-1-git-send-email-avagin@openvz.org>
Subject: [LTP] [PATCH 1/2] inotify: fix warnings
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

inotify04.c:200:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (len == -1)
          ^
inotify04.c:206:11: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  while (i < len) {

inotify02.c:202:42: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
         && event_set[TST_TOTAL - 1].mask ==
                                          ^
inotify02.c:223:41: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
    } else if ((event_set[test_num].mask == event->mask)

Signed-off-by: Andrey Vagin <avagin@openvz.org>
---
 testcases/kernel/syscalls/inotify/inotify02.c | 2 +-
 testcases/kernel/syscalls/inotify/inotify04.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index d07705b..f4f93fc 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -69,7 +69,7 @@ static int wd;
 
 struct event_t {
 	char name[BUF_SIZE];
-	int mask;
+	unsigned int mask;
 	int len;
 };
 #define FILE_NAME1 "test_file1"
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index c1c8db1..7c3fdef 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -66,8 +66,8 @@ int TST_TOTAL = 4;
 
 struct event_t {
 	char name[BUF_SIZE];
-	int mask;
-	size_t len;
+	unsigned int mask;
+	unsigned int len;
 };
 
 #define	TEST_DIR	"test_dir"
@@ -147,8 +147,7 @@ static void setup(void)
 int main(int argc, char **argv)
 {
 	const char *msg;
-	size_t len;
-	int i, test_num;
+	int i, test_num, len;
 
 	i = 0;
 	test_num = 0;
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
