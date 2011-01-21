Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cristian@regolo.cc>) id 1PgEBa-0005sQ-82
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 10:25:42 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgEBU-0005qJ-5i
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 10:25:42 +0000
Received: from regolo (93-46-43-128.ip106.fastwebnet.it [93.46.43.128])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 3470A64
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 11:25:20 +0100 (CET)
Date: Fri, 21 Jan 2011 11:25:17 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110121112517.0d468826@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Various fixes for manpages.
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

please merge some small fixes for manpages (typos, outdated content
and file permissions).

Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 doc/man1/ltp-pan.1           |    4 ++--
 doc/man3/parse_opts.3        |    4 +---
 doc/man3/tst_res.3           |    6 +++---
 doc/man3/usctest.3           |    5 ++---
 4 files changed, 8 insertions(+), 11 deletions(-)
 mode change 100755 => 100644 doc/man3/random_range.3
 mode change 100755 => 100644 doc/man3/random_range_seed.3

diff --git a/doc/man1/ltp-pan.1 b/doc/man1/ltp-pan.1
index 16893ee..1359c78 100644
--- a/doc/man1/ltp-pan.1
+++ b/doc/man1/ltp-pan.1
@@ -144,7 +144,7 @@ specified for \fI-x\fP then it is bumped up to be equal to the value of
 Indicates the length that ltp-pan should run tests. By default this is not set.  If specified, 
 the \fI-s\fP flag is automatically set to 0 (infinite).  Presumably, you want as many 
 tests ran during this timeframe. Duration is measured in \fIs\fPeconds, \fIm\fPinutes, 
-\fIh\Pours,OR \fId\Pays.
+\fIh\fPours, or \fId\fPays.
 .TP 1i
 \fB-x \fInactive\fB
 Indicates the number of commands (tags) that should be kept active at any one
@@ -198,7 +198,7 @@ printing the output as a human readable format, with the test output at /tmp/out
 and all failed test commands (if you have any) at /tmp/fail-command-file.
 
 $ ltp-pan -n stress -e -p -q -S -t 24h -a stress -l logfile -f command-file \
-		-o /tmp/output-file -C /tmp/fail-command-file
+-o /tmp/output-file -C /tmp/fail-command-file
 
 .SH LAYERING
 
diff --git a/doc/man3/parse_opts.3 b/doc/man3/parse_opts.3
index 525554a..abba0d5 100644
--- a/doc/man3/parse_opts.3
+++ b/doc/man3/parse_opts.3
@@ -115,7 +115,7 @@ Run for \fIn\fR iterations. A value of 0 makes the test loop infinitely.
 The test will loop until \fIx\fR seconds have passed. (default 0.0)
 .TP
 .B \-p
-Pause for SIGUSR1 before testing. The test will pause were you place
+Pause for SIGUSR1 before testing. The test will pause where you place
 TEST_PAUSE.  \fIWarning\fR: The test will also fork at this point if \-c is
 used.  
 .TP
@@ -177,5 +177,3 @@ int main(int argc, char *argv[])
 .fi
 .SH "SEE ALSO"
 usctest(3), getopt(3).
-
-
diff --git a/doc/man3/random_range.3 b/doc/man3/random_range.3
old mode 100755
new mode 100644
diff --git a/doc/man3/random_range_seed.3 b/doc/man3/random_range_seed.3
old mode 100755
new mode 100644
diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
index d1a1c50..03e8f24 100644
--- a/doc/man3/tst_res.3
+++ b/doc/man3/tst_res.3
@@ -37,9 +37,9 @@ tst_res \- Print result message, including file contents
 .sp
 tst_resm \- Print result message
 .sp
-tst_brk \- Print result message and break remaining test cases
+tst_brk \- Print result message, including file contents, and break remaining test cases
 .sp
-tst_brkm \- Print result message, including file contents, and break remaining test cases
+tst_brkm \- Print result message and break remaining test cases
 .sp
 tst_flush \- Print any messages pending because of CONDENSE mode, and flush output stream
 .sp
@@ -74,7 +74,7 @@ extern int Tst_range;
 .SH DESCRIPTION
 .SS Introduction
 This library of functions are used by UNICOS tests to report results to
-standard out in a consistent manner.  It is assumed that tests using this
+standard output in a consistent manner.  It is assumed that tests using this
 library have a distinct number of test cases, and that each test case is
 distinct and uniquely identified by the test case number.  It is also assumed
 that test case results are printed in consecutive order, starting with 1.
diff --git a/doc/man3/usctest.3 b/doc/man3/usctest.3
index 8407803..d52968c 100644
--- a/doc/man3/usctest.3
+++ b/doc/man3/usctest.3
@@ -114,8 +114,7 @@ The \fBparse_opts\fR routine parses the command line (see \fBparse_opts(3)\fR).
 variables used are set by the \fBparse_opts(3)\fR routine.
 
 .SH EXAMPLES
-Below is a partial template of a system call test using these routines, macros, and global variables.  A complete
-template may be found in the CUTS/sun/skel directory, in the file \fBusctest.c\fR.
+Below is a partial template of a system call test using these routines, macros, and global variables.
 
 .nf
 void
@@ -143,7 +142,7 @@ int main(ac, av)
 	setup();	/* execute setup */
 
 	/* parse options */
-	msg=parse_opts(ac, av, (option_t *)NULL);
+	msg=parse_opts(ac, av, (option_t *)NULL, NULL);
 
 	/* Check parse_opts return */
 
-- 
1.7.2.3


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
