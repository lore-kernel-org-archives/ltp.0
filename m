Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YIIf2-0004MZ-4K
	for ltp-list@lists.sourceforge.net; Mon, 02 Feb 2015 15:11:36 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIIf1-0002Z5-0z
	for ltp-list@lists.sourceforge.net; Mon, 02 Feb 2015 15:11:36 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t12FBS6X021859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Feb 2015 15:11:29 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t12FBRDt000624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Feb 2015 15:11:28 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t12FBRif008423
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Feb 2015 15:11:27 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon,  2 Feb 2015 18:11:21 +0300
Message-Id: <1422889881-9432-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <54CF8D41.6090709@oracle.com>
References: <54CF8D41.6090709@oracle.com>
Subject: [LTP] [PATCH V2 2/2] tst_module: introduce a timeout to unload
	modules
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
Cc: vasily.isaenko@oracle.com

It may happen, that the first execution of 'rmmod module_name'
may fail for some reason (like the module is in use for some short time).

Changed tst_module_unload() to execute 'rmmod module_name' multiple
times with the total number limited by a timeout.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * rely on the exit code of rmmod
 * removed tst_module_unload
 * added missing usleep()


 lib/tst_module.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/lib/tst_module.c b/lib/tst_module.c
index 8104582..0be6ced 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -100,6 +100,21 @@ void tst_module_load(void (cleanup_fn)(void),
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
+	int i, rc;
+
 	const char *const argv[] = { "rmmod", mod_name, NULL };
-	tst_run_cmd(cleanup_fn, argv, NULL, NULL, 0);
+
+	rc = 1;
+	for (i = 0; i < 50; i++) {
+		rc = tst_run_cmd(NULL, argv, "/dev/null", "/dev/null", 1);
+		if (!rc)
+			break;
+
+		usleep(20000);
+	}
+
+	if (rc) {
+		tst_brkm(TBROK, cleanup_fn,
+			 "could not unload %s module", mod_name);
+	}
 }
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
