From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:23 +0100
Subject: [LTP] [COMMITTED] [PATCH 01/23] lib/parse_opts: Get rid of the long
	unused -p and -P options
Message-ID: <20170228111145.3265-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/parse_opts.c | 87 --------------------------------------------------------
 1 file changed, 87 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 3f8b78f..3a879e4 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -51,13 +51,10 @@
 #endif
 
 /* Define flags and args for standard options */
-static int STD_PAUSE = 0;	/* flag indicating to pause before actual start, */
-    /* for contention mode */
 static int STD_INFINITE = 0;	/* flag indciating to loop forever */
 int STD_LOOP_COUNT = 1;		/* number of iterations */
 
 static float STD_LOOP_DURATION = 0.0;	/* duration value in fractional seconds */
-static float STD_LOOP_DELAY = 0.0;	/* loop delay value in fractional seconds */
 
 static char **STD_opt_arr = NULL;	/* array of option strings */
 static int STD_argind = 1;	/* argv index to next argv element */
@@ -90,8 +87,6 @@ static struct std_option_t {
 	{"h", "  -h      Show this help screen\n", NULL, NULL},
 	{"i:", "  -i n    Execute test n times\n", NULL, NULL},
 	{"I:", "  -I x    Execute test for x seconds\n", NULL, NULL},
-	{"p", "  -p      Pause for SIGUSR1 before starting\n", NULL, NULL},
-	{"P:", "  -P x    Pause for x seconds between iterations\n", NULL, NULL},
 #ifdef UCLINUX
 	{"C:",
 	      "  -C ARG  Run the child process with arguments ARG (for internal use)\n",
@@ -213,19 +208,12 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
 			if (STD_LOOP_COUNT == 0)
 				STD_INFINITE = 1;
 			break;
-		case 'P':	/* Delay between iterations */
-			options |= OPT_delay;
-			STD_LOOP_DELAY = atof(optarg);
-			break;
 		case 'I':	/* Time duration */
 			options |= OPT_duration;
 			STD_LOOP_DURATION = atof(optarg);
 			if (STD_LOOP_DURATION == 0.0)
 				STD_INFINITE = 1;
 			break;
-		case 'p':	/* Pause for SIGUSR1 */
-			STD_PAUSE = 1;
-			break;
 		case 'h':	/* Help */
 			print_help(uhf);
 			exit(0);
@@ -345,20 +333,6 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
 			}
 		}
 	}
-	/*
-	 * If the USC_LOOP_DELAY environmental variable is set,
-	 * use that number as delay in factional seconds (same as -P option).
-	 * The -P option with arg will be used even if this env var is set.
-	 */
-	if (!(options & OPT_delay) && (ptr = getenv(USC_LOOP_DELAY)) != NULL) {
-		if (sscanf(ptr, "%f", &ftmp) == 1 && ftmp >= 0.0) {
-			STD_LOOP_DELAY = ftmp;
-			if (Debug)
-				printf
-				    ("Using env %s, set STD_LOOP_DELAY = %f\n",
-				     USC_LOOP_DELAY, ftmp);
-		}
-	}
 
 	/*
 	 * The following are special system testing envs to turn on special
@@ -465,46 +439,20 @@ const char *parse_opts(int ac, char **av, const option_t * user_optarr,
 #if UNIT_TEST
 	printf("The following variables after option and env parsing:\n");
 	printf("STD_LOOP_DURATION   = %f\n", STD_LOOP_DURATION);
-	printf("STD_LOOP_DELAY      = %f\n", STD_LOOP_DELAY);
 	printf("STD_LOOP_COUNT      = %d\n", STD_LOOP_COUNT);
 	printf("STD_INFINITE        = %d\n", STD_INFINITE);
-	printf("STD_PAUSE           = %d\n", STD_PAUSE);
 #endif
 
 	return NULL;
 }
 
-/*
- * routine to goto when we get the SIGUSR1 for STD_PAUSE
- */
-static void STD_go(int sig)
-{
-	(void)sig;
-	return;
-}
-
 /***********************************************************************
  * This function will do desired end of global setup test
  * hooks.
- * Currently it will only do a pause waiting for sigusr1 if
- * STD_PAUSE is set.
- *
  ***********************************************************************/
 int usc_global_setup_hook(void)
 {
 #ifndef UCLINUX
-	/* temp variable to store old signal action to be restored after pause */
-	int (*_TMP_FUNC) (void);
-
-	/*
-	 * pause waiting for sigusr1.
-	 */
-	if (STD_PAUSE) {
-		_TMP_FUNC = (int (*)())signal(SIGUSR1, STD_go);
-		pause();
-		signal(SIGUSR1, (void (*)())_TMP_FUNC);
-	}
-
 	if (STD_TP_sbrk || STD_LP_sbrk)
 		STD_start_break = sbrk(0);	/* get original sbreak size */
 
@@ -548,8 +496,6 @@ int usc_test_looping(int counter)
 {
 	static int first_time = 1;
 	static uint64_t stop_time = 0;
-	static uint64_t delay;
-	uint64_t ct, end;
 	int keepgoing = 0;
 
 	/*
@@ -569,39 +515,6 @@ int usc_test_looping(int counter)
 			    (uint64_t) (USECS_PER_SEC * STD_LOOP_DURATION)
 			    + get_current_time();
 		}
-
-		/*
-		 * If doing delay each iteration, calcuate the number
-		 * of clocks for each delay.
-		 */
-		if (STD_LOOP_DELAY)
-			delay = USECS_PER_SEC * STD_LOOP_DELAY;
-	}
-
-	/*
-	 * if delay each iteration, loop for delay clocks.
-	 * This will not be done on first iteration.
-	 * The delay will happen before determining if
-	 * there will be another iteration.
-	 */
-	else if (STD_LOOP_DELAY) {
-		ct = get_current_time();
-		end = ct + delay;
-		while (ct < end) {
-			/*
-			 * The following are special test hooks in the delay loop.
-			 */
-			if (STD_LD_recfun) {
-				if (Debug)
-					printf
-					    ("calling usc_recressive_func(0, %d, *STD_bigstack)\n",
-					     STD_LD_recfun);
-				usc_recressive_func(0, STD_LD_recfun,
-						    *STD_bigstack);
-			}
-
-			ct = get_current_time();
-		}
 	}
 
 	if (STD_INFINITE)
-- 
2.10.2

