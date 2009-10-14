Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My9Cd-0007DG-7s
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:08:03 +0000
Received: from mail-px0-f180.google.com ([209.85.216.180])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My9CY-0005L1-Ej
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:08:03 +0000
Received: by pxi10 with SMTP id 10so36968pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 12:07:52 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 12:07:52 -0700
Message-ID: <364299f40910141207ucd102e5sa05d8f33e852fefa@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Address a malloc failure, a typo,
	and an indent issue in 	pan.c
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
To: LTP list <ltp-list@lists.sourceforge.net>

While trying to figure out why entries don't get entered in the exec
log, I found the following issue with a malloc call. I also fixed a
typo and a whacky indentation item as well.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: pan/ltp-pan.c
===================================================================
RCS file: /cvsroot/ltp/ltp/pan/ltp-pan.c,v
retrieving revision 1.3
diff -u -r1.3 ltp-pan.c
--- pan/ltp-pan.c       9 Jun 2009 16:14:40 -0000       1.3
+++ pan/ltp-pan.c       14 Oct 2009 19:05:59 -0000
@@ -337,6 +337,11 @@

     /* a place to store the pgrps we're watching */
     running = (struct tag_pgrp *)malloc((keep_active + 1) *
sizeof(struct tag_pgrp));
+    if (running == NULL) {
+        fprintf(stderr, "pan(%s): Failed to allocate memory: %s\n", panname,
+                strerror(errno));
+       exit(2);
+    }
     memset(running, 0, keep_active * sizeof(struct tag_pgrp));
     running[keep_active].pgrp = -1;    /* end sentinel */

@@ -397,7 +402,7 @@
     if (outputfilename) {
        if (!freopen(outputfilename, "a+", stdout)) {
            fprintf(stderr,
-                   "pan(%s): Error %s (%d) openning output file '%s'\n",
+                   "pan(%s): Error %s (%d) opening output file '%s'\n",
                    panname, strerror(errno), errno, outputfilename);
            exit(1);
        }
@@ -743,7 +748,7 @@
                                                        w);
                        }

-                               fflush(logfile);
+                       fflush(logfile);
                }

                if ((failcmdfile != NULL) && (w !=0)) {

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
