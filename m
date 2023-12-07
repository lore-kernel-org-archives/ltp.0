Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA5EC4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 21:28:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C9823CD8A8
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 22:28:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EFFF3CBB89
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 22:27:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B51E01A00EFF
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 22:27:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 119B6220A1;
 Thu,  7 Dec 2023 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701984466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fvZi3TKmAWHEO1J/0QtgaIRKkj8Qr16reY2iGq/NAY=;
 b=H0uZwFhCT2+fqXM7eob9EWJg1CdxT9MgL+R50F1WdymJF1fwnywXpBuScHwL9oHJ+IdIyZ
 JBd/NVDAfZDrBNoAdbgCv3N4uIEzIww3D5FxmuYB8XbdvAkc0Ts62Kt9QoNDzvKBNflwkN
 0ZyrhNhSAQBob2dxT373m6SWgxgnNBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701984466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fvZi3TKmAWHEO1J/0QtgaIRKkj8Qr16reY2iGq/NAY=;
 b=bCZYh8e0PtLZjyrKCWekREBau/+zXSmAsAr7uqjVwXtNpn5Fv7Gu08Ig5Alsrgodb54usR
 KfTJHkUNarySRqBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 428A113907;
 Thu,  7 Dec 2023 21:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id eOHaAtE4cmXtHQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 21:27:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Dec 2023 22:27:37 +0100
Message-ID: <20231207212739.302374-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207212739.302374-1-pvorel@suse.cz>
References: <20231207212739.302374-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] lib: Add support for TDBUG tst_res() flag
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
-v option.

Use unused value 8 (former TRETR).
Assigned color is white.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/C-Test-API.asciidoc          |  1 +
 include/tst_ansi_color.h         |  3 +++
 include/tst_common.h             |  2 +-
 include/tst_res_flags.h          |  1 +
 include/tst_test.h               |  5 +++--
 lib/newlib_tests/tst_res_flags.c |  6 ++++--
 lib/tst_ansi_color.c             |  3 +++
 lib/tst_res.c                    |  9 ++++++---
 lib/tst_test.c                   | 12 ++++++++++++
 9 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index dab811564..479179263 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -227,6 +227,7 @@ Printf-like function to report test result, it's mostly used with ttype:
 | 'TPASS' | Test has passed.
 | 'TFAIL' | Test has failed.
 | 'TINFO' | General message.
+| 'TDBUG' | Debug message (C API only, printed with '-v').
 | 'TWARN' | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
 
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
index 520cca72c..e22aa9a30 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -80,7 +80,7 @@
 #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
 	TST_BUILD_BUG_ON(condition)
 
-#define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
+#define TST_RES_SUPPORTS_TCONF_TDBUG_TFAIL_TINFO_TPASS_TWARN(condition) \
 	TST_BUILD_BUG_ON(condition)
 
 /* stringification */
diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 8eda2f8b8..327b27fb3 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -11,6 +11,7 @@
 #define TFAIL	1	/* Test failed flag */
 #define TBROK	2	/* Test broken flag */
 #define TWARN	4	/* Test warning flag */
+#define TDBUG	8	/* Test debug information flag */
 #define TINFO	16	/* Test information flag */
 #define TCONF	32	/* Test not appropriate for configuration flag */
 #define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
diff --git a/include/tst_test.h b/include/tst_test.h
index 75c2109b9..e54601285 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -54,8 +54,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
 
 #define tst_res(ttype, arg_fmt, ...) \
 	({									\
-		TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(!((TTYPE_RESULT(ttype) ?: TCONF) & \
-			(TCONF | TFAIL | TINFO | TPASS | TWARN))); 				\
+		TST_RES_SUPPORTS_TCONF_TDBUG_TFAIL_TINFO_TPASS_TWARN(\
+			!((TTYPE_RESULT(ttype) ?: TCONF) & \
+			(TCONF | TDBUG | TFAIL | TINFO | TPASS | TWARN))); 				\
 		tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
 	})
 
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index dc8f27e74..331f1ae1c 100644
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
+	{FLAG(TDBUG), " (printed only with -v)"},
 };
 
 static void do_cleanup(void)
@@ -32,9 +34,9 @@ static void do_test(unsigned int n)
 	int flag = tcases[n].flag;
 	const char *str = tcases[n].str;
 
-	tst_res(flag, "%s message", str);
+	tst_res(flag, "%s message%s", str, tcases[n].note ?: "");
 
-	if (flag == TWARN || flag == TINFO)
+	if (flag == TWARN || flag == TINFO || flag == TDBUG)
 		tst_res(TPASS, "%s message is not a result", str);
 }
 
diff --git a/lib/tst_ansi_color.c b/lib/tst_ansi_color.c
index 1c29268f2..9598cafc9 100644
--- a/lib/tst_ansi_color.c
+++ b/lib/tst_ansi_color.c
@@ -31,6 +31,9 @@ char* tst_ttype2color(int ttype)
 	case TINFO:
 		return ANSI_COLOR_BLUE;
 	break;
+	case TDBUG:
+		return ANSI_COLOR_WHITE;
+	break;
 	default:
 		return "";
 	}
diff --git a/lib/tst_res.c b/lib/tst_res.c
index e0896eb05..2e6606088 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -157,6 +157,7 @@ const char *strttype(int ttype)
 		PAIR(TCONF)
 		PAIR(TWARN)
 		PAIR(TINFO)
+		PAIR(TDBUG)
 	};
 
 	PAIR_LOOKUP(ttype_pairs, TTYPE_RESULT(ttype));
@@ -174,8 +175,10 @@ static void tst_res__(const char *file, const int lineno, int ttype,
 	int len = 0;
 	int ttype_result = TTYPE_RESULT(ttype);
 
-	if (file && (ttype_result != TPASS && ttype_result != TINFO))
+	if (file && (ttype_result != TPASS && ttype_result != TINFO &&
+		     ttype_result != TDBUG))
 		len = sprintf(tmesg, "%s:%d: ", file, lineno);
+
 	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG - len);
 
 	/*
@@ -193,7 +196,7 @@ static void tst_res__(const char *file, const int lineno, int ttype,
 	 * Set the test case number and print the results, depending on the
 	 * display type.
 	 */
-	if (ttype_result == TWARN || ttype_result == TINFO) {
+	if (ttype_result == TWARN || ttype_result == TINFO || ttype_result == TDBUG) {
 		tst_print(TCID, 0, ttype, tmesg);
 	} else {
 		if (tst_count < 0)
@@ -411,7 +414,7 @@ void tst_exit(void)
 
 	tst_old_flush();
 
-	T_exitval &= ~TINFO;
+	T_exitval &= ~(TINFO | TDBUG);
 
 	if (T_exitval == TCONF && passed_cnt)
 		T_exitval &= ~TCONF;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c2f8f503f..04be736ab 100644
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
+	case TDBUG:
+		res = "TDBUG";
+	break;
 	default:
 		tst_brk(TBROK, "Invalid ttype value %i", ttype);
 		abort();
@@ -352,6 +356,9 @@ void tst_res_(const char *file, const int lineno, int ttype,
 {
 	va_list va;
 
+	if (ttype == TDBUG && !tdebug)
+		return;
+
 	va_start(va, fmt);
 	tst_vres_(file, lineno, ttype, fmt, va);
 	va_end(va);
@@ -511,6 +518,7 @@ static struct option {
 	{"h",  "-h       Prints this help"},
 	{"i:", "-i n     Execute test n times"},
 	{"I:", "-I x     Execute test for n seconds"},
+	{"v",  "-v       Prints debug information"},
 	{"V",  "-V       Prints LTP version"},
 	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
@@ -692,6 +700,10 @@ static void parse_opts(int argc, char *argv[])
 			else
 				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
 		break;
+		case 'v':
+			tdebug = 1;
+			tst_res(TINFO, "Run with -v, printing debug info");
+		break;
 		case 'V':
 			fprintf(stderr, "LTP version: " LTP_VERSION "\n");
 			exit(0);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
