From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 22:02:50 +0200
Subject: [LTP] [PATCH v2 5/5] Use SAFE_CMD()
In-Reply-To: <CAEemH2dQfpn9mEBY=CFfVj_8dLETD7zh4=j3KP-bt95m_CCBxg@mail.gmail.com>
References: <20200330124338.6764-1-pvorel@suse.cz>
 <20200330124338.6764-6-pvorel@suse.cz>
 <CAEemH2dQfpn9mEBY=CFfVj_8dLETD7zh4=j3KP-bt95m_CCBxg@mail.gmail.com>
Message-ID: <20200330200250.GB8636@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Oh, you did the renaming in patch 5/5, but pity that the
> TST_CMD_TCONF_ON_MISSING still not being used:). I guess this modification
> should belong to patch4/5.
Thanks for careful review. Yes, I found that as well + the other problem you
reported - tst_run_cmd() during one more check.

+ I needed to put back static inline for safe_cmd() (it was in previous version,
it's really needed). So there is latest version available on
https://github.com/pevik/ltp/tree/needs_cmds.v2.fixes

which passed some travis jobs (I'll check that tomorrow)
https://travis-ci.org/github/pevik/ltp/builds/668925599

Diff from v2 below.

IMHO now it should be ok, but I'm waiting for your or anybody else ack/review.

Kind regards,
Petr

diff --git doc/test-writing-guidelines.txt doc/test-writing-guidelines.txt
index 75c2e517a..895f6c99d 100644
--- doc/test-writing-guidelines.txt
+++ doc/test-writing-guidelines.txt
@@ -1263,7 +1263,7 @@ different once the call returns and should be used only for rough estimates.
 int tst_cmd(const char *const argv[],
 	        const char *stdout_path,
 	        const char *stderr_path,
-			enum tst_cmd_flags flags);
+	        enum tst_cmd_flags flags);
 -------------------------------------------------------------------------------
 
 'tst_cmd()' is a wrapper for 'vfork() + execvp()' which provides a way
diff --git include/tst_safe_macros.h include/tst_safe_macros.h
index d050c5990..8126179f4 100644
--- include/tst_safe_macros.h
+++ include/tst_safe_macros.h
@@ -538,13 +538,13 @@ void safe_unshare(const char *file, const int lineno, int flags);
 void safe_setns(const char *file, const int lineno, int fd, int nstype);
 #define SAFE_SETNS(fd, nstype) safe_setns(__FILE__, __LINE__, (fd), (nstype));
 
-void safe_cmd(const char *file, const int lineno, const char *const argv[],
+static inline void safe_cmd(const char *file, const int lineno, const char *const argv[],
 				  const char *stdout_path, const char *stderr_path)
 {
 	int rval;
 
-	switch ((rval = tst_cmd(argv, stdout_path, stderr_path, TST_CMD_PASS_RETVAL
-							| TST_CMD_CHECK_CMD))) {
+	switch ((rval = tst_cmd(argv, stdout_path, stderr_path,
+				TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING))) {
 	case 0:
 		break;
 	default:
