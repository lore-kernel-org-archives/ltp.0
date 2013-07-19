Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V06y3-00018O-Jm
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 09:27:15 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V06xy-0005pD-Rm
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 09:27:15 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r6J9R4Qv031601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jul 2013 09:27:05 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6J9R3Cd009762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jul 2013 09:27:04 GMT
Received: from abhmt110.oracle.com (abhmt110.oracle.com [141.146.116.62])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6J9R3cN009758
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jul 2013 09:27:03 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 19 Jul 2013 13:26:52 +0400
Message-Id: <1374226012-16771-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1374226012-16771-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1374226012-16771-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/2] lib/tst_module.c: modification for updated
	tst_run_cmd specification
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

Modified lib/tst_module.c:
* for updated tst_run_cmd specification
* to hide gcc warning "initialization discards qualifiers from pointer target type"

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_module.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_module.c b/lib/tst_module.c
index 832da27..4871005 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -94,12 +94,12 @@ void tst_module_load(void (cleanup_fn)(void),
 	for (i = offset; i < size; ++i)
 		mod_argv[i] = argv[i - offset];
 
-	tst_run_cmd(cleanup_fn, mod_argv);
+	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL);
 	free(mod_path);
 }
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
-	char *const argv[] = { "rmmod", mod_name, NULL };
-	tst_run_cmd(cleanup_fn, argv);
+	char *const argv[] = { "rmmod", (char *) mod_name, NULL };
+	tst_run_cmd(cleanup_fn, argv, NULL, NULL);
 }
-- 
1.7.1


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
