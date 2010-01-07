Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1NSqNb-0008EZ-PZ
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:18:15 +0000
Received: from maroilles.sis.pasteur.fr ([157.99.64.223]
	helo=mail-interne3.pasteur.fr)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSqNZ-0004P1-BJ
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:18:15 +0000
Date: Thu, 7 Jan 2010 11:58:51 +0100
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20100107105850.GA323602@medusa.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
Subject: [LTP] kill unneeded chmod calls on created tmp directory
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
To: LTP list <ltp-list@lists.sf.net>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

The following patch kills some unneeded chmod(2) calls on newly
created temporary directory; the tst_tmpdir() function do already set
the correct permissions.

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-tmpdirchmod.diff"

Index: testcases/kernel/syscalls/mkdir/mkdir02.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/mkdir/mkdir02.c,v
retrieving revision 1.8
diff -u -p -r1.8 mkdir02.c
--- testcases/kernel/syscalls/mkdir/mkdir02.c	23 Mar 2009 13:35:54 -0000	1.8
+++ testcases/kernel/syscalls/mkdir/mkdir02.c	7 Jan 2010 10:52:49 -0000
@@ -329,9 +329,6 @@ void setup()
 	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
 
-	/* make it writeable */
-	chmod(".", 0777);
-
 	umask(0);
 }
 
Index: testcases/kernel/syscalls/mkdir/mkdir04.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/mkdir/mkdir04.c,v
retrieving revision 1.9
diff -u -p -r1.9 mkdir04.c
--- testcases/kernel/syscalls/mkdir/mkdir04.c	23 Mar 2009 13:35:54 -0000	1.9
+++ testcases/kernel/syscalls/mkdir/mkdir04.c	7 Jan 2010 10:52:49 -0000
@@ -235,9 +235,6 @@ void setup()
 	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
 
-	/* give the write rights to all user */
-	chmod(".", 0777);
-
 	umask(0);
 }
 
Index: testcases/kernel/syscalls/rename/rename09.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/rename/rename09.c,v
retrieving revision 1.10
diff -u -p -r1.10 rename09.c
--- testcases/kernel/syscalls/rename/rename09.c	23 Mar 2009 13:36:01 -0000	1.10
+++ testcases/kernel/syscalls/rename/rename09.c	7 Jan 2010 10:52:49 -0000
@@ -264,9 +264,6 @@ void setup()
 	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
 
-	/* give write permission to all users */
-	chmod(".", 0777);
-
 	umask(0);
 
 	sprintf(fdir, "tdir_%d", getpid());
Index: testcases/kernel/syscalls/rename/rename12.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/rename/rename12.c,v
retrieving revision 1.10
diff -u -p -r1.10 rename12.c
--- testcases/kernel/syscalls/rename/rename12.c	23 Mar 2009 13:36:01 -0000	1.10
+++ testcases/kernel/syscalls/rename/rename12.c	7 Jan 2010 10:52:49 -0000
@@ -207,9 +207,6 @@ void setup()
 	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
 
-	/* give the write rights to all user */
-	chmod(".", 0777);
-
 	umask(0);
 
 	sprintf(fdir, "./tdir_%d", getpid());
Index: testcases/kernel/syscalls/rmdir/rmdir03.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/rmdir/rmdir03.c,v
retrieving revision 1.11
diff -u -p -r1.11 rmdir03.c
--- testcases/kernel/syscalls/rmdir/rmdir03.c	23 Mar 2009 13:36:01 -0000	1.11
+++ testcases/kernel/syscalls/rmdir/rmdir03.c	7 Jan 2010 10:52:49 -0000
@@ -338,9 +338,6 @@ void setup()
 	/* Create a temporary directory and make it current. */
 	tst_tmpdir();
 
-	/* give write permission to all users */
-	chmod(".", 0777);
-
 	umask(0);
 
 	sprintf(tstdir1, "./tstdir1_%d", getpid());

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--ew6BAiZeqk4r7MaW--

