Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1Mfi84-0002xo-G4
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:35:08 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mfi7z-0008R0-Iq
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:35:08 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7OM9bBc015032
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 16:09:37 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7OMAQaj220580
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 16:10:28 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7OMAQG4024205
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 16:10:26 -0600
Message-ID: <4A930FD1.9060903@us.ibm.com>
Date: Mon, 24 Aug 2009 15:10:25 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH][realtime] add support for long options
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Vernon Mauery <vernux@us.ibm.com>

add support for long options

Incorporating existing tests (like pthread_cond_many) may require support
for long options if the existing arguments are to remain supported.  This
patch adds support for long options, while keeping the default of only
short options in place.  long opts MUST have an equivalent short opt so
as to not require changing (and complicating) the parse_arg signature.
This patch tests for this in the rt_init routine.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Vernon Mauery <vernux@us.ibm.com>

---
 include/librttest.h |   12 ++++++++++--
 lib/librttest.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 6 deletions(-)

Index: realtime/include/librttest.h
===================================================================
--- realtime.orig/include/librttest.h
+++ realtime/include/librttest.h
@@ -235,10 +235,12 @@ static volatile int _debug_count = 0;
 /* rt_help: print help for standard args */
 void rt_help();
 
-/* rt_init: initialize librttest
+/* rt_init_long: initialize librttest
  * options: pass in an getopt style string of options -- e.g. "ab:cd::e:"
  *          if this or parse_arg is null, no option parsing will be done
  *          on behalf of the calling program (only internal args will be parsed)
+ * longopts: a pointer to the first element of an array of struct option, the
+ *           last entry must be set to all zeros.
  * parse_arg: a function that will get called when one of the above
  *            options is encountered on the command line.  It will be passed
  *            the option -- e.g. 'b' -- and the value.  Something like:
@@ -267,7 +269,13 @@ void rt_help();
  * argc: passed from main
  * argv: passed from main
  */
-int rt_init(const char *options, int (*parse_arg)(int option, char *value), int argc, char *argv[]);
+int rt_init_long(const char *options, const struct option *longopts,
+		 int (*parse_arg)(int option, char *value),
+		 int argc, char *argv[]);
+
+/* rt_init: same as rt_init_long with no long options */
+int rt_init(const char *options, int (*parse_arg)(int option, char *value),
+	    int argc, char *argv[]);
 
 int create_thread(void*(*func)(void*), void *arg, int prio, int policy);
 
Index: realtime/lib/librttest.c
===================================================================
--- realtime.orig/lib/librttest.c
+++ realtime/lib/librttest.c
@@ -99,9 +99,13 @@ void calibrate_busyloop(void)
 	iters_per_us = (CALIBRATE_LOOPS * NS_PER_US) / (end-start);
 }
 
-int rt_init(const char *options, int (*parse_arg)(int option, char *value), int argc, char *argv[])
+int rt_init_long(const char *options, const struct option *longopts,
+		 int (*parse_arg)(int option, char *value), int argc,
+		 char *argv[])
 {
+	const struct option *cur_opt;
 	int use_buffer = 1;
+	char *longopt_vals;
 	size_t i;
 	int c;
 	opterr = 0;
@@ -126,8 +130,33 @@ int rt_init(const char *options, int (*p
 			exit(1);
 		}
 	}
+
+	/* Ensure each long options has a known unique short option in val. */
+	longopt_vals = "";
+	cur_opt = longopts;
+	while (cur_opt && cur_opt->name) {
+		if (cur_opt->flag) {
+			fprintf(stderr, "Programmer error -- argument --%s flag"
+				" is non-null\n", cur_opt->name);
+			exit(1);
+		}
+		if (!strchr(all_options, cur_opt->val)) {
+			fprintf(stderr, "Progreammer error -- argument --%s "
+				"shortopt -%c wasn't listed in options (%s)\n",
+				cur_opt->name, cur_opt->val, all_options);
+			exit(1);
+		}
+		if (strchr(longopt_vals, cur_opt->val)) {
+			fprintf(stderr, "Programmer error -- argument --%s "
+				"shortopt -%c is used more than once\n",
+				cur_opt->name, cur_opt->val);
+			exit(1);
+		}
+		asprintf(&longopt_vals, "%s%c", longopt_vals, cur_opt->val);
+		cur_opt++;
+	}
 	
-	while ((c = getopt(argc, argv, all_options)) != -1) {
+	while ((c = getopt_long(argc, argv, all_options, longopts, NULL)) != -1) {
 		switch (c) {
 		case 'c':
 			pass_criteria = atof(optarg);
@@ -148,11 +177,17 @@ int rt_init(const char *options, int (*p
 			save_stats = 1;
 			break;
 		case ':':
-			fprintf(stderr, "option -%c: missing arg\n", optopt);
+			if (optopt == '-')
+				fprintf(stderr, "long option missing arg\n");
+			else
+				fprintf(stderr, "option -%c: missing arg\n", optopt);
 			parse_arg('h', optarg); /* Just to display usage */
 			exit (1); /* Just in case. (should normally be done by usage()) */
 		case '?':
-			fprintf(stderr, "option -%c not recognized\n", optopt);
+			if (optopt == '-')
+				fprintf(stderr, "unrecognized long option\n");
+			else
+				fprintf(stderr, "option -%c not recognized\n", optopt);
 			parse_arg('h', optarg); /* Just to display usage */
 			exit (1); /* Just in case. (should normally be done by usage()) */
 		default:
@@ -185,6 +220,12 @@ int rt_init(const char *options, int (*p
 	return 0;
 }
 
+int rt_init(const char *options, int (*parse_arg)(int option, char *value),
+	    int argc, char *argv[])
+{
+	return rt_init_long(options, NULL, parse_arg, argc, argv);
+}
+
 void buffer_init(void)
 {
 	_print_buffer = (char *)malloc(PRINT_BUFFER_SIZE);
-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
