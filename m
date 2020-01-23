From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 23 Jan 2020 17:20:17 +0100
Subject: [LTP] [PATCH v3 1/3] Add tst_purge_dir() helper function
In-Reply-To: <20200123162019.18958-1-mdoucha@suse.cz>
References: <20200123162019.18958-1-mdoucha@suse.cz>
Message-ID: <20200123162019.18958-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function deletes the contents of the given directory while leaving
the directory itself intact. Useful for purging the mountpoint between test
iterations or test cases.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_device.h |   5 ++
 lib/tst_tmpdir.c     | 106 +++++++++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 3db5275c9..d2e4ad5be 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -88,4 +88,9 @@ static inline int tst_dev_sync(int fd)
  */
 unsigned long tst_dev_bytes_written(const char *dev);
 
+/*
+ *Wipe the contents of given directory but keep the directory itself
+ */
+void tst_purge_dir(const char *path);
+
 #endif	/* TST_DEVICE_H__ */
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 09b7b6e22..4b21dfad6 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -99,6 +99,8 @@ static char test_start_work_dir[PATH_MAX];
 /* lib/tst_checkpoint.c */
 extern futex_t *tst_futexes;
 
+static int rmobj(const char *obj, char **errmsg);
+
 int tst_tmpdir_created(void)
 {
 	return TESTDIR != NULL;
@@ -119,60 +121,80 @@ const char *tst_get_startwd(void)
 	return test_start_work_dir;
 }
 
-static int rmobj(char *obj, char **errmsg)
+static int purge_dir(const char *path, char **errptr)
 {
 	int ret_val = 0;
 	DIR *dir;
 	struct dirent *dir_ent;
 	char dirobj[PATH_MAX];
-	struct stat statbuf;
 	static char err_msg[1024];
 	int fd;
 
-	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
-	if (fd != -1) {
-		close(fd);
+	errno = 0;
+	fd = open(path, O_DIRECTORY | O_NOFOLLOW);
 
-		/* Do NOT perform the request if the directory is "/" */
-		if (!strcmp(obj, "/")) {
-			if (errmsg != NULL) {
-				sprintf(err_msg, "Cannot remove /");
-				*errmsg = err_msg;
-			}
-			return -1;
+	if (fd < 0) {
+		if (errptr) {
+			sprintf(err_msg,
+				"Cannot open directory %s; errno=%d: %s",
+				path, errno, tst_strerrno(errno));
+			*errptr = err_msg;
 		}
 
-		/* Open the directory to get access to what is in it */
-		if ((dir = opendir(obj)) == NULL) {
-			if (rmdir(obj) != 0) {
-				if (errmsg != NULL) {
-					sprintf(err_msg,
-						"rmdir(%s) failed; errno=%d: %s",
-						obj, errno, tst_strerrno(errno));
-					*errmsg = err_msg;
-				}
-				return -1;
-			} else {
-				return 0;
-			}
-		}
+		return -1;
+	}
 
-		/* Loop through the entries in the directory, removing each one */
-		for (dir_ent = (struct dirent *)readdir(dir);
-		     dir_ent != NULL; dir_ent = (struct dirent *)readdir(dir)) {
+	close(fd);
 
-			/* Don't remove "." or ".." */
-			if (!strcmp(dir_ent->d_name, ".")
-			    || !strcmp(dir_ent->d_name, ".."))
-				continue;
+	/* Do NOT perform the request if the directory is "/" */
+	if (!strcmp(path, "/")) {
+		if (errptr) {
+			strcpy(err_msg, "Cannot purge system root directory");
+			*errptr = err_msg;
+		}
 
-			/* Recursively call this routine to remove the current entry */
-			sprintf(dirobj, "%s/%s", obj, dir_ent->d_name);
-			if (rmobj(dirobj, errmsg) != 0)
-				ret_val = -1;
+		return -1;
+	}
+
+	/* Open the directory to get access to what is in it */
+	if (!(dir = opendir(path))) {
+		if (errptr) {
+			sprintf(err_msg,
+				"Cannot open directory %s; errno=%d: %s",
+				path, errno, tst_strerrno(errno));
+			*errptr = err_msg;
 		}
+		return -1;
+	}
+
+	/* Loop through the entries in the directory, removing each one */
+	for (dir_ent = readdir(dir); dir_ent; dir_ent = readdir(dir)) {
+		/* Don't remove "." or ".." */
+		if (!strcmp(dir_ent->d_name, ".")
+		    || !strcmp(dir_ent->d_name, ".."))
+			continue;
+
+		/* Recursively remove the current entry */
+		sprintf(dirobj, "%s/%s", path, dir_ent->d_name);
+		if (rmobj(dirobj, errptr) != 0)
+			ret_val = -1;
+	}
+
+	closedir(dir);
+	return ret_val;
+}
+
+static int rmobj(const char *obj, char **errmsg)
+{
+	int ret_val = 0;
+	struct stat statbuf;
+	static char err_msg[1024];
+	int fd;
 
-		closedir(dir);
+	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
+	if (fd >= 0) {
+		close(fd);
+		ret_val = purge_dir(obj, errmsg);
 
 		/* If there were problems removing an entry, don't attempt to
 		   remove the directory itself */
@@ -330,3 +352,11 @@ void tst_rmdir(void)
 			 __func__, TESTDIR, errmsg);
 	}
 }
+
+void tst_purge_dir(const char *path)
+{
+	char *err;
+
+	if (purge_dir(path, &err))
+		tst_brkm(TBROK, NULL, "%s: %s", __func__, err);
+}
-- 
2.24.1

