Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YFght-0008SB-U2
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 10:15:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YFght-0003CR-5j
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 10:15:46 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0QAFfDs029738
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 10:15:42 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0QAFeGx013883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 10:15:41 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0QAFdGb027283
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 10:15:40 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 26 Jan 2015 13:15:33 +0300
Message-Id: <1422267333-22808-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20150120114329.GA11013@rei>
References: <20150120114329.GA11013@rei>
Subject: [LTP] [PATCH 2/2] tst_module: introduce a timeout to unload modules
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
 include/tst_module.h |   11 ++++++++
 lib/tst_module.c     |   70 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/include/tst_module.h b/include/tst_module.h
index c50efec..f6b699a 100644
--- a/include/tst_module.h
+++ b/include/tst_module.h
@@ -48,6 +48,17 @@ void tst_module_exist(void (cleanup_fn)(void), const char *mod_name,
 	char **mod_path);
 
 /*
+ * Check if the module is loaded.
+ *
+ * @mod_name: the module's name or file name
+ *
+ * Returns 1 if the module is loaded, 0 - if it's not.
+ *
+ * In case of failure calls cleanup_fn and exits with TBROK.
+ */
+int tst_module_is_loaded(void (cleanup_fn)(void), const char *mod_name);
+
+/*
  * Load a module using insmod program.
  *
  * @mod_name: module's file name.
diff --git a/lib/tst_module.c b/lib/tst_module.c
index 8104582..49c9bd0 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -74,6 +74,59 @@ void tst_module_exists(void (cleanup_fn)(void),
 		free(buf);
 }
 
+int tst_module_is_loaded(void (cleanup_fn)(void),
+			 const char *mod_name)
+{
+	FILE *f;
+	char *pos;
+	char mod_name_can[64];
+	char mod_name_read[64];
+	char buf[128];
+	int ret = 0;
+
+	if (strlen(mod_name) + 1 > sizeof(mod_name_can))
+		tst_brkm(TBROK, cleanup_fn, "Too long module name: '%s'",
+			mod_name);
+
+	/*
+	 * modify the module name to compare with names in /proc/modules
+	 */
+	strcpy(mod_name_can, mod_name);
+
+	pos = strstr(mod_name_can, ".ko");
+	if (pos != NULL)
+		*pos = '\0';
+
+	pos = mod_name_can;
+	while (*pos) {
+		if (*pos == '-')
+			*pos = '_';
+		pos++;
+	}
+
+	f = fopen("/proc/modules", "r");
+	if (f == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "Failed to open /proc/modules at %s:%d",
+			 __FILE__, __LINE__);
+
+	while (fgets(buf, sizeof(buf), f) != NULL) {
+		if (sscanf(buf, "%63s", mod_name_read) != 1) {
+			fclose(f);
+			tst_brkm(TBROK | TERRNO, cleanup_fn,
+				 "Failed to parse /proc/modules at %s:%d",
+				 __FILE__, __LINE__);
+		}
+
+		if (!strcmp(mod_name_can, mod_name_read)) {
+			ret = 1;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 void tst_module_load(void (cleanup_fn)(void),
 	const char *mod_name, char *const argv[])
 {
@@ -100,6 +153,21 @@ void tst_module_load(void (cleanup_fn)(void),
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
+	int i;
+	int loaded;
+
 	const char *const argv[] = { "rmmod", mod_name, NULL };
-	tst_run_cmd(cleanup_fn, argv, NULL, NULL, 0);
+
+	loaded = 1;
+	for (i = 0; i < 50; i++) {
+		tst_run_cmd(NULL, argv, "/dev/null", "/dev/null", 1);
+
+		loaded = tst_module_is_loaded(cleanup_fn, mod_name);
+		if (!loaded)
+			break;
+	}
+
+	if (loaded)
+		tst_brkm(TBROK, cleanup_fn,
+			 "could not unload %s module", mod_name);
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
