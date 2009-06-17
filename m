Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1MGwWu-0004g7-DH
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 14:54:24 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGwWq-0006PK-Cq
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 14:54:24 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5HEsHal025187
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2009 10:54:17 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5HEsGWf008030
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2009 10:54:17 -0400
Received: from localhost (beach.nrt.redhat.com [10.64.200.71])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5HEsFGV031813
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jun 2009 10:54:15 -0400
Date: Wed, 17 Jun 2009 23:54:14 +0900 (JST)
Message-Id: <20090617.235414.789903209098431159.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Subject: [LTP] build failure of aio02 test case
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
To: ltp-list@lists.sourceforge.net

Hi,


--static for gcc is really needed? I cannot find strong reason for
it.



Signed-off-by: Masatake YAMATO <yamato@redhat.com>


Index: aio/aio02/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/aio/aio02/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- aio/aio02/Makefile	23 Feb 2009 11:08:04 -0000	1.5
+++ aio/aio02/Makefile	17 Jun 2009 14:51:57 -0000
@@ -5,12 +5,12 @@
 HARNESS_SRCS:=main.c
 # io_queue.c
 
-CFLAGS+=--static -Wall  -g -O -I../../../../../include -Wall
+CFLAGS+=-Wall  -g -O -I../../../../../include -Wall
 LDFLAGS+=-L../../../../../lib -lltp $(AIO_LIBS)
 #-lpthread -lrt
 all: $(PROGS)
 
-$(PROGS): %: %.c $(HARNESS_SRCS)
+$(PROGS): %: %.c $(HARNESS_SRCS) Makefile
 	$(CC) $(CFLAGS) -DTEST_NAME=\"$<\" -o $@ main.c $(LDFLAGS)
 
 clean:
Index: aio/aio02/main.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/aio/aio02/main.c,v
retrieving revision 1.4
diff -u -r1.4 main.c
--- aio/aio02/main.c	26 Feb 2009 12:02:22 -0000	1.4
+++ aio/aio02/main.c	17 Jun 2009 14:51:57 -0000
@@ -35,6 +35,7 @@
 int main(void)
 {
   tst_brkm(TCONF, tst_exit, "libaio missing");
+  return 0;
 }
 
 #endif

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
