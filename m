Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWmsf-0001yb-49
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 07:50:21 +0000
Received: from rv-out-0708.google.com ([209.85.198.246])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWmsa-0003oz-S2
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 07:50:21 +0000
Received: by rv-out-0708.google.com with SMTP id b17so507751rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 00:50:11 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 31 Jul 2009 00:50:11 -0700
Message-ID: <364299f40907310050x23bf9e2uc5349a3de82a2773@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] General purpose digsig fixes
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

These are general purpose fixes for digsig that accomplish the following:

1. Use cross-compilable tools.
2. Specify -fPIC for .so files.
3. Update builddigsig.sh per SF changes and improve upon logic, slightly.
4. Fix -Wshadow reported earlier in libwritetest.c.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/security/digsig/builddigsig.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/builddigsig.sh,v
retrieving revision 1.1
diff -u -r1.1 builddigsig.sh
--- testcases/kernel/security/digsig/builddigsig.sh	21 Mar 2005
22:02:02 -0000	1.1
+++ testcases/kernel/security/digsig/builddigsig.sh	31 Jul 2009 07:48:56 -0000
@@ -1,5 +1,5 @@
 #!/bin/sh
-
+#
 #	script created by Serge E. Hallyn <serue@us.ibm.com>
 #	Copyright (c) International Business Machines  Corp., 2005
 #
@@ -16,18 +16,19 @@
 #	You should have received a copy of the GNU General Public License
 #	along with this program;  if not, write to the Free Software
 #	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#

-if [ ! -x /usr/bin/wget ]; then
+if ! wget=`which wget`; then
 	echo "This script requires wget."
 	exit 1
 fi

-if [ ! -x /usr/local/bin/bsign ]; then
+if ! bsign=`which bsign`; then
 	echo "This test will require bsign"
 	exit 1
 fi

-/usr/bin/wget http://osdn.dl.sourceforge.net/sourceforge/disec/digsig-latest.tar.gz
+$wget http://downloads.sourceforge.net/project/disec/digsig/digsig-latest/digsig-latest.tar.gz
 tar zxf digsig-latest.tar.gz
 cd digsig-latest
 ./digsig.init compile
Index: testcases/kernel/security/digsig/writeexec/libwritetest.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/libwritetest.c,v
retrieving revision 1.1
diff -u -r1.1 libwritetest.c
--- testcases/kernel/security/digsig/writeexec/libwritetest.c	1 Nov
2005 16:09:43 -0000	1.1
+++ testcases/kernel/security/digsig/writeexec/libwritetest.c	31 Jul
2009 07:48:56 -0000
@@ -9,8 +9,6 @@
 #include <dlfcn.h>
 #include <wait.h>

-int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
-
 int writer(void *data)
 {
 	int fd;
Index: testcases/kernel/security/digsig/writeexec/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/security/digsig/writeexec/Makefile	26 Feb 2009
06:29:48 -0000	1.3
+++ testcases/kernel/security/digsig/writeexec/Makefile	31 Jul 2009
07:48:56 -0000
@@ -1,21 +1,22 @@
-LIBS= -ldl
-
+LDLIBS	+= -ldl

 all: shared.so libwritetest
-	@bsign=`which bsign`; \
-	if test -n $$bsign; then \
+	if bsign=`which bsign 2>/dev/null`; then \
 		echo "running bsign"; \
-		$$bsign -s -P "--homedir=../twiddlebit" libwritetest shared.so; \
+		$$bsign -s -P "--homedir=../twiddlebit" libwritetest \
+		shared.so; \
 		cp shared.so shared.so.signed; \
 	else \
 		echo "No bsign found"; \
 	fi;

 libwritetest: libwritetest.c
-	$(CC) -o $@ libwritetest.c $(LIBS)
+	$(CC) -o $@ libwritetest.c $(LDLIBS)
+
+shared.o: CFLAGS += -fPIC

 shared.so: shared.o
-	ld -shared shared.o -o shared.so
+	$(LD) -shared $^ $(OUTPUT_OPTION) $@

 clean:
 	rm -f *.o core *.so weoutput libwritetest shared.so.signed execlog writelog
Index: testcases/kernel/security/digsig/twiddlebit/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/twiddlebit/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/security/digsig/twiddlebit/Makefile	26 Feb 2009
06:29:48 -0000	1.2
+++ testcases/kernel/security/digsig/twiddlebit/Makefile	31 Jul 2009
07:48:56 -0000
@@ -3,8 +3,7 @@
 all: hw_signed swapbit
 swapbit: swapbit.o
 hw_signed: hw
-	@bsign=`which bsign`; \
-	if test -n $$bsign; then \
+	if bsign=`which bsign 2>/dev/null`; then \
 		echo "running bsign"; \
 		$$bsign -s -P "--homedir=." hw; \
 		cp hw hw_signed; \

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
