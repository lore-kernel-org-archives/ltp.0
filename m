Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MBD3R-0004ea-BQ
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 19:20:17 +0000
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2AA528726A
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Jun 2009 21:20:07 +0200 (CEST)
Date: Mon, 1 Jun 2009 21:20:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090601192006.GA26914@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Subject: [LTP] [PATCH] test library cleanups
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch does:
================

Removing no longer used code from test.h eg. test_error.c is no longer in ltp,
and the same for t_res.c so there is no need to include function prototypes for
these.

Adding void to functions that doesn't take any parameters; tst_exit() ->
tst_exit(void); so code that pases parameters to these is not compileable any
more.

Also fixes all test broken by that change. As parameters passed to tst_exit()
are ignored anyway it's quite safe to just remove them; but I'would rather see
someone take a closer look.

Code cleanups and fixes in tst_res.c:

* removed trivial and useless comments
* cleaned coding style
* and much more

TODO: there is much redundant code in tst_res.c I'll eliminate that by static
functions 

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--OXfL5xGRrasGEqWY
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_tests_lib.patch"

Index: ltp-full-20090430/include/compiler.h
===================================================================
--- ltp-full-20090430.orig/include/compiler.h
+++ ltp-full-20090430/include/compiler.h
@@ -7,10 +7,10 @@
 #ifndef __LTP_COMPILER_H__
 #define __LTP_COMPILER_H__
 
-#define attribute_noreturn __attribute__((noreturn))
+#define LTP_ATTRIBUTE_NORETURN __attribute__((noreturn))
 
 #ifndef ARRAY_SIZE
-# define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+	#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 #endif
 
-#endif
+#endif /* __LTP_COMPILER_H__ */
Index: ltp-full-20090430/include/test.h
===================================================================
--- ltp-full-20090430.orig/include/test.h
+++ ltp-full-20090430/include/test.h
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * 
+ * Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
  * published by the Free Software Foundation.
@@ -131,36 +132,6 @@
 					/* environment variable to desired path */
 
 /*
- * The following contains support for error message passing.
- * See test_error.c for details.
- */
-#define  TST_ERR_MESG_SIZE      1023    /* max size of error message */
-#define  TST_ERR_FILE_SIZE      511     /* max size of module name used by compiler */
-#define  TST_ERR_FUNC_SIZE      127     /* max size of func name */
-
-typedef struct {
-    int  te_line;                       /* line where last error was reported.  Use */
-                                        /* "__LINE__" and let compiler do the rest */
-    int  te_level;                      /* If set, will prevent current stored */
-                                        /* error to not be overwritten */
-    char te_func[TST_ERR_FUNC_SIZE+1];  /* name of function of last error */
-                                        /* Name of function or NULL */
-    char te_file[TST_ERR_FILE_SIZE+1];  /* module of last error.  Use */
-                                        /* "__FILE__" and let compiler do the rest */
-    char te_mesg[TST_ERR_MESG_SIZE+1];  /* string of last error */
-
-} _TST_ERROR;
-
-extern _TST_ERROR Tst_error;            /* defined in test_error.c */
-#if __STDC__
-extern void tst_set_error(char *file, int line, char *func, char *fmt, ...);
-#else
-extern void tst_set_error();
-#endif
-extern void tst_clear_error();
-
-
-/*
  * The following define contains the name of an environmental variable
  * that can be used to specify the number of iterations.
  * It is supported in parse_opts.c and USC_setup.c.
@@ -206,42 +177,63 @@ extern void tst_clear_error();
 #endif
 
 /*
- * The following prototypes are needed to remove compile errors
- * on IRIX systems when compiled with -n32 and -64.
+ * Functions from lib/tst_res.c
+ */
+void tst_res(int ttype, char *fname, char *arg_fmt, ...);
+void tst_resm(int ttype, char *arg_fmt, ...);
+void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...);
+void tst_brkloop(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...);
+void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...);
+void tst_brkloopm(int ttype, void (*func)(void), char *arg_fmt, ...);
+void tst_require_root(void (*func)(void));
+int  tst_environ(void);
+void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
+void tst_flush(void);
+
+extern int Tst_count;
+
+/*
+ * Function from lib/tst_sig.c
+ */
+void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
+
+/*
+ * Functions from lib/tst_tmpdir.c
  */
-extern void tst_res(int ttype, char *fname, char *arg_fmt, ...);
-extern void tst_resm(int ttype, char *arg_fmt, ...);
-extern void tst_brk(int ttype, char *fname, void (*func)(), 
-							char *arg_fmt, ...);
-extern void tst_brkloop(int ttype, char *fname, void (*func)(), 
-							char *arg_fmt, ...);
-extern void tst_brkm(int ttype, void (*func)(), char *arg_fmt, ...);
-extern void tst_brkloopm(int ttype, void (*func)(), char *arg_fmt, ...);
-extern void tst_require_root(void (*func)());
-
-extern int  tst_environ();
-extern void tst_exit() attribute_noreturn;
-extern void tst_flush();
-
-/* prototypes for the t_res.c functions */
-extern void t_result(char *tcid, int tnum, int ttype, char *tmesg);
-extern void tt_exit();
-extern int  t_environ();
-extern void t_breakum(char *tcid, int total, int typ, char *msg, void (*fnc)());
-
-extern void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
-extern void tst_tmpdir();
-extern void tst_rmdir();
-
-extern char * get_high_address(void);
-
-extern void get_kver(int*, int*, int*);
-extern int tst_kvercmp(int, int, int);
-extern int tst_is_cwd_nfs();
-extern int tst_is_cwd_tmpfs();
-extern int tst_cwd_has_free(int required_kib);
+void tst_tmpdir(void);
+void tst_rmdir(void);
 
+/*
+ * Function from lib/get_high_address.c
+ */
+char *get_high_address(void);
 
+/*
+ * Functions from lib/tst_kvercmp.c
+ */
+void tst_getkver(int *k1, int *k2, int *k3);
+int tst_kvercmp(int r1, int r2, int r3);
+
+/*
+ * Function from lib/tst_is_cwd_nfs.c
+ */
+int tst_is_cwd_nfs(void);
+
+/*
+ * Function from lib/tst_is_cwd_tmpfs.c
+ */
+int tst_is_cwd_tmpfs(void);
+
+/*
+ * Function from lib/tst_cwd_has_free.c
+ */
+int tst_cwd_has_free(int required_kib);
+
+/*
+ * Functions from lib/self_exec.c
+ */
+void maybe_run_child(void (*child)(), char *fmt, ...);
+int self_exec(char *argv0, char *fmt, ...);
 
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
@@ -250,14 +242,6 @@ extern int tst_cwd_has_free(int required
 #else
 #define TCID_BIT_SUFFIX ""
 #endif
-#define TCID_DEFINE(ID) \
-  char *TCID = (#ID TCID_BIT_SUFFIX)
-
-
-extern int Tst_count;
-
-/* self_exec.c functions */
-void maybe_run_child(void (*child)(), char *fmt, ...);
-int self_exec(char *argv0, char *fmt, ...);
+#define TCID_DEFINE(ID) char *TCID = (#ID TCID_BIT_SUFFIX)
 
-#endif	/* end of __TEST_H__ */
+#endif	/* __TEST_H__ */
Index: ltp-full-20090430/lib/tst_res.c
===================================================================
--- ltp-full-20090430.orig/lib/tst_res.c
+++ ltp-full-20090430/lib/tst_res.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * 
+ * Copyring  (c) 2009 Cyril Hrubis chrubis@suse.cz
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
  * published by the Free Software Foundation.
@@ -101,22 +102,20 @@
  *
  *    DATE STARTED      : 05/01/90 (rewritten 1/96)
  *
+ *    MAJOR CLEANUPS BY : Cyril Hrubis
+ *
  *    DESCRIPTION
  *      See the man page(s).
  *
  *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
 #include <errno.h>
 #include <string.h>
-#include <stdio.h>         /* for I/O functions, BUFSIZ */
-#include <stdlib.h>        /* for getenv() */
-#include <stdarg.h>        /* for varargs stuff */
-#include <unistd.h>        /* for access() */
-#include "test.h"          /* for output display mode & result type */
-                           /* defines */
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include "test.h"
 
-/*
- * Define some useful macros.
- */
 #define VERBOSE      1     /* flag values for the T_mode variable */
 #define CONDENSE     2
 #define NOPASS       3
@@ -134,7 +133,7 @@
 #define EXPAND_VAR_ARGS(arg_fmt, str) {   \
    va_list ap; /* varargs mechanism */    \
                                           \
-   if ( arg_fmt != NULL ) {               \
+   if (arg_fmt != NULL) {                 \
       if ( Expand_varargs == TRUE ) {     \
          va_start(ap, arg_fmt);           \
          vsprintf(str, arg_fmt, ap);      \
@@ -145,12 +144,12 @@
    } else {                               \
       str[0] = '\0';                      \
    }                                      \
-}  /* EXPAND_VAR_ARGS() */
+}
 
 /*
  * Define local function prototypes.
  */
-static void check_env();
+static void check_env(void);
 static void tst_condense(int tnum, int ttype, char *tmesg);
 static void tst_print(char *tcid, int tnum, int trange, int ttype, char *tmesg);
 static void cat_file(char *filename);
@@ -214,108 +213,84 @@ char *TESTDIR = NULL;
  *             All result functions (tst_resm(), tst_brk(), etc.)
  *             eventually get here to print the results.
  */
-void
-tst_res(int ttype, char *fname, char *arg_fmt, ...)
+void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 {
-   int  i;
-   char tmesg[USERMESG];     /* expanded message */
+	int  i;
+	char tmesg[USERMESG];
 
 #if DEBUG
-   printf("IN tst_res; Tst_count = %d; Tst_range = %d\n",
-          Tst_count, Tst_range); fflush(stdout);
-#endif
-
-   /*
-    * Expand the arg_fmt string into tmesg, if necessary.
-    */
-   EXPAND_VAR_ARGS(arg_fmt, tmesg);
-
-   /*
-    * Save the test result type by ORing ttype into the current exit
-    * value (used by tst_exit()).
-    */
-   T_exitval |= ttype;
-
-   /*
-    * Unless T_out has already been set by tst_environ(), make tst_res()
-    * output go to standard output.
-    */
-   if ( T_out == NULL )
-       T_out = stdout;
-
-   /*
-    * Check TOUTPUT environment variable (if first time) and set T_mode
-    * flag.
-    */
-   check_env();
-
-   /*
-    * A negative or NULL range is invalid.
-    */
-   if ( Tst_range <= 0 ) {
-      Tst_range = 1;
-      tst_print(TCID, 0, 1, TWARN,
-                "tst_res(): Tst_range must be positive");
-   }
-
-   /*
-    * If a filename was specified, set 'File' if it exists.
-    */
-   if ( fname != NULL && access(fname, F_OK) == 0 )
-      File = fname;
-
-   /*
-    * Set the test case number and print the results, depending on the
-    * display type.
-    */
-   if ( ttype == TWARN || ttype == TINFO ) {
-      /*
-       * Handle WARN and INFO results (test case number is 0).
-       */
-      if ( Tst_range > 1 ) {
-         tst_print(TCID, 0, 1, TWARN,
-                   "tst_res(): Range not valid for TINFO or TWARN types");
-      }
-      tst_print(TCID, 0, 1, ttype, tmesg);
-   } else {
-      /*
-       * Handle all other types of results other than WARN and INFO.
-       */
-      if ( Tst_count < 0 )
-         tst_print(TCID, 0, 1, TWARN,
-                   "tst_res(): Tst_count < 0 is not valid");
-
-      /*
-       * Process each display type.
-       */
-      switch ( T_mode ) {
-      case DISCARD:
-         /* do not print any results */
-         break;
-
-      case NOPASS:   /* passing result types are filtered by tst_print() */
-      case CONDENSE:
-         tst_condense(Tst_count + 1, ttype, tmesg);
-         break;
-
-      default: /* VERBOSE */
-         for ( i = 1 ; i <= Tst_range ; i++ )
-            tst_print(TCID, Tst_count + i, Tst_range, ttype, tmesg);
-         break;
-      }  /* end switch() */
-
-      /*
-       * Increment Tst_count.
-       */
-      Tst_count += Tst_range;
-   }  /* if ( ttype == TWARN || ttype == TINFO ) */
-
-   /*
-    * Reset some values.
-    */
-   Tst_range = 1;
-   Expand_varargs = TRUE;
-}  /* tst_res() */
+	printf("IN tst_res; Tst_count = %d; Tst_range = %d\n",
+	       Tst_count, Tst_range); fflush(stdout);
+#endif
+
+	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+
+	/*
+	 * Save the test result type by ORing ttype into the current exit
+	 * value (used by tst_exit()).
+	 */
+	T_exitval |= ttype;
+
+	/*
+	 * Unless T_out has already been set by tst_environ(), make tst_res()
+	 * output go to standard output.
+	 */
+	if (T_out == NULL)
+		T_out = stdout;
+
+	/*
+	 * Check TOUTPUT environment variable (if first time) and set T_mode
+	 * flag.
+	 */
+	check_env();
+
+	if (Tst_range <= 0) {
+		Tst_range = 1;
+		tst_print(TCID, 0, 1, TWARN,
+			  "tst_res(): Tst_range must be positive");
+	}
+
+	if (fname != NULL && access(fname, F_OK) == 0)
+		File = fname;
+
+	/*
+	 * Set the test case number and print the results, depending on the
+	 * display type.
+	 */
+	if (ttype == TWARN || ttype == TINFO) {
+		if (Tst_range > 1)
+			tst_print(TCID, 0, 1, TWARN,
+				  "tst_res(): Range not valid for TINFO or TWARN types");
+		tst_print(TCID, 0, 1, ttype, tmesg);
+	} else {
+		if (Tst_count < 0)
+			tst_print(TCID, 0, 1, TWARN,
+				  "tst_res(): Tst_count < 0 is not valid");
+
+		/*
+		 * Process each display type.
+		 */
+		switch (T_mode) {
+			case DISCARD: /* do not print any results */
+			break;
+
+			case NOPASS:  /* passing result types are filtered by tst_print() */
+			case CONDENSE:
+				tst_condense(Tst_count + 1, ttype, tmesg);
+			break;
+
+			default:      /* VERBOSE */
+				for (i = 1 ; i <= Tst_range ; i++)
+					tst_print(TCID, Tst_count + i, Tst_range, ttype, tmesg);
+			break;
+		}
+
+		Tst_count += Tst_range;
+	}
+
+	Tst_range = 1;
+	Expand_varargs = TRUE;
+}
 
 
 /*
@@ -325,169 +300,167 @@ tst_res(int ttype, char *fname, char *ar
  *                  specified, print the current result and do not
  *                  buffer it.
  */
-static void
-tst_condense(int tnum, int ttype, char *tmesg)
+static void tst_condense(int tnum, int ttype, char *tmesg)
 {
-   char *file;
+	char *file;
 
 #if DEBUG
-   printf("IN tst_condense: tcid = %s, tnum = %d, ttype = %d, tmesg = %s\n",
-          TCID, tnum, ttype, tmesg);
-   fflush(stdout);
-#endif
-
-   /*
-    * If this result is the same as the previous result, return.
-    */
-   if ( Buffered == TRUE ) {
-      if ( strcmp(Last_tcid, TCID) == 0 && Last_type == ttype &&
-           strcmp(Last_mesg, tmesg) == 0 && File == NULL )
-         return;
-
-      /*
-       * This result is different from the previous result.  First,
-       * print the previous result.
-       */
-      file = File;
-      File = NULL;
-      tst_print(Last_tcid, Last_num, tnum - Last_num, Last_type,
-                Last_mesg);
-      free(Last_tcid);
-      free(Last_mesg);
-      File = file;
-   }  /* if ( Buffered == TRUE ) */
-
-   /*
-    * If a file was specified, print the current result since we have no
-    * way of retaining the file contents for comparing with future
-    * results.  Otherwise, buffer the current result info for next time.
-    */
-   if ( File != NULL ) {
-      tst_print(TCID, tnum, Tst_range, ttype, tmesg);
-      Buffered = FALSE;
-   } else {
-      Last_tcid = (char *)malloc(strlen(TCID) + 1);
-      strcpy(Last_tcid, TCID);
-      Last_num = tnum;
-      Last_type = ttype;
-      Last_mesg = (char *)malloc(strlen(tmesg) + 1);
-      strcpy(Last_mesg, tmesg);
-      Buffered = TRUE;
-   }
-}  /* tst_condense() */
+	printf("IN tst_condense: tcid = %s, tnum = %d, ttype = %d, tmesg = %s\n",
+	       TCID, tnum, ttype, tmesg);
+	fflush(stdout);
+#endif
+
+	/*
+	 * If this result is the same as the previous result, return.
+	 */
+	if (Buffered == TRUE) {
+		if (strcmp(Last_tcid, TCID) == 0 && Last_type == ttype &&
+		    strcmp(Last_mesg, tmesg) == 0 && File == NULL )
+			return;
+
+		/*
+		 * This result is different from the previous result.  First,
+		 * print the previous result.
+		 */
+		file = File;
+		File = NULL;
+		tst_print(Last_tcid, Last_num, tnum - Last_num, Last_type,
+			  Last_mesg);
+		free(Last_tcid);
+		free(Last_mesg);
+		File = file;
+	}
+
+	/*
+	 * If a file was specified, print the current result since we have no
+	 * way of retaining the file contents for comparing with future
+	 * results.  Otherwise, buffer the current result info for next time.
+	 */
+	if (File != NULL) {
+		tst_print(TCID, tnum, Tst_range, ttype, tmesg);
+		Buffered = FALSE;
+	} else {
+		Last_tcid = (char *)malloc(strlen(TCID) + 1);
+		strcpy(Last_tcid, TCID);
+		Last_num = tnum;
+		Last_type = ttype;
+		Last_mesg = (char *)malloc(strlen(tmesg) + 1);
+		strcpy(Last_mesg, tmesg);
+		Buffered = TRUE;
+	}
+}
 
 
 /*
  * tst_flush() - Print any messages pending because of CONDENSE mode,
  *               and flush T_out.
  */
-void
-tst_flush()
+void tst_flush(void)
 {
 #if DEBUG
-   printf("IN tst_flush\n");
-   fflush(stdout);
+	printf("IN tst_flush\n");
+	fflush(stdout);
 #endif
 
-   /*
-    * Print out last line if in CONDENSE or NOPASS mode.
-    */
-   if ( Buffered == TRUE && (T_mode == CONDENSE || T_mode == NOPASS) ) {
-      tst_print(Last_tcid, Last_num, Tst_count - Last_num + 1,
-                Last_type, Last_mesg);
-      Buffered = FALSE;
-   }
-   fflush(T_out);
-}  /* tst_flush() */
+	/*
+	 * Print out last line if in CONDENSE or NOPASS mode.
+	 */
+	if (Buffered == TRUE && (T_mode == CONDENSE || T_mode == NOPASS)) {
+		tst_print(Last_tcid, Last_num, Tst_count - Last_num + 1,
+			  Last_type, Last_mesg);
+		Buffered = FALSE;
+	}
+
+	fflush(T_out);
+}
 
 
 /*
  * tst_print() - Actually print a line or range of lines to the output
  *               stream.
  */
-static void
-tst_print(char *tcid, int tnum, int trange, int ttype, char *tmesg)
+static void tst_print(char *tcid, int tnum, int trange, int ttype, char *tmesg)
 {
-   char type[5];
+	char type[5];
 
 #if DEBUG
-   printf("IN tst_print: tnum = %d, trange = %d, ttype = %d, tmesg = %s\n",
-          tnum, trange, ttype, tmesg);
-   fflush(stdout);
-#endif
-
-   /*
-    * Save the test result type by ORing ttype into the current exit
-    * value (used by tst_exit()).  This is already done in tst_res(), but
-    * is also done here to catch internal warnings.  For internal warnings, 
-    * tst_print() is called directly with a case of TWARN.
-    */
-   T_exitval |= ttype;
-
-   /*
-    * If output mode is DISCARD, or if the output mode is NOPASS and
-    * this result is not one of FAIL, BROK, or WARN, just return.  This
-    * check is necessary even though we check for DISCARD mode inside of
-    * tst_res(), since occasionally we get to this point without going
-    * through tst_res() (e.g. internal TWARN messages).
-    */
-   if ( T_mode == DISCARD || (T_mode == NOPASS && ttype != TFAIL &&
-                              ttype != TBROK && ttype != TWARN) )
-      return;
-
-   /*
-    * Fill in the type string according to ttype.
-    */
-   switch ( ttype ) {
-   case TPASS:
-      strcpy(type, "PASS");
-      break;
-   case TFAIL:
-      strcpy(type, "FAIL");
-      break;
-   case TBROK:
-      strcpy(type, "BROK");
-      break;
-   case TRETR:
-      strcpy(type, "RETR");
-      break;
-   case TCONF:
-      strcpy(type, "CONF");
-      break;
-   case TWARN:
-      strcpy(type, "WARN");
-      break;
-   case TINFO:
-      strcpy(type, "INFO");
-      break;
-   default:
-      strcpy(type, "????");
-      break;
-   }  /* switch ( ttype ) */
-
-   /*
-    * Build the result line and print it.
-    */
-   if ( T_mode == VERBOSE ) {
-      fprintf(T_out, "%-8s %4d  %s  :  %s\n", tcid, tnum, type, tmesg);
-   } else {
-      /* condense results if a range is specified */
-      if ( trange > 1 )
-         fprintf(T_out, "%-8s %4d-%-4d  %s  :  %s\n",
-                 tcid, tnum, tnum + trange - 1, type, tmesg);
-      else
-         fprintf(T_out, "%-8s %4d       %s  :  %s\n",
-                 tcid, tnum, type, tmesg);
-   }
-
-   /*
-    * If tst_res() was called with a file, append file contents to the
-    * end of last printed result.
-    */
-   if ( File != NULL )
-      cat_file(File);
-   File = NULL;
-}  /* tst_print() */
+	printf("IN tst_print: tnum = %d, trange = %d, ttype = %d, tmesg = %s\n",
+	       tnum, trange, ttype, tmesg);
+	fflush(stdout);
+#endif
+
+	/*
+	 * Save the test result type by ORing ttype into the current exit value
+	 * (used by tst_exit()).  This is already done in tst_res(), but is
+	 * also done here to catch internal warnings.  For internal warnings,
+	 * tst_print() is called directly with a case of TWARN.
+	 */
+	T_exitval |= ttype;
+
+	/*
+	 * If output mode is DISCARD, or if the output mode is NOPASS and this
+	 * result is not one of FAIL, BROK, or WARN, just return.  This check
+	 * is necessary even though we check for DISCARD mode inside of
+	 * tst_res(), since occasionally we get to this point without going
+	 * through tst_res() (e.g. internal TWARN messages).
+	 */
+	if (T_mode == DISCARD || (T_mode == NOPASS && ttype != TFAIL &&
+	    ttype != TBROK && ttype != TWARN))
+		return;
+
+	/*
+	 * Fill in the type string according to ttype.
+	 */
+	switch (ttype) {
+		case TPASS:
+			strcpy(type, "PASS");
+		break;
+		case TFAIL:
+			strcpy(type, "FAIL");
+		break;
+		case TBROK:
+			strcpy(type, "BROK");
+		break;
+		case TRETR:
+			strcpy(type, "RETR");
+		break;
+		case TCONF:
+			strcpy(type, "CONF");
+		break;
+		case TWARN:
+			strcpy(type, "WARN");
+		break;
+		case TINFO:
+			strcpy(type, "INFO");
+		break;
+		default:
+			strcpy(type, "????");
+		break;
+	}
+
+	/*
+	 * Build the result line and print it.
+	 */
+	if (T_mode == VERBOSE) {
+		fprintf(T_out, "%-8s %4d  %s  :  %s\n", tcid, tnum, type, tmesg);
+	} else {
+		if (trange > 1)
+			fprintf(T_out, "%-8s %4d-%-4d  %s  :  %s\n",
+				tcid, tnum, tnum + trange - 1, type, tmesg);
+		else
+			fprintf(T_out, "%-8s %4d       %s  :  %s\n",
+				tcid, tnum, type, tmesg);
+	}
+
+	/*
+	 * If tst_res() was called with a file, append file contents to the
+	 * end of last printed result.
+	 */
+	if (File != NULL)
+		cat_file(File);
+
+	File = NULL;
+}
 
 
 /*
@@ -497,38 +470,46 @@ tst_print(char *tcid, int tnum, int tran
  *               "NOPASS", or "DISCARD".  If TOUTPUT does not exist or
  *               is not set to a valid value, the default is "VERBOSE".
  */
-static void
-check_env()
+static void check_env(void)
 {
-   static int first_time = 1;
-   char       *value;      /* value of TOUTPUT environment variable */
+	static int first_time = 1;
+	char      *value;
 
 #if DEBUG
-   printf("IN check_env\n");
-   fflush(stdout);
-#endif
-
-   if ( !first_time )
-      return;
-
-   first_time = 0;
-
-   if ( (value = getenv(TOUTPUT)) == NULL ) {
-      /* TOUTPUT not defined, use default */
-      T_mode = VERBOSE;
-   } else if ( strcmp(value, TOUT_CONDENSE_S) == 0 ) {
-      T_mode = CONDENSE;
-   } else if ( strcmp(value, TOUT_NOPASS_S) == 0 ) {
-      T_mode = NOPASS;
-   } else if ( strcmp(value, TOUT_DISCARD_S) == 0 ) {
-      T_mode = DISCARD;
-   } else {
-      /* default */
-      T_mode = VERBOSE;
-   }
+	printf("IN check_env\n");
+	fflush(stdout);
+#endif
+
+	if (!first_time)
+		return;
 
-   return;
-}  /* check_env() */
+	first_time = 0;
+
+	/* TOUTPUT not defined, use default */
+  	if ((value = getenv(TOUTPUT)) == NULL) {
+		T_mode = VERBOSE;
+		return;
+	}
+
+	if (strcmp(value, TOUT_CONDENSE_S) == 0) {
+		T_mode = CONDENSE;
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
 
 
 /*
@@ -538,343 +519,274 @@ check_env()
  *              TBROK, TWARN, TCONF).  Also, print the last result (if
  *              necessary) before exiting.
  */
-void
-tst_exit()
+void tst_exit(void)
 {
 #if DEBUG
-   printf("IN tst_exit\n"); fflush(stdout);
-   fflush(stdout);
+	printf("IN tst_exit\n"); fflush(stdout);
+	fflush(stdout);
 #endif
 
-   /*
-    * Call tst_flush() flush any ouput in the buffer or the last
-    * result not printed because of CONDENSE mode.
-    */
-   tst_flush();
+	/*
+	 * Call tst_flush() flush any ouput in the buffer or the last
+	 * result not printed because of CONDENSE mode.
+	 */
+	tst_flush();
 
-   /*
-    * Mask out TRETR, TINFO, and TCONF results from the exit status.
-    */
-   exit(T_exitval & ~(TRETR | TINFO | TCONF));
-}  /* tst_exit() */
+	/*
+	 * Mask out TRETR, TINFO, and TCONF results from the exit status.
+	 */
+	exit(T_exitval & ~(TRETR | TINFO | TCONF));
+}
 
 
 /*
  * tst_environ() - Preserve the tst_res() output location, despite any
  *                 changes to stdout.
  */
-int
-tst_environ()
+int tst_environ(void)
 {
-   if ( (T_out = fdopen(dup(fileno(stdout)), "w")) == NULL )
-      return(-1);
-   else
-      return(0);
-}  /* tst_environ() */
+	if ((T_out = fdopen(dup(fileno(stdout)), "w")) == NULL)
+		return -1;
+	else
+		return 0;
+}
 
 
 /*
  * tst_brk() - Fail or break current test case, and break the remaining
  *             tests cases.
  */
-void
-tst_brk(int ttype, char *fname, void (*func)(), char *arg_fmt, ...)
+void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
 {
-   char    tmesg[USERMESG];      /* expanded message */
+	char tmesg[USERMESG];
 
 #if DEBUG
-   printf("IN tst_brk\n"); fflush(stdout);
-   fflush(stdout);
+	printf("IN tst_brk\n"); fflush(stdout);
+	fflush(stdout);
 #endif
 
-   /*
-    * Expand the arg_fmt string into tmesg, if necessary.
-    */
-   EXPAND_VAR_ARGS(arg_fmt, tmesg);
-
-   /*
-    * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
-    */
-   if ( ttype != TFAIL && ttype != TBROK && ttype != TCONF &&
-        ttype != TRETR ) {
-      sprintf(Warn_mesg, "tst_brk(): Invalid Type: %d.  Using TBROK",
-              ttype);
-      tst_print(TCID, 0, 1, TWARN, Warn_mesg);
-      ttype = TBROK;
-   }
-
-   /*
-    * Print the first result, if necessary.
-    */
-   if ( Tst_count < TST_TOTAL )
-     tst_res(ttype, fname, "%s", tmesg);
-
-   /*
-    * Determine the number of results left to report.
-    */
-   Tst_range = TST_TOTAL - Tst_count;
-
-   /*
-    * Print the rest of the results, if necessary.
-    */
-   if ( Tst_range > 0 ) {
-      if ( ttype == TCONF )
-         tst_res(ttype, NULL,
-                 "Remaining cases not appropriate for configuration");
-      else if ( ttype == TRETR )
-         tst_res(ttype, NULL, "Remaining cases retired");
-      else
-         tst_res(TBROK, NULL, "Remaining cases broken");
-   } else {
-      Tst_range = 1;
-      Expand_varargs = TRUE;
-   }  /* if ( Tst_range > 0 ) */
-
-   /*
-    * If no cleanup function was specified, just return to the caller.
-    * Otherwise call the specified function.  If specified function
-    * returns, call tst_exit().
-    */
-   if ( func != NULL ) {
-      (*func)();
-      tst_exit();
-   }
-
-   return;
-}  /* tst_brk() */
+	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+
+	/*
+	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
+	 */
+	if (ttype != TFAIL && ttype != TBROK && ttype != TCONF &&
+	    ttype != TRETR ) {
+		sprintf(Warn_mesg, "tst_brk(): Invalid Type: %d.  Using TBROK",
+			ttype);
+		tst_print(TCID, 0, 1, TWARN, Warn_mesg);
+		ttype = TBROK;
+	}
+
+	/* Print the first result, if necessary. */
+	if (Tst_count < TST_TOTAL)
+		tst_res(ttype, fname, "%s", tmesg);
+
+	/* Determine the number of results left to report. */
+	Tst_range = TST_TOTAL - Tst_count;
+
+	/* Print the rest of the results, if necessary. */
+	if (Tst_range > 0) {
+		if (ttype == TCONF) {
+			tst_res(ttype, NULL,
+				"Remaining cases not appropriate for configuration");
+		} else {
+				if ( ttype == TRETR )
+					tst_res(ttype, NULL, "Remaining cases retired");
+				else
+					tst_res(TBROK, NULL, "Remaining cases broken");
+		}
+	} else {
+		Tst_range = 1;
+		Expand_varargs = TRUE;
+	}
+
+	/*
+	 * If no cleanup function was specified, just return to the caller.
+	 * Otherwise call the specified function.  If specified function
+	 * returns, call tst_exit().
+	 */
+	if (func != NULL) {
+		(*func)();
+		tst_exit();
+	}
+}
 
 
 /*
  * tst_brkloop() - Fail or break current test case, and break the
  *                 remaining test cases within test case loop.
  */
-void
-tst_brkloop(int ttype, char *fname, void (*func)(), char *arg_fmt, ...)
+void tst_brkloop(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
 {
-   char    tmesg[USERMESG];      /* expanded message */
+	char tmesg[USERMESG];
 
 #if DEBUG
-   printf("IN tst_brkloop\n"); fflush(stdout);
-   fflush(stdout);
+	printf("IN tst_brkloop\n"); fflush(stdout);
+	fflush(stdout);
 #endif
 
-   /*
-    * Expand the arg_fmt string into tmesg.
-    */
-   EXPAND_VAR_ARGS(arg_fmt, tmesg);
-
-   /*
-    * Verify that Tst_lpstart & Tst_lptotal are valid.
-    */
-   if ( Tst_lpstart < 0 || Tst_lptotal < 0 ) {
-      tst_print(TCID, 0, 1, TWARN,
-                "tst_brkloop(): Tst_lpstart & Tst_lptotal must both be assigned non-negative values");
-      Expand_varargs = TRUE;
-      return;
-   }
-
-   /*
-    * Only FAIL, BROK, CONF, and RETR are supported by tst_brkloop().
-    */
-   if ( ttype != TFAIL && ttype != TBROK && ttype != TCONF &&
-        ttype != TRETR ) {
-      sprintf(Warn_mesg,
-              "tst_brkloop(): Invalid Type: %d.  Using TBROK",
-              ttype);
-      tst_print(TCID, 0, 1, TWARN, Warn_mesg);
-      ttype = TBROK;
-   }
-
-   /*
-    * Print the first result, if necessary.
-    */
-   if ( Tst_count < Tst_lpstart + Tst_lptotal )
-     tst_res(ttype, fname, "%s", tmesg);
-
-   /*
-    * Determine the number of results left to report.
-    */
-   Tst_range = Tst_lptotal + Tst_lpstart - Tst_count;
-
-   /*
-    * Print the rest of the results, if necessary.
-    */
-   if ( Tst_range > 0 ) {
-      if ( ttype == TCONF )
-         tst_res(ttype, NULL,
-                 "Remaining cases in loop not appropriate for configuration");
-      else if ( ttype == TRETR )
-         tst_res(ttype, NULL, "Remaining cases in loop retired");
-      else
-         tst_res(TBROK, NULL, "Remaining cases in loop broken");
-   } else {
-      Tst_range = 1;
-      Expand_varargs = TRUE;
-   }  /* if ( Tst_range > 0 ) */
-
-   /*
-    * If a cleanup function was specified, call it.
-    */
-   if ( func != NULL )
-      (*func)();
-}  /* tst_brkloop() */
+	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+
+	if (Tst_lpstart < 0 || Tst_lptotal < 0) {
+		tst_print(TCID, 0, 1, TWARN,
+			  "tst_brkloop(): Tst_lpstart & Tst_lptotal must both be assigned non-negative values");
+		Expand_varargs = TRUE;
+		return;
+	}
+
+	/*
+	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brkloop().
+	 */
+	if (ttype != TFAIL && ttype != TBROK && ttype != TCONF &&
+	    ttype != TRETR) {
+		sprintf(Warn_mesg,
+			"tst_brkloop(): Invalid Type: %d.  Using TBROK",
+			ttype);
+		tst_print(TCID, 0, 1, TWARN, Warn_mesg);
+		ttype = TBROK;
+	}
+
+	/* Print the first result, if necessary. */
+	if (Tst_count < Tst_lpstart + Tst_lptotal)
+		tst_res(ttype, fname, "%s", tmesg);
+
+	/* Determine the number of results left to report. */
+	Tst_range = Tst_lptotal + Tst_lpstart - Tst_count;
+
+	/* Print the rest of the results, if necessary. */
+	if (Tst_range > 0) {
+		if (ttype == TCONF) {
+			tst_res(ttype, NULL,
+				"Remaining cases in loop not appropriate for configuration");
+		} else {
+			if (ttype == TRETR)
+				tst_res(ttype, NULL, "Remaining cases in loop retired");
+			else
+				tst_res(TBROK, NULL, "Remaining cases in loop broken");
+		}
+	} else {
+		Tst_range = 1;
+		Expand_varargs = TRUE;
+	}
+
+	/* If a cleanup function was specified, call it. */
+	if (func != NULL)
+		(*func)();
+}
 
 
 /*
  * tst_resm() - Interface to tst_res(), with no filename.
  */
-void
-tst_resm(int ttype, char *arg_fmt, ...)
+void tst_resm(int ttype, char *arg_fmt, ...)
 {
-   char    tmesg[USERMESG];      /* expanded message */
+	char tmesg[USERMESG];
 
 #if DEBUG
-   printf("IN tst_resm\n"); fflush(stdout);
-   fflush(stdout);
+	printf("IN tst_resm\n"); fflush(stdout);
+	fflush(stdout);
 #endif
 
-   /*
-    * Expand the arg_fmt string into tmesg.
-    */
-   EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(arg_fmt, tmesg);
 
-   /*
-    * Call tst_res with a null filename argument.
-    */
-   tst_res(ttype, NULL, "%s", tmesg);
-}  /* tst_resm() */
+	tst_res(ttype, NULL, "%s", tmesg);
+}
 
 
 /*
  * tst_brkm() - Interface to tst_brk(), with no filename.
  */
-void
-tst_brkm(int ttype, void (*func)(), char *arg_fmt, ...)
+void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...)
 {
-   char    tmesg[USERMESG];      /* expanded message */
+	char tmesg[USERMESG];
 
 #if DEBUG
-   printf("IN tst_brkm\n"); fflush(stdout);
-   fflush(stdout);
+	printf("IN tst_brkm\n"); fflush(stdout);
+	fflush(stdout);
 #endif
 
-   /*
-    * Expand the arg_fmt string into tmesg.
-    */
-   EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(arg_fmt, tmesg);
 
-   /*
-    * Call tst_brk with a null filename argument.
-    */
-   tst_brk(ttype, NULL, func, tmesg);
-}  /* tst_brkm() */
+	tst_brk(ttype, NULL, func, tmesg);
+}
 
 
 /*
  * tst_brkloopm() - Interface to tst_brkloop(), with no filename.
  */
-void
-tst_brkloopm(int ttype, void (*func)(), char *arg_fmt, ...)
+void tst_brkloopm(int ttype, void (*func)(void), char *arg_fmt, ...)
 {
-   char    tmesg[USERMESG];      /* expanded message */
+	char tmesg[USERMESG];
 
 #if DEBUG
-   printf("IN tst_brkloopm\n");
-   fflush(stdout);
+	printf("IN tst_brkloopm\n");
+	fflush(stdout);
 #endif
 
-   /*
-    * Expand the arg_fmt string into tmesg.
-    */
-   EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(arg_fmt, tmesg);
 
-   /*
-    * Call tst_brkloop with a null filename argument.
-    */
-   tst_brkloop(ttype, NULL, func, tmesg);
-}  /* tst_brkloopm() */
+	tst_brkloop(ttype, NULL, func, tmesg);
+}
 
 
 /*
  * tst_require_root() - Test for root permissions and abort if not.
  */
-void
-tst_require_root(void (*func)())
+void tst_require_root(void (*func)(void))
 {
-   if (geteuid() != 0)
-      tst_brkm(TCONF, func, "Test needs to be run as root");
+	if (geteuid() != 0)
+		tst_brkm(TCONF, func, "Test needs to be run as root");
 }
 
 
 /*
  * cat_file() - Print the contents of a file to standard out.
  */
-static void
-cat_file(char *filename)
+static void cat_file(char *filename)
 {
-   FILE *fp;                  /* file pointer */
-   int  b_read;               /* number of bytes read with read() */
-   int  b_written;            /* number of bytes written with write() */
-   char buffer[BUFSIZ];       /* read/write buffer; BUFSIZ defined in */
-                              /* stdio.h */
-
-#if DEBUG
-   printf("IN cat_file\n"); fflush(stdout);
-#endif
-
-   /*
-    * Open the file for reading.
-    */
-   if ( (fp = fopen(filename, "r")) == NULL ) {
-      sprintf(Warn_mesg,
-              "tst_res(): fopen(%s, \"r\") failed; errno = %d: %s",
-              filename, errno, strerror(errno));
-      tst_print(TCID, 0, 1, TWARN, Warn_mesg);
-      return;
-   }  /* if ( fopen(filename, "r") == -1 ) */
-
-   /*
-    * While something to read, continue to read blocks.
-    * From fread(3) man page: 
-    *   If an error occurs, or the end-of-file is reached, the return
-    *   value is zero.
-    */
-   errno = 0;
-   while ( (b_read = fread((void *)buffer, 1, BUFSIZ, fp)) != (size_t)0 ) {
-      /*
-       * Write what was read to the result output stream.
-       */
-      if ( (b_written = fwrite((void *)buffer, 1, b_read, T_out)) !=
-           b_read ) {
-         sprintf(Warn_mesg,
-                 "tst_res(): While trying to cat \"%s\", fwrite() wrote only %d of %d bytes",
-                 filename, b_written, b_read);
-         tst_print(TCID, 0, 1, TWARN, Warn_mesg);
-         break;
-      }  /* if ( b_written != b_read ) */
-   }  /* while ( fread() != 0 ) */
-
-   /*
-    * Check for an fread() error.
-    */
-   if ( !feof(fp) ) {
-      sprintf(Warn_mesg,
-              "tst_res(): While trying to cat \"%s\", fread() failed, errno = %d: %s",
-              filename, errno, strerror(errno));
-      tst_print(TCID, 0, 1, TWARN, Warn_mesg);
-   }  /* if ( !feof() ) */
-
-   /*
-    * Close the file.
-    */
-   if ( fclose(fp) == EOF ) {
-      sprintf(Warn_mesg,
-              "tst_res(): While trying to cat \"%s\", fclose() failed, errno = %d: %s",
-              filename, errno, strerror(errno));
-      tst_print(TCID, 0, 1, TWARN, Warn_mesg);
-   }  /* if ( fclose(fp) == EOF ) */
-}  /* cat_file() */
-
+	FILE *fp;
+	int  b_read, b_written;
+	char buffer[BUFSIZ];
+
+#if DEBUG
+	printf("IN cat_file\n"); fflush(stdout);
+#endif
+
+	if ((fp = fopen(filename, "r")) == NULL) {
+		sprintf(Warn_mesg,
+			"tst_res(): fopen(%s, \"r\") failed; errno = %d: %s",
+			filename, errno, strerror(errno));
+			tst_print(TCID, 0, 1, TWARN, Warn_mesg);
+		return;
+	}
+
+	errno = 0;
+
+	while ((b_read = fread(buffer, 1, BUFSIZ, fp)) != 0) {
+		if ((b_written = fwrite(buffer, 1, b_read, T_out)) != b_read) {
+			sprintf(Warn_mesg,
+				"tst_res(): While trying to cat \"%s\", fwrite() wrote only %d of %d bytes",
+				filename, b_written, b_read);
+			tst_print(TCID, 0, 1, TWARN, Warn_mesg);
+			break;
+		}
+	}
+
+	if (!feof(fp)) {
+		sprintf(Warn_mesg,
+			"tst_res(): While trying to cat \"%s\", fread() failed, errno = %d: %s",
+			filename, errno, strerror(errno));
+		tst_print(TCID, 0, 1, TWARN, Warn_mesg);
+	}
+
+	if (fclose(fp) != 0) {
+		sprintf(Warn_mesg,
+			"tst_res(): While trying to cat \"%s\", fclose() failed, errno = %d: %s",
+			filename, errno, strerror(errno));
+		tst_print(TCID, 0, 1, TWARN, Warn_mesg);
+	}
+}
 
 
 #ifdef UNIT_TEST
@@ -889,84 +801,85 @@ char *TCID = "TESTTCID";
 #define RES  "tst_res.c UNIT TEST message; ttype = %d; contents of \"%s\":"
 #define RESM "tst_res.c UNIT TEST message; ttype = %d"
 
-main()
+int main(void)
 {
-   int  ttype;
-   int  range;
-   char *chrptr;
-   char chr;
-   char fname[MAXMESG];
-
-   printf("UNIT TEST of tst_res.c.  Options for ttype:\n\
-   -1 : call tst_exit()\n\
-   -2 : call tst_flush()\n\
-   -3 : call tst_brk()\n\
-   -4 : call tst_brkloop()\n\
-   -5 : call tst_res() with a range\n\
-    0 : call tst_res(TPASS, ...)\n\
-    1 : call tst_res(TFAIL, ...)\n\
-    2 : call tst_res(TBROK, ...)\n\
-    4 : call tst_res(TWARN, ...)\n\
-    8 : call tst_res(TRETR, ...)\n\
-   16 : call tst_res(TINFO, ...)\n\
-   32 : call tst_res(TCONF, ...)\n\n");
-
-   while ( 1 ) {
-      printf("Enter ttype (-5,-4,-3,-2,-1,0,1,2,4,8,16,32): ");
-      (void) scanf("%d%c", &ttype, &chr);
-
-
-      switch ( ttype ) {
-      case -1:
-         tst_exit();
-         break;
-
-      case -2:
-         tst_flush();
-         break;
-
-      case -3:
-         printf("Enter the current type (1=FAIL, 2=BROK, 8=RETR, 32=CONF): ");
-         (void) scanf("%d%c", &ttype, &chr);
-         printf("Enter file name (<cr> for none): ");
-         gets(fname);
-         if ( strcmp(fname, "") == 0 )
-            tst_brkm(ttype, tst_exit, RESM, ttype);
-         else
-            tst_brk(ttype, fname, tst_exit, RES, ttype, fname);
-         break;
-
-      case -4:
-         printf("Enter the size of the loop: ");
-         (void) scanf("%d%c", &range, &chr);
-         Tst_lpstart = Tst_count;
-         Tst_lptotal = range;
-         printf("Enter the current type (1=FAIL, 2=BROK, 8=RETR, 32=CONF): ");
-         (void) scanf("%d%c", &ttype, &chr);
-         printf("Enter file name (<cr> for none): ");
-         gets(fname);
-         if ( strcmp(fname, "") == 0 )
-            tst_brkloopm(ttype, NULL, RESM, ttype);
-         else
-            tst_brkloop(ttype, fname, NULL, RES, ttype, fname);
-         break;
-
-      case -5:
-         printf("Enter the size of the range: ");
-         (void) scanf("%d%c", &Tst_range, &chr);
-         printf("Enter the current type (0,1,2,4,8,16,32): ");
-         (void) scanf("%d%c", &ttype, &chr);
-         /* fall through to tst_res() call */
-
-      default:
-         printf("Enter file name (<cr> for none): ");
-         gets(fname);
-         if ( strcmp(fname, "") == 0 )
-            tst_resm(ttype, RESM, ttype);
-         else
-            tst_res(ttype, fname, RES, ttype, fname);
-         break;
-      }  /* switch() */
-   }  /* while() */
+	int  ttype;
+	int  range;
+	char *chrptr;
+	char chr;
+	char fname[MAXMESG];
+
+	printf("UNIT TEST of tst_res.c.  Options for ttype:\n\
+	       -1 : call tst_exit()\n\
+	       -2 : call tst_flush()\n\
+	       -3 : call tst_brk()\n\
+	       -4 : call tst_brkloop()\n\
+	       -5 : call tst_res() with a range\n\
+	        0 : call tst_res(TPASS, ...)\n\
+	        1 : call tst_res(TFAIL, ...)\n\
+	        2 : call tst_res(TBROK, ...)\n\
+	        4 : call tst_res(TWARN, ...)\n\
+	        8 : call tst_res(TRETR, ...)\n\
+	       16 : call tst_res(TINFO, ...)\n\
+	       32 : call tst_res(TCONF, ...)\n\n");
+
+	while (1) {
+		printf("Enter ttype (-5,-4,-3,-2,-1,0,1,2,4,8,16,32): ");
+		scanf("%d%c", &ttype, &chr);
+
+		switch (ttype) {
+			case -1:
+				tst_exit();
+			break;
+
+			case -2:
+				tst_flush();
+			break;
+
+			case -3:
+				printf("Enter the current type (1=FAIL, 2=BROK, 8=RETR, 32=CONF): ");
+				scanf("%d%c", &ttype, &chr);
+				printf("Enter file name (<cr> for none): ");
+				gets(fname);
+				if (strcmp(fname, "") == 0)
+					tst_brkm(ttype, tst_exit, RESM, ttype);
+				else
+					tst_brk(ttype, fname, tst_exit, RES, ttype, fname);
+			break;
+
+			case -4:
+				printf("Enter the size of the loop: ");
+				scanf("%d%c", &range, &chr);
+				Tst_lpstart = Tst_count;
+				Tst_lptotal = range;
+				printf("Enter the current type (1=FAIL, 2=BROK, 8=RETR, 32=CONF): ");
+				scanf("%d%c", &ttype, &chr);
+				printf("Enter file name (<cr> for none): ");
+				gets(fname);
+
+				if (strcmp(fname, "") == 0)
+					tst_brkloopm(ttype, NULL, RESM, ttype);
+				else
+					tst_brkloop(ttype, fname, NULL, RES, ttype, fname);
+			break;
+
+			case -5:
+				printf("Enter the size of the range: ");
+				scanf("%d%c", &Tst_range, &chr);
+				printf("Enter the current type (0,1,2,4,8,16,32): ");
+				scanf("%d%c", &ttype, &chr);
+			default:
+				printf("Enter file name (<cr> for none): ");
+				gets(fname);
+
+				if (strcmp(fname, "") == 0)
+					tst_resm(ttype, RESM, ttype);
+				else
+					tst_res(ttype, fname, RES, ttype, fname);
+			break;
+		}
+
+	}
 }
-#endif  /* UNIT_TEST */
+
+#endif /* UNIT_TEST */
Index: ltp-full-20090430/lib/get_high_address.c
===================================================================
--- ltp-full-20090430.orig/lib/get_high_address.c
+++ ltp-full-20090430/lib/get_high_address.c
@@ -34,8 +34,7 @@
 
 #include <unistd.h> 
 
-char *
-get_high_address()
+char *get_high_address(void)
 {
        return (char *)sbrk(0) + (4 * getpagesize());
 }
Index: ltp-full-20090430/lib/tst_is_cwd_nfs.c
===================================================================
--- ltp-full-20090430.orig/lib/tst_is_cwd_nfs.c
+++ ltp-full-20090430/lib/tst_is_cwd_nfs.c
@@ -31,12 +31,11 @@
 
 #define NFS_MAGIC 0x6969 /* man 2 statfs */
 
-int
-tst_is_cwd_nfs()
+int tst_is_cwd_nfs(void)
 {
-       struct statfs sf;
-       statfs(".", &sf);
+	struct statfs sf;
+	statfs(".", &sf);
 
-       /* Verify that the file is not on a nfs filesystem */
-       return sf.f_type == NFS_MAGIC?1:0;
+	/* Verify that the file is not on a nfs filesystem */
+	return sf.f_type == NFS_MAGIC?1:0;
 }
Index: ltp-full-20090430/lib/tst_is_cwd_tmpfs.c
===================================================================
--- ltp-full-20090430.orig/lib/tst_is_cwd_tmpfs.c
+++ ltp-full-20090430/lib/tst_is_cwd_tmpfs.c
@@ -14,8 +14,7 @@
 
 #define TMPFS_MAGIC 0x01021994 /* man 2 statfs */
 
-int 
-tst_is_cwd_tmpfs() 
+int tst_is_cwd_tmpfs(void)
 {
 	struct statfs sf;
 	statfs(".", &sf);
Index: ltp-full-20090430/lib/tst_tmpdir.c
===================================================================
--- ltp-full-20090430.orig/lib/tst_tmpdir.c
+++ ltp-full-20090430/lib/tst_tmpdir.c
@@ -116,8 +116,7 @@ extern char *TESTDIR;         /* the dir
 #undef   FN_NAME
 #define  FN_NAME  "tst_tmpdir()"
 
-void
-tst_tmpdir()
+void tst_tmpdir(void)
 {
  	char template[PATH_MAX];      /* template for mkstemp, mkdtemp */
   	int  no_cleanup = 0;          /* !0 means TDIRECTORY env var was set */
@@ -268,8 +267,7 @@ tst_tmpdir()
 #undef   FN_NAME
 #define  FN_NAME  "tst_rmdir()"
 
-void
-tst_rmdir()
+void tst_rmdir(void)
 {
    char *errmsg;
    char *tdirectory;
Index: ltp-full-20090430/testcases/kernel/containers/mqns/mqns_01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/mqns/mqns_01.c
+++ ltp-full-20090430/testcases/kernel/containers/mqns/mqns_01.c
@@ -59,10 +59,8 @@ int check_mqueue(void *vtest)
 		write(p2[1], "exists", 7);
 		mq_close(mqd);
 	}
-	tst_exit(0);
 
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
 
 int main(int argc, char *argv[])
@@ -85,7 +83,7 @@ int main(int argc, char *argv[])
 	if (mqd == -1) {
 		perror("mq_open");
 		tst_resm(TFAIL, "mq_open failed\n");
-		tst_exit(3);
+		tst_exit();
 	}
 
 	tst_resm(TINFO, "Checking namespaces isolation from parent to child\n");
@@ -95,7 +93,7 @@ int main(int argc, char *argv[])
 		tst_resm(TFAIL, "failed clone/unshare\n");
 		mq_close(mqd);
 		mq_unlink(SLASH_MQ1);
-		tst_exit(1);
+		tst_exit();
 	}
 
 	close(p1[0]);
@@ -104,21 +102,15 @@ int main(int argc, char *argv[])
 	read(p2[0], buf, 7);
 	if (!strcmp(buf, "exists")) {
 		tst_resm(TFAIL, "child process found mqueue\n");
-		r = TFAIL;
 	} else if (!strcmp(buf, "notfnd")) {
 		tst_resm(TPASS, "child process didn't find mqueue\n");
-		r = TPASS;
 	} else {
 		tst_resm(TFAIL, "UNKNOWN RESULT\n");
-		r = TFAIL;
 	}
 
 	/* destroy the mqueue */
 	mq_close(mqd);
 	mq_unlink(SLASH_MQ1);
 
-	tst_exit(r);
-
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/containers/mqns/mqns_02.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/mqns/mqns_02.c
+++ ltp-full-20090430/testcases/kernel/containers/mqns/mqns_02.c
@@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
 	mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	write(p2[1], "mqopen", 7);
@@ -72,10 +72,7 @@ int check_mqueue(void *vtest)
 
 	write(p2[1], "done", 5);
 
-	tst_exit(0);
-
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
 
 
@@ -99,7 +96,7 @@ int main(int argc, char *argv[])
 	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 	if (r < 0) {
 		tst_resm(TFAIL, "failed clone/unshare\n");
-		tst_exit(1);
+		tst_exit();
 	}
 
 	tst_resm(TINFO, "Checking namespaces isolation (child to parent)\n");
@@ -112,19 +109,17 @@ int main(int argc, char *argv[])
 	if (!strcmp(buf, "mqfail")) {
 		tst_resm(TFAIL, "child process could not create mqueue\n");
 		umount(DEV_MQUEUE);
-		tst_exit(TFAIL);
+		tst_exit();
 	} else if (strcmp(buf, "mqopen")) {
 		tst_resm(TFAIL, "child process could not create mqueue\n");
 		umount(DEV_MQUEUE);
-		tst_exit(TFAIL);
+		tst_exit();
 	}
 
 	mqd = mq_open(SLASH_MQ1, O_RDONLY);
 	if (mqd == -1) {
-		r = TPASS;
 		tst_resm(TPASS, "Father process doesn't see mqueue\n");
 	} else {
-		r = TFAIL;
 		tst_resm(TFAIL, "Father process found mqueue\n");
 		mq_close(mqd);
 	}
@@ -132,8 +127,5 @@ int main(int argc, char *argv[])
 	write(p1[1], "cont", 5);
 	read(p2[0], buf, 7);
 
-	tst_exit(r);
-
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/containers/mqns/mqns_03.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/mqns/mqns_03.c
+++ ltp-full-20090430/testcases/kernel/containers/mqns/mqns_03.c
@@ -64,7 +64,7 @@ int check_mqueue(void *vtest)
 	mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	mq_close(mqd);
@@ -73,19 +73,19 @@ int check_mqueue(void *vtest)
 	if (rc == -1) {
 		perror("mount");
 		write(p2[1], "mount1", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	rc = stat(FNAM1, &statbuf);
 	if (rc == -1) {
 		write(p2[1], "stat1", 6);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	rc = creat(FNAM2, 0755);
 	if (rc == -1) {
 		write(p2[1], "creat", 6);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	close(rc);
@@ -94,33 +94,30 @@ int check_mqueue(void *vtest)
 	if (rc == -1) {
 		perror("umount");
 		write(p2[1], "umount", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
 	if (rc == -1) {
 		write(p2[1], "mount2", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	rc = stat(FNAM1, &statbuf);
 	if (rc == -1) {
 		write(p2[1], "stat2", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	rc = stat(FNAM2, &statbuf);
 	if (rc == -1) {
 		write(p2[1], "stat3", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	write(p2[1], "done", 5);
 
-	tst_exit(0);
-
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
 
 
@@ -143,7 +140,7 @@ int main(int argc, char *argv[])
 	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 	if (r < 0) {
 		tst_resm(TFAIL, "failed clone/unshare\n");
-		tst_exit(1);
+		tst_exit();
 	}
 
 	tst_resm(TINFO, "Checking correct umount+remount of mqueuefs\n");
@@ -189,8 +186,5 @@ int main(int argc, char *argv[])
 fail:
 	umount(DEV_MQUEUE2);
 	rmdir(DEV_MQUEUE2);
-	tst_exit(r);
-
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/containers/mqns/mqns_04.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/mqns/mqns_04.c
+++ ltp-full-20090430/testcases/kernel/containers/mqns/mqns_04.c
@@ -60,7 +60,7 @@ int check_mqueue(void *vtest)
 	mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	mq_close(mqd);
@@ -69,22 +69,18 @@ int check_mqueue(void *vtest)
 	if (rc == -1) {
 		perror("mount");
 		write(p2[1], "mount", 6);
-		tst_exit(3);
+		tst_exit();
 	}
 
 	write(p2[1], "go", 3);
 	read(p1[0], buf, 3);
 
-	tst_exit(0);
-
-	/* NOT REACHED */
-	return 0;
+	tst_exit();
 }
 
 
 int main(int argc, char *argv[])
 {
-	int r = TFAIL;
 	int rc;
 	int status;
 	char buf[30];
@@ -157,12 +153,10 @@ int main(int argc, char *argv[])
 
 	tst_resm(TPASS, "Child mqueue fs still visible for parent\n");
 
-	r = 0;
-
 fail:
 	umount(DEV_MQUEUE2);
 	rmdir(DEV_MQUEUE2);
-	tst_exit(r);
+	tst_exit();
 
 	/* NOT REACHED */
 	return 0;
Index: ltp-full-20090430/testcases/kernel/containers/pidns/pidns30.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/pidns/pidns30.c
+++ ltp-full-20090430/testcases/kernel/containers/pidns/pidns30.c
@@ -145,8 +145,7 @@ static void cleanup(int result, int step
 	/* Clean the test testcase as LTP wants*/
 	TEST_CLEANUP;
 
-	/* exit with return code appropriate for results */
-	tst_exit(result);
+	tst_exit();
 }
 
 /*
Index: ltp-full-20090430/testcases/kernel/containers/pidns/pidns31.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/pidns/pidns31.c
+++ ltp-full-20090430/testcases/kernel/containers/pidns/pidns31.c
@@ -143,7 +143,7 @@ static void cleanup(int result, int step
 	TEST_CLEANUP;
 
 	/* exit with return code appropriate for results */
-	tst_exit(result);
+	tst_exit();
 }
 
 /*
Index: ltp-full-20090430/testcases/kernel/containers/sysvipc/shmnstest.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/containers/sysvipc/shmnstest.c
+++ ltp-full-20090430/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -57,10 +57,8 @@ int check_shmid(void *vtest)
               write(p2[1], "exists", 7);
               shmctl(id, IPC_RMID, NULL);
       }
-      tst_exit(0);
 
-      /* NOT REACHED */
-      return 0;
+      tst_exit();
 }
 
 #define UNSHARESTR "unshare"
@@ -76,7 +74,7 @@ int main(int argc, char *argv[])
       if (argc != 2) {
               tst_resm(TFAIL, "Usage: %s <clone|unshare|none>\n", argv[0]);
               tst_resm(TFAIL, " where clone, unshare, or fork specifies unshare method.");
-              tst_exit(2);
+              tst_exit();
       }
       if (pipe(p1) == -1) { perror("pipe"); exit(EXIT_FAILURE); }
       if (pipe(p2) == -1) { perror("pipe"); exit(EXIT_FAILURE); }
@@ -94,7 +92,7 @@ int main(int argc, char *argv[])
       if (id == -1) {
               perror("shmget");
               tst_resm(TFAIL, "shmget failed\n");
-              tst_exit(3);
+              tst_exit();
       }
 
       tst_resm(TINFO, "shmid namespaces test : %s\n",tsttype);
@@ -102,7 +100,7 @@ int main(int argc, char *argv[])
       r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
       if (r < 0) {
               tst_resm(TFAIL, "%s failed\n", tsttype);
-              tst_exit(1);
+              tst_exit();
       }
 
       close(p1[0]);
@@ -126,8 +124,5 @@ int main(int argc, char *argv[])
       /* destroy the key */
       shmctl(id, IPC_RMID, NULL);
 
-      tst_exit(0);
-
-      /* NOT REACHED */
-      return 0;
+      tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/mem/mmapstress/mmapstress01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ ltp-full-20090430/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -166,7 +166,7 @@ main(int argc, char *argv[])
 	tst_tmpdir();
 	if (argc < 2) {
 		tst_resm(TBROK, "usage: %s %s\n", progname, usage);
-                tst_exit(0);
+                tst_exit();
 	}
 
 	while ((c = getopt(argc, argv, "S:omdlrf:p:t:")) != -1) {
@@ -218,7 +218,7 @@ main(int argc, char *argv[])
 			break;
 		default:
 			(void)fprintf(stderr,"usage: %s %s\n", progname, usage);
-                        tst_exit(0);
+                        tst_exit();
 		}
 	}
 
Index: ltp-full-20090430/testcases/kernel/security/cap_bound/cap_bounds_r.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/cap_bound/cap_bounds_r.c
+++ ltp-full-20090430/testcases/kernel/security/cap_bound/cap_bounds_r.c
@@ -60,13 +60,13 @@ int main(int argc, char *argv[])
 			tst_resm(TFAIL, "prctl(CAP_BSET_READ, %d) returned %d\n", i, ret);
 			if (ret == -1)
 				tst_resm(TINFO, "errno was %d\n", errno);
-			tst_exit(1);
+			tst_exit();
 		}
 	}
 	ret = prctl(CAP_BSET_READ, -1);
 	if (ret != -1) {
 		tst_resm(TFAIL, "prctl(CAP_BSET_READ, -1) returned %d\n", -1, ret);
-		tst_exit(1);
+		tst_exit();
 	}
 
 	/* Ideally I'd check CAP_LAST_CAP+1, but userspace
@@ -79,8 +79,8 @@ int main(int argc, char *argv[])
 	if (ret != -1) {
 		tst_resm(TFAIL, "prctl(CAP_BSET_READ, %d) returned %d\n", CAP_LAST_CAP+1, ret);
 		tst_resm(TINFO, " %d is CAP_LAST_CAP+1 and should not exist\n", CAP_LAST_CAP+1);
-		tst_exit(1);
+		tst_exit();
 	}
 	tst_resm(TPASS, "CAP_BSET_READ tests passed\n");
-	tst_exit(0);
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/security/cap_bound/cap_bounds_rw.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ ltp-full-20090430/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -57,7 +57,7 @@ int check_remaining_caps(int lastdropped
 		ret = prctl(CAP_BSET_READ, i);
 		if (ret == -1) {
 			tst_resm(TBROK, "Failed to read bounding set during sanity check\n");
-			tst_exit(1);
+			tst_exit();
 		}
 		if (ret == 1) {
 			tst_resm(TFAIL, "Bit %d should have been dropped but wasn't\n", i);
@@ -68,7 +68,7 @@ int check_remaining_caps(int lastdropped
 		ret = prctl(CAP_BSET_READ, i);
 		if (ret == -1) {
 			tst_resm(TBROK, "Failed to read bounding set during sanity check\n");
-			tst_exit(1);
+			tst_exit();
 		}
 		if (ret == 0) {
 			tst_resm(TFAIL, "Bit %d wasn't yet dropped, but isn't in bounding set\n", i);
@@ -86,7 +86,7 @@ int main(int argc, char *argv[])
 	ret = prctl(CAP_BSET_DROP, -1);
 	if (ret != -1) {
 		tst_resm(TFAIL, "prctl(CAP_BSET_DROP, -1) returned %d\n", ret);
-		tst_exit(1);
+		tst_exit();
 	}
 	/* Ideally I'd check CAP_LAST_CAP+1, but userspace
 	 * tends to be far too unreliable to trust CAP_LAST_CAP>
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 	if (ret != -1) {
 		tst_resm(TFAIL, "prctl(CAP_BSET_DROP, %d) returned %d\n", max(INSANE, CAP_LAST_CAP+1), ret);
 		tst_resm(TINFO, " %d is should not exist\n", max(INSANE, CAP_LAST_CAP+1));
-		tst_exit(1);
+		tst_exit();
 	}
 	for (i=0; i<=CAP_LAST_CAP; i++) {
 		ret = prctl(CAP_BSET_DROP, i);
@@ -106,19 +106,19 @@ int main(int argc, char *argv[])
 			tst_resm(TFAIL, "prctl(CAP_BSET_DROP, %d) returned %d\n", i, ret);
 			if (ret == -1)
 				tst_resm(TINFO, "errno was %d\n", errno);
-			tst_exit(1);
+			tst_exit();
 		}
 		ret = check_remaining_caps(i);
 		if (ret > 0) {
 			tst_resm(TFAIL, "after dropping bits 0..%d, %d was still in bounding set\n",
 				i, ret);
-			tst_exit(1);
+			tst_exit();
 		} else if (ret < 0) {
 			tst_resm(TFAIL, "after dropping bits 0..%d, %d was not in bounding set\n",
 				i, -ret);
-			tst_exit(1);
+			tst_exit();
 		}
 	}
 	tst_resm(TPASS, "CAP_BSET_DROP tests passed\n");
-	tst_exit(0);
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
+++ ltp-full-20090430/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
@@ -63,27 +63,27 @@ int main(int argc, char *argv[])
 	ret = prctl(CAP_BSET_READ, CAP_SYS_ADMIN);
 	if (ret != 1) {
 		tst_resm(TBROK, "Not starting with CAP_SYS_ADMIN\n");
-		tst_exit(1);
+		tst_exit();
 	}
 
 	/* Make sure it's in pI */
 	cur = cap_from_text("all=eip");
 	if (!cur) {
 		tst_resm(TBROK, "Failed to create cap_sys_admin+i cap_t (errno %d)\n", errno);
-		tst_exit(1);
+		tst_exit();
 	}
 	ret = cap_set_proc(cur);
 	if (ret) {
 		tst_resm(TBROK, "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)\n",
 			ret, errno);
-		tst_exit(1);
+		tst_exit();
 	}
 	cap_free(cur);
 	cur = cap_get_proc();
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
 	if (ret || f != CAP_SET) {
 		tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN to pI\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	cap_free(cur);
 
@@ -92,7 +92,7 @@ int main(int argc, char *argv[])
 	if (ret) {
 		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
 		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
-		tst_exit(1);
+		tst_exit();
 	}
 
 	/* test 1: is CAP_SYS_ADMIN still in pI? */
@@ -100,7 +100,7 @@ int main(int argc, char *argv[])
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
 	if (ret || f != CAP_SET) {
 		tst_resm(TFAIL, "CAP_SYS_ADMIN not in pI after dropping from bounding set\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	tst_resm(TPASS, "CAP_SYS_ADMIN remains in pI after removing from bounding set\n");
 
@@ -109,12 +109,12 @@ int main(int argc, char *argv[])
 	ret = cap_set_flag(tmpcap, CAP_INHERITABLE, 1, v, CAP_CLEAR);
 	if (ret) {
 		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from cap_t\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	ret = cap_set_proc(tmpcap);
 	if (ret) {
 		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from pI\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	cap_free(tmpcap);
 
@@ -122,10 +122,10 @@ int main(int argc, char *argv[])
 	ret = cap_set_proc(cur);
 	if (ret == 0) { /* success means pI was not bounded by X */
 		tst_resm(TFAIL, "Managed to put CAP_SYS_ADMIN back into pI though not in X\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	cap_free(cur);
 
 	tst_resm(TPASS, "Couldn't put CAP_SYS_ADMIN back into pI when not in bounding set\n");
-	tst_exit(0);
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/security/cap_bound/check_pe.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/cap_bound/check_pe.c
+++ ltp-full-20090430/testcases/kernel/security/cap_bound/check_pe.c
@@ -46,35 +46,35 @@ int main(int argc, char *argv[])
 
 	if (argc != 2) {
 		tst_resm(TBROK, "Usage: check_pe [0|1]\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	n = atoi(argv[1]);
 	if (n != 0 && n != 1) {
 		tst_resm(TBROK, "Usage: check_pe [0|1]\n");
-		tst_exit(1);
+		tst_exit();
 	}
 
 	cur = cap_get_proc();
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_EFFECTIVE, &f);
 	if (ret) {
 		tst_resm(TBROK, "cap_get_flag failed (errno %d)\n", errno);
-		tst_exit(1);
+		tst_exit();
 	}
 	
 	cap_free(cur);
 	if (n == 1) {
 		if (f == CAP_SET) {
 			tst_resm(TPASS, "cap is in pE\n");
-			tst_exit(0);
+			tst_exit();
 		}
 		tst_resm(TFAIL, "Cap is not in pE\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	if (f == CAP_CLEAR) {
 		tst_resm(TPASS, "cap is not in pE\n");
-		tst_exit(0);
+		tst_exit();
 	}
 	tst_resm(TFAIL, "Cap is in pE\n");
-	tst_exit(1);
+	tst_exit();
 
 }
Index: ltp-full-20090430/testcases/kernel/security/cap_bound/exec_with_inh.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ ltp-full-20090430/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -61,20 +61,20 @@ int main(int argc, char *argv[])
 	cur = cap_from_text("all=eip");
 	if (!cur) {
 		tst_resm(TBROK, "Failed to create cap_sys_admin+i cap_t (errno %d)\n", errno);
-		tst_exit(1);
+		tst_exit();
 	}
 	ret = cap_set_proc(cur);
 	if (ret) {
 		tst_resm(TBROK, "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)\n",
 			ret, errno);
-		tst_exit(1);
+		tst_exit();
 	}
 	cap_free(cur);
 	cur = cap_get_proc();
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
 	if (ret || f != CAP_SET) {
 		tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN to pI\n");
-		tst_exit(1);
+		tst_exit();
 	}
 	cap_free(cur);
 
@@ -83,11 +83,11 @@ int main(int argc, char *argv[])
 	if (ret) {
 		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
 		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
-		tst_exit(1);
+		tst_exit();
 	}
 
 	/* execute "check_pe 1" */
 	execl("check_pe", "check_pe", "1", NULL);
 	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
-	tst_exit(1);
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/security/cap_bound/exec_without_inh.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ ltp-full-20090430/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 			ret = cap_set_proc(cur);
 		if (ret) {
 			tst_resm(TBROK, "Failed to drop cap_sys_admin from pI\n");
-			tst_exit(1);
+			tst_exit();
 		}
 	}
 	cap_free(cur);
@@ -78,11 +78,11 @@ int main(int argc, char *argv[])
 	if (ret) {
 		tst_resm(TFAIL, "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
 		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
-		tst_exit(1);
+		tst_exit();
 	}
 
 	/* execute "check_pe 0" */
 	execl("check_pe", "check_pe", "0", NULL);
 	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
-	tst_exit(1);
+	tst_exit();
 }
Index: ltp-full-20090430/testcases/kernel/syscalls/madvise/madvise03.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/madvise/madvise03.c
+++ ltp-full-20090430/testcases/kernel/syscalls/madvise/madvise03.c
@@ -137,13 +137,13 @@ int main(int argc, char *argv[])
 #define MADV_DOFORK     11
 		tst_resm(TCONF, "This test can only run on kernels that are ");
 		tst_resm(TCONF, "2.6.16 and higher");
-		tst_exit(0);
+		tst_exit();
 	}
 
 	if ((msg =
 	     parse_opts(argc, argv, (option_t *) NULL, NULL)) != (char *)NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit(0);
+		tst_exit();
 	}
 
 	/**************************************************
Index: ltp-full-20090430/testcases/kernel/syscalls/sbrk/sbrk01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ ltp-full-20090430/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	if ((msg = parse_opts(ac, av, (option_t *) NULL, NULL)) != (char *)NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit(0);
+		tst_exit();
 	}
 
     /***************************************************************
Index: ltp-full-20090430/testcases/kernel/syscalls/setpgrp/setpgrp01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/setpgrp/setpgrp01.c
+++ ltp-full-20090430/testcases/kernel/syscalls/setpgrp/setpgrp01.c
@@ -135,7 +135,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	if ((msg = parse_opts(ac, av, (option_t *) NULL, NULL)) != (char *)NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit(0);
+		tst_exit();
 	}
 
     /***************************************************************

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--OXfL5xGRrasGEqWY--

