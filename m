From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 20:48:27 +0200
Subject: [LTP] [PATCH v2 4/5] lib: Implement SAFE_CMD() macro (new API
 only)
In-Reply-To: <CAEemH2dcxrpB_dkp26=5oiMdY_2OVw5v_OjpyG37N+zx7y+A9g@mail.gmail.com>
References: <20200330124338.6764-1-pvorel@suse.cz>
 <20200330124338.6764-5-pvorel@suse.cz>
 <CAEemH2dcxrpB_dkp26=5oiMdY_2OVw5v_OjpyG37N+zx7y+A9g@mail.gmail.com>
Message-ID: <20200330184827.GA8636@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > +       switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path,
> > +                                   TST_RUN_CMD_PASS_EXIT_VAL |
> > +                                   TST_RUN_CMD_CHECK_CMD))) {


> This should be TST_CMD_TCONF_ON_MISSING ^.

> I'd help to build&run the whole patches tomorrow, anything wrong if I can
> find will reply to you then.

Thanks for fixes. Here is following diff from v2 (addressing issues you found,
fixed tst_run_cmd() being replaced in later commit, fix doc formatting),
code available also on:
https://github.com/pevik/ltp/tree/needs_cmds.v2.fixes

I'm going to test each commit if it builds and wait for your ack tomorrow.

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
index d050c5990..295800c1b 100644
--- include/tst_safe_macros.h
+++ include/tst_safe_macros.h
@@ -543,8 +543,8 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
 {
 	int rval;
 
-	switch ((rval = tst_cmd(argv, stdout_path, stderr_path, TST_CMD_PASS_RETVAL
-							| TST_CMD_CHECK_CMD))) {
+	switch ((rval = tst_cmd(argv, stdout_path, stderr_path,
+				TST_CMD_PASS_EXIT_VAL | TST_CMD_TCONF_ON_MISSING))) {
 	case 0:
 		break;
 	default:
