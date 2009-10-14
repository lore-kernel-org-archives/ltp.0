Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My8Xu-0000pY-Sm
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:25:58 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My8Xb-0006V9-I7
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:25:45 +0000
Received: by pzk26 with SMTP id 26so50835pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 11:25:33 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 11:25:33 -0700
Message-ID: <364299f40910141125p113a6d28va6289a10bb8574da@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Move `creating ... directory' to block where
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

We shouldn't say that we're creating the directory unless we are
actually creating the directory. This only leads to potential
confusion with LTP newbies.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: runltp
===================================================================
RCS file: /cvsroot/ltp/ltp/runltp,v
retrieving revision 1.51
diff -u -r1.51 runltp
--- runltp      13 Oct 2009 12:10:13 -0000      1.51
+++ runltp      14 Oct 2009 18:23:29 -0000
@@ -456,9 +456,9 @@
     # If we need, create the output directory
     [ "$ALT_DIR_OUT" -eq 1 ] && \
     {
-        echo "INFO: creating $LTPROOT/output directory"
         [ ! -d $LTPROOT/output ] && \
         {
+           echo "INFO: creating $LTPROOT/output directory"
            mkdir -p $LTPROOT/output || \
            {
                echo "ERROR: failed to create $LTPROOT/output"

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
