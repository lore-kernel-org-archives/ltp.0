Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xuw@redhat.com>) id 1Xo34w-0006s2-DQ
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 04:29:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xo34v-00020m-4M
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 04:29:18 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAB4TAGE018703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 23:29:10 -0500
From: xuw@redhat.com
Date: Tue, 11 Nov 2014 12:29:06 +0800
Message-Id: <1415680146-9562-1-git-send-email-xuw@redhat.com>
Subject: [LTP] [PATCH] tst_mkfs: ignorce SIGCHLD for calling system function
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
Cc: fs-qe-dev@redhat.com

From: George Wang <xuw@redhat.com>

function(3) system will raise the SIGCHILD signal to parent process,
which should cause the test case failed(especially to btrfs). ignorce
it before calling the system function and restore it after the calling.

Signed-off-by: George Wang <xuw@redhat.com>
---
 lib/tst_mkfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5eb3392..9a63863 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -45,11 +45,13 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 		/*
 		 * The -f option was added to btrfs-progs v3.12
 		 */
+		void *old_handler = signal(SIGCHLD, SIG_DFL);	
 		if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
 			tst_resm(TINFO, "Appending '-f' flag to mkfs.%s",
 				fs_type);
 			argv[pos++] = "-f";
 		}
+		signal(SIGCHLD, old_handler);
 	}
 
 	if (fs_opts) {
-- 
1.9.3


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
