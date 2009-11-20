Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peppe.cavallaro@st.com>) id 1NBSBO-00070n-UP
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 12:01:46 +0000
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145])
	by 1b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NBSBH-0000Wb-BT
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 12:01:46 +0000
Message-ID: <4B068507.4010303@st.com>
Date: Fri, 20 Nov 2009 13:01:11 +0100
From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
MIME-Version: 1.0
References: <4AF3D509.3060408@st.com> <4AF41677.8030408@linux.vnet.ibm.com>	
	<4AF41D01.207@st.com> <4AF42CBC.6000204@linux.vnet.ibm.com>	
	<1257788343.7677.63.camel@subratamodak.linux.ibm.com>	
	<4B01682C.8040708@st.com> <4B06495F.2060600@st.com>
	<1258712924.4986.5.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1258712924.4986.5.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------090608070602070901030305"
Subject: Re: [LTP] [PATCH] add iterations option in gtod_latency.
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090608070602070901030305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Subrata,

this is the patch reworked to be applied against the ltp cvs.

Regards
Peppe

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAksGhQcACgkQ2Xo3j31MSSINMACfdqZU48hhlPJETmqJkAKppYdo
HawAoLc0yJ8JB2iQ4JU+ffNXmSaZW+9z
=s7E+
-----END PGP SIGNATURE-----

--------------090608070602070901030305
Content-Type: text/x-patch;
 name="ltp-gtod_latency_iterations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ltp-gtod_latency_iterations.patch"

[PATCH] add iterations option in gtod_latency.

This patch adds a new option for tuning the number
of iterations into the gtod_latency realtime test.

Running gtod_latency on a target with limited resources
it fails (ENOMEM) as soon as it try to allocate the memory
for the two buffers start_data and stop_data.

Tested on i386 and sh4 architectures.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

--- ltp/testcases/realtime/func/gtod_latency/gtod_latency.c.orig	2009-11-20 12:45:57.000000000 +0100
+++ ltp/testcases/realtime/func/gtod_latency/gtod_latency.c	2009-11-20 12:47:39.000000000 +0100
@@ -57,6 +57,7 @@
 #include <sys/mman.h>
 
 #define ITERATIONS 10000000
+#define MIN_ITERATION 10000
 #define HIST_BUCKETS 20
 
 #define SCATTER_FILENAME	0
@@ -82,13 +83,14 @@ char *labels[] = {"scatter plot x-axis",
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
@@ -195,6 +197,15 @@ int stats_cmdline(int argc, char *argv[]
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
@@ -211,9 +222,6 @@ long long timespec_subtract(struct times
 	return ns;
 }
 
-struct timespec start_data[ITERATIONS];
-struct timespec stop_data[ITERATIONS];
-
 int main(int argc, char *argv[])
 {
 	int i, j, k, err;
@@ -224,16 +232,38 @@ int main(int argc, char *argv[])
 	stats_container_t hist;
 	stats_quantiles_t quantiles;
 	stats_record_t rec;
+	struct timespec *start_data;
+	struct timespec *stop_data;
+
+	if (stats_cmdline(argc, argv) < 0) {
+		printf("usage: %s help\n", argv[0]);
+		exit(1);
+	}
+
+	if (iterations < MIN_ITERATION) {
+		iterations = MIN_ITERATION ;
+		printf("user \"iterations\" value is too small (use: %d)\n",
+			iterations);
+	}
 
-	stats_container_init(&dat, ITERATIONS);
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
 
@@ -255,9 +285,9 @@ int main(int argc, char *argv[])
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
@@ -265,7 +295,7 @@ int main(int argc, char *argv[])
 	}
 	/* This loop runs for a long time, hence can cause soft lockups.
 	   Calling sleep periodically avoids this. */
-	for (i=0; i<(ITERATIONS/10000); i++) {
+	for (i = 0; i < (iterations/10000); i++) {
 		for (j=0; j < 10000; j++) {
 			k = (i * 10000) + j;
 			clock_gettime(CLOCK_MONOTONIC,&start_data[k]);
@@ -273,7 +303,7 @@ int main(int argc, char *argv[])
 		}
 		usleep(1000);
 	}
-	for (i = 0; i < ITERATIONS; i++) {
+	for (i = 0; i < iterations; i++) {
 		delta = timespec_subtract(&start_data[i], &stop_data[i]);
 		rec.x = i;
 		rec.y = delta;
@@ -285,7 +315,7 @@ int main(int argc, char *argv[])
 	}
 	if (latency_threshold) {
 		latency_trace_stop();
-		if (i != ITERATIONS) {
+		if (i != iterations) {
 			printf("Latency threshold (%lluus) exceeded at iteration %d\n",
 				latency_threshold, i);
 			latency_trace_print();
@@ -308,5 +338,9 @@ int main(int argc, char *argv[])
 	stats_quantiles_calc(&dat, &quantiles);
 	stats_quantiles_print(&quantiles);
 
+	stats_container_free(&dat);
+	stats_container_free(&hist);
+	stats_quantiles_free(&quantiles);
+
 	return 0;
 }

--------------090608070602070901030305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------090608070602070901030305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090608070602070901030305--

