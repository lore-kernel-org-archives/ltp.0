Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D3C44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784183714; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3Lrimh/uiwzzK3DIPdOc/Z+eemjhiTB8E9Efg4pOToA=;
 b=F/h2O2oUa+ETWz+OlGjx6/2c2aw6WZjzb0x7O5RIhl5aP1w+WCm4s2jIdYXioeuTVZ6wR
 MBo61z2k/U/ZYv34m8rlT3L1juvXaS7SWSL459ajUTicj9ZiJ9tYNhOVpokQ0tja+3aAQKU
 47PmB4opIqr57cGj2PPGAFeIOeS4EIs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4833E2567
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 08:35:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FDBF3E2549
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 08:33:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78E22600551
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 08:33:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784183622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LimA7WHy9DBj/P98quxSx9vf3HPI4R92uk4A13qLVhI=;
 b=MT3hx+mMmHJ20Xlb98GtTCBW9Nb0fQ8Y4WcaGHDv7nB/YmiNDBUrDHVgQfRKPggQXjphs2
 YWMe5b48wg7R+h8SpqB6+X3z2U3GNXDPMXXz3yAAYIsqMT4Soe9Lh1ckgfW7vy17QWU4B2
 p2heQlJie9/GwnJ7EekO3GbNXi2CKDk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-iq9ZvANMPeqw4kpgOpSgKg-1; Thu,
 16 Jul 2026 02:33:39 -0400
X-MC-Unique: iq9ZvANMPeqw4kpgOpSgKg-1
X-Mimecast-MFC-AGG-ID: iq9ZvANMPeqw4kpgOpSgKg_1784183619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11A86180066B
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:33:39 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.com (unknown [10.44.48.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 641CF3003EFD
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:33:38 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 08:33:25 +0200
Message-ID: <a4418d01566f0b8c6af77db5979a4216d8d5f46c.1784183478.git.tdzik@redhat.com>
In-Reply-To: <cover.1784183478.git.tdzik@redhat.com>
References: <cover.1784183478.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ns8hLoZHyW2RBearq7paJ4DquwpWRQ6Dle86RLoeJjs_1784183619
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Replace sprintf() with more secure snprintf()
 variant in float tests
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

There are tests in testcases/misc/math/float/ which use sprintf().
It is safer to use snprintf().

Signed-off-by: Tomas Dzik <tdzik@redhat.com>
---
 testcases/misc/math/float/bessel/genbessel.c  | 10 +++----
 .../misc/math/float/exp_log/genexp_log.c      | 21 ++++++++++-----
 testcases/misc/math/float/iperb/geniperb.c    |  9 ++++---
 testcases/misc/math/float/main.c              | 18 +++++++++----
 testcases/misc/math/float/power/genpower.c    | 18 ++++++++-----
 testcases/misc/math/float/thread_code.c       | 26 ++++++++++++-------
 testcases/misc/math/float/trigo/gentrigo.c    | 21 ++++++++++-----
 7 files changed, 81 insertions(+), 42 deletions(-)

diff --git a/testcases/misc/math/float/bessel/genbessel.c b/testcases/misc/math/float/bessel/genbessel.c
index 91ea3b6da..644aa7e3d 100644
--- a/testcases/misc/math/float/bessel/genbessel.c
+++ b/testcases/misc/math/float/bessel/genbessel.c
@@ -79,23 +79,23 @@ int main(int argc, char *argv[])
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
 	if (funct == NULL)
 		err(1, "malloc failed");
-	sprintf(funct, "%s/genj0", bin_path);
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
index e02d0d344..0411aa8bf 100644
--- a/testcases/misc/math/float/exp_log/genexp_log.c
+++ b/testcases/misc/math/float/exp_log/genexp_log.c
@@ -79,31 +79,38 @@ int main(int argc, char *argv[])
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
 	if (funct == NULL)
 		err(1, "malloc failed");
-	sprintf(funct, "%s/genexp", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genlog", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genlog", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genlog10", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genlog10", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfrexp", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genfrexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genldexp", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genldexp", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genhypot", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genhypot", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genmodf", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genmodf", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/iperb/geniperb.c b/testcases/misc/math/float/iperb/geniperb.c
index 98a6a380a..2583f9cfb 100644
--- a/testcases/misc/math/float/iperb/geniperb.c
+++ b/testcases/misc/math/float/iperb/geniperb.c
@@ -80,15 +80,18 @@ int main(int argc, char *argv[])
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
 	if (funct == NULL)
 		err(1, "malloc failed");
-	sprintf(funct, "%s/gencosh", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gencosh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gensinh", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gensinh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gentanh", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gentanh", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
index 7285141a4..862250d7f 100644
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
+	cmdline = malloc(cmdline_size);
 	if (cmdline == NULL)
 		return (1);
-	sprintf(cmdline, fmt, datadir, bin_path, GENERATOR, bin_path);
+	snprintf(cmdline, cmdline_size, fmt, datadir,
+		bin_path, GENERATOR, bin_path);
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
 
@@ -432,6 +439,7 @@ static void sys_error(const char *msg, int line)
 {
 	char syserr_msg[256];
 
-	sprintf(syserr_msg, "%s: %s", msg, strerror(errno));
+	snprintf(syserr_msg, sizeof(syserr_msg),
+		"%s: %s", msg, strerror(errno));
 	error(syserr_msg, line);
 }
diff --git a/testcases/misc/math/float/power/genpower.c b/testcases/misc/math/float/power/genpower.c
index 8a8f753a7..6e8356e8e 100644
--- a/testcases/misc/math/float/power/genpower.c
+++ b/testcases/misc/math/float/power/genpower.c
@@ -79,27 +79,33 @@ int main(int argc, char *argv[])
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
 	if (funct == NULL)
 		err(1, "malloc failed");
-	sprintf(funct, "%s/genceil", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genceil", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfabs", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genfabs", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfloor", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genfloor", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genfmod", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genfmod", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genpow", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genpow", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gensqrt", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gensqrt", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
diff --git a/testcases/misc/math/float/thread_code.c b/testcases/misc/math/float/thread_code.c
index 6f3a463dd..b67edbb34 100644
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
@@ -288,7 +291,8 @@ void *thread_code(void *arg)
 
 	fsize = read_file(th_data->th_func.din_fname, (void **)&din);
 	if (fsize == (size_t) 0) {
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: reading %s, %s\n",
 			th_data->th_func.fident,
 			th_data->th_func.din_fname, strerror(errno));
@@ -298,7 +302,8 @@ void *thread_code(void *arg)
 	}
 	fsize2 = read_file(th_data->th_func.dex_fname, (void **)&dex);
 	if (fsize2 == (size_t) 0) {
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: reading %s, %s\n",
 			th_data->th_func.fident,
 			th_data->th_func.dex_fname, strerror(errno));
@@ -318,7 +323,8 @@ void *thread_code(void *arg)
 	case FUNC_GAM:
 		fsize3 = read_file(th_data->th_func.dex2_fname, (void **)&dex2);
 		if (fsize3 == (size_t) 0) {
-			sprintf(th_data->detail_data,
+			snprintf(th_data->detail_data,
+				DETAIL_DATA_SIZE,
 				"FAIL: %s: reading %s, %s\n",
 				th_data->th_func.fident,
 				th_data->th_func.dex2_fname, strerror(errno));
@@ -351,7 +357,8 @@ void *thread_code(void *arg)
 		break;
 	default:
 file_size_error:
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: file sizes don't match\n",
 			th_data->th_func.fident);
 		th_data->th_result = 1;
@@ -395,7 +402,8 @@ file_size_error:
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
index 4908d0435..a0c6f2a88 100644
--- a/testcases/misc/math/float/trigo/gentrigo.c
+++ b/testcases/misc/math/float/trigo/gentrigo.c
@@ -80,31 +80,38 @@ int main(int argc, char *argv[])
 	funct = malloc(strlen(bin_path) + MAX_FNAME_LEN);
 	if (funct == NULL)
 		err(1, "malloc failed");
-	sprintf(funct, "%s/gencos", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gencos", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gensin", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gensin", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/gentan", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/gentan", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genatan", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genatan", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genatan2", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genatan2", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genacos", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genacos", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-	sprintf(funct, "%s/genasin", bin_path);
+	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
+		"%s/genasin", bin_path);
 	child = create_file(funct, 0);
 	waitpid(child, NULL, 0);
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
