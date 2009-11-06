Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peppe.cavallaro@st.com>) id 1N6JZu-0001by-85
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 07:49:50 +0000
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123])
	by 29vjzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6JZm-0001Yy-6W
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 07:49:50 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A624184
	for <ltp-list@lists.sourceforge.net>;
	Fri,  6 Nov 2009 07:49:33 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B389A5F6
	for <ltp-list@lists.sourceforge.net>;
	Fri,  6 Nov 2009 07:49:32 +0000 (GMT)
Message-ID: <4AF3D509.3060408@st.com>
Date: Fri, 06 Nov 2009 08:49:29 +0100
From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010202040709050202050306"
Subject: [LTP] [PATCH] add iterations option in gtod_latency.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010202040709050202050306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Regards,
Peppe

--------------010202040709050202050306
Content-Type: text/x-patch;
	name="ltp-full-20090731-gtod_latency_iterations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ltp-full-20090731-gtod_latency_iterations.patch"

[PATCH] add iterations option in gtod_latency.

This patch adds a new option for tuning the number
of iterations into the gtod_latency realtime test.

Running gtod_latency on a target with limited resources
it fails (ENOMEM) as soon as it try to allocate the memory
for the two buffers start_data and stop_data.

Tested on i386 and sh4 architectures.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

--- ltp/testcases/realtime.orig/func/gtod_latency/gtod_latency.c	2009-11-04 15:55:58.000000000 +0100
+++ ltp/testcases/realtime/func/gtod_latency/gtod_latency.c	2009-11-06 08:37:14.000000000 +0100
@@ -81,13 +81,14 @@ char *labels[] = {"scatter plot x-axis",
 		  "histogram y-axis"};
 
 static unsigned long long latency_threshold = 0;
+static unsigned int iterations = ITERATIONS;
 
 void stats_cmdline_help(void)
 {
 	printf("Usage: ./gtod_latency {-[so|scatter-output] -[ho|hist-output]"
 		" -[st|scatter-title] -[ht|hist-title] -[sxl|scatter-xlabel]"
 		" -[syl|scatter-ylabel] -[hxl|hist-xlabel] -[hyl|hist-ylabel]"
-		" -[lt|latency-trace]}"
+		" -[lt|latency-trace] -[i|iterations]}"
 		" -[help] \n");
 	printf("**command-line options are not supported yet for this testcase\n");
 }
@@ -194,6 +195,15 @@ int stats_cmdline(int argc, char *argv[]
 			continue;
 		}
 
+		if (!strcmp(flag, "i") || !strcmp(flag, "iterations")) {
+			if (i + 1 == argc) {
+				printf("flag has missing argument\n");
+				return -1;
+			}
+			iterations = strtoull(argv[++i], NULL, 0);
+			continue;
+		}
+
 		printf("unknown flag given\n");
 		return -1;
 	}
@@ -210,9 +220,6 @@ long long timespec_subtract(struct times
 	return ns;
 }
 
-struct timespec start_data[ITERATIONS];
-struct timespec stop_data[ITERATIONS];
-
 int main(int argc, char *argv[])
 {
 	int i, j, k, err;
@@ -222,16 +229,38 @@ int main(int argc, char *argv[])
 	stats_container_t dat;
 	stats_container_t hist;
 	stats_quantiles_t quantiles;
+	struct timespec *start_data;
+	struct timespec *stop_data;
 
-	stats_container_init(&dat, ITERATIONS);
+	if (stats_cmdline(argc, argv) < 0) {
+		printf("usage: %s help\n", argv[0]);
+		exit(1);
+	}
+
+	if (iterations < 10000) {
+		iterations = 10000;
+		printf("user \"iterations\" value is too small, try with %d",
+			iterations);
+	}
+
+	stats_container_init(&dat, iterations);
 	stats_container_init(&hist, HIST_BUCKETS);
-	stats_quantiles_init(&quantiles, (int)log10(ITERATIONS));
+	stats_quantiles_init(&quantiles, (int)log10(iterations));
 	setup();
 
 	mlockall(MCL_CURRENT|MCL_FUTURE);
 
-	if (stats_cmdline(argc, argv) < 0) {
-		printf("usage: %s help\n", argv[0]);
+	start_data = calloc(iterations, sizeof(struct timespec));
+	if (start_data == NULL) {
+		printf("Memory allocation Failed (too many Iteration: %d)\n",
+			iterations);
+		exit(1);
+	}
+	stop_data = calloc(iterations, sizeof(struct timespec));
+	if (stop_data == NULL) {
+		printf("Memory allocation Failed (too many Iteration: %d)\n",
+			iterations);
+		free(start_data);
 		exit(1);
 	}
 
@@ -253,9 +282,9 @@ int main(int argc, char *argv[])
 	printf("\n----------------------\n");
 	printf("Gettimeofday() Latency\n");
 	printf("----------------------\n");
-	printf("Iterations: %d\n\n", ITERATIONS);
+	printf("Iterations: %d\n\n", iterations);
 
-	/* collect ITERATIONS pairs of gtod calls */
+	/* collect iterations pairs of gtod calls */
 	max = min = 0;
 	if (latency_threshold) {
 		latency_trace_enable();
@@ -263,7 +292,7 @@ int main(int argc, char *argv[])
 	}
 	/* This loop runs for a long time, hence can cause soft lockups.
 	   Calling sleep periodically avoids this. */
-	for (i=0; i<(ITERATIONS/10000); i++) {
+	for (i = 0; i < (iterations/10000); i++) {
 		for (j=0; j < 10000; j++) {
 			k = (i * 10000) + j;
 			clock_gettime(CLOCK_MONOTONIC,&start_data[k]);
@@ -271,7 +300,7 @@ int main(int argc, char *argv[])
 		}
 		usleep(1000);
 	}
-	for (i = 0; i < ITERATIONS; i++) {
+	for (i = 0; i < iterations; i++) {
 		delta = timespec_subtract(&start_data[i], &stop_data[i]);
 		dat.records[i].x = i;
 		dat.records[i].y = delta;
@@ -282,7 +311,7 @@ int main(int argc, char *argv[])
 	}
 	if (latency_threshold) {
 		latency_trace_stop();
-		if (i != ITERATIONS) {
+		if (i != iterations) {
 			printf("Latency threshold (%lluus) exceeded at iteration %d\n",
 				latency_threshold, i);
 			latency_trace_print();

--------------010202040709050202050306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------010202040709050202050306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010202040709050202050306--

