From: Helge Deller <deller@gmx.de>
Date: Sat, 6 May 2017 10:52:06 +0200
Subject: [LTP] [PATCH] Add terminating NUL after calling readlink()
Message-ID: <20170506085206.GA3058@ls3530.fritz.box>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

readlink() does not append a NUL byte to the target buffer. Fix it in
the pidns03 and fsstress testcases to avoid wrong test results.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index c4dca66d0..553c65aad 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -63,7 +63,7 @@ int child_func(void *arg)
 	}
 
 	/* self is symlink to directory named after current pid number */
-	if (readlink(PROCDIR"/self", buf, sizeof(buf)) == -1) {
+	if (SAFE_READLINK(NULL, PROCDIR"/self", buf, sizeof(buf)) == -1) {
 		perror("readlink");
 		umount(PROCDIR);
 		return 1;
diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 629bcf4d1..bfdffd52b 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -1143,6 +1143,8 @@ int readlink_path(pathname_t * name, char *lbuf, size_t lbufsiz)
 	int rval;
 
 	rval = readlink(name->path, lbuf, lbufsiz);
+	if (rval >= 0)
+		lbuf[rval] = 0; /* add terminating NUL */
 	if (rval >= 0 || errno != ENAMETOOLONG)
 		return rval;
 	separate_pathname(name, buf, &newname);
