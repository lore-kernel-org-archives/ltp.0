Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WD9x2-00029Y-Bf
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 09:48:24 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WD9x1-00015T-1a
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 09:48:24 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1B9mGUh020578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 09:48:17 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1B9mGwu016944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 09:48:16 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1B9mFlI016927
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 09:48:15 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 11 Feb 2014 13:48:10 +0400
Message-Id: <1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 4/4] lib: add tst_res_r.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

It contains thread-safe versions of functions defined in tst_res.c.
NOPASS mode not implemented yet.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 lib/tst_res_r.c |  499 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 499 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_res_r.c

diff --git a/lib/tst_res_r.c b/lib/tst_res_r.c
new file mode 100644
index 0000000..1cf79ad
--- /dev/null
+++ b/lib/tst_res_r.c
@@ -0,0 +1,499 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2009-2013 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <pthread.h>
+#include "tst_res.h"
+
+/*
+ * Synchronize access to global vars T_exitval, T_out, tst_count with
+ * mutexes.
+ */
+pthread_mutex_t exitval_mutex = PTHREAD_MUTEX_INITIALIZER,
+                tstcount_mutex =  PTHREAD_MUTEX_INITIALIZER,
+                tout_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static int exitval_or(int ttype_result)
+{
+	int res;
+	pthread_mutex_lock(&exitval_mutex);
+	res = T_exitval |= ttype_result;
+	pthread_mutex_unlock(&exitval_mutex);
+	return res;
+}
+
+static int exitval_and(int ttype_result)
+{
+	int res;
+	pthread_mutex_lock(&exitval_mutex);
+	res = T_exitval &= ttype_result;
+	pthread_mutex_unlock(&exitval_mutex);
+	return res;
+}
+
+static int get_tst_count()
+{
+	int res;
+	pthread_mutex_lock(&tstcount_mutex);
+	res = tst_count;
+	pthread_mutex_unlock(&tstcount_mutex);
+	return res;
+}
+
+static void cat_file_r(char *filename);
+
+/*
+ * tst_print_r() - thread-safe version of tst_print()
+ * Additionally takes filename, because it isn't using global File
+ */
+static void tst_print_r(char *tcid, char *fname, int tnum, int ttype, char *tmesg)
+{
+	/*
+	 * avoid unintended side effects from failures with fprintf when
+	 * calling write(2), et all.
+	 */
+	int err = errno;
+	const char *type;
+	int ttype_result = TTYPE_RESULT(ttype);
+	char message[USERMESG];
+	size_t size;
+
+#if DEBUG
+	printf("IN tst_print_r: tnum = %d, ttype = %d, tmesg = %s\n",
+	       tnum, ttype, tmesg);
+	fflush(stdout);
+#endif
+
+	/*
+	 * Save the test result type by ORing ttype into the current exit value
+	 * (used by tst_exit()).  This is already done in tst_res(), but is
+	 * also done here to catch internal warnings.  For internal warnings,
+	 * tst_print() is called directly with a case of TWARN.
+	 */
+	exitval_or(ttype_result);
+
+	/*
+	 * If output mode is DISCARD, or if the output mode is NOPASS and this
+	 * result is not one of FAIL, BROK, or WARN, just return.  This check
+	 * is necessary even though we check for DISCARD mode inside of
+	 * tst_res(), since occasionally we get to this point without going
+	 * through tst_res() (e.g. internal TWARN messages).
+	 */
+	if (T_mode == DISCARD || (T_mode == NOPASS && ttype_result != TFAIL &&
+				  ttype_result != TBROK
+				  && ttype_result != TWARN))
+		return;
+
+	/*
+	 * Build the result line and print it.
+	 */
+	type = strttype(ttype);
+	if (T_mode == VERBOSE) {
+		size = snprintf(message, sizeof(message),
+				"%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
+	} else {
+		size = snprintf(message, sizeof(message),
+				"%-8s %4d       %s  :  %s",
+				tcid, tnum, type, tmesg);
+	}
+
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	if (ttype & TERRNO) {
+		size += snprintf(message + size, sizeof(message) - size,
+				 ": errno=%s(%i): %s", strerrnodef(err),
+				 err, strerror(err));
+	}
+
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	if (ttype & TTERRNO) {
+		size += snprintf(message + size, sizeof(message) - size,
+				 ": TEST_ERRNO=%s(%i): %s",
+				 strerrnodef(TEST_ERRNO), (int)TEST_ERRNO,
+				 strerror(TEST_ERRNO));
+	}
+
+	if (size + 1 >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	message[size] = '\n';
+	message[size + 1] = '\0';
+
+	pthread_mutex_lock(&tout_mutex);
+	fputs(message, T_out);
+	pthread_mutex_unlock(&tout_mutex);
+
+	/*
+	 * If tst_res() was called with a file, append file contents to the
+	 * end of last printed result.
+	 */
+	if (fname != NULL)
+		cat_file_r(fname);
+}
+
+/*
+ * check_env_once() - thread-safe version of check_env()
+ */
+static void check_env_once(void)
+{
+	char *value;
+
+#if DEBUG
+	printf("IN check_env_r\n");
+	fflush(stdout);
+#endif
+
+	/* BTOUTPUT not defined, use default */
+	if ((value = getenv(TOUTPUT)) == NULL) {
+		T_mode = VERBOSE;
+		return;
+	}
+
+	if (strcmp(value, TOUT_NOPASS_S) == 0) {
+		T_mode = NOPASS;
+		return;
+	}
+
+	if (strcmp(value, TOUT_DISCARD_S) == 0) {
+		T_mode = DISCARD;
+		return;
+	}
+
+	/* default */
+	T_mode = VERBOSE;
+	return;
+}
+DECLARE_ONCE_FN(check_env_r, check_env_once)
+
+/*
+ * tst_res_r() - thread-safe version of tst_res()
+ * Note: NOPASS mode not implemented
+ */
+void tst_res_r(int ttype, char *fname, char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+	int ttype_result = TTYPE_RESULT(ttype);
+
+#if DEBUG
+	printf("IN tst_res_r; tst_count = %d\n", get_tst_count());
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	/*
+	 * Save the test result type by ORing ttype into the current exit
+	 * value (used by tst_exit()).
+	 */
+	exitval_or(ttype_result);
+	/*
+	 * Unless T_out has already been set by tst_environ(), make tst_res()
+	 * output go to standard output.
+	 */
+	pthread_mutex_lock(&tout_mutex);
+	if (T_out == NULL)
+		T_out = stdout;
+	pthread_mutex_unlock(&tout_mutex);
+
+	/*
+	 * Check TOUTPUT environment variable (if first time) and set T_mode
+	 * flag.
+	 */
+	check_env_r();
+
+	if (fname != 0 && access(fname, F_OK) != 0)
+		fname = NULL;
+
+	/*
+	 * Set the test case number and print the results, depending on the
+	 * display type.
+	 */
+	if (ttype_result == TWARN || ttype_result == TINFO) {
+		tst_print_r(TCID, fname, 0, ttype, tmesg);
+	} else {
+		if (get_tst_count() < 0)
+			tst_print_r(TCID, NULL, 0, TWARN,
+				  "tst_res(): tst_count < 0 is not valid");
+
+		/*
+		 * Process each display type.
+		 */
+		switch (T_mode) {
+		case DISCARD:
+			break;
+		/* thread-safe NOPASS mode not implemented */
+		default:	/* VERBOSE */
+			tst_print_r(TCID, fname, get_tst_count() + 1,
+				ttype, tmesg);
+			break;
+		}
+
+		pthread_mutex_lock(&tstcount_mutex);
+		++tst_count;
+		pthread_mutex_unlock(&tstcount_mutex);
+	}
+}
+
+/*
+ * tst_flush_r() - thread-safe version of tst_flush()
+ * Note: NOPASS mode not implemented
+ */
+void tst_flush_r(void)
+{
+#if DEBUG
+	printf("IN tst_flush_r\n");
+	fflush(stdout);
+#endif
+
+	pthread_mutex_lock(&tout_mutex);
+	fflush(T_out);
+	pthread_mutex_unlock(&tout_mutex);
+}
+
+/*
+ * cat_file_r() - thread-safe version of cat_file()
+ */
+static void cat_file_r(char *filename)
+{
+	FILE *fp;
+	int b_read = 0, b_written = 0;
+	char buffer[BUFSIZ];
+	char warn_msg[MAXMESG];
+
+#if DEBUG
+	printf("IN cat_file_r\n");
+	fflush(stdout);
+#endif
+
+	if ((fp = fopen(filename, "r")) == NULL) {
+		sprintf(warn_msg,
+			"tst_res(): fopen(%s, \"r\") failed; errno = %d: %s",
+			filename, errno, strerror(errno));
+		tst_print_r(TCID, NULL, 0, TWARN, warn_msg);
+		return;
+	}
+
+	errno = 0;
+
+	pthread_mutex_lock(&tout_mutex);
+	while ((b_read = fread(buffer, 1, BUFSIZ, fp)) != 0) {
+		b_written = fwrite(buffer, 1, b_read, T_out);
+		if (b_written != b_read)
+			break;
+	}
+	pthread_mutex_unlock(&tout_mutex);
+
+	if (b_read && b_written != b_read) {
+		sprintf(warn_msg, "tst_res(): While trying to cat \"%s\", "
+			"fwrite() wrote only %d of %d bytes",
+			filename, b_written, b_read);
+		tst_print_r(TCID, NULL, 0, TWARN, warn_msg);
+	}
+
+	if (!feof(fp)) {
+		sprintf(warn_msg,
+			"tst_res(): While trying to cat \"%s\", fread() "
+			"failed, errno = %d: %s",
+			filename, errno, strerror(errno));
+		tst_print_r(TCID, NULL, 0, TWARN, warn_msg);
+	}
+
+	if (fclose(fp) != 0) {
+		sprintf(warn_msg,
+			"tst_res(): While trying to cat \"%s\", fclose() "
+			"failed, errno = %d: %s",
+			filename, errno, strerror(errno));
+		tst_print_r(TCID, NULL, 0, TWARN, warn_msg);
+	}
+}
+
+
+/*
+ * tst_exit_once() - thread-safe version of tst_exit()
+ */
+static void tst_exit_once(void)
+{
+#if DEBUG
+	printf("IN tst_exit_r\n");
+	fflush(stdout);
+	fflush(stdout);
+#endif
+
+	/* Call tst_flush() flush any output in the buffer. */
+	tst_flush_r();
+
+	/* Mask out TRETR, TINFO, and TCONF results from the exit status. */
+	exit(exitval_and(~(TRETR | TINFO | TCONF)));
+}
+DECLARE_ONCE_FN(tst_exit_r, tst_exit_once)
+
+/*
+ * tst_environ_r() - thread-safe version of tst_environ()
+ */
+int tst_environ_r(void)
+{
+	int res;
+	pthread_mutex_lock(&tout_mutex);
+	T_out = fdopen(dup(fileno(stdout)), "w");
+	res = T_out ? 0 : -1;
+	pthread_mutex_unlock(&tout_mutex);
+	return res;
+}
+
+/*
+ * tst_brk_r() - thread-safe version of tst_brk()
+ */
+void tst_brk_r(int ttype, char *fname, void (*func) (void), char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+	int ttype_result = TTYPE_RESULT(ttype);
+	char warn_msg[MAXMESG];
+
+#if DEBUG
+	printf("IN tst_brk_r\n");
+	fflush(stdout);
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	/*
+	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
+	 */
+	if (ttype_result != TFAIL && ttype_result != TBROK &&
+	    ttype_result != TCONF && ttype_result != TRETR) {
+		sprintf(warn_msg, "%s: Invalid Type: %d. Using TBROK",
+			__func__, ttype_result);
+		tst_print_r(TCID, fname, 0, TWARN, warn_msg);
+		/* Keep TERRNO, TTERRNO, etc. */
+		ttype = (ttype & ~ttype_result) | TBROK;
+	}
+
+	tst_res_r(ttype, fname, "%s", tmesg);
+
+	if (ttype_result == TCONF)
+		tst_res_r(ttype, NULL,
+			"Remaining cases not appropriate for "
+			"configuration");
+	else if (ttype_result == TRETR)
+		tst_res_r(ttype, NULL, "Remaining cases retired");
+	else if (ttype_result == TBROK)
+		tst_res_r(TBROK, NULL, "Remaining cases broken");
+
+	if (func != NULL)
+		(*func) ();
+	tst_exit_r();
+}
+
+/*
+ * tst_resm_r() - thread-safe version of tst_resm()
+ */
+void tst_resm_r(int ttype, char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+
+#if DEBUG
+	printf("IN tst_resm_r\n");
+	fflush(stdout);
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	tst_res_r(ttype, NULL, "%s", tmesg);
+}
+
+/*
+ * tst_resm_hexd_r() - thread-safe version of tst_resm_hexd()
+ */
+void tst_resm_hexd_r(int ttype, const void *buf, size_t size, char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+
+#if DEBUG
+	printf("IN tst_resm_hexd_r\n");
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	static const size_t symb_num	= 2; /* xx */
+	static const size_t size_max	= 16;
+	size_t offset = strlen(tmesg);
+	char *pmesg = tmesg;
+
+	if (size > size_max || size == 0 ||
+		(offset + size * (symb_num + 1)) >= USERMESG)
+		tst_res_r(ttype, NULL, "%s", tmesg);
+	else
+		pmesg += offset;
+
+	size_t i;
+	for (i = 0; i < size; ++i) {
+		/* add space before byte except first one */
+		if (pmesg != tmesg)
+			*(pmesg++) = ' ';
+
+		sprintf(pmesg, "%02x", ((unsigned char *)buf)[i]);
+		pmesg += symb_num;
+		if ((i + 1) % size_max == 0 || i + 1 == size) {
+			tst_res_r(ttype, NULL, "%s", tmesg);
+			pmesg = tmesg;
+		}
+	}
+}
+
+/*
+ * tst_brkm_r() - thread-safe version of tst_brkm()
+ */
+void tst_brkm_r(int ttype, void (*func) (void), char *arg_fmt, ...)
+{
+	char tmesg[USERMESG];
+
+#if DEBUG
+	printf("IN tst_brkm_r\n");
+	fflush(stdout);
+	fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+
+	tst_brk_r(ttype, NULL, func, "%s", tmesg);
+	/* Shouldn't be reach, but fixes build time warnings about noreturn. */
+	abort();
+}
+
+/*
+ * tst_require_root_r() - thread-safe version of tst_require_root()
+ */
+void tst_require_root_r(void (*func) (void))
+{
+	if (geteuid() != 0)
+		tst_brkm_r(TCONF, func, "Test needs to be run as root");
+}
-- 
1.7.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
