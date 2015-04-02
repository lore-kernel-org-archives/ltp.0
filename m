Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jack@suse.cz>) id 1YdZKa-0000Y2-Vn
	for ltp-list@lists.sourceforge.net; Thu, 02 Apr 2015 07:14:24 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 9B335AC3B
	for <ltp-list@lists.sourceforge.net>;
	Thu,  2 Apr 2015 07:14:16 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Date: Thu,  2 Apr 2015 09:14:11 +0200
Message-Id: <1427958851-16850-1-git-send-email-jack@suse.cz>
Subject: [LTP] [PATCH] syscalls/fanotify02: Fixup testcase
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
Cc: Jan Kara <jack@suse.cz>

The tescase incorrectly assumed that events will be generated for a
directory when FAN_ONDIR was not specified. That used to be the case due
to a kernel bug but it's not the case anymore.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify02.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 35e73b156d2f..c9aeca183c02 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -78,12 +78,13 @@ int main(int ac, char **av)
 
 		if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
 				    FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
-				    FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
+				    FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
+				  ".") < 0) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
 			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
-			    "FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
-			    fd_notify);
+			    "FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
+			    "failed", fd_notify);
 		}
 
 		/*
-- 
2.1.4


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
