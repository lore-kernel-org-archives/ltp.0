Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6C4C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:22:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DACF63CF4CC
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:22:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 070033CE710
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B5E651001165
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:09 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF8D71F7E7;
 Thu, 14 Dec 2023 15:20:08 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 730CD134B0;
 Thu, 14 Dec 2023 15:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6MPBGSgde2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:20:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:53 +0100
Message-ID: <20231214151954.840244-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: EF8D71F7E7
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 09/10] lib: Add support for TDEBUG tst_res() flag
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To print more verbose info. By default it's off, printing enabled with
-D option or TST_ENABLE_DEBUG=1.

Use unused value 8 (former TRETR).
Assigned color is white.
Legacy API does not support it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/C-Test-API.asciidoc          | 10 ++++++----
 doc/User-Guidelines.asciidoc     |  1 +
 include/tst_ansi_color.h         |  3 +++
 include/tst_common.h             |  2 +-
 include/tst_res_flags.h          |  1 +
 include/tst_test.h               |  5 +++--
 lib/newlib_tests/tst_res_flags.c |  5 ++++-
 lib/tst_ansi_color.c             |  3 +++
 lib/tst_res.c                    |  5 +++++
 lib/tst_test.c                   | 19 +++++++++++++++++++
 10 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index dab811564..979ec5ccf 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -224,10 +224,12 @@ void tst_res(int ttype, char *arg_fmt, ...);
 Printf-like function to report test result, it's mostly used with ttype:
 
 |==============================
-| 'TPASS' | Test has passed.
-| 'TFAIL' | Test has failed.
-| 'TINFO' | General message.
-| 'TWARN' | Something went wrong but we decided to continue. Mostly used in cleanup functions.
+| 'TPASS'  | Test has passed.
+| 'TFAIL'  | Test has failed.
+| 'TINFO'  | General message.
+| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'TST_ENABLE_DEBUG=1' or 'y'
+             environment variable), only for messages which would be too verbose for normal run.
+| 'TWARN'  | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
 
 The 'ttype' can be combined bitwise with 'TERRNO' or 'TTERRNO' to print
diff --git a/doc/User-Guidelines.asciidoc b/doc/User-Guidelines.asciidoc
index 8f2418df0..ec6d89b65 100644
--- a/doc/User-Guidelines.asciidoc
+++ b/doc/User-Guidelines.asciidoc
@@ -41,6 +41,7 @@ For running LTP network tests see `testcases/network/README.md`.
                           and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
                           Must be an absolute path (default: '/tmp').
 | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
+| 'TST_ENABLE_DEBUG'    | Enable debug info (value 'y' or '1').
 |==============================================================================
 
 
diff --git a/include/tst_ansi_color.h b/include/tst_ansi_color.h
index 770bf46d9..376d4ad63 100644
--- a/include/tst_ansi_color.h
+++ b/include/tst_ansi_color.h
@@ -4,14 +4,17 @@
 
 #ifndef TST_ANSI_COLOR_H__
 #define TST_ANSI_COLOR_H__
+
 /*
  * NOTE: these colors should match colors defined in tst_flag2color() in
  * testcases/lib/tst_ansi_color.sh
  */
+
 #define ANSI_COLOR_BLUE		"\033[1;34m"
 #define ANSI_COLOR_GREEN	"\033[1;32m"
 #define ANSI_COLOR_MAGENTA	"\033[1;35m"
 #define ANSI_COLOR_RED		"\033[1;31m"
+#define ANSI_COLOR_WHITE	"\033[1;37m"
 #define ANSI_COLOR_YELLOW	"\033[1;33m"
 
 #define ANSI_COLOR_RESET	"\033[0m"
diff --git a/include/tst_common.h b/include/tst_common.h
index 520cca72c..b14bbae04 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -80,7 +80,7 @@
 #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
 	TST_BUILD_BUG_ON(condition)
 
-#define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
+#define TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(condition) \
 	TST_BUILD_BUG_ON(condition)
 
 /* stringification */
diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 8eda2f8b8..872352144 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -11,6 +11,7 @@
 #define TFAIL	1	/* Test failed flag */
 #define TBROK	2	/* Test broken flag */
 #define TWARN	4	/* Test warning flag */
+#define TDEBUG	8	/* Test debug information flag */
 #define TINFO	16	/* Test information flag */
 #define TCONF	32	/* Test not appropriate for configuration flag */
 #define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
diff --git a/include/tst_test.h b/include/tst_test.h
index 75c2109b9..0c3171e5b 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -54,8 +54,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
 
 #define tst_res(ttype, arg_fmt, ...) \
 	({									\
-		TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(!((TTYPE_RESULT(ttype) ?: TCONF) & \
-			(TCONF | TFAIL | TINFO | TPASS | TWARN))); 				\
+		TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(\
+			!((TTYPE_RESULT(ttype) ?: TCONF) & \
+			(TCONF | TDEBUG | TFAIL | TINFO | TPASS | TWARN))); 				\
 		tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
 	})
 
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index 85eee09a6..b104808d7 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -13,6 +13,7 @@
 static struct tcase {
 	int flag;
 	const char *str;
+	const char *note;
 } tcases[] = {
 	{FLAG(TPASS)},
 	{FLAG(TFAIL)},
@@ -20,6 +21,7 @@ static struct tcase {
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
 	{FLAG(TINFO)},
+	{FLAG(TDEBUG), " (printed only with -D or TST_ENABLE_DEBUG=1)"},
 };
 
 static void do_cleanup(void)
@@ -32,7 +34,8 @@ static void do_test(void)
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(tcases); i++)
-		tst_res(tcases[i].flag, "%s message", tcases[i].str);
+		tst_res(tcases[i].flag, "%s message%s", tcases[i].str,
+			tcases[i].note ?: "");
 }
 
 static struct tst_test test = {
diff --git a/lib/tst_ansi_color.c b/lib/tst_ansi_color.c
index 1c29268f2..98041c0af 100644
--- a/lib/tst_ansi_color.c
+++ b/lib/tst_ansi_color.c
@@ -31,6 +31,9 @@ char* tst_ttype2color(int ttype)
 	case TINFO:
 		return ANSI_COLOR_BLUE;
 	break;
+	case TDEBUG:
+		return ANSI_COLOR_WHITE;
+	break;
 	default:
 		return "";
 	}
diff --git a/lib/tst_res.c b/lib/tst_res.c
index e0896eb05..e87918ed1 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -174,6 +174,11 @@ static void tst_res__(const char *file, const int lineno, int ttype,
 	int len = 0;
 	int ttype_result = TTYPE_RESULT(ttype);
 
+	if (ttype_result == TDEBUG) {
+		printf("%s: %i: TDEBUG is not supported\n", __func__, __LINE__);
+		abort();
+	}
+
 	if (file && (ttype_result != TPASS && ttype_result != TINFO))
 		len = sprintf(tmesg, "%s:%d: ", file, lineno);
 	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG - len);
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c2f8f503f..edc17a00b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -60,6 +60,7 @@ static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
+static int tdebug;
 
 struct results {
 	int passed;
@@ -224,6 +225,9 @@ static void print_result(const char *file, const int lineno, int ttype,
 	case TINFO:
 		res = "TINFO";
 	break;
+	case TDEBUG:
+		res = "TDEBUG";
+	break;
 	default:
 		tst_brk(TBROK, "Invalid ttype value %i", ttype);
 		abort();
@@ -352,6 +356,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
 {
 	va_list va;
 
+	if (ttype == TDEBUG && !tdebug)
+		return;
+
 	va_start(va, fmt);
 	tst_vres_(file, lineno, ttype, fmt, va);
 	va_end(va);
@@ -511,6 +518,7 @@ static struct option {
 	{"h",  "-h       Prints this help"},
 	{"i:", "-i n     Execute test n times"},
 	{"I:", "-I x     Execute test for n seconds"},
+	{"D",  "-D       Prints debug information"},
 	{"V",  "-V       Prints LTP version"},
 	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
@@ -679,6 +687,10 @@ static void parse_opts(int argc, char *argv[])
 			print_help();
 			tst_brk(TBROK, "Invalid option");
 		break;
+		case 'D':
+			tst_res(TINFO, "Enabling debug info");
+			tdebug = 1;
+		break;
 		case 'h':
 			print_help();
 			print_test_tags();
@@ -1137,6 +1149,8 @@ static void do_cgroup_requires(void)
 
 static void do_setup(int argc, char *argv[])
 {
+	char *tdebug_env = getenv("TST_ENABLE_DEBUG");
+
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
@@ -1157,6 +1171,11 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	if (tdebug_env && (!strcmp(tdebug_env, "y") || !strcmp(tdebug_env, "1"))) {
+		tst_res(TINFO, "Enabling debug info");
+		tdebug = 1;
+	}
+
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
