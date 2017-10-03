From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:56 +0200
Subject: [LTP] [COMMITTED] [PATCH 23/40] Make use of SAFE_RENAME()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-23-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify02.c | 21 ++++-----------------
 testcases/kernel/syscalls/rename/rename01.c   |  8 ++------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 2c92f1616..4a1036ab4 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -117,11 +117,7 @@ int main(int ac, char **av)
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		tst_count++;
 
-		if (rename(FILE_NAME1, FILE_NAME2) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "rename(%s, %s) failed",
-				 FILE_NAME1, FILE_NAME2);
-		}
+		SAFE_RENAME(cleanup, FILE_NAME1, FILE_NAME2);
 		event_set[tst_count].mask = IN_MOVED_FROM;
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		tst_count++;
@@ -135,10 +131,7 @@ int main(int ac, char **av)
 		}
 
 		snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
-		if (rename(fname1, fname2) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "rename(%s, %s) failed", fname1, fname2);
-		}
+		SAFE_RENAME(cleanup, fname1, fname2);
 		event_set[tst_count].mask = IN_MOVE_SELF;
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
@@ -155,15 +148,9 @@ int main(int ac, char **av)
 		 * 2.6.25. See comment below.
 		 */
 		snprintf(fname3, BUF_SIZE, "%s.rename2", fname1);
-		if (rename(fname2, fname3) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "rename(%s, %s) failed", fname2, fname3);
-		}
+		SAFE_RENAME(cleanup, fname2, fname3);
 
-		if (rename(fname3, fname1) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "rename(%s, %s) failed", fname3, fname1);
-		}
+		SAFE_RENAME(cleanup, fname3, fname1);
 		event_set[tst_count].mask = IN_MOVE_SELF;
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index 2474ab95e..80977d35f 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -164,13 +164,9 @@ int main(int ac, char **av)
 				 "for renaming a %s", TC[i].desc);
 		}
 		/* reset things in case we are looping */
-		if (rename(mname, fname) == -1) {
-			tst_brkm(TBROK, cleanup, "file rename failed");
-		}
+		SAFE_RENAME(cleanup, mname, fname);
 
-		if (rename(mdir, fdir) == -1) {
-			tst_brkm(TBROK, cleanup, "directory rename failed");
-		}
+		SAFE_RENAME(cleanup, mdir, fdir);
 	}
 
 	cleanup();
-- 
2.13.5

