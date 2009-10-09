Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MwF1d-00064j-N4
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 12:56:49 +0000
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 7B57786A2E
	for <ltp-list@lists.sourceforge.net>;
	Fri,  9 Oct 2009 14:56:38 +0200 (CEST)
Date: Fri, 9 Oct 2009 14:56:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091009125638.GC3725@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix possible tst_xxx buffer overrun
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


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch fixes tst_** functions that would segfault for printing
messages longer than 2048 chars. Now such message is truncated.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--jousvV0MzM2p6OtC
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="tst_res_buffer_overrun.patch"

Index: ltp/lib/tst_res.c
===================================================================
--- ltp.orig/lib/tst_res.c
+++ ltp/lib/tst_res.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * Copyring  (c) 2009 Cyril Hrubis chrubis@suse.cz
+ * Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -131,20 +131,18 @@
  * EXPAND_VAR_ARGS - Expand the variable portion (arg_fmt) of a result
  *                   message into the specified string.
  */
-#define EXPAND_VAR_ARGS(arg_fmt, str) {   \
-   va_list ap; /* varargs mechanism */    \
-                                          \
-   if (arg_fmt != NULL) {                 \
-      if ( Expand_varargs == TRUE ) {     \
-         va_start(ap, arg_fmt);           \
-         vsprintf(str, arg_fmt, ap);      \
-         va_end(ap);                      \
-      } else {                            \
-         strcpy(str, arg_fmt);            \
-      }                                   \
-   } else {                               \
-      str[0] = '\0';                      \
-   }                                      \
+#define EXPAND_VAR_ARGS(buf, arg_fmt, buf_len) {              \
+	va_list ap;                                           \
+	                                                      \
+	if (arg_fmt != NULL) {                                \
+		if (Expand_varargs) {                         \
+			va_start(ap, arg_fmt);                \
+			vsnprintf(buf, buf_len, arg_fmt, ap); \
+			va_end(ap);                           \
+		} else                                        \
+			strncpy(buf, arg_fmt, buf_len);       \
+	} else                                                \
+		buf[0] = '\0';                                \
 }
 
 /*
@@ -300,7 +298,7 @@ void tst_res(int ttype, char *fname, cha
 	       Tst_count, Tst_range); fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
 	/*
 	 * Save the test result type by ORing ttype into the current exit
@@ -625,7 +623,7 @@ void tst_brk(int ttype, char *fname, voi
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
 	/*
 	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
@@ -686,7 +684,7 @@ void tst_brkloop(int ttype, char *fname,
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
 	if (Tst_lpstart < 0 || Tst_lptotal < 0) {
 		tst_print(TCID, 0, 1, TWARN,
@@ -748,7 +746,7 @@ void tst_resm(int ttype, char *arg_fmt, 
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
 	tst_res(ttype, NULL, "%s", tmesg);
 }
@@ -766,7 +764,7 @@ void tst_brkm(int ttype, void (*func)(vo
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
 	tst_brk(ttype, NULL, func, "%s", tmesg);
 }
@@ -784,7 +782,7 @@ void tst_brkloopm(int ttype, void (*func
 	fflush(stdout);
 #endif
 
-	EXPAND_VAR_ARGS(arg_fmt, tmesg);
+	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
 
 	tst_brkloop(ttype, NULL, func, "%s", tmesg);
 }

--jousvV0MzM2p6OtC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--jousvV0MzM2p6OtC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--jousvV0MzM2p6OtC--

