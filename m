Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76AEC43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 07:02:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 950F93C9AC2
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 09:02:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 402A43C9F31
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 09:02:21 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id EAEA76008B2
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 09:02:18 +0200 (CEST)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+Pg+dhi5xAsAA--.15215S2; 
 Thu, 21 Jul 2022 15:02:05 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jul 2022 15:01:51 +0800
Message-Id: <1658386911-890-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxT+Pg+dhi5xAsAA--.15215S2
X-Coremail-Antispam: 1UD129KBjvAXoW3trWDGr17XF1kZw1xArW7twb_yoW8Xr4xuo
 WFvw1Ykw1rGr1rtr18J3ZxtFyUJr1DWrW3Ar4rG3WDGFnrXFs5urWrCw13G343JF45Ka47
 Xry7X345XrWftF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY87AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
 JVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] float: convert to new LTP API
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
Cc: ltp@lists.linux.it, Hongchen Zhang <zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

convert float to new LTP API. we will run NB_FUNC test cases,
every test case will run with num_threads and every thread run
num_loops loops.
You can specify the parameters(-D -n -l -v) as before.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 testcases/misc/math/float/main.c | 446 +++++++++------------------------------
 1 file changed, 100 insertions(+), 346 deletions(-)

diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
index 7285141..7ddce1d 100644
--- a/testcases/misc/math/float/main.c
+++ b/testcases/misc/math/float/main.c
@@ -1,52 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-	* Copyright (C) Bull S.A. 2001
-	* Copyright (c) International Business Machines  Corp., 2001
-	*
-	*   This program is free software;  you can redistribute it and/or modify
-	*   it under the terms of the GNU General Public License as published by
-	*   the Free Software Foundation; either version 2 of the License, or
-	*   (at your option) any later version.
-	*
-	*   This program is distributed in the hope that it will be useful,
-	*   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-	*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-	*   the GNU General Public License for more details.
-	*
-	*   You should have received a copy of the GNU General Public License
-	*   along with this program;  if not, write to the Free Software
-	*   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-	*/
-
-/******************************************************************************/
-/*									    */
-/* Dec-03-2001  Created: Jacky Malcles & Jean Noel Cordenner		  */
-/*	      These tests are adapted from AIX float PVT tests.	     */
-/*									    */
-/******************************************************************************/
+ * Copyright (C) Bull S.A. 2001
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Dec-03-2001  Created: Jacky Malcles & Jean Noel Cordenner
+ *	      These tests are adapted from AIX float PVT tests.
+ */
 #include "tfloat.h"
 
-#include "test.h"
+#include "tst_test.h"
 
 #define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
-/* LTP status reporting */
-char *TCID;			/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
-
-/* To avoid extensive modifications to the code, use this bodge */
-#define exit(x) myexit(x)
-
-void myexit(int x)
-{
-	if (x)
-		tst_resm(TFAIL, "Test failed");
-	else
-		tst_resm(TPASS, "Test passed");
-	tst_exit();
-}
 
 TH_DATA *pcom;
 TH_DATA **tabcom;
-TH_DATA **tabcour;
+
 #ifndef	PATH_MAX
 #define PATH_MAX		1024
 #endif
@@ -59,32 +26,27 @@ char datadir[PATH_MAX];		/* DATA directory */
 int num_threads = DEFAULT_NUM_THREADS;
 int num_loops = 500;
 
-int sig_cancel = 0;		/* flag set by handle_signals to tell initial thread
-				   to stop creating new threads (signal caught) */
-
-int indice = 0;			/* # of threads created, to be canceled by handle_signals
-				   or waited for by initial thread */
-
-pthread_mutex_t sig_mutex;
 pthread_t *threads;
-
 int debug = 0;
-int true = 1;
-
-static void *handle_signals(void *);
-
-static void sys_error(const char *, int);
 
 const double EPS = 0.1e-300;
 
-const int nb_func = NB_FUNC;
+static char *Dopt, *lopt, *nopt, *vopt;
+static struct tst_option opt[] = {
+	{"D:", &Dopt,   "DATA directory's absolute path"},
+	{"l:", &lopt, "set number of loops per function"},
+	{"n:", &nopt, "set number of threads per function"},
+	{"v", &vopt, "debug level"},
+	{}
+};
 
 int generate(char *datadir, char *bin_path)
 {
 	char *cmdline;
 	char *fmt = "cd %s; %s/%s %s";
 
-	cmdline = malloc(2 * strlen(bin_path) + strlen(datadir) + strlen(GENERATOR) + strlen(fmt));
+	cmdline = malloc(2 * strlen(bin_path) + strlen(datadir) +
+				strlen(GENERATOR) + strlen(fmt));
 	if (cmdline == NULL)
 		return (1);
 	sprintf(cmdline, fmt, datadir, bin_path, GENERATOR, bin_path);
@@ -93,345 +55,137 @@ int generate(char *datadir, char *bin_path)
 	return (0);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int opt = 0;
-	pid_t pid;
-
 	char *bin_path, *ltproot;
-	void *exit_value;
-	pthread_attr_t newattr;
-	pthread_t sig_hand;
-	size_t stacksize = 2093056;
-	int th_num;
-	int retvalend = 0;
-	int retval = 0;
-	int error = 0;
-	/*int time=1; */
-	int i;
-
-	/* Generate test ID from invocation name */
-	if ((TCID = strrchr(argv[0], '/')) != NULL)
-		TCID++;
-	else
-		TCID = argv[0];
+
 	ltproot = getenv("LTPROOT");
 	if (ltproot == NULL || strlen(ltproot) == 0) {
-		tst_brkm(TBROK, NULL,
+		tst_brk(TBROK,
 			 "You must set $LTPROOT before executing this test");
 	}
 	bin_path = malloc(strlen(ltproot) + 16);
 	if (bin_path == NULL) {
-		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
+		tst_brk(TBROK, "malloc failed");
 	}
 	sprintf(bin_path, "%s/testcases/bin", ltproot);
 
-	tst_tmpdir();
-
 	setbuf(stdout, NULL);
 	setbuf(stderr, NULL);
 	datadir[0] = '.';
 	datadir[1] = '\0';
 
-	if (argc != 1) {
-		while ((opt = getopt(argc, argv, "vn:l:D:?")) != EOF) {
-			switch (opt) {
-			case 'D':
-				strncpy(datadir, optarg, PATH_MAX);
-				break;
-			case 'l':
-				num_loops = atoi(optarg);
-				break;
-			case 'n':
-				num_threads = atoi(optarg);
-				break;
-			case 'v':
-				++debug;	/* verbose mode */
-				break;
-			default:
-				fprintf(stderr,
-					"usage: %s [-n number_of_threads] [-v]\n",
-					argv[0]);
-				fprintf(stderr, "[-l number_of_loops] ");
-				fprintf(stderr, "[-D DATAs absolute path]\n");
-				exit(1);
-			}
-		}
-	}
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-	case 0:
-		generate(datadir, bin_path);
-		exit(0);
-	default:
-		waitpid(pid, NULL, 0);
-	}
+	if (Dopt)
+		strncpy(datadir, Dopt, PATH_MAX);
+	if (lopt)
+		num_loops = atoi(lopt);
+	if (nopt)
+		num_threads = atoi(nopt);
+	if (vopt)
+		debug = 1;
+
+	generate(datadir, bin_path);
 	SAFE_FREE(bin_path);
 
-	if (debug) {
-		tst_resm(TINFO,
-			 "%s: will run for %d loops; using %s as a data directory",
-			 argv[0], num_loops, datadir);
-	}
 	if (num_threads <= 0) {
-		tst_resm(TWARN,
-			 "num_threads undefined or incorrect, using \"1\"");
 		num_threads = 1;
+	} else if (num_threads > PTHREAD_THREADS_MAX - 2) {
+		num_threads = PTHREAD_THREADS_MAX - 2;
 	}
 
-	if (nb_func * num_threads > PTHREAD_THREADS_MAX - 2)
-		while (nb_func * num_threads > PTHREAD_THREADS_MAX - 2)
-			num_threads--;
-	if (debug)
-		tst_resm(TINFO,
-			 "%s: will run %d functions, %d threads per function",
-			 argv[0], nb_func, num_threads);
-
-	retval = pthread_mutex_init(&sig_mutex, NULL);
-	if (retval != 0)
-		sys_error("main : mutex_init(&sig_mutex) FAILED", __LINE__);
+	if (debug) {
+		tst_res(TINFO,
+			"will run for %d loops, %d threads per function;"
+			"using %s as a data directory",
+			num_loops, num_threads, datadir);
+	}
+}
 
-	retval = pthread_create(&sig_hand, NULL, handle_signals, NULL);
-	if (retval != 0)
-		sys_error("main : create(&sig_hand) FAILED", __LINE__);
+void run(unsigned int n)
+{
+	void *exit_value;
+	pthread_attr_t newattr;
+	size_t stacksize = 2093056;
+	int th_num;
+	int retval = 0;
 
 	/*
-	 * Start all calculation threads...
+	 * Start calculation threads...
 	 */
-	threads = malloc(nb_func * num_threads * sizeof(pthread_t));
+	threads = malloc(num_threads * sizeof(pthread_t));
 	if (threads == NULL)
-		tst_brkm(TFAIL | TERRNO, cleanup, "malloc failed");
+		tst_brk(TFAIL, "malloc failed");
 
-	tabcom = malloc((sizeof(TH_DATA *) * nb_func * num_threads));
+	tabcom = malloc((sizeof(TH_DATA *) * num_threads));
 	if (!tabcom)
-		tst_brkm(TFAIL | TERRNO, cleanup, "malloc failed");
-	tabcour = tabcom;
+		tst_brk(TFAIL, "malloc failed");
 
 	retval = pthread_attr_init(&newattr);
 	if (retval != 0)
-		sys_error("main : attr_init(&newattr) FAILED", __LINE__);
+		tst_brk(TFAIL, "attr_init(&newattr) failed");
 
 	if (pthread_attr_setstacksize(&newattr, stacksize))
-		sys_error("main: pthread_attr_setstacksize failed", __LINE__);
+		tst_brk(TFAIL, "pthread_attr_setstacksize failed");
 
-	retval = pthread_attr_setdetachstate(&newattr, PTHREAD_CREATE_JOINABLE);
+	retval = pthread_attr_setdetachstate(&newattr,
+						PTHREAD_CREATE_JOINABLE);
 	if (retval != 0)
-		sys_error("main : attr_setdetachstate(&newattr) FAILED",
-			  __LINE__);
-
-	/* run the nb_func functions on num_threads */
-
-	indice = 0;
-	for (i = 0; i < nb_func; i++) {
-
-		for (th_num = 0; th_num < num_threads; th_num++) {
-
-			/* allocate struct of commucation  with the thread */
-			pcom = calloc(1, sizeof(TH_DATA));
-			if (pcom == NULL)
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "calloc failed");
-			*tabcour = (TH_DATA *) pcom;
-			tabcour++;
-			/*
-			 * update structure of communication
-			 */
-			pcom->th_num = th_num;
-			pcom->th_func = th_func[i];
-
-			pthread_mutex_lock(&sig_mutex);
-
-			if (sig_cancel) {	/* stop processing right now! */
-				pthread_mutex_unlock(&sig_mutex);
-				goto finished;
-			}
-			retval = pthread_create(&threads[indice], &newattr,
-						thread_code, (void *)pcom);
-			if (retval != 0)
-				sys_error("main : create FAILED", __LINE__);
-			indice++;
-			pthread_mutex_unlock(&sig_mutex);
-
-		}		/* num_threads */
-	}			/* for i */
-
-	/*alarm(60*time); *//* start all threads for TEST_time */
+		tst_brk(TFAIL, "attr_setdetachstate(&newattr) FAILED");
+
+	/* run the calculation function on num_threads */
+	for (th_num = 0; th_num < num_threads; th_num++) {
+
+		/* allocate struct of commucation  with the thread */
+		pcom = calloc(1, sizeof(TH_DATA));
+		if (pcom == NULL)
+			tst_brk(TFAIL, "calloc failed");
+		*(tabcom + th_num) = (TH_DATA *) pcom;
+		/*
+		 * update structure of communication
+		 */
+		pcom->th_num = th_num;
+		pcom->th_func = th_func[n];
+
+		retval = pthread_create(&threads[th_num], &newattr,
+					thread_code, (void *)pcom);
+		if (retval != 0)
+			tst_brk(TFAIL, "pthread create failed");
+
+	}
 
 	/*
 	 * Wait for the threads finish their task
 	 * pthread_join () will block
 	 */
-
-finished:
-	if (debug) {
-		tst_resm(TINFO,
-			 "initial thread: Waiting for %d threads to finish",
-			 indice);
-	}
-	tabcour = tabcom;
-
-	for (th_num = 0; th_num < indice; th_num++) {
-		retvalend = pthread_join(threads[th_num], &exit_value);
-		if (retvalend != 0)
-			sys_error("finish : join FAILED", __LINE__);
+	for (th_num = 0; th_num < num_threads; th_num++) {
+		retval = pthread_join(threads[th_num], &exit_value);
+		if (retval != 0)
+			tst_brk(TFAIL, "finish : join %d failed", th_num);
 
 		/* test the result in TH_DATA : communication buffer */
-		pcom = *tabcour++;
+		pcom = *(tabcom + th_num);
 		if (pcom->th_result != 0) {
-			error++;
-			tst_resm(TFAIL,
-				 "thread %d (%s) terminated unsuccessfully %d "
-				 "errors/%d loops\n%s",
-				 th_num, pcom->th_func.fident, pcom->th_nerror,
-				 pcom->th_nloop, pcom->detail_data);
-		} else if (debug) {
-			tst_resm(TINFO,
-				 "thread %d (%s) terminated successfully %d loops",
-				 th_num, pcom->th_func.fident,
-				 pcom->th_nloop - 1);
+			tst_res(TFAIL,
+				"thread %d (%s) terminated unsuccessfully %d errors/%d loops\n%s",
+				th_num, pcom->th_func.fident,
+				pcom->th_nerror, pcom->th_nloop,
+				pcom->detail_data);
 		}
 		SAFE_FREE(pcom);
-
 	}
+
 	SAFE_FREE(tabcom);
 	SAFE_FREE(threads);
-	tst_rmdir();
-	if (error)
-		exit(1);
-	else
-		exit(0);
-	return 0;
-}
-
-/*----------------------------------------------------------------------+
-|			    handle_signals ()				|
-| ======================================================================|
-|									|
-| Function:  ....							|
-|	    If SIGALRM or SIGUSR1 or SIGINT : cancel threads		|
-|									|
-| Updates:   ....							|
-|									|
-+-----------------------------------------------------------------------*/
-static void *handle_signals(void *arg)
-{
-	sigset_t signals_set;
-	int thd;
-	int sig;
-	int retvalsig = 0;
 
-	if (debug)
-		tst_resm(TINFO, "signal handler %lu started", pthread_self());
-	/*
-	 * Set up the signals that we want to handle...
-	 */
-	sigemptyset(&signals_set);
-	sigaddset(&signals_set, SIGINT);
-	sigaddset(&signals_set, SIGQUIT);
-	sigaddset(&signals_set, SIGTERM);
-	sigaddset(&signals_set, SIGUSR1);
-	sigaddset(&signals_set, SIGALRM);
-	while (1) {
-		if (debug)
-			tst_resm(TINFO, "Signal handler starts waiting...");
-
-		sigwait(&signals_set, &sig);
-		if (debug)
-			tst_resm(TINFO, "Signal handler caught signal %d", sig);
-
-		switch (sig) {
-		case SIGALRM:
-		case SIGUSR1:
-		case SIGINT:
-			if (sig_cancel)
-				tst_resm(TINFO,
-					 "Signal handler: already finished; "
-					 "ignoring signal");
-			else {
-				/*
-				 * Have to signal all non started threads...
-				 */
-
-				retvalsig = pthread_mutex_lock(&sig_mutex);
-				if (retvalsig != 0)
-					sys_error
-					    ("handle_signal : mutex_lock(&sig_mutex) FAILED",
-					     __LINE__);
-
-				sig_cancel = 1;
-				retvalsig = pthread_mutex_unlock(&sig_mutex);
-				if (retvalsig != 0)
-					sys_error
-					    ("handle_signal : mutex_unlock(&sig_mutex) FAILED",
-					     __LINE__);
-
-				/*
-				 * ......... and all started
-				 */
-				for (thd = 0; thd < indice; thd++) {
-					if (debug)
-						tst_resm(TINFO,
-							 "signal handler: "
-							 "cancelling thread (%d of "
-							 "%d)", thd, indice);
-					retvalsig =
-					    pthread_cancel(threads[thd]);
-					if (retvalsig != 0)
-						sys_error
-						    ("handle_signal : cancel FAILED",
-						     __LINE__);
-				}
-			}
-			break;
-		case SIGQUIT:
-			tst_resm(TINFO,
-				 "Signal handler: Caught SIGQUIT; doing nothing");
-			break;
-		case SIGTERM:
-			tst_resm(TINFO,
-				 "Signal handler: Caught SIGTERM; doing nothing");
-			break;
-		default:
-			exit(1);
-		}
-	}
-	return NULL;
+	tst_res(TPASS,
+		"%s terminated successfully", th_func[n].fident);
 }
 
-/*----------------------------------------------------------------------+
- |				error ()				|
- | =====================================================================|
- |									|
- | Function:  Prints out message and exits...				|
- |									|
- +----------------------------------------------------------------------*/
-static void error(const char *msg, int line)
-{
-	tst_brkm(TFAIL, cleanup, "ERROR [line: %d] %s", line, msg);
-}
-
-/*----------------------------------------------------------------------+
- |			     sys_error ()				|
- | =====================================================================|
- |									|
- | Function:  Creates system error message and calls error ()		|
- |									|
- +----------------------------------------------------------------------*/
-/*
- * XXX (garrcoop): the way that this is being called is just plain wrong.
- * pthread(5) returns 0 or errnos, not necessarily sets errno to a sensible
- * value.
- */
-static void sys_error(const char *msg, int line)
-{
-	char syserr_msg[256];
-
-	sprintf(syserr_msg, "%s: %s", msg, strerror(errno));
-	error(syserr_msg, line);
-}
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.options = opt,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.tcnt = NB_FUNC,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
