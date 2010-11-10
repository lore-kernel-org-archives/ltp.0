Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PG1QJ-0003Nh-2e
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 03:32:35 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PG1QH-0003td-To
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 03:32:35 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAA3WRKN010146
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Nov 2010 22:32:27 -0500
Date: Tue, 9 Nov 2010 22:32:27 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1206967940.2804651289359947848.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1824167242.2804331289359263862.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix sysconf failure in RHEL4
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
To: LTP List <ltp-list@lists.sourceforge.net>

Hi all,

I met a strange error (only) in RHEL4, syscalls/sysconf 
failed the last test case because of the variable `actual' 
was not evaluated by `errno':

sysconf01   56  TFAIL  :  sysconf correctly failed, but expected errno (22) != actual (0)

I remov the var `actual' and use `errno' directly, seems it 
works. Re-test under RHEL4/5/6 and all of them pass the test. 

I have no idea why errno value couldn't be assigned to 
`actual', either not sure whether my patch works on other
non-Red Hat distos. Please have a look at this patch if 
you want, thanks.

Signed-off-by: Caspar Zhang <czhang@redhat.com>

---
 testcases/kernel/syscalls/sysconf/sysconf01.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/sysconf/sysconf01.c b/testcases/kernel/syscalls/sysconf/sysconf01.c
index 783c6f5..42246f0 100644
--- a/testcases/kernel/syscalls/sysconf/sysconf01.c
+++ b/testcases/kernel/syscalls/sysconf/sysconf01.c
@@ -153,19 +153,18 @@ int main()
 
 	/* 56 */
 	{
-		int retval, actual;
+		int retval;
 		errno = 0;
 		retval = sysconf(INVAL_FLAG);
-		actual = errno;
 		if (retval != -1) {
 			tst_resm(TFAIL,
 				 "sysconf succeeded for invalid flag (%i), "
 				 " retval=%d errno=%d: %s",
-				 INVAL_FLAG, retval, actual, strerror(actual));
-		} else if (actual != EINVAL) {
+				 INVAL_FLAG, retval, errno, strerror(errno));
+		} else if (errno != EINVAL) {
 			tst_resm(TFAIL,
 				 "sysconf correctly failed, but expected "
-				 "errno (%i) != actual (%i)", EINVAL, actual);
+				 "errno (%i) != actual (%i)", EINVAL, errno);
 		} else
 			tst_resm(TPASS, "The invalid sysconf key was trapped "
 					"appropriately");
-- 
1.7.3.2

-- 
Quality Assurance Associate (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch

TEL: +86-10-62608150
WEB: http://www.redhat.com/

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
