From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 22:39:22 +0100
Subject: [LTP] [PATCH 4/6] lib/tst_run_cmd_*(): Search for program in $PATH
In-Reply-To: <20200327213924.18816-1-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
Message-ID: <20200327213924.18816-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

before calling execvp(). This is slightly safer than checking errno ENOENT.
TST_RUN_CMD_CHECK_CMD flag cause TBROK when program not found.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New commit.

 doc/test-writing-guidelines.txt |  3 ++-
 include/tst_cmd.h               |  3 +++
 lib/tst_run_cmd.c               | 16 ++++++++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 31897309d..51eba6e39 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1274,7 +1274,8 @@ which is followed by optional arguments.
 
 'TST_RUN_CMD_PASS_EXIT_VAL' enum 'tst_run_cmd_flags' makes 'tst_run_cmd()'
 return the program exit code to the caller, otherwise 'tst_run_cmd()' exit the
-tests on failure.
+tests on failure. 'TST_RUN_CMD_CHECK_CMD' check for program in '$PATH' and exit
+with 'TCONF' if not found.
 
 In case that 'execvp()' has failed and the 'pass_exit_val' flag was set, the
 return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 67dec32f2..cab25462e 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -11,6 +11,9 @@ enum tst_run_cmd_flags {
 	 * program exit code is not zero.
 	 */
 	TST_RUN_CMD_PASS_EXIT_VAL = 1,
+
+	/* exit with TCONF if program is not in path */
+	TST_RUN_CMD_CHECK_CMD = 2,
 };
 
 /*
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 3536ec494..0494c6083 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -56,6 +56,17 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
 	 */
 	void *old_handler = signal(SIGCHLD, SIG_DFL);
 
+	const char *cmd;
+	char path[PATH_MAX];
+
+	if (tst_get_path(argv[0], path, sizeof(path))) {
+		if (flags & TST_RUN_CMD_CHECK_CMD)
+			tst_brkm(TCONF, "Couldn't find '%s' in $PATH at %s:%d", argv[0],
+				 __FILE__, __LINE__);
+		else
+			_exit(255);
+	}
+
 	pid_t pid = vfork();
 	if (pid == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
@@ -74,10 +85,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
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
2.25.1

