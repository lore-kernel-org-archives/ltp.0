From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  6 Nov 2019 13:57:43 +0100
Subject: [LTP] [PATCH 1/1] Create full path to workdir in fs/doio/growfiles.c
In-Reply-To: <20191106125743.29952-1-mdoucha@suse.cz>
References: <20191106125743.29952-1-mdoucha@suse.cz>
Message-ID: <20191106125743.29952-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LVM runfile sets the work directory for growfiles to /test/growfiles/[fsname].
If the /test/growfiles directory doesn't exist, the test will fail.

Fix the error by creating the full path.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/fs/doio/growfiles.c | 71 +++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index eb58ce0cd..c0109ffcb 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -114,6 +114,7 @@ int check_write(int fd, int cf_inter, char *filename, int mode);
 int check_file(int fd, int cf_inter, char *filename, int no_file_check);
 int file_size(int fd);
 int lkfile(int fd, int operation, int lklevel);
+int mkpath(const char *path, mode_t mode);
 
 #ifndef linux
 int pre_alloc(int fd, long size);
@@ -380,7 +381,6 @@ int main(int argc, char **argv)
 	long total_grow_value;	/* used in pre-allocations */
 #endif
 	int backgrnd = 1;	/* return control to user */
-	struct stat statbuf;
 	int time_iterval = -1;
 	time_t start_time = 0;
 	char reason[128];	/* reason for loop termination */
@@ -481,23 +481,11 @@ int main(int argc, char **argv)
 #ifdef CRAY
 			unsetenv("TMPDIR");	/* force the use of auto_dir */
 #endif
-			if (stat(auto_dir, &statbuf) == -1) {
-				if (mkdir(auto_dir, 0777) == -1) {
-					if (errno != EEXIST) {
-						fprintf(stderr,
-							"%s%s: Unable to make dir %s\n",
-							Progname, TagName,
-							auto_dir);
-						exit(1);
-					}
-				}
-			} else {
-				if (!(statbuf.st_mode & S_IFDIR)) {
-					fprintf(stderr,
-						"%s%s: %s already exists and is not a directory\n",
-						Progname, TagName, auto_dir);
-					exit(1);
-				}
+			if (!mkpath(auto_dir, 0777)) {
+				fprintf(stderr,
+					"%s%s: Unable to make dir %s\n",
+					Progname, TagName, auto_dir);
+				exit(1);
 			}
 			break;
 
@@ -3019,6 +3007,53 @@ int lkfile(int fd, int operation, int lklevel)
 	return 0;
 }
 
+int mkpath(const char *path, mode_t mode)
+{
+	struct stat statbuf;
+	size_t pathlen = strlen(path), pos;
+	char *pathbuf = malloc(pathlen + 1);
+
+	strcpy(pathbuf, path);
+
+	// Strip trailing slashes from path
+	for (pos = pathlen - 1; pos > 0 && pathbuf[pos] == '/'; pos--,
+		pathlen--) {
+		pathbuf[pos] = '\0';
+	}
+
+	// Find the longest existing section of the path
+	for (pos = pathlen; pos > 0;) {
+		if (!stat(pathbuf, &statbuf)) {
+			if (!(statbuf.st_mode & S_IFDIR)) {
+				fprintf(stderr,
+					"%s%s: %s already exists and is not a directory\n",
+					Progname, TagName, pathbuf);
+				free(pathbuf);
+				return 0;
+			}
+
+			break;
+		}
+
+		while (pos > 0 && pathbuf[--pos] != '/');
+		pathbuf[pos] = '\0';
+	}
+
+	// Create missing directories
+	while (pos < pathlen) {
+		pathbuf[pos] = '/';
+		while (pathbuf[++pos]);
+
+		if (mkdir(pathbuf, mode)) {
+			free(pathbuf);
+			return 0;
+		}
+	}
+
+	free(pathbuf);
+	return 1;
+}
+
 #ifndef linux
 /***********************************************************************
  *
-- 
2.23.0

