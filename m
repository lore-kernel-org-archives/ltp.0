Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD026C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783612135; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=CCiXFXFwnmcxauqR7hB3+iRfPsRaBOJMfMjrTu1fp7Y=;
 b=Zt62aRyQKclYUD/uWHnF+X+Wj6MCovIlAlZZmFwz0oAvpXkFu7ysK/C62qjhQESHvzZ+1
 r4KoUWWJ85N9XO2kzVAlLgWo/iughLnKJk8O4diBjdxHWr3EG5Xj+Ms4s8JRw+rxgmwPvmF
 6W6ZyA2Y9OCD7o3RTEJm0OmS58dAU8A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58A053E68EC
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:48:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2CB03E5D30
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39E29600257
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783611627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpC+I0mEoXkO1D2cog/wk4zPQwI3KWRq/JS7NX6UJuw=;
 b=DkKi1DEeWOszXgK4Sp8qdZgkVlJy/dcAEhW05uE2Gbo4LFi9azDL6kA5DhOCIn9Rl104oc
 PeTC1araQoDsGp5C/L+fE565qnQncBp9teN5a4BhA0f2mdnCOpp5di1l0VF0eHytiRpf00
 mtppVV7kXued4devH5NSMErMKG95cc8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-TVQk7J1OMwW1D9Iv22qopQ-1; Thu,
 09 Jul 2026 11:40:25 -0400
X-MC-Unique: TVQk7J1OMwW1D9Iv22qopQ-1
X-Mimecast-MFC-AGG-ID: TVQk7J1OMwW1D9Iv22qopQ_1783611624
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 984C01955DC1
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:24 +0000 (UTC)
Received: from tdzik-thinkpadt14gen6.tpbc.com (unknown [10.44.49.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB0F13000C14
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:23 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 17:40:06 +0200
Message-ID: <564f7bf1677320fcf6869d6d7c6a446eaeaa85ad.1783610933.git.tdzik@redhat.com>
In-Reply-To: <cover.1783610933.git.tdzik@redhat.com>
References: <cover.1783610933.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oc0jddV90Tl-P_88kjxQuH7GeuJ4GyXD221fOAb8nI0_1783611624
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Jul 2026 17:47:41 +0200
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
 testcases/misc/math/float/iperb/geniperb.c    |  8 ++++--
 testcases/misc/math/float/main.c              | 18 +++++++++----
 testcases/misc/math/float/power/genpower.c    | 18 ++++++++-----
 testcases/misc/math/float/thread_code.c       | 26 ++++++++++++-------
 testcases/misc/math/float/trigo/gentrigo.c    | 21 ++++++++++-----
 7 files changed, 81 insertions(+), 41 deletions(-)

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
index 98a6a380a..d115bd6e4 100644
--- a/testcases/misc/math/float/iperb/geniperb.c
+++ b/testcases/misc/math/float/iperb/geniperb.c
@@ -80,15 +80,19 @@ int main(int argc, char *argv[])
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
 
 	sprintf(funct, "%s/gentanh", bin_path);
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
index 34a9578d4..af32b71c9 100644
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
@@ -289,7 +292,8 @@ void *thread_code(void *arg)
 
 	fsize = read_file(th_data->th_func.din_fname, (void **)&din);
 	if (fsize == (size_t) 0) {
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: reading %s, %s\n",
 			th_data->th_func.fident,
 			th_data->th_func.din_fname, strerror(errno));
@@ -299,7 +303,8 @@ void *thread_code(void *arg)
 	}
 	fsize2 = read_file(th_data->th_func.dex_fname, (void **)&dex);
 	if (fsize2 == (size_t) 0) {
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: reading %s, %s\n",
 			th_data->th_func.fident,
 			th_data->th_func.dex_fname, strerror(errno));
@@ -319,7 +324,8 @@ void *thread_code(void *arg)
 	case FUNC_GAM:
 		fsize3 = read_file(th_data->th_func.dex2_fname, (void **)&dex2);
 		if (fsize3 == (size_t) 0) {
-			sprintf(th_data->detail_data,
+			snprintf(th_data->detail_data,
+				DETAIL_DATA_SIZE,
 				"FAIL: %s: reading %s, %s\n",
 				th_data->th_func.fident,
 				th_data->th_func.dex2_fname, strerror(errno));
@@ -352,7 +358,8 @@ void *thread_code(void *arg)
 		break;
 	default:
 file_size_error:
-		sprintf(th_data->detail_data,
+		snprintf(th_data->detail_data,
+			DETAIL_DATA_SIZE,
 			"FAIL: %s: file sizes don't match\n",
 			th_data->th_func.fident);
 		th_data->th_result = 1;
@@ -396,7 +403,8 @@ file_size_error:
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
