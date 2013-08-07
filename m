Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V71pl-0005JS-A4
	for ltp-list@lists.sourceforge.net; Wed, 07 Aug 2013 11:23:17 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V71pj-0006N9-99
	for ltp-list@lists.sourceforge.net; Wed, 07 Aug 2013 11:23:17 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r77BN8ew026538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Aug 2013 11:23:09 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r77BN7U5012396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Aug 2013 11:23:08 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r77BN7Ar010073
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Aug 2013 11:23:07 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  7 Aug 2013 15:22:55 +0400
Message-Id: <1375874575-29198-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130807102427.GA4389@rei>
References: <20130807102427.GA4389@rei>
Subject: [LTP] [PATCH] tst_run_cmd: const correctness
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
Cc: vasily.isaenko@oracle.com, alexey.kodanev@oracle.com

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h    |    4 ++--
 lib/tst_module.c  |    4 ++--
 lib/tst_run_cmd.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/test.h b/include/test.h
index 1957148..75a34ab 100644
--- a/include/test.h
+++ b/include/test.h
@@ -225,7 +225,7 @@ long tst_ncpus_max(void);
  * redirection is not needed.
  */
 void tst_run_cmd_fds(void (cleanup_fn)(void),
-			char *const argv[],
+			const char *const argv[],
 			int stdout_fd,
 			int stderr_fd);
 
@@ -236,7 +236,7 @@ void tst_run_cmd_fds(void (cleanup_fn)(void),
  * not needed.
  */
 void tst_run_cmd(void (cleanup_fn)(void),
-		char *const argv[],
+		const char *const argv[],
 		const char *stdout_path,
 		const char *stderr_path);
 
diff --git a/lib/tst_module.c b/lib/tst_module.c
index c0f2c8f..028af0e 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -85,7 +85,7 @@ void tst_module_load(void (cleanup_fn)(void),
 	while (argv && argv[size])
 		++size;
 	size += offset;
-	char *mod_argv[size + 1]; /* + NULL in the end */
+	const char *mod_argv[size + 1]; /* + NULL in the end */
 	mod_argv[size] = NULL;
 	mod_argv[0] = "insmod";
 	mod_argv[1] = mod_path;
@@ -100,6 +100,6 @@ void tst_module_load(void (cleanup_fn)(void),
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
-	char *const argv[] = { "rmmod", mod_name, NULL };
+	const char *const argv[] = { "rmmod", mod_name, NULL };
 	tst_run_cmd(cleanup_fn, argv, NULL, NULL);
 }
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 714b508..2c84cfd 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -31,7 +31,7 @@
 #define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
 
 void tst_run_cmd_fds(void (cleanup_fn)(void),
-		char *const argv[],
+		const char *const argv[],
 		int stdout_fd,
 		int stderr_fd)
 {
@@ -73,7 +73,7 @@ void tst_run_cmd_fds(void (cleanup_fn)(void),
 }
 
 void tst_run_cmd(void (cleanup_fn)(void),
-		char *const argv[],
+		const char *const argv[],
 		const char *stdout_path,
 		const char *stderr_path)
 {
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
