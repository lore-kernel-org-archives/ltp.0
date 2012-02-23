Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1S0VQX-0006ID-VQ
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 09:57:29 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S0VQS-0001F8-2a
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 09:57:29 +0000
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 23 Feb 2012 09:56:58 +0000
Message-ID: <1329991018-26230-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] creat07: Drop basename() function call from read-only
	variable
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

test_app is a read-only variable because it is defined as a preprocessor macro.
Using basename() on this variable, it will most certainly lead to a segmentation
fault in uClibc code. Moreover, there is no need to use basename() at all since
the test_app variable is a single string and it does not contain any leading
paths.

Quote from uClibc's include/libgen.h header:

"Return final component of PATH.
	This is the weird XPG version of this function.  It sometimes will
	modify its argument.  Therefore we normally use the GNU version (in
	<string.h>) and only if this header is included make the XPG
	version available under the real name.

	extern char *__xpg_basename (char *__path) __THROW;
	#define basename        __xpg_basename"

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/syscalls/creat/creat07.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 3bb1288..294f998 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 
 		if (pid == 0) {
 			char *av[2];
-			av[0] = basename(test_app);
+			av[0] = test_app;
 			av[1] = NULL;
 			(void)execve(test_app, av, NULL);
 			perror("execve failed");
@@ -147,7 +147,7 @@ void setup(char *app)
 			tst_brkm(TBROK|TERRNO, NULL, "getcwd failed");
 
 		snprintf(test_path, sizeof(test_path), "%s/%s",
-		    pwd, basename(test_app));
+		    pwd, test_app);
 
 		free(pwd);
 	}
-- 
1.7.1



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
