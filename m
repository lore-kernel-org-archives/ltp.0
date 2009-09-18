Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kiran@linux.vnet.ibm.com>) id 1MocGx-0006Km-0G
	for ltp-list@lists.sourceforge.net; Fri, 18 Sep 2009 12:09:07 +0000
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MocGq-0004XL-HH
	for ltp-list@lists.sourceforge.net; Fri, 18 Sep 2009 12:09:06 +0000
From: Kiran <kiran@linux.vnet.ibm.com>
In-Reply-To: <4AB23BCE.4030703@redhat.com>
References: <1251794259.3881.6.camel@kiran-laptop>
	<1251875695.4930.8.camel@subratamodak.linux.ibm.com>
	<1252057746.4698.6.camel@kiran-laptop> <4AB037E4.9000904@redhat.com>
	<4AB23BCE.4030703@redhat.com>
Date: Fri, 18 Sep 2009 17:38:47 +0530
Message-Id: <1253275727.6773.41.camel@kiran-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Patch to change the format of Steve Rostedt's
 rt-migrate-test testcase
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
To: jburke@redhat.com
Cc: ltp-list@lists.sf.net, rostedt <rostedt@goodmis.org>

On Thu, 2009-09-17 at 09:38 -0400, Jeff Burke wrote:
> Jeff Burke wrote:
> > Kiran wrote:
> >> Hi Subrata,
> >>
> >> This patch places the rt-migrate testcase into the
> >> realtime/func/rt-migrate directory.
> >>
> >> Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
> >>
> > Kiran,
> >     Did you get a chance to test this on both x86_64 and i386? In my 
> > stand alone version(Before you ported it to LTP). My results vary quite 
> > a bit for i386. I have attached two files.
> > standalone - Is the rt-migrate test results outside of LTP
> > ltpver - Is the rt-migrate test results ported into LTP
> > 
> > Note: The results are from the same system same kernel. The test were 
> > run back to back.
> > 
> Kiran,
> 	Did you get a chance to review the results?
> Jeff
> > Thanks,
> > Jeff
> > 
> 
Hi,

This is a patch on the cvs version of LTP.

Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>

diff -Naur ltp_orig/testcases/realtime/func/rt-migrate/rt-migrate.c ltp/testcases/realtime/func/rt-migrate/rt-migrate.c
--- ltp_orig/testcases/realtime/func/rt-migrate/rt-migrate.c	2009-09-07 14:29:10.000000000 +0530
+++ ltp/testcases/realtime/func/rt-migrate/rt-migrate.c	2009-09-18 17:30:34.000000000 +0530
@@ -46,7 +46,6 @@
  *                    testcases by Kiran Prakash
  *
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #ifndef __USE_XOPEN2K
 # define __USE_XOPEN2K
@@ -247,17 +246,17 @@
 	for (i = 0; i < nr_runs; i++) {
 		printf("%4d:   ", i);
 		for (t = 0; t < nr_tasks; t++)
-			printf("%6lld  ", intervals[t].records[i].y);
+			printf("%ld  ", intervals[t].records[i].y);
 
 		printf("\n");
 		printf(" len:   ");
 		for (t = 0; t < nr_tasks; t++)
-			printf("%6lld  ", intervals_length[t].records[i].y);
+			printf("%ld  ", intervals_length[t].records[i].y);
 
 		printf("\n");
 		printf(" loops: ");
 		for (t = 0; t < nr_tasks; t++)
-			printf("%6ld  ", intervals_loops[t].records[i].y);
+			printf("%ld  ", intervals_loops[t].records[i].y);
 
 		printf("\n");
 		printf("\n");

Thanks,
Kiran


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
