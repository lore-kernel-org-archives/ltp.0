Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1Mw8n1-0000Ur-Vj
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:17:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mw8mz-0008Va-JB
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:17:19 +0000
Date: Fri, 09 Oct 2009 15:21:08 +0900 (JST)
Message-Id: <20091009.152108.954124754429052503.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Subject: [LTP] Checking flex existance in configure
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
To: ltp-list@lists.sf.net

Hi,


In INSTALL file:

    3. Run "make" to build everything.
       *NOTE: Some of the Makefiles (example: pan/Makefile) require the lex (or
       flex) package to be installed.

I've added AC_PROG_LEX to configure.ac to check the existance of flex or lex command.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Index: config.mk.in
===================================================================
RCS file: /cvsroot/ltp/ltp/config.mk.in,v
retrieving revision 1.5
diff -u -r1.5 config.mk.in
--- config.mk.in	7 Sep 2009 07:08:53 -0000	1.5
+++ config.mk.in	9 Oct 2009 06:13:07 -0000
@@ -2,6 +2,9 @@
 AR = @AR@
 RANLIB = @RANLIB@
 
+LEX = @LEX@
+LEXLIB = @LEXLIB@
+
 CPPFLAGS = @CPPFLAGS@
 CFLAGS = @CFLAGS@
 LDFLAGS = @LDFLAGS@
Index: configure.ac
===================================================================
RCS file: /cvsroot/ltp/ltp/configure.ac,v
retrieving revision 1.16
diff -u -r1.16 configure.ac
--- configure.ac	9 Sep 2009 17:48:08 -0000	1.16
+++ configure.ac	9 Oct 2009 06:13:07 -0000
@@ -8,6 +8,7 @@
 AC_PROG_CC
 AC_PROG_AR
 AC_PROG_RANLIB
+AC_PROG_LEX
 
 AC_CHECK_HEADERS_ONCE([ \
 ifaddrs.h \
Index: pan/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/pan/Makefile,v
retrieving revision 1.19
diff -u -r1.19 Makefile
--- pan/Makefile	19 May 2009 09:39:11 -0000	1.19
+++ pan/Makefile	9 Oct 2009 06:13:07 -0000
@@ -1,3 +1,4 @@
+include ../config.mk
 
 LOADLIBES += -lm
 LFLAGS += -l -w
Index: testcases/ballista/ballista/compile/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/ballista/ballista/compile/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/ballista/ballista/compile/Makefile	26 Feb 2009 06:29:46 -0000	1.2
+++ testcases/ballista/ballista/compile/Makefile	9 Oct 2009 06:13:08 -0000
@@ -15,6 +15,9 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 
+include ../../../config.mk
+
+
 dFLAGS=-g -DDEBUG
 FLAGS= -O -Wall
 PFLAGS= -p -g3
@@ -53,7 +56,7 @@
 lex.yy.o: lex.yy.c
 
 lex.yy.c: ballista.l tokens.h
-	flex ballista.l
+	$(LEX) ballista.l
 
 blexer.o: blexer.c blexer.h jlist.h butil.h
 

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
