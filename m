Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E144C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783503602; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=QRAt0VkQNDPPuN/Ss2lKWbtD4Us6QbAByrdVoM/rb7E=;
 b=UjKnY0lGa5dtOv492v5eaEeVPQI/g/viHcd72HOXJ7AL0mSo9YL6+o61H3LMgbjEbZnc6
 nNt5r3SiSukJUx1QluBBe8yYxIg3povHpGCNXkWRgjtilX3FrqUX0OWb1oy7MTGalbk6cZ5
 PLWYwlAKTTRrIjUzeXVU8NtBOlFCIWc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81F993E2A2E
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:40:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F5E43E295B
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:37:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E04D21A00923
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783503455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bBxu3P4lA89LYqEo0oIQnCvoIJN9+KnFq0L1XKX+Iz0=;
 b=BOSyVw0u3+exrZr05CgUcwiZ6IWY9BvyX7nS89GgC7SxP6iHeVEUT+igKa6Ahvn7EJA3se
 pXUmitWLAhhZWdzqtTeadQz68pDgonD0oa80TZjm7l6/ycCJtzXKuBJPxa58ZO7lezWxMC
 UuNv0CKjZDSTGlGseheua5WoqiZD4kE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-nR_-_PkbM_-kvQiS6oiCJA-1; Wed,
 08 Jul 2026 05:37:34 -0400
X-MC-Unique: nR_-_PkbM_-kvQiS6oiCJA-1
X-Mimecast-MFC-AGG-ID: nR_-_PkbM_-kvQiS6oiCJA_1783503453
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60F51955F26
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 09:37:32 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.csb (unknown [10.43.3.29])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3501D1956056
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 09:37:31 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 11:37:15 +0200
Message-ID: <20260708093715.45301-1-tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NFe7OdAmZVndGy5DcYAHha49MVkmjRX_OIKYF6BLU5Q_1783503453
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 08 Jul 2026 11:39:35 +0200
Subject: [LTP] [PATCH] LTP/Lite test float_trigo core dumps due to free():
 invalid pointer
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
From: Tomas Dzik via ltp <ltp@lists.linux.it>
Reply-To: Tomas Dzik <tdzik@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If malloc() fails and return value is not checked, the current code runs
free() on uninitialized pointer.

Here is the log from failed run:
~==== float_trigo ====
command: float_trigo -v
float_trigo    0  TINFO  :  Using /tmp/LTP_floJSug25 as tmpdir (xfs
filesystem)
float_trigo    1  TPASS  :  Test passed
float_trigo    0  TINFO  :  float_trigo: will run for 500 loops; using .
as a data directory
float_trigo    0  TINFO  :  float_trigo: will run 7 functions, 20
threads per function
float_trigo    0  TINFO  :  signal handler 140451533870784 started
float_trigo    0  TINFO  :  Signal handler starts waiting...
free(): invalid pointer

Duration: 0.926

This fix:
- initializes pointers where we actually core dumped (*din, *dex).
- adds checks for all malloc() return values int testcases/misc/math/float/
  directory
- replaces sprintf() with more secure snprintf() variants

Signed-off-by: Tomas Dzik <tdzik@redhat.com>
---
 testcases/misc/math/float/bessel/genbessel.c  | 11 ++++---
 .../misc/math/float/exp_log/genexp_log.c      | 28 +++++++++-------
 testcases/misc/math/float/iperb/geniperb.c    |  9 +++--
 testcases/misc/math/float/main.c              | 17 +++++++---
 testcases/misc/math/float/power/genpower.c    | 16 +++++----
 testcases/misc/math/float/thread_code.c       | 33 +++++++++++++------
 testcases/misc/math/float/trigo/gentrigo.c    | 28 +++++++++-------
 7 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/testcases/misc/math/float/bessel/genbessel.c b/testcases/misc/math/float/bessel/genbessel.c
index 91ea3b6da..0954cfe0a 100644
--- a/testcases/misc/math/float/bessel/genbessel.c
+++ b/testcases/misc/math/float/bessel/genbessel.c
@@ -79,23 +79,24 @@ int main(int argc, char *argv[])
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
 	if (funct == NULL)
 		err(1, "malloc failed");
-	sprintf(funct, "%s/genj0", bin_path);
+
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genj0", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genj1", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genj1", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/geny0", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/geny0", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/geny1", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/geny1", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genlgamma", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genlgamma", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/exp_log/genexp_log.c b/testcases/misc/math/float/exp_log/genexp_log.c
index 7f26945ec..dbab5cccd 100644
--- a/testcases/misc/math/float/exp_log/genexp_log.c
+++ b/testcases/misc/math/float/exp_log/genexp_log.c
@@ -25,11 +25,12 @@
 /******************************************************************************/
 #include	<sys/types.h>
 #include	<sys/wait.h>
-#include 	<float.h>
-#include 	<stdio.h>
-#include 	<stdlib.h>
-#include 	<string.h>
-#include 	<errno.h>
+#include	<float.h>
+#include	<stdio.h>
+#include	<stdlib.h>
+#include	<string.h>
+#include	<errno.h>
+#include	<err.h>
 #include        <limits.h>
 #include        <unistd.h>
 #include        <fcntl.h>
@@ -76,31 +77,34 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
-	sprintf(funct, "%s/genexp", bin_path);
+	if (funct == NULL)
+		err(1, "malloc failed");
+
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genlog", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genlog", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genlog10", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genlog10", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfrexp", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genfrexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genldexp", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genldexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genhypot", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genhypot", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genmodf", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genmodf", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/iperb/geniperb.c b/testcases/misc/math/float/iperb/geniperb.c
index f7bf55c84..ec182a06b 100644
--- a/testcases/misc/math/float/iperb/geniperb.c
+++ b/testcases/misc/math/float/iperb/geniperb.c
@@ -78,15 +78,18 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
-	sprintf(funct, "%s/gencosh", bin_path);
+	if (funct == NULL)
+		err(1, "malloc failed");
+
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gencosh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gensinh", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gensinh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gentanh", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gentanh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
index 7285141a4..53e59e241 100644
--- a/testcases/misc/math/float/main.c
+++ b/testcases/misc/math/float/main.c
@@ -83,11 +83,15 @@ int generate(char *datadir, char *bin_path)
 {
 	char *cmdline;
 	char *fmt = "cd %s; %s/%s %s";
+	size_t cmdline_size;
 
-	cmdline = malloc(2 * strlen(bin_path) + strlen(datadir) + strlen(GENERATOR) + strlen(fmt));
+	cmdline_size = 2 * strlen(bin_path) + strlen(datadir);
+	cmdline_size += strlen(GENERATOR) + strlen(fmt);
+
+	cmdline = malloc(cmdline_size);
 	if (cmdline == NULL)
 		return (1);
-	sprintf(cmdline, fmt, datadir, bin_path, GENERATOR, bin_path);
+	snprintf(cmdline, cmdline_size, fmt, datadir, bin_path, GENERATOR, bin_path);
 	system(cmdline);
 	free(cmdline);
 	return (0);
@@ -114,6 +118,7 @@ int main(int argc, char *argv[])
 	int error = 0;
 	/*int time=1; */
 	int i;
+	size_t bin_path_size;
 
 	/* Generate test ID from invocation name */
 	if ((TCID = strrchr(argv[0], '/')) != NULL)
@@ -125,11 +130,13 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, NULL,
 			 "You must set $LTPROOT before executing this test");
 	}
-	bin_path = malloc(strlen(ltproot) + 16);
+
+	bin_path_size = strlen(ltproot) + 16;
+	bin_path = malloc(bin_path_size);
 	if (bin_path == NULL) {
 		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
 	}
-	sprintf(bin_path, "%s/testcases/bin", ltproot);
+	snprintf(bin_path, bin_path_size, "%s/testcases/bin", ltproot);
 
 	tst_tmpdir();
 
@@ -432,6 +439,6 @@ static void sys_error(const char *msg, int line)
 {
 	char syserr_msg[256];
 
-	sprintf(syserr_msg, "%s: %s", msg, strerror(errno));
+	snprintf(syserr_msg, sizeof(syserr_msg), "%s: %s", msg, strerror(errno));
 	error(syserr_msg, line);
 }
diff --git a/testcases/misc/math/float/power/genpower.c b/testcases/misc/math/float/power/genpower.c
index 44f7af934..b2c1171c0 100644
--- a/testcases/misc/math/float/power/genpower.c
+++ b/testcases/misc/math/float/power/genpower.c
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <err.h>
 #include <sys/signal.h>
 #include <math.h>
 
@@ -76,27 +77,30 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
-	sprintf(funct, "%s/genceil", bin_path);
+	if (funct == NULL)
+		err(1, "malloc failed");
+
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genceil", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfabs", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genfabs", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfloor", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genfloor", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfmod", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genfmod", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genpow", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genpow", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gensqrt", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gensqrt", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/thread_code.c b/testcases/misc/math/float/thread_code.c
index ca18cef1e..b67edbb34 100644
--- a/testcases/misc/math/float/thread_code.c
+++ b/testcases/misc/math/float/thread_code.c
@@ -47,7 +47,7 @@ static size_t read_file(char *fname, void **data)
 	int fd;
 	int maxretries = 1;
 
-	(void)sprintf(path, "%s/%s", datadir, fname);
+	(void)snprintf(path, PATH_MAX, "%s/%s", datadir, fname);
 
 	errno = 0;
 
@@ -135,7 +135,8 @@ static void check_error(TH_DATA * th_data, double e, double r, int index)
 			++th_data->th_nerror;
 			/* record first error only ! */
 			if (th_data->th_result == 0) {
-				sprintf(th_data->detail_data,
+				snprintf(th_data->detail_data,
+					DETAIL_DATA_SIZE,
 					errtmplt,
 					th_data->th_func.fident,
 					index, e, r, x);
@@ -194,7 +195,8 @@ static void compute_modf(TH_DATA * th_data, double *din, double *dex,
 		++th_data->th_nerror;
 		/* record first error only ! */
 		if (th_data->th_result == 0) {
-			sprintf(th_data->detail_data,
+			snprintf(th_data->detail_data,
+				DETAIL_DATA_SIZE,
 				errtmplt1,
 				th_data->th_func.fident,
 				index, dex2[index], tmp);
@@ -239,7 +241,8 @@ static void compute_frexp_lgamma(TH_DATA * th_data, double *din, double *dex,
 			++th_data->th_nerror;
 			/* record first error only ! */
 			if (th_data->th_result == 0) {
-				sprintf(th_data->detail_data,
+				snprintf(th_data->detail_data,
+					DETAIL_DATA_SIZE,
 					errtmplt2,
 					th_data->th_func.fident,
 					index, dex2[index], tmp);
@@ -278,12 +281,18 @@ void *thread_code(void *arg)
 {
 	TH_DATA *th_data = (TH_DATA *) arg;
 	size_t fsize, fsize2, fsize3;
-	double *din, *dex, *dex2 = NULL;
+	/*
+	 * If read_file() fails for whatever reason, these pointers might
+	 * stay uninitialized. Initialize them to NULL, because SAFE_FREE()
+	 * can handle it.
+	 */
+	double *din = NULL, *dex = NULL, *dex2 = NULL;
 	int imax, index;
 
 	fsize = read_file(th_data->th_func.din_fname, (void **)&din);
 	if (fsize == (size_t) 0) {
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: reading %s, %s\n",
 			th_data->th_func.fident,
 			th_data->th_func.din_fname, strerror(errno));
@@ -293,7 +302,8 @@ void *thread_code(void *arg)
 	}
 	fsize2 = read_file(th_data->th_func.dex_fname, (void **)&dex);
 	if (fsize2 == (size_t) 0) {
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: reading %s, %s\n",
 			th_data->th_func.fident,
 			th_data->th_func.dex_fname, strerror(errno));
@@ -313,7 +323,8 @@ void *thread_code(void *arg)
 	case FUNC_GAM:
 		fsize3 = read_file(th_data->th_func.dex2_fname, (void **)&dex2);
 		if (fsize3 == (size_t) 0) {
-			sprintf(th_data->detail_data,
+			snprintf(th_data->detail_data,
+				DETAIL_DATA_SIZE,
 				"FAIL: %s: reading %s, %s\n",
 				th_data->th_func.fident,
 				th_data->th_func.dex2_fname, strerror(errno));
@@ -346,7 +357,8 @@ void *thread_code(void *arg)
 		break;
 	default:
 file_size_error:
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: file sizes don't match\n",
 			th_data->th_func.fident);
 		th_data->th_result = 1;
@@ -390,7 +402,8 @@ file_size_error:
 					      din, dex, (int *)dex2, index);
 				break;
 			default:
-				sprintf(th_data->detail_data,
+				snprintf(th_data->detail_data,
+					DETAIL_DATA_SIZE,
 					"FAIL: %s: unexpected function type\n",
 					th_data->th_func.fident);
 				th_data->th_result = 1;
diff --git a/testcases/misc/math/float/trigo/gentrigo.c b/testcases/misc/math/float/trigo/gentrigo.c
index 5f7e0cbc7..0d512d17f 100644
--- a/testcases/misc/math/float/trigo/gentrigo.c
+++ b/testcases/misc/math/float/trigo/gentrigo.c
@@ -25,11 +25,12 @@
 /******************************************************************************/
 #include	<sys/types.h>
 #include	<sys/wait.h>
-#include 	<float.h>
-#include 	<stdio.h>
-#include 	<stdlib.h>
-#include 	<string.h>
-#include 	<errno.h>
+#include	<float.h>
+#include	<stdio.h>
+#include	<stdlib.h>
+#include	<string.h>
+#include	<errno.h>
+#include	<err.h>
 #include        <limits.h>
 #include        <unistd.h>
 #include        <fcntl.h>
@@ -77,31 +78,34 @@ int main(int argc, char *argv[])
 	bin_path = argv[1];
 
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
-	sprintf(funct, "%s/gencos", bin_path);
+	if (funct == NULL)
+		err(1, "malloc failed");
+
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gencos", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gensin", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gensin", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gentan", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/gentan", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genatan", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genatan", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genatan2", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genatan2", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genacos", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genacos", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genasin", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN, "%s/genasin", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
