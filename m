Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Yptjb-0002KS-Vn
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yptjb-0002S6-48
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:11 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t467Plh6004584
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 15:25:47 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 6 May 2015 15:26:13 +0800
Message-ID: <1430897176-16486-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/5] kernel/syscalls/ipc/lib: Don't allocate memory
	for getpwnam()
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
To: ltp-list@lists.sourceforge.net

The getpwnam() function returns a pointer to a passwd
structure.
so Just need to declare a pointer to this structure,
not to allocate memory for it.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/lib/libipc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/lib/libipc.c b/testcases/kernel/syscalls/ipc/lib/libipc.c
index f10e257..93fe6ce 100644
--- a/testcases/kernel/syscalls/ipc/lib/libipc.c
+++ b/testcases/kernel/syscalls/ipc/lib/libipc.c
@@ -141,13 +141,7 @@ void rm_sema(int sem_id)
  */
 int getuserid(char *user)
 {
-	struct passwd *ent;
-
-	/* allocate some space for the passwd struct */
-	if ((ent = malloc(sizeof(struct passwd))) == NULL) {
-		tst_brkm(TBROK, cleanup, "couldn't allocate space for passwd"
-			 " structure");
-	}
+	struct passwd *ent = NULL;
 
 	/* get the uid value for the user */
 	if ((ent = getpwnam(user)) == NULL) {
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
