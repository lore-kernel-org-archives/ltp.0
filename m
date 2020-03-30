From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 14:43:36 +0200
Subject: [LTP] [PATCH v2 3/5] lib/tst_cmd_*(): Search for program in $PATH
In-Reply-To: <20200330124338.6764-1-pvorel@suse.cz>
References: <20200330124338.6764-1-pvorel@suse.cz>
Message-ID: <20200330124338.6764-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

before calling execvp(). This is slightly safer than checking errno ENOENT.
TST_CMD_TCONF_ON_MISSING flag cause TCONF when program not found.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt |  3 ++-
 include/tst_cmd.h               |  3 +++
 lib/tst_cmd.c                   | 16 ++++++++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index e48168dfb..7069d3c8f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1274,7 +1274,8 @@ which is followed by optional arguments.
 
 'TST_CMD_PASS_RETVAL' enum 'tst_cmd_flags' makes 'tst_cmd()'
 return the program exit code to the caller, otherwise 'tst_cmd()' exit the
-tests on failure.
+tests on failure. 'TST_CMD_TCONF_ON_MISSING' check for program in '$PATH' and exit
+with 'TCONF' if not found.
 
 In case that 'execvp()' has failed and the enum 'TST_CMD_PASS_RETVAL' flag was set, the
 return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index bba530e50..1f39f690f 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -11,6 +11,9 @@ enum tst_cmd_flags {
 	 * program exit code is not zero.
 	 */
 	TST_CMD_PASS_RETVAL = 1,
+
+	/* exit with TCONF if program is not in path */
+	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
 /*
diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 012c2a32b..ba79806ce 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -56,6 +56,17 @@ int tst_cmd_fds_(void (cleanup_fn)(void),
 	 */
 	void *old_handler = signal(SIGCHLD, SIG_DFL);
 
+	const char *cmd;
+	char path[PATH_MAX];
+
+	if (tst_get_path(argv[0], path, sizeof(path))) {
+		if (flags & TST_CMD_TCONF_ON_MISSING)
+			tst_brkm(TCONF, "Couldn't find '%s' in $PATH at %s:%d", argv[0],
+				 __FILE__, __LINE__);
+		else
+			_exit(255);
+	}
+
 	pid_t pid = vfork();
 	if (pid == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
@@ -74,10 +85,7 @@ int tst_cmd_fds_(void (cleanup_fn)(void),
 			dup2(stderr_fd, STDERR_FILENO);
 		}
 
-		if (execvp(argv[0], (char *const *)argv)) {
-			if (errno == ENOENT)
-				_exit(255);
-		}
+		execvp(argv[0], (char *const *)argv);
 		_exit(254);
 	}
 
-- 
2.26.0

