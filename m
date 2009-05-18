Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M66ac-0003HB-Ea
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 17:25:26 +0000
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id EB08393717
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 May 2009 19:24:30 +0200 (CEST)
Date: Mon, 18 May 2009 19:24:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090518172430.GA14257@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Subject: [LTP]  [PATCH] Renaming binaries to avoid conflicts
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


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this is second try. I've cleaned scanner, bump and pan source a bit, but most
of the pan source is broken by desing :(.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--bp/iNruPH9dso1Pn
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="add_ltp_prefix.patch"

Index: ltp-full-20090430/doc/automation-README.html
===================================================================
--- ltp-full-20090430.orig/doc/automation-README.html
+++ ltp-full-20090430/doc/automation-README.html
@@ -60,7 +60,7 @@ is unavailable.<br>
 options:</li>
    
   <ul>
-     <li>ex: <i>${LTPROOT}/pan/pan -l $PAN_LOG -e -S $instances $time -a
+     <li>ex: <i>${LTPROOT}/pan/ltp-pan -l $PAN_LOG -e -S $instances $time -a
 $$ -n $$ -f ${TMP}/alltests</i></li>
    
   </ul>
Index: ltp-full-20090430/doc/automation-cookbook.html
===================================================================
--- ltp-full-20090430.orig/doc/automation-cookbook.html
+++ ltp-full-20090430/doc/automation-cookbook.html
@@ -60,7 +60,7 @@ is unavailable.<br>
 options:</li>
    
   <ul>
-     <li>ex: <i>${LTPROOT}/pan/pan -l $PAN_LOG -e -S $instances $time -a
+     <li>ex: <i>${LTPROOT}/pan/ltp-pan -l $PAN_LOG -e -S $instances $time -a
 $$ -n $$ -f ${TMP}/alltests</i></li>
    
   </ul>
Index: ltp-full-20090430/doc/ltp-howto.lyx
===================================================================
--- ltp-full-20090430.orig/doc/ltp-howto.lyx
+++ ltp-full-20090430/doc/ltp-howto.lyx
@@ -253,7 +253,7 @@ Testing Tools
 The Linux Test Project has not yet decided on a "final" test harness.
   We have provided a simple solution with 
 \family typewriter 
-pan
+ltp-pan
 \family default 
  to make due until a complete solution has been found/created that compliments
  the Linux kernel development process.
@@ -263,24 +263,24 @@ pan
    
 \layout Subsection
 
-Pan
+Ltp-pan
 \layout Standard
 
 
 \family typewriter 
-pan
+ltp-pan
 \family default 
  is a simple test driver with the ability to keep track of orphaned processes
  and capture test output.
  It works by reading a list of test tags and command lines and runs them.
- By default pan will select a command randomly from the list of test tags,
+ By default ltp-pan will select a command randomly from the list of test tags,
  wait for it to finish.
  Through command line options you can run through the entire list sequentially,
  run n tests, keep n test running at all times, and buffer test output.
- Pan can be nested to create very complex test environments.
+ Ltp-pan can be nested to create very complex test environments.
 \layout Standard
 
-Pan uses an 
+Ltp-pan uses an 
 \emph on 
 active file
 \emph default 
@@ -290,11 +290,11 @@ zoo file
 \emph default 
  to keep track of which tests are currently running.
  This file holds the pid, tag, and a portion of the command line.
- When you start pan it becomes a test tag in itself, thus it requires a
+ When you start ltp-pan it becomes a test tag in itself, thus it requires a
  name for itself.
- Pan updates the active file to show which test tags are currently running.
- When a test tag exits, pan will overwrite the first character with a '#'.
- The active file can be shared between multiple instances of pan so you
+ Ltp-pan updates the active file to show which test tags are currently running.
+ When a test tag exits, ltp-pan will overwrite the first character with a '#'.
+ The active file can be shared between multiple instances of ltp-pan so you
  know which tests were running when the system crashes by looking at one
  file.
  
@@ -302,10 +302,10 @@ zoo file
 
 A 
 \emph on 
-pan file
+ltp-pan file
 \emph default 
- contains a list of test tags for pan to run.
- The format of a pan file is as follows:
+ contains a list of test tags for ltp-pan to run.
+ The format of a ltp-pan file is as follows:
 \layout Code
 
 
@@ -321,7 +321,7 @@ testtag testprogram -o one -p two other 
 
 
 \latex no_latex 
-# tags in your pan file.
+# tags in your ltp-pan file.
  Tests programs can have different 
 \layout Code
 
@@ -397,7 +397,7 @@ kill09 kill09 
 
 
 \latex no_latex 
-fs-suite01 pan -e -a fs-suite01.zoo -n fs-suite01 -f runtest/fs
+fs-suite01 ltp-pan -e -a fs-suite01.zoo -n fs-suite01 -f runtest/fs
 \layout Code
 
 
@@ -407,7 +407,7 @@ fs-suite01 pan -e -a fs-suite01.zoo -n f
 
 The test tags are simple identifiers, no spaces are allowed.
  The test of the line is the program to run, which is done using execvp(3).
- Lines starting with '#' are comments and ignored by pan.
+ Lines starting with '#' are comments and ignored by ltp-pan.
  It is a good practice to include descriptions with your test tags so you
  can have a reminder what a certain obscure test tag tries to do.
 \layout Subsubsection
@@ -415,7 +415,7 @@ The test tags are simple identifiers, no
 Examples
 \layout Standard
 
-The most basic way to run pan is by passing the test program and parameters
+The most basic way to run ltp-pan is by passing the test program and parameters
  on the command line.
  This will run the single program once and wrap the output.
  
@@ -423,7 +423,7 @@ The most basic way to run pan is by pass
 
 
 \latex no_latex 
-$ pan -a ltp.zoo -n tutor sleep 4
+$ ltp-pan -a ltp.zoo -n tutor sleep 4
 \layout Code
 
 
@@ -484,7 +484,7 @@ $ cat ltp.zoo
 
 
 \latex no_latex 
-#9357,tutor,pan/pan -a ltp.zoo -n tutor sleep 4 
+#9357,tutor,pan/ltp-pan -a ltp.zoo -n tutor sleep 4 
 \layout Code
 
 
@@ -500,8 +500,8 @@ $ 
 How it works
 \layout Standard
 
-This example shows the two parameters that are always required by pan, the
- active file and a test tag for pan.
+This example shows the two parameters that are always required by ltp-pan, the
+ active file and a test tag for ltp-pan.
  The 
 \begin_inset Quotes eld
 \end_inset 
@@ -510,7 +510,7 @@ sleep 4
 \begin_inset Quotes erd
 \end_inset 
 
- on the end of the command line is a test program and parameters that pan
+ on the end of the command line is a test program and parameters that ltp-pan
  should run.
  This test is given the tag 
 \begin_inset Quotes eld
@@ -520,8 +520,8 @@ cmdln.
 \begin_inset Quotes erd
 \end_inset 
 
- Pan will run one test randomly, which ends up being cmdln since it is the
- only test that we told pan about.
+ Ltp-pan will run one test randomly, which ends up being cmdln since it is the
+ only test that we told ltp-pan about.
  
 \layout Standard
 
@@ -529,12 +529,12 @@ In the active file, 
 \family typewriter 
 ltp.zoo
 \family default 
-, pan writes the pid, test tag, and part of the command line for the currently
+, ltp-pan writes the pid, test tag, and part of the command line for the currently
  running tests.
  The command lines are truncated so each line will fit on an 80 column display.
- When a test tag finishes, pan will place a '#' at the beginning of the
+ When a test tag finishes, ltp-pan will place a '#' at the beginning of the
  line to mark it as available.
- Here you can see that cmdln and tutor, the name we gave pan, ran to completion.
+ Here you can see that cmdln and tutor, the name we gave ltp-pan, ran to completion.
  If the computer hangs, you can read this file to see which test programs
  were running.
 \layout Standard
@@ -547,7 +547,7 @@ We have run one test once.
 
 
 \latex no_latex 
-$ pan -a ltp.zoo -n tutor -x 3 -s 3 -O /tmp sleep 1
+$ ltp-pan -a ltp.zoo -n tutor -x 3 -s 3 -O /tmp sleep 1
 \layout Code
 
 
@@ -744,15 +744,15 @@ In this example we run another fake test
  
 \layout Itemize
 
-Using a pan file to run multiple tests
+Using a ltp-pan file to run multiple tests
 \layout Itemize
 
-Nesting pan
+Nesting ltp-pan
 \layout Standard
 
-For more information on pan see the man page 
+For more information on ltp-pan see the man page 
 \family typewriter 
-doc/man1/pan.1
+doc/man1/ltp-pan.1
 \family default 
 .
 \layout Subsection
@@ -762,7 +762,7 @@ Scanner
 
 
 \family typewriter 
-scanner
+Ltp-scanner
 \family default 
  is a results analysis tool that understands the 
 \emph on 
@@ -770,7 +770,7 @@ rts
 \emph default 
  style output which 
 \family typewriter 
-pan
+ltp-pan
 \family default 
  generates by default.
  It will produce a table summarizing which tests passed and which failed.
@@ -936,7 +936,7 @@ Test\SpecialChar ~
 Driver A program that handles the execution of test programs.
  It is responsible for starting the test programs, capturing their output,
  and recording their results.
- Pan is an example of a test driver.
+ Ltp-pan is an example of a test driver.
 \layout Description
 
 Test\SpecialChar ~
Index: ltp-full-20090430/doc/ltp-howto.txt
===================================================================
--- ltp-full-20090430.orig/doc/ltp-howto.txt
+++ ltp-full-20090430/doc/ltp-howto.txt
@@ -154,44 +154,44 @@ the results. 
 5 Testing Tools
 
 The Linux Test Project has not yet decided on a "final" test
-harness.  We have provided a simple solution with pan to
+harness.  We have provided a simple solution with ltp-pan to
 make due until a complete solution has been found/created
 that compliments the Linux kernel development process. 
 Several people have said we should use such and such a test
 harness. Until we find we need a large complex test harness,
 we will apply the KISS concept.   
 
-5.1 Pan
+5.1 Ltp-pan
 
-pan is a simple test driver with the ability to keep track
+Ltp-pan is a simple test driver with the ability to keep track
 of orphaned processes and capture test output. It works
 by reading a list of test tags and command lines and runs
-them. By default pan will select a command randomly from
+them. By default ltp-pan will select a command randomly from
 the list of test tags, wait for it to finish. Through command
 line options you can run through the entire list sequentially,
 run n tests, keep n test running at all times, and buffer
-test output. Pan can be nested to create very complex test
+test output. Ltp-pan can be nested to create very complex test
 environments.
 
-Pan uses an active file, also called a zoo file to keep track
+Ltp-pan uses an active file, also called a zoo file to keep track
 of which tests are currently running. This file holds the
 pid, tag, and a portion of the command line. When you start
-pan it becomes a test tag in itself, thus it requires a
-name for itself. Pan updates the active file to show which
+ltp-pan it becomes a test tag in itself, thus it requires a
+name for itself. Ltp-pan updates the active file to show which
 test tags are currently running. When a test tag exits,
-pan will overwrite the first character with a '#'. The active
-file can be shared between multiple instances of pan so
+ltp-pan will overwrite the first character with a '#'. The active
+file can be shared between multiple instances of ltp-pan so
 you know which tests were running when the system crashes
 by looking at one file. 
 
-A pan file contains a list of test tags for pan to run. The
-format of a pan file is as follows:
+A ltp-pan file contains a list of test tags for ltp-pan to run. The
+format of a ltp-pan file is as follows:
 
 testtag testprogram -o one -p two other command line options
 
 # This is a comment. It is a good idea to describe the test 
 
-# tags in your pan file. Tests programs can have different 
+# tags in your ltp-pan file. Tests programs can have different 
 
 # behaviors depending on the command line options so it is 
 
@@ -222,24 +222,24 @@ kill09 kill09 
 
 # Basic test for kill(2)
 
-fs-suite01 pan -e -a fs-suite01.zoo -n fs-suite01 -f runtest/fs
+fs-suite01 ltp-pan -e -a fs-suite01.zoo -n fs-suite01 -f runtest/fs
 
 # run the entire set of file system tests
 
 The test tags are simple identifiers, no spaces are allowed.
 The test of the line is the program to run, which is done
 using execvp(3). Lines starting with '#' are comments and
-ignored by pan. It is a good practice to include descriptions
+ignored by ltp-pan. It is a good practice to include descriptions
 with your test tags so you can have a reminder what a certain
 obscure test tag tries to do.
 
 5.1.1 Examples
 
-The most basic way to run pan is by passing the test program
+The most basic way to run ltp-pan is by passing the test program
 and parameters on the command line. This will run the single
 program once and wrap the output. 
 
-$ pan -a ltp.zoo -n tutor sleep 4
+$ ltp-pan -a ltp.zoo -n tutor sleep 4
 
 <<<test_start>>> 
 
@@ -264,7 +264,7 @@ corefile=no cutime=0 cstime=0
 
 $ cat ltp.zoo
 
-#9357,tutor,pan/pan -a ltp.zoo -n tutor sleep 4 
+#9357,tutor,pan/ltp-pan -a ltp.zoo -n tutor sleep 4 
 
 #9358,cmdln,sleep 4
 
@@ -273,27 +273,27 @@ $ 
 How it works
 
 This example shows the two parameters that are always required
-by pan, the active file and a test tag for pan. The "sleep
+by ltp-pan, the active file and a test tag for ltp-pan. The "sleep
 4" on the end of the command line is a test program and
-parameters that pan should run. This test is given the tag
-"cmdln." Pan will run one test randomly, which ends
-up being cmdln since it is the only test that we told pan
+parameters that ltp-pan should run. This test is given the tag
+"cmdln." Ltp-pan will run one test randomly, which ends
+up being cmdln since it is the only test that we told ltp-pan
 about. 
 
-In the active file, ltp.zoo, pan writes the pid, test tag,
+In the active file, ltp.zoo, ltp-pan writes the pid, test tag,
 and part of the command line for the currently running tests.
 The command lines are truncated so each line will fit on
-an 80 column display. When a test tag finishes, pan will
+an 80 column display. When a test tag finishes, ltp-pan will
 place a '#' at the beginning of the line to mark it as available.
 Here you can see that cmdln and tutor, the name we gave
-pan, ran to completion. If the computer hangs, you can read
+ltp-pan, ran to completion. If the computer hangs, you can read
 this file to see which test programs were running.
 
 We have run one test once. Let's do something a little more
 exciting. Let's run one test several times, at the same
 time. 
 
-$ pan -a ltp.zoo -n tutor -x 3 -s 3 -O /tmp sleep 1
+$ ltp-pan -a ltp.zoo -n tutor -x 3 -s 3 -O /tmp sleep 1
 
 <<<test_start>>>
 
@@ -380,16 +380,16 @@ the output of each test tag. You can see
 cmdln ran three times. If the -O option were omitted, your
 test output would be mixed, making it almost worthless. 
 
-* Using a pan file to run multiple tests
+* Using a ltp-pan file to run multiple tests
 
-* Nesting pan
+* Nesting ltp-pan
 
-For more information on pan see the man page doc/man1/pan.1.
+For more information on ltp-pan see the man page doc/man1/ltp-pan.1.
 
 5.2 Scanner
 
-scanner is a results analysis tool that understands the rts
-style output which pan generates by default. It will produce
+Ltp-scanner is a results analysis tool that understands the rts
+style output which ltp-pan generates by default. It will produce
 a table summarizing which tests passed and which failed.
   
 
@@ -475,7 +475,7 @@ Test Case A test assertion with a single
 Test Driver A program that handles the execution of
   test programs. It is responsible for starting the test
   programs, capturing their output, and recording their
-  results. Pan is an example of a test driver.
+  results. Ltp-pan is an example of a test driver.
 
 Test Framework A mechanism for organizing a group of
   tests.  Frameworks may have complex or very simple API's,
Index: ltp-full-20090430/doc/man1/Makefile
===================================================================
--- ltp-full-20090430.orig/doc/man1/Makefile
+++ ltp-full-20090430/doc/man1/Makefile
@@ -1,7 +1,7 @@
 
 
 PREFIX=/usr
-MANPAGES=bump.1 doio.1 iogen.1 pan.1
+MANPAGES=ltp-bump.1 doio.1 iogen.1 ltp-pan.1
 
 all:
 
Index: ltp-full-20090430/doc/man1/bump.1
===================================================================
--- ltp-full-20090430.orig/doc/man1/bump.1
+++ /dev/null
@@ -1,80 +0,0 @@
-.\"
-.\" $Id: bump.1,v 1.1 2000/09/14 21:54:44 nstraz Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\" 
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\" 
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\" 
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\" 
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc., 59
-.\" Temple Place - Suite 330, Boston MA 02111-1307, USA.
-.\" 
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\" 
-.\" http://www.sgi.com 
-.\" 
-.\" For further information regarding this notice, see: 
-.\" 
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.\"
-.TH BUMP 1 "14 Sep 2000" "LTP" "Linux Test Project"
-.SH NAME
-bump \- send signal to tags run by pan
-.SH SYNOPSIS
-\fBbump [-1] [-s \fIsig\fB] [\fI-a active-file\fB] [tags...]
-.SH DESCRIPTION
-
-Bump will send a SIGINT signal to processes, given that each process has a
-corresponding tag in an active-file.  The active-file is the same one that is
-used by the pan to start the processes.
-
-If the active file has multiple occurrences of a single tag name then only the
-first process will be signaled.  You may specify the tag name multiple times
-on the commandline if necessary.
-
-.TP 1i
-\fB-1\fP
-Send a SIGUSR1 signal.  By default a SIGINT will be sent.
-.TP 1i
-\fB-a \fIactive_file\fB
-A file containing the tagnames, pids, and commands being run by a pan.  If this
-is not specified then the ZOO environment variable will be read for the name of
-the directory where the active file can be found.
-.TP 1i
-\fB-s \fIsig\fB
-Used to specify a signal number to send.  By default a SIGINT will be sent.
-
-.in -1i
-
-.SH ENVIRONMENT
-.TP
-ZOO
-If set, should name the directory where the active file can be found.
-This is ignored if \fI-a\fP is specified.
-
-.SH FILES
-.TP
-active
-Default name of active file if \fI-a\fP is not specified.  This is prefixed
-by the directory name found in the ZOO environment variable.
-
-.SH "SEE ALSO"
-Zoo tools - pan(1)
-
-.SH DIAGNOSTICS
-Exits zero, unless it cannot find the active file or if there were no tags
-listed on the commandline.
Index: ltp-full-20090430/doc/man1/ltp-bump.1
===================================================================
--- /dev/null
+++ ltp-full-20090430/doc/man1/ltp-bump.1
@@ -0,0 +1,80 @@
+.\"
+.\" $Id: ltp-bump.1,v 1.1 2000/09/14 21:54:44 nstraz Exp $
+.\"
+.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+.\" 
+.\" This program is free software; you can redistribute it and/or modify it
+.\" under the terms of version 2 of the GNU General Public License as
+.\" published by the Free Software Foundation.
+.\" 
+.\" This program is distributed in the hope that it would be useful, but
+.\" WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+.\" 
+.\" Further, this software is distributed without any warranty that it is
+.\" free of the rightful claim of any third person regarding infringement
+.\" or the like.  Any license provided herein, whether implied or
+.\" otherwise, applies only to this software file.  Patent licenses, if
+.\" any, provided herein do not apply to combinations of this program with
+.\" other software, or any other product whatsoever.
+.\" 
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write the Free Software Foundation, Inc., 59
+.\" Temple Place - Suite 330, Boston MA 02111-1307, USA.
+.\" 
+.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+.\" Mountain View, CA  94043, or:
+.\" 
+.\" http://www.sgi.com 
+.\" 
+.\" For further information regarding this notice, see: 
+.\" 
+.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+.\"
+.TH BUMP 1 "14 Sep 2000" "LTP" "Linux Test Project"
+.SH NAME
+ltp-bump \- send signal to tags run by ltp-pan
+.SH SYNOPSIS
+\fBltp-bump [-1] [-s \fIsig\fB] [\fI-a active-file\fB] [tags...]
+.SH DESCRIPTION
+
+Bump will send a SIGINT signal to processes, given that each process has a
+corresponding tag in an active-file.  The active-file is the same one that is
+used by the ltp-pan to start the processes.
+
+If the active file has multiple occurrences of a single tag name then only the
+first process will be signaled.  You may specify the tag name multiple times
+on the commandline if necessary.
+
+.TP 1i
+\fB-1\fP
+Send a SIGUSR1 signal.  By default a SIGINT will be sent.
+.TP 1i
+\fB-a \fIactive_file\fB
+A file containing the tagnames, pids, and commands being run by a ltp-pan.  If this
+is not specified then the ZOO environment variable will be read for the name of
+the directory where the active file can be found.
+.TP 1i
+\fB-s \fIsig\fB
+Used to specify a signal number to send.  By default a SIGINT will be sent.
+
+.in -1i
+
+.SH ENVIRONMENT
+.TP
+ZOO
+If set, should name the directory where the active file can be found.
+This is ignored if \fI-a\fP is specified.
+
+.SH FILES
+.TP
+active
+Default name of active file if \fI-a\fP is not specified.  This is prefixed
+by the directory name found in the ZOO environment variable.
+
+.SH "SEE ALSO"
+Zoo tools - ltp-pan(1)
+
+.SH DIAGNOSTICS
+Exits zero, unless it cannot find the active file or if there were no tags
+listed on the commandline.
Index: ltp-full-20090430/doc/man1/ltp-pan.1
===================================================================
--- /dev/null
+++ ltp-full-20090430/doc/man1/ltp-pan.1
@@ -0,0 +1,262 @@
+.\"
+.\" $Id: ltp-pan.1,v 1.5 2007/07/25 10:12:03 subrata_modak Exp $
+.\"
+.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+.\" 
+.\" This program is free software; you can redistribute it and/or modify it
+.\" under the terms of version 2 of the GNU General Public License as
+.\" published by the Free Software Foundation.
+.\" 
+.\" This program is distributed in the hope that it would be useful, but
+.\" WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+.\" 
+.\" Further, this software is distributed without any warranty that it is
+.\" free of the rightful claim of any third person regarding infringement
+.\" or the like.  Any license provided herein, whether implied or
+.\" otherwise, applies only to this software file.  Patent licenses, if
+.\" any, provided herein do not apply to combinations of this program with
+.\" other software, or any other product whatsoever.
+.\" 
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write the Free Software Foundation, Inc., 59
+.\" Temple Place - Suite 330, Boston MA 02111-1307, USA.
+.\" 
+.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+.\" Mountain View, CA  94043, or:
+.\" 
+.\" http://www.sgi.com 
+.\" 
+.\" For further information regarding this notice, see: 
+.\" 
+.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+.TH PAN 1 "19 Feb 2002" "LTP" "Linux Test Project"
+.SH NAME
+ltp-pan \- A light-weight driver to run tests and clean up their pgrps
+.SH SYNOPSIS
+\fBltp-pan -n tagname [-SyAehp] [-t #s|m|h|d \fItime\fB] [-s \fIstarts\fB] [\fI-x nactive\fB] [\fI-l logfile\fB] [\fI-a active-file\fB] [\fI-f command-file\fB] [\fI-d debug-level\fB] [\fI-o output-file\fB] [\fI-O buffer_directory\fB] [\fI-r report_type\fB] [\fI-C fail-command-file\fB] [cmd]
+.SH DESCRIPTION
+
+Pan will run a command, as specified on the commandline, or collection of
+commands from a command-file.  By default ltp-pan runs one command, choosing it at
+random from the whole set of commands available to it.  The ltp-pan's name in the
+active file is specified by the tagname.  When a command terminates ltp-pan will
+kill any orphans that may have been left behind in its pgrp.  If ltp-pan is
+signaled it will kill any active commands and, again, clean up any orphans.
+
+Pan uses the signal ratchet found in other zoo tools.  The first time ltp-pan is
+signaled it sends a SIGTERM to the active pgrps; the second time it sends
+SIGHUP; the third time a SIGINT; after that it always sends SIGKILL.
+
+Pan will not terminate until all the active commands and everything in their
+pgrps is dead.  It will loop around at 5 second intervals, triggering its own
+signal ratchet, until it succeeds in killing the pgrps.
+
+When the ltp-pan starts up it places its own tagname and commandline in the active
+file and begins scheduling commands.  After a command is started ltp-pan puts an
+entry for it into the active file with its indicated tagname.  If the command
+was specified on the command line, rather than in the command-file, then its
+tagname will be "cmdln".  When a process terminates ltp-pan frees the active file
+entry.  If a command terminates and leaves an orphaned pgrp then ltp-pan will put
+an entry into the active file called "panorphan" which will be removed only
+when the orphaned pgrp is cleaned up.  Before ltp-pan exits it will ensure that
+all orphaned pgrps are dead (see above) and then it will remove its own
+tagname from the active file.
+
+The command-file is a file containing tag/command pairs.  Each line in the
+file begins with a tag identifying the command, followed by white space, and
+then the command and its arguments.  A line beginning with the # character is
+a comment.  Pan recognizes the token "%f" in a command's arguments and
+replaces it with a unique identifier--add this to filename arguments to
+prevent two instances of the command from interfering with each other.
+
+When ltp-pan receives a SIGUSR2 it stops scheduling new tests and waits for the
+active tests to terminate.  If the \fB-y\fP option was used then it will begin
+scheduling again, otherwise it will exit.  It does not propagate the SIGUSR2.
+
+.TP 1i
+\fB-A\fP
+The all-stop flag.  If any command exits non-zero ltp-pan will shutdown its
+scheduler and signal any active pgrps.  The ltp-pan will exit non-zero after
+everything is shut down.  By default ltp-pan ignores command exit statuses.
+The \fI-e\fP option is implied when this option is used.
+.TP 1i
+\fB-a \fIactive_file\fB
+A file containing the tagnames, pids, and commands being run.  If this is
+not specified then the ZOO environment variable will be read for the name
+of a directory where the active file will be placed, and in this case the
+active file's name will be "active".  A single active file may be shared
+by any number of Zoo tools.
+.TP 1i
+\fB-C \fIfail-command-file\fB
+The file to which all failed test commands will be saved.  You can use it later with \fI-f\fP option if you want to run only the failed test cases.
+.TP 1i
+\fB-d \fIdebug-level\fB
+See the source for settings.
+.TP 1i
+\fB-e\fP
+Pan will exit non-zero if any of its commands exited non-zero.  By default
+ltp-pan ignores command exit statuses.
+.TP 1i
+\fB-f \fIcommand-file\fB
+The file that has a collection of commands that ltp-pan will execute.
+.TP 1i
+\fB-h\fP
+Print some simple help.
+.TP 1i
+\fB-l \fIlogfile\fB
+Name of a log file to be used to store exit information for each of the
+commands (tags) that are run.  This log file may not be shared with other Zoo
+tools or other ltp-pan processes.
+.TP 1i
+\fB-n \fItagname\fB
+The tagname by which this ltp-pan process will be known by the zoo tools.  This
+is a required argument.
+.TP 1i
+\fB-o \fIoutput_file\fB
+The file to which all test output will be saved.  Normally all test output is sent to standard output.  This includes each test's standard output and standard error.
+.TP 1i
+\fB-O \fIbuffer_directory\fB
+A directory where ltp-pan can place temporary files to capture test output.  This will prevent output from several tests mixing together in the output file.
+.TP 1i
+\fB-p\fP
+Enables printing results in human readable format.
+.TP 1i
+\fB-r \fIreport_type\fB
+This controls the type of output that ltp-pan will produce.  Supported formats are \fIrts\fP and \fInone\fP.  The default is \fIrts\fP.
+.TP 1i
+\fB-S\fP
+Causes ltp-pan to run commands (tags) sequentially, as they are listed in the
+command-file.  By default it chooses tags randomly.  If a command is specified
+on the commandline and a command-file is also specified, then the commandline
+tag will be the last command.  If this is specified and \fI-s\fP is not
+specified then the default setting for \fI-s\fP is equal to the total number
+of commands.
+.TP 1i
+\fB-s \fIstarts\fB
+Indicates the number of commands (tags) that should be run before terminating.
+Set this to zero to run forever.  By default this is set to 1 (but see
+\fI-S\fP for an exception).  If this is specified and is less than the value
+specified for \fI-x\fP then it is bumped up to be equal to the value of
+\fI-x\fP (in other words, \fI-x\fP is always satisfied).
+.TP 1i
+\fB-t #s|m|h|d \fItime\fB
+Indicates the length that ltp-pan should run tests. By default this is not set.  If specified, 
+the \fI-s\fP flag is automatically set to 0 (infinite).  Presumably, you want as many 
+tests ran during this timeframe. Duration is measured in \fIs\fPeconds, \fIm\fPinutes, 
+\fIh\Pours,OR \fId\Pays.
+.TP 1i
+\fB-x \fInactive\fB
+Indicates the number of commands (tags) that should be kept active at any one
+time.  If this is greater than 1 then it is possible to have multiple
+instances of the same tag active at once.  By default this is 1.
+.TP 1i
+\fB-y\fP
+Causes the ltp-pan scheduler to go idle if a signal is received or if a command
+exits non-zero.  All active commands and their pgrps will be killed.  After
+everything is dead the scheduler will restart again where it left off.  If the
+signal is SIGUSR1 then ltp-pan will behave as if \fI-y\fP had not been specified.
+
+.in -1i
+
+.SH EXAMPLES
+
+In practice, the ZOO environment variable is generally prefered over the
+\fI-a\fP option.  All examples assume this is being set.
+
+The following creates a ltp-pan named "ex1" with an active file in /tmp/active.
+It runs the command "echo hello", keeping 3 copies running at all times,
+running 10 copies before terminating.
+
+$ export ZOO=/tmp
+.br
+$ ltp-pan -n ex1 -s 10 -x 3 echo hello
+
+The next example will use this command file.  Call this /tmp/cmds1.
+.br
+----------cut------
+.br
+fido    ls /bin
+.br
+rover   echo hello wally
+.br
+gidget  sleep 2
+.br
+lassie  ls /etc
+.br
+----------cut------
+.br
+
+Using the above command file, /tmp/cmds1, run one command at a time,
+sequentially, running each command only once.  If one command should fail then
+terminate immediately.  An exit log is kept for all the commands.
+
+$ ltp-pan -n ex3 -S -A -f /tmp/cmds1 -l ex3.log
+
+Here is just a simple stress case. In this case the test will run for 24 hours,
+printing the output as a human readable format, with the test output at /tmp/output-file
+and all failed test commands (if you have any) at /tmp/fail-command-file.
+
+$ ltp-pan -n stress -e -p -q -S -t 24h -a stress -l logfile -f command-file \
+		-o /tmp/output-file -C /tmp/fail-command-file
+
+.SH LAYERING
+
+Pan is often used in layers.  This section extends the above examples to show
+how this is done.
+
+The next example will use this command file.  Call this /tmp/cmds2.  Note that
+the embedded ltp-pans inside this file have exit logs, and that %f is used to give
+each ltp-pan a unique log file name.
+.br
+----------cut------
+.br
+larry  ltp-pan -n ex4b -s10 -A -l ex4_%f.log echo hello
+.br
+curly  ltp-pan -n ex4c -S -A -f /tmp/cmds1 -l ex4_%f.log
+.br
+moe    echo done here
+.br
+----------cut------
+.br
+
+The following will run commands from the command file, keeping two at a time
+running, choosing them sequentially, and terminating if any of them exits
+non-zero.
+
+$ ltp-pan -n ex4 -x2 -A -S -f /tmp/cmds2
+
+Now run the commands in /tmp/cmds2, but this time we want to recover if one of
+the commands should exit non-zero.  In this example it is possible for the
+"larry" or "curly" tags to exit non-zero.  When this happens the ltp-pan will kill
+all active tags, making sure both larry and curly are dead, and then will
+continue scheduling--ensuring that our "done here" message comes out no matter
+what.
+
+$ ltp-pan -n ex5 -x2 -A -S -y -f /tmp/cmds2
+
+.SH ENVIRONMENT
+.TP
+ZOO
+If set, should name the directory where the active file should be placed.
+This is ignored if \fI-a\fP is specified.
+
+.SH FILES
+.TP
+active
+Default name of active file if \fI-a\fP is not specified.  This is prefixed
+by the directory name found in the ZOO environment variable.
+.TP
+PAN_STOP_FILE
+The creation of this file in the defined \fITMP\fP directory will cause ltp-pan to
+execute one more loop and stop.  This is useful when testing needs to be stopped
+before its scheduled stop time (\fI-t\fP).  By doing a 'touch' on this file, testing
+is ended, i.e. touch /tmp/runalltests-2345/PAN_STOP_FILE
+
+.SH "SEE ALSO"
+Zoo tools - ltp-bump(1)
+
+.SH DIAGNOSTICS
+By default it exits zero unless signaled, regardless of the exit status of any
+of the commands it is running.  If \fI-A\fP or \fI-e\fP are specified it exits non-zero if
+it is signaled or if any of the commands it is running should exit non-zero.
Index: ltp-full-20090430/doc/man1/pan.1
===================================================================
--- ltp-full-20090430.orig/doc/man1/pan.1
+++ /dev/null
@@ -1,262 +0,0 @@
-.\"
-.\" $Id: pan.1,v 1.5 2007/07/25 10:12:03 subrata_modak Exp $
-.\"
-.\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
-.\" 
-.\" This program is free software; you can redistribute it and/or modify it
-.\" under the terms of version 2 of the GNU General Public License as
-.\" published by the Free Software Foundation.
-.\" 
-.\" This program is distributed in the hope that it would be useful, but
-.\" WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.\" 
-.\" Further, this software is distributed without any warranty that it is
-.\" free of the rightful claim of any third person regarding infringement
-.\" or the like.  Any license provided herein, whether implied or
-.\" otherwise, applies only to this software file.  Patent licenses, if
-.\" any, provided herein do not apply to combinations of this program with
-.\" other software, or any other product whatsoever.
-.\" 
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write the Free Software Foundation, Inc., 59
-.\" Temple Place - Suite 330, Boston MA 02111-1307, USA.
-.\" 
-.\" Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
-.\" Mountain View, CA  94043, or:
-.\" 
-.\" http://www.sgi.com 
-.\" 
-.\" For further information regarding this notice, see: 
-.\" 
-.\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
-.TH PAN 1 "19 Feb 2002" "LTP" "Linux Test Project"
-.SH NAME
-pan \- A light-weight driver to run tests and clean up their pgrps
-.SH SYNOPSIS
-\fBpan -n tagname [-SyAehp] [-t #s|m|h|d \fItime\fB] [-s \fIstarts\fB] [\fI-x nactive\fB] [\fI-l logfile\fB] [\fI-a active-file\fB] [\fI-f command-file\fB] [\fI-d debug-level\fB] [\fI-o output-file\fB] [\fI-O buffer_directory\fB] [\fI-r report_type\fB] [\fI-C fail-command-file\fB] [cmd]
-.SH DESCRIPTION
-
-Pan will run a command, as specified on the commandline, or collection of
-commands from a command-file.  By default pan runs one command, choosing it at
-random from the whole set of commands available to it.  The pan's name in the
-active file is specified by the tagname.  When a command terminates pan will
-kill any orphans that may have been left behind in its pgrp.  If pan is
-signaled it will kill any active commands and, again, clean up any orphans.
-
-Pan uses the signal ratchet found in other zoo tools.  The first time pan is
-signaled it sends a SIGTERM to the active pgrps; the second time it sends
-SIGHUP; the third time a SIGINT; after that it always sends SIGKILL.
-
-Pan will not terminate until all the active commands and everything in their
-pgrps is dead.  It will loop around at 5 second intervals, triggering its own
-signal ratchet, until it succeeds in killing the pgrps.
-
-When the pan starts up it places its own tagname and commandline in the active
-file and begins scheduling commands.  After a command is started pan puts an
-entry for it into the active file with its indicated tagname.  If the command
-was specified on the command line, rather than in the command-file, then its
-tagname will be "cmdln".  When a process terminates pan frees the active file
-entry.  If a command terminates and leaves an orphaned pgrp then pan will put
-an entry into the active file called "panorphan" which will be removed only
-when the orphaned pgrp is cleaned up.  Before pan exits it will ensure that
-all orphaned pgrps are dead (see above) and then it will remove its own
-tagname from the active file.
-
-The command-file is a file containing tag/command pairs.  Each line in the
-file begins with a tag identifying the command, followed by white space, and
-then the command and its arguments.  A line beginning with the # character is
-a comment.  Pan recognizes the token "%f" in a command's arguments and
-replaces it with a unique identifier--add this to filename arguments to
-prevent two instances of the command from interfering with each other.
-
-When pan receives a SIGUSR2 it stops scheduling new tests and waits for the
-active tests to terminate.  If the \fB-y\fP option was used then it will begin
-scheduling again, otherwise it will exit.  It does not propagate the SIGUSR2.
-
-.TP 1i
-\fB-A\fP
-The all-stop flag.  If any command exits non-zero pan will shutdown its
-scheduler and signal any active pgrps.  The pan will exit non-zero after
-everything is shut down.  By default pan ignores command exit statuses.
-The \fI-e\fP option is implied when this option is used.
-.TP 1i
-\fB-a \fIactive_file\fB
-A file containing the tagnames, pids, and commands being run.  If this is
-not specified then the ZOO environment variable will be read for the name
-of a directory where the active file will be placed, and in this case the
-active file's name will be "active".  A single active file may be shared
-by any number of Zoo tools.
-.TP 1i
-\fB-C \fIfail-command-file\fB
-The file to which all failed test commands will be saved.  You can use it later with \fI-f\fP option if you want to run only the failed test cases.
-.TP 1i
-\fB-d \fIdebug-level\fB
-See the source for settings.
-.TP 1i
-\fB-e\fP
-Pan will exit non-zero if any of its commands exited non-zero.  By default
-pan ignores command exit statuses.
-.TP 1i
-\fB-f \fIcommand-file\fB
-The file that has a collection of commands that pan will execute.
-.TP 1i
-\fB-h\fP
-Print some simple help.
-.TP 1i
-\fB-l \fIlogfile\fB
-Name of a log file to be used to store exit information for each of the
-commands (tags) that are run.  This log file may not be shared with other Zoo
-tools or other pan processes.
-.TP 1i
-\fB-n \fItagname\fB
-The tagname by which this pan process will be known by the zoo tools.  This
-is a required argument.
-.TP 1i
-\fB-o \fIoutput_file\fB
-The file to which all test output will be saved.  Normally all test output is sent to standard output.  This includes each test's standard output and standard error.
-.TP 1i
-\fB-O \fIbuffer_directory\fB
-A directory where pan can place temporary files to capture test output.  This will prevent output from several tests mixing together in the output file.
-.TP 1i
-\fB-p\fP
-Enables printing results in human readable format.
-.TP 1i
-\fB-r \fIreport_type\fB
-This controls the type of output that pan will produce.  Supported formats are \fIrts\fP and \fInone\fP.  The default is \fIrts\fP.
-.TP 1i
-\fB-S\fP
-Causes pan to run commands (tags) sequentially, as they are listed in the
-command-file.  By default it chooses tags randomly.  If a command is specified
-on the commandline and a command-file is also specified, then the commandline
-tag will be the last command.  If this is specified and \fI-s\fP is not
-specified then the default setting for \fI-s\fP is equal to the total number
-of commands.
-.TP 1i
-\fB-s \fIstarts\fB
-Indicates the number of commands (tags) that should be run before terminating.
-Set this to zero to run forever.  By default this is set to 1 (but see
-\fI-S\fP for an exception).  If this is specified and is less than the value
-specified for \fI-x\fP then it is bumped up to be equal to the value of
-\fI-x\fP (in other words, \fI-x\fP is always satisfied).
-.TP 1i
-\fB-t #s|m|h|d \fItime\fB
-Indicates the length that pan should run tests. By default this is not set.  If specified, 
-the \fI-s\fP flag is automatically set to 0 (infinite).  Presumably, you want as many 
-tests ran during this timeframe. Duration is measured in \fIs\fPeconds, \fIm\fPinutes, 
-\fIh\Pours,OR \fId\Pays.
-.TP 1i
-\fB-x \fInactive\fB
-Indicates the number of commands (tags) that should be kept active at any one
-time.  If this is greater than 1 then it is possible to have multiple
-instances of the same tag active at once.  By default this is 1.
-.TP 1i
-\fB-y\fP
-Causes the pan scheduler to go idle if a signal is received or if a command
-exits non-zero.  All active commands and their pgrps will be killed.  After
-everything is dead the scheduler will restart again where it left off.  If the
-signal is SIGUSR1 then pan will behave as if \fI-y\fP had not been specified.
-
-.in -1i
-
-.SH EXAMPLES
-
-In practice, the ZOO environment variable is generally prefered over the
-\fI-a\fP option.  All examples assume this is being set.
-
-The following creates a pan named "ex1" with an active file in /tmp/active.
-It runs the command "echo hello", keeping 3 copies running at all times,
-running 10 copies before terminating.
-
-$ export ZOO=/tmp
-.br
-$ pan -n ex1 -s 10 -x 3 echo hello
-
-The next example will use this command file.  Call this /tmp/cmds1.
-.br
-----------cut------
-.br
-fido    ls /bin
-.br
-rover   echo hello wally
-.br
-gidget  sleep 2
-.br
-lassie  ls /etc
-.br
-----------cut------
-.br
-
-Using the above command file, /tmp/cmds1, run one command at a time,
-sequentially, running each command only once.  If one command should fail then
-terminate immediately.  An exit log is kept for all the commands.
-
-$ pan -n ex3 -S -A -f /tmp/cmds1 -l ex3.log
-
-Here is just a simple stress case. In this case the test will run for 24 hours,
-printing the output as a human readable format, with the test output at /tmp/output-file
-and all failed test commands (if you have any) at /tmp/fail-command-file.
-
-$ pan -n stress -e -p -q -S -t 24h -a stress -l logfile -f command-file \
-		-o /tmp/output-file -C /tmp/fail-command-file
-
-.SH LAYERING
-
-Pan is often used in layers.  This section extends the above examples to show
-how this is done.
-
-The next example will use this command file.  Call this /tmp/cmds2.  Note that
-the embedded pans inside this file have exit logs, and that %f is used to give
-each pan a unique log file name.
-.br
-----------cut------
-.br
-larry  pan -n ex4b -s10 -A -l ex4_%f.log echo hello
-.br
-curly  pan -n ex4c -S -A -f /tmp/cmds1 -l ex4_%f.log
-.br
-moe    echo done here
-.br
-----------cut------
-.br
-
-The following will run commands from the command file, keeping two at a time
-running, choosing them sequentially, and terminating if any of them exits
-non-zero.
-
-$ pan -n ex4 -x2 -A -S -f /tmp/cmds2
-
-Now run the commands in /tmp/cmds2, but this time we want to recover if one of
-the commands should exit non-zero.  In this example it is possible for the
-"larry" or "curly" tags to exit non-zero.  When this happens the pan will kill
-all active tags, making sure both larry and curly are dead, and then will
-continue scheduling--ensuring that our "done here" message comes out no matter
-what.
-
-$ pan -n ex5 -x2 -A -S -y -f /tmp/cmds2
-
-.SH ENVIRONMENT
-.TP
-ZOO
-If set, should name the directory where the active file should be placed.
-This is ignored if \fI-a\fP is specified.
-
-.SH FILES
-.TP
-active
-Default name of active file if \fI-a\fP is not specified.  This is prefixed
-by the directory name found in the ZOO environment variable.
-.TP
-PAN_STOP_FILE
-The creation of this file in the defined \fITMP\fP directory will cause pan to
-execute one more loop and stop.  This is useful when testing needs to be stopped
-before its scheduled stop time (\fI-t\fP).  By doing a 'touch' on this file, testing
-is ended, i.e. touch /tmp/runalltests-2345/PAN_STOP_FILE
-
-.SH "SEE ALSO"
-Zoo tools - bump(1)
-
-.SH DIAGNOSTICS
-By default it exits zero unless signaled, regardless of the exit status of any
-of the commands it is running.  If \fI-A\fP or \fI-e\fP are specified it exits non-zero if
-it is signaled or if any of the commands it is running should exit non-zero.
Index: ltp-full-20090430/ltp-devel.spec
===================================================================
--- ltp-full-20090430.orig/ltp-devel.spec
+++ ltp-full-20090430/ltp-devel.spec
@@ -21,9 +21,9 @@ It is intended to be used to build testc
 %files
 /opt/ltp/lib/libltp.a
 /usr/share/pkgconfig/ltp.pc
-/opt/ltp/bin/pan
-/opt/ltp/bin/scanner
-/opt/ltp/bin/bump
+/opt/ltp/bin/ltp-pan
+/opt/ltp/bin/ltp-scanner
+/opt/ltp/bin/ltp-bump
 /opt/ltp/include/linux_syscall_numbers.h
 /opt/ltp/include/libtestsuite.h
 /opt/ltp/include/usctest.h
@@ -59,10 +59,10 @@ It is intended to be used to build testc
 /usr/share/man/man3/string_to_tokens.3
 /usr/share/man/man3/tst_sig.3
 /usr/share/man/man3/get_attrib.3
-/usr/share/man/man1/pan.1
+/usr/share/man/man1/ltp-pan.1
 /usr/share/man/man1/doio.1
 /usr/share/man/man1/iogen.1
-/usr/share/man/man1/bump.1
+/usr/share/man/man1/ltp-bump.1
 # Post-install stuff would go here.
 #EOF
 
Index: ltp-full-20090430/pan/Makefile
===================================================================
--- ltp-full-20090430.orig/pan/Makefile
+++ ltp-full-20090430/pan/Makefile
@@ -4,21 +4,21 @@ LFLAGS += -l -w
 CFLAGS += -w 
 PREFIX = /opt/ltp
 
-all: pan bump scanner
+all: ltp-pan ltp-bump ltp-scanner
 
-pan: pan.o zoolib.o splitstr.o
+ltp-pan: ltp-pan.o zoolib.o splitstr.o
 
 
-bump: bump.o zoolib.o
+ltp-bump: ltp-bump.o zoolib.o
 
 
-scanner: scan.o scanner.o reporter.o tag_report.o symbol.o splitstr.o debug.o
+ltp-scanner: scan.o ltp-scanner.o reporter.o tag_report.o symbol.o splitstr.o debug.o
 
 
-install: pan bump scanner
-	install -D scanner $(DESTDIR)/$(PREFIX)/bin/scanner
-	install -D pan $(DESTDIR)/$(PREFIX)/bin/pan
-	install -D bump $(DESTDIR)/$(PREFIX)/bin/bump
+install: ltp-pan ltp-bump ltp-scanner
+	install -D ltp-scanner $(DESTDIR)/$(PREFIX)/bin/ltp-scanner
+	install -D ltp-pan $(DESTDIR)/$(PREFIX)/bin/ltp-pan
+	install -D ltp-bump $(DESTDIR)/$(PREFIX)/bin/ltp-bump
 
 clean:
-	rm -f *.o pan bump scanner
+	rm -f *.o ltp-pan ltp-bump ltp-scanner
Index: ltp-full-20090430/pan/bump.c
===================================================================
--- ltp-full-20090430.orig/pan/bump.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/* $Id: bump.c,v 1.4 2001/03/08 19:13:21 nstraz Exp $ */
-#include <stdio.h>
-#include <errno.h>
-#include <sys/signal.h>
-#include <string.h>
-#include <stdlib.h>
-
-#include "zoolib.h"
-
-pid_t
-read_active( FILE *fp, char *name );
-
-int 
-main( int argc, char **argv ){
-	extern char *optarg;
-	extern int optind;
-	int c;
-	char *active = NULL;
-	pid_t nanny;
-	zoo_t zoo;
-	int sig = SIGINT;
-
-	while( (c = getopt(argc, argv, "a:s:12")) != -1 ){
-		switch(c){
-			case 'a':
-				active = (char*)malloc(strlen(optarg)+1);
-				strcpy( active, optarg );
-				break;
-			case 's':
-				sig = atoi( optarg );
-				break;
-			case '1':
-				sig = SIGUSR1;
-				break;
-			case '2':
-				sig = SIGUSR2;
-				break;
-		}
-	}
-
-	if( active == NULL ){
-		active = zoo_getname();
-		if( active == NULL ){
-			fprintf(stderr, "bump: Must supply -a or set ZOO env variable\n");
-			exit(1);
-		}
-	}
-	if( optind == argc ){
-		fprintf( stderr, "bump: Must supply names\n");
-		exit(1);
-	}
-
-	/* need r+ here because we're using write-locks */
-	if( (zoo = zoo_open(active)) == NULL ){
-		fprintf(stderr, "bump: %s\n", zoo_error);
-		exit(1);
-	}
-	while( optind < argc ){
-		/*printf("argv[%d] = (%s)\n", optind, argv[optind] );*/
-		nanny = zoo_getpid(zoo, argv[optind]);
-		if( nanny == -1 ){
-			fprintf(stderr, "bump: Did not find tag '%s'\n",
-				argv[optind] );
-		}
-		else{
-			if (kill( nanny, sig ) == -1){
-				if (errno == ESRCH){
-					fprintf(stderr,"bump: Tag %s (pid %d) seems to be dead already.\n",
-						argv[optind], nanny );
-					if (zoo_clear(zoo, nanny))
-						fprintf(stderr,"bump: %s\n", zoo_error);
-				}
-			}
-		}
-		++optind;
-	}
-	zoo_close(zoo);
-
-	exit(0);
-}
-
Index: ltp-full-20090430/pan/ltp-bump.c
===================================================================
--- /dev/null
+++ ltp-full-20090430/pan/ltp-bump.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ *
+ */
+/* $Id: ltp-bump.c,v 1.4 2001/03/08 19:13:21 nstraz Exp $ */
+#include <stdio.h>
+#include <errno.h>
+#include <sys/signal.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "zoolib.h"
+
+pid_t read_active(FILE *fp, char *name);
+
+int main(int argc, char **argv)
+{
+	int c;
+	char *active = NULL;
+	pid_t nanny;
+	zoo_t zoo;
+	int sig = SIGINT;
+
+	while((c = getopt(argc, argv, "a:s:12")) != -1) {
+		switch(c) {
+			case 'a':
+				active = (char*)malloc(strlen(optarg)+1);
+				strcpy( active, optarg );
+				break;
+			case 's':
+				sig = atoi( optarg );
+				break;
+			case '1':
+				sig = SIGUSR1;
+				break;
+			case '2':
+				sig = SIGUSR2;
+				break;
+		}
+	}
+
+	if (active == NULL) {
+		active = zoo_getname();
+		if (active == NULL) {
+			fprintf(stderr, "ltp-bump: Must supply -a or set ZOO env variable\n");
+			exit(1);
+		}
+	}
+
+	if (optind == argc) {
+		fprintf(stderr, "ltp-bump: Must supply names\n");
+		exit(1);
+	}
+
+	/* need r+ here because we're using write-locks */
+	if ((zoo = zoo_open(active)) == NULL) {
+		fprintf(stderr, "ltp-bump: %s\n", zoo_error);
+		exit(1);
+	}
+
+	while (optind < argc) {
+		/*printf("argv[%d] = (%s)\n", optind, argv[optind] );*/
+		nanny = zoo_getpid(zoo, argv[optind]);
+		if (nanny == -1) {
+			fprintf(stderr, "ltp-bump: Did not find tag '%s'\n",
+				argv[optind]);
+		} else {
+			if (kill( nanny, sig ) == -1) {
+				if (errno == ESRCH) {
+					fprintf(stderr,"ltp-bump: Tag %s (pid %d) seems to be dead already.\n",
+						argv[optind], nanny);
+					if (zoo_clear(zoo, nanny))
+						fprintf(stderr,"ltp-bump: %s\n", zoo_error);
+				}
+			}
+		}
+		++optind;
+	}
+	zoo_close(zoo);
+
+	exit(0);
+}
Index: ltp-full-20090430/pan/ltp-pan.c
===================================================================
--- /dev/null
+++ ltp-full-20090430/pan/ltp-pan.c
@@ -0,0 +1,1394 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ *
+ * Changelog:
+ * 
+ *	Added timer options: William Jay Huie, IBM
+ *	01/27/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
+ *			   - option '-p' (pretty printing)i to enabled formatted printing 
+ *			     of results.
+ *
+ *	01/27/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
+ *			   - added code to print system information
+ *
+ *	01/28/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
+ *			   - added code to print test exit value.
+ *
+ *	01/29/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
+ *			   - added code supresses test start and test end tags.
+ *
+ * 	07/22/07 - Added: Ricardo Salveti de Araujo, rsalveti@linux.vnet.ibm.com
+ *			   - added option to create a command file with all failed tests.
+ * 	
+ */
+/* $Id: ltp-pan.c,v 1.32 2009/02/23 10:43:35 subrata_modak Exp $ */
+
+#include <errno.h>
+#include <string.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/times.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <time.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <sys/utsname.h>
+#include <unistd.h>
+
+#include "splitstr.h"
+#include "zoolib.h"
+
+/* One entry in the command line collection.  */
+struct coll_entry
+{
+	char *name;		/* tag name */
+	char *cmdline;	/* command line */
+	char *pcnt_f;	/* location of %f in the command line args, flag */
+	struct coll_entry *next;
+};
+
+struct collection
+{
+	int cnt;
+	struct coll_entry **ary;
+};
+
+struct tag_pgrp
+{
+	int pgrp;
+	int stopping;
+	time_t mystime;
+	struct coll_entry *cmd;
+	char output[PATH_MAX];
+};
+
+struct orphan_pgrp
+{
+	int pgrp;
+	struct orphan_pgrp *next;
+};
+
+static pid_t run_child(struct coll_entry *colle, struct tag_pgrp *active,
+		       int quiet_mode);
+static char *slurp(char *file);
+static struct collection *get_collection(char *file, int optind, int argc,
+					 char **argv);
+static void pids_running(struct tag_pgrp *running, int keep_active);
+static int check_pids(struct tag_pgrp *running, int *num_active,
+		      int keep_active, FILE * logfile, FILE * failcmdfile, 
+		      struct orphan_pgrp *orphans, int fmt_print,
+		      int *failcnt, int quiet_mode);
+static void propagate_signal(struct tag_pgrp *running, int keep_active,
+			     struct orphan_pgrp *orphans);
+static void dump_coll(struct collection *coll);
+static char *subst_pcnt_f(struct coll_entry *colle);
+static void mark_orphan(struct orphan_pgrp *orphans, pid_t cpid);
+static void orphans_running(struct orphan_pgrp *orphans);
+static void check_orphans(struct orphan_pgrp *orphans, int sig);
+static void copy_buffered_output(struct tag_pgrp *running);
+static void write_test_start(struct tag_pgrp *running, const char *init_status);
+static void write_test_end(struct tag_pgrp *running,
+			   time_t exit_time, char *term_type, int stat_loc,
+			   int term_id, struct tms *tms1, struct tms *tms2);
+
+static char PAN_STOP_FILE[] = "PAN_STOP_FILE";
+
+static char *panname = NULL;
+static char *test_out_dir = NULL;	/* dir to buffer output to */
+zoo_t zoofile;
+static char *reporttype = NULL;
+
+/* zoolib */
+int rec_signal; 	/* received signal */
+int send_signal;	/* signal to send */
+
+/* Debug Bits */
+int Debug = 0;
+#define Dbuffile	0x000400	/* buffer file use */
+#define	Dsetup		0x000200	/* one-time set-up */
+#define	Dshutdown	0x000100	/* killed by signal */
+#define	Dexit		0x000020	/* exit status */
+#define	Drunning	0x000010	/* current pids running */
+#define	Dstartup	0x000004	/* started command */
+#define	Dstart		0x000002	/* started command */
+#define Dwait		0x000001	/* wait interrupted */
+
+/*
+ * Print help and exit.
+ */
+static void print_help(void)
+{
+	fprintf(stdout, "Usage: ltp-pan -n name [ -SyAehpq ] [ -s starts ]"
+		" [-t time[s|m|h|d] [ -x nactive ] [ -l logfile ]\n\t"
+		"[ -a active-file ] [ -f command-file ] "
+		"[ -C fail-command-file ] "
+		"[ -d debug-level ]\n\t[-o output-file] "
+		"[-O output-buffer-directory] [cmd]\n");
+	exit(0);
+}
+
+/*
+ * Parse time from string.
+ */
+static void parse_time(const char *str, int *run_time, int *timed, int quiet_mode)
+{
+	char modifier = 'm';
+	int ret = sscanf(str, "%d%c", run_time, &modifier);
+
+	if (ret == 0) { 
+		fprintf(stderr, "Need proper time input: ####x where"
+				"x is one of s,m,h,d\n"); 
+		return;
+	}
+
+	if (ret == 1) { 
+		fprintf(stderr, "Only got a time value of %d "
+				"modifiers need to come immediately after #"
+				" assuming %c\n", run_time, modifier);
+	} 
+		
+	switch (modifier) {
+		case 's': *run_time = *run_time; break;
+		case 'm': *run_time = *run_time * 60; break; 
+		case 'h': *run_time = *run_time * 60 * 60; break;
+		case 'd': *run_time = *run_time * 60 * 60 * 24; break;
+		default: 
+			fprintf(stderr, "Invalid time modifier, try: s|h|m|d\n"); exit(-1);
+	}
+
+	if (!quiet_mode)
+			  printf("PAN will run for %d seconds\n", run_time);
+
+	timed = 1; /* -t implies run as many starts as possible, by default */
+}
+
+/*
+ * Prepares logfile.
+ */
+static void open_logfile(const char *logfilename, FILE **logfile, int fmt_print)
+{
+	time_t startup;
+	char *s;
+
+	if (logfilename != NULL) {
+		if (logfilename[0] != "-") {
+			*logfile = stdout;
+		} else {
+			if ((*logfile = fopen(logfilename, "a+")) == NULL) {
+				fprintf(stderr, "ltp-pan(%s): Error %s (%d) opening log file '%s'\n",
+					panname, strerror(errno), errno, logfilename);
+				exit(1);
+			}
+		}
+
+		time(&startup);
+		s = ctime(&startup);
+		s[strlen(s) - 1] = '\0';
+
+		if (!fmt_print)
+			fprintf(logfile, "startup='%s'\n", s);
+		else {
+			fprintf(logfile, "Test Start Time: %s\n", s);
+			fprintf(logfile, "-----------------------------------------\n");
+			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n", 
+					"Testcase", "Result", "Exit Value");
+			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
+				   	"--------", "------", "------------");
+		}
+	}
+}
+
+
+int main(int argc, char **argv)
+{
+	char *zooname = NULL;		/* name of the zoo file to use */
+	char *filename = "/dev/null";	/* filename to read test tags from */
+	char *logfilename = NULL;
+	char *failcmdfilename = NULL;
+	char *outputfilename = NULL;
+	struct collection *coll = NULL;
+	struct tag_pgrp *running;
+	struct orphan_pgrp *orphans, *orph;
+	struct utsname unamebuf;
+	FILE *logfile = NULL;
+	FILE *failcmdfile = NULL;
+	int keep_active = 1;
+	int num_active = 0;
+	int failcnt = 0;		/* count of total testcases that failed. */
+	int err, i;
+	int starts = -1;
+	int timed = 0;
+	int run_time = -1;
+	int ret = 0;
+	int stop;
+	int go_idle;
+	int has_brakes = 0;		/* stop everything if a test case fails */
+	int sequential = 0;		/* run tests sequentially */
+	int fork_in_road = 0;
+	int exit_stat;
+	int track_exit_stats = 0;	/* exit non-zero if any test exits non-zero */
+	int fmt_print = 0;		/* enables formatted printing of logfiles. */
+	int quiet_mode = 0;		/* supresses test start and test end tags. */
+	int c;
+	pid_t cpid;
+	struct sigaction sa;
+
+	while ((c = getopt(argc, argv, "AO:Sa:C:d:ef:hl:n:o:pqr:s:t:x:y")) != -1) {
+		switch (c) {
+			case 'A':	/* all-stop flag */
+				has_brakes = 1;
+				track_exit_stats = 1;
+				break;
+			case 'O':	/* output buffering directory */
+				test_out_dir = strdup(optarg);
+				break;
+			case 'S':	/* run tests sequentially */
+				sequential = 1;
+				break;
+			case 'a':	/* name of the zoo file to use */
+				zooname = strdup(optarg);
+				break;
+			case 'C':	/* name of the file where all failed commands will be */
+				failcmdfilename = strdup(optarg);
+				break;
+			case 'd':	/* debug options */
+				sscanf(optarg, "%i", &Debug);
+				break;
+			case 'e':	/* exit non-zero if any test exists non-zero */
+				track_exit_stats = 1;
+				break;
+			case 'f':	/* filename to read test tags from */
+				filename = strdup(optarg);
+				break;
+			case 'h':	/* help */
+				print_help();
+			case 'l':	/* log file */
+				logfilename = strdup(optarg);
+				break;
+			case 'n':	/* tag given to ltp-pan */
+				panname = strdup(optarg);
+				break;
+			case 'o':	/* send test output here */
+				outputfilename = strdup(optarg);
+				break;
+			case 'p':	/* formatted printing. */
+				fmt_print = 1;
+				break;
+			case 'q':	/* supress test start and test end messages */
+				quiet_mode = 1;
+				break;
+			case 'r':	/* reporting type: none, rts */
+				reporttype = strdup(optarg);
+				break;
+			case 's':	/* number of tags to run */
+				starts = atoi(optarg);
+				break;
+			case 't':	/* run_time to run */
+				parse_time(optarg, &run_time, &timed, quiet_mode);
+			case 'x':	/* number of tags to keep running */
+				keep_active = atoi(optarg);
+				break;
+			case 'y':	/* restart on failure or signal */
+				fork_in_road = 1;
+				break;
+		}
+	}
+
+	if (panname == NULL) {
+		fprintf(stderr, "ltp-pan: Must supply -n\n");
+		exit(1);
+	}
+
+	if (zooname == NULL) {
+		zooname = zoo_getname();
+		if (zooname == NULL) {
+			fprintf(stderr,
+				"ltp-pan(%s): Must supply -a or set ZOO env variable\n",
+				panname);
+			exit(1);
+		}
+	}
+
+	/* make sure we understand the report type */
+	if (reporttype) {
+		if (strcasecmp(reporttype, "rts") && strcasecmp(reporttype, "none"))
+			reporttype = "rts";
+	} else
+		/* set the default */
+		reporttype = "rts";
+
+	open_logfile(logfilename, &logfile, fmt_print);
+
+	coll = get_collection(filename, optind, argc, argv);
+	
+	if(!coll)
+		exit(1);
+	
+	if (coll->cnt == 0) {
+		fprintf(stderr,
+			"ltp-pan(%s): Must supply a file collection or a command\n",
+			panname);
+		exit(1);
+	}
+
+	if (Debug & Dsetup)
+		dump_coll(coll);
+
+	/* a place to store the pgrps we're watching */
+	running = malloc((keep_active + 1) * sizeof(struct tag_pgrp));
+	if (running == NULL) {
+		fprintf(stderr, "ltp-pan: malloc failed.\n");
+		exit(1);
+	}
+	memset(running, 0, keep_active * sizeof(struct tag_pgrp));
+	running[keep_active].pgrp = -1;	/* end sentinel */
+
+	/* a head to the orphaned pgrp list */
+	orphans = malloc(sizeof(struct orphan_pgrp));
+	if (orphans == NULL) {
+		fprintf(stderr, "ltp-pan: malloc failed.\n");
+		exit(1);
+	}
+	memset(orphans, 0, sizeof(struct orphan_pgrp));
+
+	srand48(time(NULL) ^ (getpid() + (getpid() << 15)));
+
+	/* Supply a default for starts.  If we are in sequential mode, use
+	 * the number of commands available; otherwise 1.
+	 */
+	if (timed != 1 || starts != -1) {	/* timed, infinite by default */
+		if (starts == -1) {
+			if (sequential)
+				starts = coll->cnt;
+			else
+				starts = 1;
+		} else {
+			if (starts == 0)	/* if the user specified infinite, set it */
+				starts = -1;
+			else			/* else, make sure we are starting at least keep_active processes */
+				if (starts < keep_active)
+					starts = keep_active;
+		}
+	}
+
+	/* if we're buffering output, but we're only running on process at a time,
+	 * then essentially "turn off buffering"
+	 */
+	if (test_out_dir && (keep_active == 1)) {
+		free(test_out_dir);
+		test_out_dir = NULL;
+	}
+
+	if (test_out_dir) {
+		struct stat sbuf;
+
+		if (stat(test_out_dir, &sbuf) < 0) {
+			fprintf(stderr,
+				"ltp-pan(%s): stat of -O arg '%s' failed.  errno: %d  %s\n",
+				panname, test_out_dir, errno, strerror(errno));
+			exit(1);
+		}
+		if (!S_ISDIR(sbuf.st_mode)) {
+			fprintf(stderr, "ltp-pan(%s): -O arg '%s' must be a directory.\n",
+				panname, test_out_dir);
+			exit(1);
+		}
+		if (access(test_out_dir, W_OK | R_OK | X_OK) < 0) {
+			fprintf(stderr,
+				"ltp-pan(%s): permission denied on -O arg '%s'.  errno: %d  %s\n",
+				panname, test_out_dir, errno, strerror(errno));
+			exit(1);
+		}
+	}
+
+	if (outputfilename) {
+		if (!freopen(outputfilename, "a+", stdout)) {
+			fprintf(stderr,
+				"ltp-pan(%s): Error %s (%d) openning output file '%s'\n",
+				panname, strerror(errno), errno, outputfilename);
+			exit(1);
+		}
+	}
+
+	if (failcmdfilename) {
+		if (!(failcmdfile = fopen(failcmdfilename, "a+"))) {
+			fprintf(stderr,
+				"ltp-pan(%s): Error %s (%d) opening fail cmd file '%s'\n",
+				panname, strerror(errno), errno, failcmdfilename);
+			exit(1);
+		}
+	}
+
+	if ((zoofile = zoo_open(zooname)) == NULL) {
+		fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+		exit(1);
+	}
+	
+	if (zoo_mark_args(zoofile, getpid(), panname, argc, argv)) {
+		fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+		exit(1);
+	}
+
+	/* Allocate N spaces for max-arg commands.
+	 * this is an "active file cleanliness" thing
+	 */
+	{
+		char *av[2], bigarg[82];
+
+		memset(bigarg, '.', 81);
+		bigarg[81] = '\0';
+		av[0] = bigarg;
+		av[1] = NULL;
+
+		for (c = 0; c < keep_active; c++) {
+			if (zoo_mark_cmdline(zoofile, c, panname, "")) {
+				fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+				exit(1);
+			}
+		}
+
+		for (c = 0; c < keep_active; c++) {
+			if (zoo_clear(zoofile, c)) {
+				fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+				exit(1);
+			}
+		}
+	}
+
+	rec_signal = send_signal = 0;
+	if (run_time != -1)
+		alarm(run_time);
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = wait_handler;
+
+	sigaction(SIGALRM, &sa, NULL);
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+	sigaction(SIGHUP, &sa, NULL);
+	sigaction(SIGUSR1, &sa, NULL);	/* ignore fork_in_road */
+	sigaction(SIGUSR2, &sa, NULL);	/* stop the scheduler */
+
+	c = 0;			/* in this loop, c is the command index */
+	stop = 0;
+	exit_stat = 0;
+	go_idle = 0;
+	
+	while (1) {
+
+		while ((num_active < keep_active) && (starts != 0)) {
+			if (stop || rec_signal || go_idle)
+				break;
+
+			if (!sequential)
+				c = lrand48() % coll->cnt;
+
+			/* find a slot for the child */
+			for (i = 0; i < keep_active; ++i)
+				if (running[i].pgrp == 0)
+					break;
+
+			if (i == keep_active) {
+				fprintf(stderr, "ltp-pan(%s): Aborting: i == keep_active = %d\n",
+					panname, i);
+				wait_handler(SIGINT);
+				exit_stat++;
+				break;
+			}
+
+			cpid = run_child(coll->ary[c], running + i, quiet_mode);
+			
+			if (cpid != -1)
+				++num_active;
+			if ((cpid != -1 || sequential) && starts > 0)
+				--starts;
+
+			if (sequential)
+				if (++c >= coll->cnt)
+					c = 0;
+
+		}
+
+		if (starts == 0)
+		{ 
+			if (!quiet_mode)
+				printf("incrementing stop\n"); 
+			++stop; 
+		} else
+			if (starts == -1) {
+				FILE *f = (FILE*)-1;
+	 			if ((f = fopen(PAN_STOP_FILE, "r")) != 0) {
+					printf("Got %s Stopping!\n", PAN_STOP_FILE);
+		  			fclose(f); 
+					unlink(PAN_STOP_FILE); 
+					stop++; 
+	   			}
+			}
+
+		if (rec_signal) {
+			/* propagate everything except sigusr2 */
+
+			if (rec_signal == SIGUSR2) {
+				if (fork_in_road)
+					++go_idle;
+				else
+					++stop;
+				rec_signal = send_signal = 0;
+			} else {
+				if (rec_signal == SIGUSR1)
+					fork_in_road = 0;
+					propagate_signal(running, keep_active, orphans);
+				
+				if (fork_in_road)
+					++go_idle;
+				else
+					++stop;
+			}
+		}
+
+		err = check_pids(running, &num_active, keep_active, logfile,
+				 failcmdfile, orphans, fmt_print, &failcnt, quiet_mode);
+		
+		if (Debug & Drunning) {
+			pids_running(running, keep_active);
+			orphans_running(orphans);
+		}
+
+		if (err) {
+			if (fork_in_road)
+				++go_idle;
+			
+			if (track_exit_stats)
+				exit_stat++;
+
+			if (has_brakes) {
+				fprintf(stderr, "ltp-pan(%s): All stop!%s\n", panname,
+					go_idle ? " (idling)" : "");
+				wait_handler(SIGINT);
+			}
+		}
+
+		if (stop && (num_active == 0))
+			break;
+
+		if (go_idle && (num_active == 0)) {
+			go_idle = 0;		/* It is idle, now resume scheduling. */
+			wait_handler(0);	/* Reset the signal ratchet. */
+		}
+	}
+
+	/* Wait for orphaned pgrps */
+	while (1) {
+		
+		for (orph = orphans; orph != NULL; orph = orph->next) {
+			
+			if (orph->pgrp == 0)
+				continue;
+
+			/* Yes, we have orphaned pgrps */
+			sleep(5);
+			
+			if (!rec_signal) {
+			
+				/* force an artificial signal, move us
+				 * through the signal ratchet.
+				 */
+				wait_handler(SIGINT);
+			}
+
+			propagate_signal(running, keep_active, orphans);
+
+			if (Debug & Drunning)
+				orphans_running(orphans);
+			
+			break;
+		}
+
+
+		if (orph == NULL)
+			break;
+	}
+
+
+	if (zoo_clear(zoofile, getpid())) {
+		fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+			++exit_stat;
+	}
+
+	fclose(zoofile);
+
+	if (logfile && fmt_print) {
+		if (uname(&unamebuf) == -1)
+			fprintf(stderr, "ERROR: uname(): %s\n", strerror(errno));
+
+		fprintf(logfile, "\n-----------------------------------------------\n");
+		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
+		fprintf(logfile, "Total Failures: %d\n", failcnt);
+		fprintf(logfile, "Kernel Version: %s\n", unamebuf.release);
+		fprintf(logfile, "Machine Architecture: %s\n", unamebuf.machine);
+		fprintf(logfile, "Hostname: %s\n\n", unamebuf.nodename);
+	}
+
+	if (logfile && (logfile != stdout))
+		fclose(logfile);
+
+	exit(exit_stat);
+}
+
+
+
+static void propagate_signal(struct tag_pgrp *running, int keep_active,
+			     struct orphan_pgrp *orphans)
+{
+	int i;
+
+	if (Debug & Dshutdown)
+		fprintf(stderr, "ltp-pan was signaled with sig %d...\n", rec_signal);
+
+	if (rec_signal == SIGALRM) {
+		printf("PAN stop Alarm was received\n");
+		rec_signal = SIGTERM;
+	}
+
+	for (i = 0; i < keep_active; ++i) {
+		if (running[i].pgrp == 0)
+			continue;
+
+		if (Debug & Dshutdown)
+			fprintf(stderr, "  propagating sig %d to %d\n",
+				send_signal, -running[i].pgrp);
+		
+		if (kill(-running[i].pgrp, send_signal) != 0) {
+			fprintf(stderr,
+				"ltp-pan(%s): kill(%d,%d) failed on tag (%s).  errno:%d  %s\n",
+				panname, -running[i].pgrp, send_signal,
+				running[i].cmd->name, errno, strerror(errno));
+		}
+		
+		running[i].stopping = 1;
+	}
+
+	check_orphans(orphans, send_signal);
+
+	rec_signal = send_signal = 0;
+}
+
+
+static int check_pids(struct tag_pgrp *running, int *num_active, int
+		      keep_active, FILE * logfile, FILE * failcmdfile, 
+		      struct orphan_pgrp *orphans, int fmt_print, 
+		      int *failcnt, int quiet_mode)
+{
+	int w;
+	pid_t cpid;
+	int stat_loc;
+	int ret = 0;
+	int i;
+	time_t t;
+	char *status;
+	int signaled = 0;
+	struct tms tms1, tms2;
+	clock_t tck;
+
+	check_orphans(orphans, 0);
+
+	tck = times(&tms1);
+	
+	if (tck == -1)
+		fprintf(stderr, "ltp-pan(%s): times(&tms1) failed.  errno:%d  %s\n",
+			panname, errno, strerror(errno));
+	
+	cpid = wait(&stat_loc);
+	tck = times(&tms2);
+	
+	if (tck == -1)
+		fprintf(stderr, "ltp-pan(%s): times(&tms2) failed.  errno:%d  %s\n",
+			panname, errno, strerror(errno));
+
+	if (cpid < 0) {
+		if (errno == EINTR) {
+			if (Debug)
+				fprintf(stderr, "ltp-pan(%s): wait() interrupted\n", panname);
+		} else
+			if (errno != ECHILD) {
+				fprintf(stderr, "ltp-pan(%s): wait() failed.  errno:%d  %s\n",
+					panname, errno, strerror(errno));
+			}
+	} else 
+		if (cpid > 0) {
+
+			if (WIFSIGNALED(stat_loc)) {
+				w = WTERMSIG(stat_loc);
+				status = "signaled";
+				if (Debug & Dexit)
+					fprintf(stderr, "child %d terminated with signal %d\n", cpid, w);
+				--*num_active;
+				signaled = 1;
+			} else
+				if (WIFEXITED(stat_loc)) {
+					w = WEXITSTATUS(stat_loc);
+					status = "exited";
+					if (Debug & Dexit)
+						fprintf(stderr, "child %d exited with status %d\n", cpid, w);
+						--*num_active;
+					if (w != 0)
+						ret++;
+				} else 
+					if (WIFSTOPPED(stat_loc)) {	/* should never happen */
+						w = WSTOPSIG(stat_loc);
+						status = "stopped";
+						ret++;
+					} else {		/* should never happen */
+						w = 0;
+						status = "unknown";
+						ret++;
+					}
+
+			for (i = 0; i < keep_active; ++i) {
+				if (running[i].pgrp == cpid) {
+					if ((w == 130) && running[i].stopping && (strcmp(status, "exited") == 0)) {
+						/* The child received sigint, but
+						 * did not trap for it?  Compensate
+						 * for it here.
+						 */
+						w = 0;
+						ret--;	/* undo */
+						if (Debug & Drunning)
+							fprintf(stderr,
+								"ltp-pan(%s): tag=%s exited 130, known to be signaled; will give it an exit 0.\n",
+								panname, running[i].cmd->name);
+					}
+					time(&t);
+
+					if (logfile != NULL) {
+						if (!fmt_print)
+							fprintf(logfile, "tag=%s stime=%d dur=%d exit=%s stat=%d core=%s cu=%d cs=%d\n",
+								running[i].cmd->name, (int) (running[i].mystime),
+								(int) (t - running[i].mystime), status, w,
+								(stat_loc & 0200) ? "yes" : "no",
+								(int) (tms2.tms_cutime - tms1.tms_cutime),
+								(int) (tms2.tms_cstime - tms1.tms_cstime));
+						else {
+							if (w != 0) 
+								++*failcnt;
+				
+							fprintf(logfile, "%-30.30s %-10.10s %-5d\n", 
+								running[i].cmd->name, ((w != 0) ? "FAIL" : "PASS"), w);
+						}
+			
+						fflush(logfile);
+					}
+
+					if ((failcmdfile != NULL) && (w !=0))
+						fprintf(failcmdfile, "%s %s\n", running[i].cmd->name, running[i].cmd->cmdline);
+
+					if (running[i].stopping)
+						status = "driver_interrupt";
+
+					if (test_out_dir) {
+						if (!quiet_mode)
+							write_test_start(running+i, "ok");
+						copy_buffered_output(running + i);
+						unlink(running[i].output);
+					}
+
+					if (!quiet_mode)
+						write_test_end(running+i, t, status, stat_loc, w, &tms1, &tms2);
+
+					/* If signaled and we weren't expecting
+					 * this to be stopped then the proc
+					 * had a problem.
+					 */
+					if (signaled && !running[i].stopping)
+						ret++;
+
+					running[i].pgrp = 0;
+					
+					if (zoo_clear(zoofile, cpid)) {
+						fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+						exit(1);
+					}
+
+					/* Check for orphaned pgrps */
+					if ((kill(-cpid, 0) == 0) || (errno == EPERM)) {
+						if (zoo_mark_cmdline(zoofile, cpid, "panorphan", running[i].cmd->cmdline)) {
+							fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+							exit(1);
+						}
+
+					mark_orphan(orphans, cpid);
+					/* status of kill doesn't matter */
+					kill(-cpid, SIGTERM);
+				}
+
+				break;
+			}
+		}
+	}
+	
+	return ret;
+}
+
+
+static pid_t run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode)
+{
+	int cpid;
+	int c_stdout = -1;		/* child's stdout, stderr */
+	int capturing = 0;		/* output is going to a file instead of stdout */
+	char *c_cmdline;
+	static long cmdno = 0;
+	int errpipe[2];		/* way to communicate to parent that the tag  */
+	char errbuf[1024];		/* didn't actually start */
+	int errlen;
+
+	/* Try to open the file that will be stdout for the test */
+	if (test_out_dir) {
+		capturing = 1;
+		
+		do {
+			sprintf(active->output, "%s/%s.%ld",
+				test_out_dir, colle->name, cmdno++);
+			c_stdout = open(active->output, O_CREAT | O_RDWR | O_EXCL | O_SYNC, 0666);
+		} while (c_stdout < 0 && errno == EEXIST);
+
+		if (c_stdout < 0) {
+			fprintf(stderr,
+				"ltp-pan(%s): open of stdout file failed (tag %s).  errno: %d  %s\n  file: %s\n",
+				panname, colle->name, errno, strerror(errno),
+				active->output);
+			return -1;
+		}
+	} 
+
+	/* get the tag's command line arguments ready.  subst_pcnt_f() uses a
+	 * static counter, that's why we do it here instead of after we fork.
+	 */
+	if (colle->pcnt_f)
+		c_cmdline = subst_pcnt_f(colle);
+	else
+		c_cmdline = colle->cmdline;
+	
+	if (pipe(errpipe) < 0) {
+		fprintf(stderr, "ltp-pan(%s): pipe() failed. errno:%d %s\n",
+				panname, errno, strerror(errno));
+		if (capturing) {
+			close(c_stdout);
+			unlink(active->output);
+		}
+
+		return -1;
+	}
+
+	if ((cpid = fork()) < 0) {
+		fprintf(stderr, "ltp-pan(%s): fork failed (tag %s).  errno:%d  %s\n",
+			panname, colle->name, errno, strerror(errno));
+		
+		if (capturing) {
+			unlink(active->output);
+			close(c_stdout);
+		}
+
+		close(errpipe[0]);
+		close(errpipe[1]);
+		
+		return -1;
+	} else 
+		if (cpid == 0) {
+			/* child */
+			fclose(zoofile);
+			close(errpipe[0]);
+			fcntl(errpipe[1], F_SETFD, 1);  /* close the pipe if we succeed */
+			setpgrp();
+			umask(0);
+
+			/* if we're putting output into a buffer file, we need to do the
+			 * redirection now.  If we fail
+			 */
+			if (capturing) {
+				if (dup2(c_stdout, fileno(stdout)) == -1) {
+					errlen = sprintf(errbuf, "ltp-pan(%s): couldn't redirect stdout for tag %s.  errno:%d  %s",
+							 panname, colle->name, errno, strerror(errno));
+					write(errpipe[1], &errlen, sizeof(errlen));
+					write(errpipe[1], errbuf, errlen);
+					exit(2);
+				}
+
+				if (dup2(c_stdout, fileno(stderr)) == -1) {
+					errlen = sprintf(errbuf, "ltp-pan(%s): couldn't redirect stderr for tag %s.  errno:%d  %s",
+						 	 panname, colle->name, errno, strerror(errno));
+					write(errpipe[1], &errlen, sizeof(errlen));
+					write(errpipe[1], errbuf, errlen);
+					exit(2);
+				}
+			} else { /* stderr still needs to be redirected */
+				if (dup2(fileno(stdout), fileno(stderr)) == -1) {
+					errlen = sprintf(errbuf, "ltp-pan(%s): couldn't redirect stderr for tag %s.  errno:%d  %s",
+						 panname, colle->name, errno, strerror(errno));
+					write(errpipe[1], &errlen, sizeof(errlen));
+					write(errpipe[1], errbuf, errlen);
+					exit(2);
+				}
+			}
+	
+		/* If there are any shell-type characters in the cmdline
+		 * such as '>', '<', '$', '|', etc, then we exec a shell and
+		 * run the cmd under a shell.
+		 *
+		 * Otherwise, break the cmdline at white space and exec the
+		 * cmd directly.
+		 */
+		if (strpbrk(c_cmdline, "\"';|<>$\\")) {
+			execlp("sh", "sh", "-c", c_cmdline, (char*)0);
+			errlen = sprintf(errbuf, 
+				 	 "ltp-pan(%s): execlp of '%s' (tag %s) failed.  errno:%d %s",
+					 panname, c_cmdline, colle->name, errno, strerror(errno));
+		} else {
+			char **arg_v;
+
+			arg_v = (char **)splitstr(c_cmdline, NULL, NULL);
+		
+			execvp(arg_v[0], arg_v);
+			       errlen = sprintf(errbuf,
+						"ltp-pan(%s): execvp of '%s' (tag %s) failed.  errno:%d  %s",
+						panname, arg_v[0], colle->name, errno, strerror(errno));
+		}
+
+		write(errpipe[1], &errlen, sizeof(errlen));
+		write(errpipe[1], errbuf, errlen);
+		exit(errno);
+	}
+
+	/* parent */
+
+	/* subst_pcnt_f() allocates the command line dynamically
+	 * free the malloc to prevent a memory leak
+	 */
+	if (colle->pcnt_f)
+		free(c_cmdline); 
+
+	close(errpipe[1]);
+	time(&active->mystime);
+	active->cmd = colle;
+
+	/* if the child couldn't go through with the exec, 
+	 * clean up the mess, note it, and move on
+	 */
+	if(read(errpipe[0], &errlen, sizeof(errlen))) {
+		int status;
+		time_t end_time;
+		int termid;
+		char *termtype;
+		struct tms notime = {0, 0, 0, 0};
+
+		read(errpipe[0], errbuf, errlen);
+		close(errpipe[0]);
+		errbuf[errlen] = '\0';
+		/* fprintf(stderr, "%s", errbuf); */
+		waitpid(cpid, &status, 0);
+		if (WIFSIGNALED(status)) {
+			termid = WTERMSIG(status);
+			termtype = "signaled";
+		} else 
+			if (WIFEXITED(status)) {
+				termid = WEXITSTATUS(status);
+				termtype = "exited";
+			} else
+				if (WIFSTOPPED(status)) {
+					termid = WSTOPSIG(status);
+					termtype = "stopped";
+				} else {
+					termid = 0;
+					termtype = "unknown";
+				}
+
+		time(&end_time);
+		if (!quiet_mode) 
+		{
+			write_test_start(active, errbuf);
+			write_test_end(active, end_time, termtype, status, 
+			 	       termid, &notime, &notime);
+		}
+
+		if (capturing) {
+			close(c_stdout);
+			unlink(active->output);
+		}
+		
+		return -1;
+	}
+
+	close(errpipe[0]);
+	
+	if (capturing)
+		close(c_stdout);
+	
+	if (!test_out_dir && !quiet_mode)
+			write_test_start(active, "ok");
+
+	active->pgrp = cpid;
+	active->stopping = 0;
+
+	if (zoo_mark_cmdline(zoofile, cpid, colle->name, colle->cmdline)) {
+		fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+		exit(1);
+	}
+
+	if (Debug & Dstartup)
+		fprintf(stderr, "started %s cpid=%d at %s",
+			colle->name, cpid, ctime(&active->mystime));
+
+	if (Debug & Dstart) {
+		
+		fprintf(stderr, "Executing test = %s as %s", colle->name, colle->cmdline);
+		
+		if (capturing)
+			fprintf(stderr, "with output file = %s\n", active->output);
+		else
+			fprintf(stderr, "\n");
+	}
+
+	return cpid;
+}
+
+
+static char *subst_pcnt_f(struct coll_entry *colle)
+{
+	static int counter = 1;
+	char pid_and_counter[20];
+	char new_cmdline[1024];
+
+	/* if we get called falsely, do the right thing anyway */
+	if (!colle->pcnt_f) 
+	return colle->cmdline;
+
+	snprintf(pid_and_counter, 20, "%d_%d", getpid(), counter++);
+	snprintf(new_cmdline, 1024, colle->cmdline, pid_and_counter);
+	return strdup(new_cmdline);
+}
+
+/*
+ * This code is broken as it's doesn't check NULL from malloc, strdup and so;
+ * but I'm just too lazy to rewrite this as pan is broken by design.
+ */
+static struct collection *get_collection(char *file, int optind, int argc, char **argv)
+{
+	char *buf, *a, *b;
+	struct coll_entry *head, *p, *n;
+	struct collection *coll;
+	int i;
+
+	buf = slurp(file);
+
+	if(!buf)
+		return NULL;
+
+	coll = malloc(sizeof(struct collection));
+	coll->cnt = 0;
+
+	head = p = n = NULL;
+	a = b = buf;
+	
+	while (a) {
+		/* set b to the start of the next line and add a NULL character
+		 * to separate the two lines */
+		if ((b = strchr(a, '\n')) != NULL)
+				*b++ = '\0';
+
+		/* If this is line isn't a comment */
+		if ((*a != '#') && (*a != '\0') && (*a != ' ')) {
+			n = malloc(sizeof(struct coll_entry));
+			
+			if ((n->pcnt_f = strstr(a, "%f")))
+				n->pcnt_f[1] = 's';
+
+			n->name = strdup(strsep(&a, " \t"));
+			n->cmdline = strdup(a);
+			n->next = NULL;
+
+			if (p)
+				p->next = n;
+
+			if (head == NULL)
+				head = n;
+
+			p = n;
+			coll->cnt++;
+		}
+		
+		a = b;
+	}
+
+	free(buf);
+
+	/* is there something on the commandline to be counted? */
+	if (optind < argc) {
+		char workstr[1024] = "";
+		int workstr_left = 1023;
+	
+		/* fill arg list */
+		for (i = 0; optind < argc; ++optind, ++i) {
+			strncat(workstr, argv[optind], workstr_left);
+			workstr_left = workstr_left - strlen(argv[optind]);
+			strncat(workstr, " ", workstr_left);
+			workstr_left--;
+		}
+
+		n = (struct coll_entry *) malloc(sizeof(struct coll_entry));
+
+		if ((n->pcnt_f = strstr(workstr, "%f")))
+			n->pcnt_f[1] = 's';
+
+		n->cmdline = strdup(workstr);
+		n->name = "cmdln";
+		n->next = NULL;
+		
+		if (p)
+			p->next = n;
+	
+		if (head == NULL)
+			head = n;
+
+		coll->cnt++;
+	}
+
+	/* get an array */
+	coll->ary = malloc(coll->cnt * sizeof(struct coll_entry *));
+
+	/* fill the array */
+	i = 0;
+	n = head;
+	
+	while (n != NULL) {
+		coll->ary[i] = n;
+		n = n->next;
+		++i;
+	}
+	
+	if (i != coll->cnt)
+		fprintf(stderr, "ltp-pan(%s): i doesn't match cnt\n", panname);
+
+	return coll;
+}
+
+static char *slurp(char *file)
+{
+	char *buf;
+	int fd;
+	struct stat sbuf;
+
+	if ((fd = open(file, O_RDONLY)) < 0) {
+		fprintf(stderr, "ltp-pan(%s): open(%s,O_RDONLY) failed.  errno:%d  %s\n",
+			panname, file, errno, strerror(errno));
+		return NULL;
+	}
+
+	if (fstat(fd, &sbuf) < 0) {
+		fprintf(stderr, "ltp-pan(%s): fstat(%s) failed.  errno:%d  %s\n",
+			panname, file, errno, strerror(errno));
+		return NULL;
+	}
+
+	buf = malloc(sbuf.st_size + 1);
+	
+	if (read(fd, buf, sbuf.st_size) != sbuf.st_size) {
+		fprintf(stderr, "ltp-pan(%s): slurp failed.  errno:%d  %s\n",
+			panname, errno, strerror(errno));
+		return NULL;
+	}
+	
+	buf[sbuf.st_size] = '\0';
+
+	close(fd);
+	return buf;
+}
+
+static void check_orphans(struct orphan_pgrp *orphans, int sig)
+{
+	struct orphan_pgrp *orph;
+
+	for (orph = orphans; orph != NULL; orph = orph->next) {
+		if (orph->pgrp == 0)
+			continue;
+
+		if (Debug & Dshutdown)
+			fprintf(stderr, "  propagating sig %d to orphaned pgrp %d\n",
+				sig, -(orph->pgrp));
+		if (kill(-(orph->pgrp), sig) != 0) {
+			if (errno == ESRCH) {
+			/* This pgrp is now empty */
+				if (zoo_clear(zoofile, orph->pgrp))
+					fprintf(stderr, "ltp-pan(%s): %s\n", panname, zoo_error);
+				orph->pgrp = 0;
+			} else {
+				fprintf(stderr,
+					"ltp-pan(%s): kill(%d,%d) on orphaned pgrp failed.  errno:%d  %s\n",
+					panname, -(orph->pgrp), sig, errno, strerror(errno));
+			}
+		}
+	}
+}
+
+
+static void mark_orphan(struct orphan_pgrp *orphans, pid_t cpid)
+{
+	struct orphan_pgrp *orph;
+
+	for (orph = orphans; orph != NULL; orph = orph->next)
+		if (orph->pgrp == 0)
+			break;
+
+	if (orph == NULL) {
+		/* make a new struct */
+		orph = (struct orphan_pgrp *) malloc(sizeof(struct orphan_pgrp));
+
+		/* plug in the new struct just after the head */
+		orph->next = orphans->next;
+		orphans->next = orph;
+	}
+
+	orph->pgrp = cpid;
+}
+
+
+
+static void copy_buffered_output(struct tag_pgrp *running)
+{
+	char *tag_output;
+
+	tag_output = slurp(running->output);
+	
+	if (tag_output) {
+		printf("%s", tag_output);
+		/* make sure the output ends with a newline */
+		if (tag_output[strlen(tag_output) - 1] != '\n')
+			printf("\n");
+		fflush(stdout);
+		free(tag_output);
+	}
+}
+
+
+static void write_test_start(struct tag_pgrp *running, const char *init_status)
+{
+	if (!strcmp(reporttype, "rts"))
+		printf("%s\ntag=%s stime=%ld\ncmdline=\"%s\"\ncontacts=\"%s\"\nanalysis=%s\ninitiation_status=\"%s\"\n%s\n",
+		       "<<<test_start>>>",
+		       running->cmd->name, running->mystime, running->cmd->cmdline, "",
+		       "exit", init_status,
+		       "<<<test_output>>>");
+
+	fflush(stdout);
+}
+
+
+static void write_test_end(struct tag_pgrp *running, time_t exit_time,
+			   char *term_type, int stat_loc, int term_id,
+			   struct tms *tms1, struct tms *tms2)
+{
+	if (!strcmp(reporttype, "rts"))
+		printf("%s\nduration=%ld termination_type=%s termination_id=%d corefile=%s\ncutime=%d cstime=%d\n%s\n",
+		       "<<<execution_status>>>", 
+		       (long) (exit_time - running->mystime),
+		       term_type, term_id, (stat_loc & 0200) ? "yes" : "no",
+		       (int) (tms2->tms_cutime - tms1->tms_cutime),
+		       (int) (tms2->tms_cstime - tms1->tms_cstime),
+		       "<<<test_end>>>");
+	
+	fflush(stdout);
+}
+
+/* Debugging functions */
+
+static void pids_running(struct tag_pgrp *running, int keep_active)
+{
+	int i;
+
+	fprintf(stderr, "pids still running: ");
+	for (i = 0; i < keep_active; ++i) {
+		if (running[i].pgrp != 0)
+			fprintf(stderr, "%d ", running[i].pgrp);
+	}
+	fprintf(stderr, "\n");
+}
+
+static void orphans_running(struct orphan_pgrp *orphans)
+{
+	struct orphan_pgrp *orph;
+
+	fprintf(stderr, "orphans still running: ");
+	
+	for (orph = orphans; orph != NULL; orph = orph->next) {
+		if (orph->pgrp != 0)
+			fprintf(stderr, "%d ", -(orph->pgrp));
+	}
+	fprintf(stderr, "\n");
+}
+
+static void dump_coll(struct collection *coll)
+{
+	int i;
+
+	for (i = 0; i < coll->cnt; ++i) {
+		fprintf(stderr, "coll %d\n", i);
+		fprintf(stderr, "  name=%s cmdline=%s\n", coll->ary[i]->name,
+			coll->ary[i]->cmdline);
+	}
+}
+
+void wait_handler(int sig)
+{
+	int lastsent = 0;
+
+	if (sig == 0) {
+		lastsent = 0;
+		return;
+	} 
+	
+	rec_signal = sig;
+	
+	if(sig == SIGUSR2)
+		return;
+
+	if(lastsent == 0)
+		send_signal = sig;
+	else if(lastsent == SIGUSR1)
+		send_signal = SIGINT;
+	else if(lastsent == sig)
+		send_signal = SIGTERM;
+	else if(lastsent == SIGTERM)
+		send_signal = SIGHUP;
+	else if(lastsent == SIGHUP)
+		send_signal = SIGKILL;
+
+	lastsent = send_signal;
+}
Index: ltp-full-20090430/pan/ltp-scanner.c
===================================================================
--- /dev/null
+++ ltp-full-20090430/pan/ltp-scanner.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ *
+ */
+/* $Id: ltp-scanner.c,v 1.1 2000/09/21 21:35:06 alaffin Exp $ */
+/*
+ * An RTS/pan driver output processing program.
+ *
+ * This program reads an RTS/pan driver output format file, parses it using lex
+ * and saves the information into an in-memory hierarchical keyword table.
+ *
+ * The reporting segment of the program reads that keyword table to produce
+ * it's reports.  
+ *
+ * Synopsis:
+ * 	ltp-scanner [ -e ] [ -D area:level ] [ -h ]
+ *
+ * Description:
+ *   Scanner is part of the RTS 2.0 reporting mechanism or pan.
+ *   It processes RTS/pan driver format output and produces a single simple report
+ *   of each test tag executed, the TCIDs it executed, and their testcases.
+ *
+ * Options:
+ *   -e
+ *	use an "extended" output format
+ *
+ *   -D
+ *	enable debug statements.  Areas are listed in report2.h and levels
+ *	are in the code.  Must be compiled with "-DDEBUGGING"
+ *
+ *   -h
+ *	print out a command usage statement and exit.
+ *
+ * INPUT
+ *   The input must conform to the RTS/pan driver format.
+ *
+ * Report Format
+ *   A single report style is used.  It consists of a header made of all
+ *   keywords in the rts_keywords fields of the driver output, and the test
+ *   information.
+ *	interpretation of CUTS "number of testcases" field when there are
+ *	multiple TCIDs.  It must be the sum of all TCIDs' testcases.
+ *
+ * System Configuration:
+ * ARCHITECTURE         IOS_MODEL_E CRAY_YMP YMP7XX 
+ * CONFIG               JOBCNTL AVL BMD EMA HPM SECURE TFM_UDB_6 SDS SSD 
+ * RELEASE              82 
+ * UNAME                sn1703c cool 8.2.0ae d82.25
+ * date                 03/24/94
+ *
+ * tag		tcid		testcase	status		contact
+ * ------------------------------------------------------------------------
+ *
+ *   When a report is made for only a tag, the TCID and Testcase fields
+ *   contain a dash ( "-" ).  The intention is that the output be usable
+ *   by other Unix programs.
+ *
+ *   When a report is made for all TCIDs and Testcases, a star ( "*" ) is used.
+ *
+ *   When in extended mode, an additional output line is produced for each
+ *   tag.
+ *
+ *	This line is identified with a "!" in the TCID and Testcase fields.
+ *
+ *	It has no minimum and maximum field widths, so the output does not
+ *	line up in columns
+ *
+ *	the "status" field contains the initiation status
+ *
+ *	the "contact" field does not expand multiple comma-separated contacts
+ *
+ *	fields:
+ *		tag, tcid, testcase, status, contact,
+ *		start time, duration, termination type, termination id,
+ *		output starting line, output ending line
+ *
+ * RELATED DOCUMENTS
+ *	Regression Test System Phase 2 Test Result Reporting System
+ *
+ * AUTHOR
+ *   Glen Overby wrote the code.
+ *
+ * Internal Data Format
+ *   All data is maintained in a hierarchical key database.  While there are
+ *   many available databases, this impliments a simple ASCII comma-separated
+ *   keyed database.
+ *
+ *   Key Naming
+ *	- The top-level keys are named after the RTS or pan test tags.
+ *	- The top-level key named "_RTS" contains the RTS Keywords
+ *	- Each tag has a "_keys" tag that contains the key fields from
+ *	  the TEST_START and EXECUTION_STATUS fields.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <string.h>
+#include <getopt.h>
+#include "scan.h"
+#include "debug.h"
+#include "reporter.h"
+#include "symbol.h"
+
+char *cnf;              /* current filename */
+int extended=0;		/* -e option        */
+
+int main(int argc, char *argv[])
+{
+	SYM tags;			/* tag data */
+	int c;
+
+	while ((c = getopt(argc, argv, "D:ehi")) != -1) {
+		switch(c) {
+			case 'i':
+			    set_iscanner();
+			    break;
+			case 'D':
+			    set_debug(optarg);
+			    break;
+			case 'e':
+			    extended++;
+			    break;
+			case 'h':
+			    fprintf(stderr, "%s [-e] [-i] [ -D area, level ] input-filenames\n",
+				    argv[0]);
+			    exit(0);
+			default:
+			    fprintf(stderr, "invalid argument, %c\n", c);
+			    exit(1);
+		}
+	}
+
+	lex_files(&argv[optind]);	/* I hope that argv[argc+1] == NULL */
+	tags = sym_open(0, 0, 0);
+
+	scanner(tags);
+#ifdef DEBUGGING
+	DEBUG(D_INIT, 1)
+	sym_dump_s(tags, 0);
+#endif
+	reporter(tags);
+
+	exit(0);
+}
Index: ltp-full-20090430/pan/pan.c
===================================================================
--- ltp-full-20090430.orig/pan/pan.c
+++ /dev/null
@@ -1,1309 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- * Changelog:
- * 
- *	Added timer options: William Jay Huie, IBM
- *	01/27/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
- *			   - option '-p' (pretty printing)i to enabled formatted printing 
- *			     of results.
- *
- *	01/27/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
- *			   - added code to print system information
- *
- *	01/28/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
- *			   - added code to print test exit value.
- *
- *	01/29/03 - Added: Manoj Iyer, manjo@mail.utexas.edu
- *			   - added code supresses test start and test end tags.
- *
- * 	07/22/07 - Added: Ricardo Salveti de Araujo, rsalveti@linux.vnet.ibm.com
- *			   - added option to create a command file with all failed tests.
- * 	
- */
-/* $Id: pan.c,v 1.32 2009/02/23 10:43:35 subrata_modak Exp $ */
-
-#include <errno.h>
-#include <string.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/times.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <time.h>
-#include <stdlib.h>
-#include <limits.h>
-#include <sys/utsname.h>
-
-#include "splitstr.h"
-#include "zoolib.h"
-
-/* One entry in the command line collection.  */
-struct coll_entry
-{
-    char *name;		/* tag name */
-    char *cmdline;	/* command line */
-    char *pcnt_f;	/* location of %f in the command line args, flag */
-    struct coll_entry *next;
-};
-
-struct collection
-{
-    int cnt;
-    struct coll_entry **ary;
-};
-
-struct tag_pgrp
-{
-    int pgrp;
-    int stopping;
-    time_t mystime;
-    struct coll_entry *cmd;
-    char output[PATH_MAX];
-};
-
-struct orphan_pgrp
-{
-    int pgrp;
-    struct orphan_pgrp *next;
-};
-
-static pid_t run_child(struct coll_entry *colle, struct tag_pgrp *active,
-				int quiet_mode);
-static char *slurp(char *file);
-static struct collection *get_collection(char *file, int optind, int argc,
-					 char **argv);
-static void pids_running(struct tag_pgrp *running, int keep_active);
-static int check_pids(struct tag_pgrp *running, int *num_active,
-		      int keep_active, FILE * logfile, FILE * failcmdfile, 
-		      struct orphan_pgrp *orphans, int fmt_print,
-		      int *failcnt, int quiet_mode);
-static void propagate_signal(struct tag_pgrp *running, int keep_active,
-			     struct orphan_pgrp *orphans);
-static void dump_coll(struct collection *coll);
-static char *subst_pcnt_f(struct coll_entry *colle);
-static void mark_orphan(struct orphan_pgrp *orphans, pid_t cpid);
-static void orphans_running(struct orphan_pgrp *orphans);
-static void check_orphans(struct orphan_pgrp *orphans, int sig);
-
-static void copy_buffered_output(struct tag_pgrp *running);
-static void write_test_start(struct tag_pgrp *running, const char *init_status);
-static void write_test_end(struct tag_pgrp *running,
-			   time_t exit_time, char *term_type, int stat_loc,
-			   int term_id, struct tms *tms1, struct tms *tms2);
-
-//wjh
-static char PAN_STOP_FILE[] = "PAN_STOP_FILE";
-
-static char *panname = NULL;
-static char *test_out_dir = NULL;	/* dir to buffer output to */
-zoo_t zoofile;
-static char *reporttype = NULL;
-
-/* zoolib */
-int rec_signal; 	/* received signal */
-int send_signal;	/* signal to send */
-
-/* Debug Bits */
-int Debug = 0;
-#define Dbuffile	0x000400	/* buffer file use */
-#define	Dsetup		0x000200	/* one-time set-up */
-#define	Dshutdown	0x000100	/* killed by signal */
-#define	Dexit		0x000020	/* exit status */
-#define	Drunning	0x000010	/* current pids running */
-#define	Dstartup	0x000004	/* started command */
-#define	Dstart		0x000002	/* started command */
-#define Dwait		0x000001	/* wait interrupted */
-
-int
-main(int argc, char **argv)
-{
-    extern char *optarg;
-    extern int optind;
-    char *zooname = NULL;	/* name of the zoo file to use */
-    char *filename = "/dev/null";	/* filename to read test tags from */
-    char *logfilename = NULL;
-    char *failcmdfilename = NULL;
-    char *outputfilename = NULL;
-    struct collection *coll = NULL;
-    struct tag_pgrp *running;
-    struct orphan_pgrp *orphans, *orph;
-	struct utsname unamebuf;
-    FILE *logfile = NULL;
-    FILE *failcmdfile = NULL;
-    int keep_active = 1;
-    int num_active = 0;
-	int failcnt = 0;           /* count of total testcases that failed. */
-    int err, i;
-    int starts = -1;
-    int timed = 0;
-    int run_time = -1; char modifier = 'm'; int ret = 0;
-    int stop;
-    int go_idle;
-    int has_brakes = 0;		/* stop everything if a test case fails */
-    int sequential = 0;		/* run tests sequentially */
-    int fork_in_road = 0;
-    int exit_stat;
-    int track_exit_stats = 0;	/* exit non-zero if any test exits non-zero */
-	int fmt_print = 0;          /* enables formatted printing of logfiles. */
-	int quiet_mode = 0;			/* supresses test start and test end tags. */
-    int c;
-    pid_t cpid;
-    struct sigaction sa;
-
-    while ((c = getopt(argc, argv, "AO:Sa:C:d:ef:hl:n:o:pqr:s:t:x:y")) != -1) {
-	switch (c) {
-	case 'A':	/* all-stop flag */
-	    has_brakes = 1;
-	    track_exit_stats = 1;
-	    break;
-	case 'O':	/* output buffering directory */
-	    test_out_dir = strdup(optarg);
-	    break;
-	case 'S':	/* run tests sequentially */
-	    sequential = 1;
-	    break;
-	case 'a':	/* name of the zoo file to use */
-	    zooname = strdup(optarg);
-	    break;
-	case 'C':	/* name of the file where all failed commands will be */
-	    failcmdfilename = strdup(optarg);
-	    break;
-	case 'd':	/* debug options */
-	    sscanf(optarg, "%i", &Debug);
-	    break;
-	case 'e':	/* exit non-zero if any test exists non-zero */
-	    track_exit_stats = 1;
-	    break;
-	case 'f':	/* filename to read test tags from */
-	    filename = strdup(optarg);
-	    break;
-	case 'h':	/* help */
-	    fprintf(stdout, "Usage: pan -n name [ -SyAehpq ] [ -s starts ]"
-				 " [-t time[s|m|h|d] [ -x nactive ] [ -l logfile ]\n\t"
-				 "[ -a active-file ] [ -f command-file ] "
-				 "[ -C fail-command-file ] "
-				 "[ -d debug-level ]\n\t[-o output-file] "
-				 "[-O output-buffer-directory] [cmd]\n");
-	    exit(0);
-	case 'l':	/* log file */
-	    logfilename = strdup(optarg);
-	    break;
-	case 'n':	/* tag given to pan */
-	    panname = strdup(optarg);
-	    break;
-	case 'o':	/* send test output here */
-	    outputfilename = strdup(optarg);
-	    break;
-	case 'p':	/* formatted printing. */
-		fmt_print = 1;
-		break;
-	case 'q':	/* supress test start and test end messages */
-		quiet_mode = 1;
-		break;
-	case 'r':	/* reporting type: none, rts */
-	    reporttype = strdup(optarg);
-	    break;
-	case 's':	/* number of tags to run */
-	    starts = atoi(optarg);
-	    break;
-	case 't':	/* run_time to run */
-	    ret = sscanf(optarg, "%d%c", &run_time, &modifier);
-            if (ret == 0) { fprintf(stderr, "Need proper time input: ####x where"
-                                    "x is one of s,m,h,d\n"); break; }
-            else if (ret == 1) { fprintf(stderr, "Only got a time value of %d "
-                                 "modifiers need to come immediately after #"
-                                 " assuming %c\n", run_time, modifier); }
-            else
-            {
-               switch (modifier)
-               {
-                  case 's': run_time = run_time; break; 
-                  case 'm': run_time = run_time * 60; break; 
-                  case 'h': run_time = run_time * 60 * 60; break; 
-                  case 'd': run_time = run_time * 60 * 60 * 24; break;
-                  default: 
-                     fprintf(stderr, "Invalid time modifier, try: s|h|m|d\n"); exit(-1);
-               }
-	       if (!quiet_mode)
-                  printf("PAN will run for %d seconds\n", run_time);
-            }
-            timed = 1; //-t implies run as many starts as possible, by default
-	    break;
-	case 'x':	/* number of tags to keep running */
-	    keep_active = atoi(optarg);
-	    break;
-	case 'y':	/* restart on failure or signal */
-	    fork_in_road = 1;
-	    break;
-	}
-    }
-
-    if (panname == NULL) {
-	fprintf(stderr, "pan: Must supply -n\n");
-	exit(1);
-    }
-    if (zooname == NULL) {
-	zooname = zoo_getname();
-	if (zooname == NULL) {
-	    fprintf(stderr,
-		    "pan(%s): Must supply -a or set ZOO env variable\n",
-		    panname);
-	    exit(1);
-	}
-    }
-    if (reporttype) {
-	/* make sure we understand the report type */
-	if (strcasecmp(reporttype, "rts")
-			&& strcasecmp(reporttype, "none")
-			/* && strcasecmp(reporttype, "xml")*/)
-	    reporttype = "rts";
-    } else {
-	/* set the default */
-	reporttype = "rts";
-    }
-
-    if (logfilename != NULL) {
-	time_t startup;
-	char *s;
-
-	if (!strcmp(logfilename, "-")) {
-	    logfile = stdout;
-	} else {
-	    if ((logfile = fopen(logfilename, "a+")) == NULL) {
-		fprintf(stderr,
-			"pan(%s): Error %s (%d) opening log file '%s'\n",
-			panname, strerror(errno), errno, logfilename);
-		exit(1);
-	    }
-	}
-
-	time(&startup);
-	s = ctime(&startup);
-	*(s + strlen(s) - 1) = '\0';
-	if (!fmt_print)
-		fprintf(logfile, "startup='%s'\n", s);
-	else
-	{
-		fprintf(logfile, "Test Start Time: %s\n", s);
-		fprintf(logfile, "-----------------------------------------\n");
-		fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n", 
-				"Testcase", "Result", "Exit Value");
-		fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
-			   	"--------", "------", "------------");
-	}
-    }
-
-    coll = get_collection(filename, optind, argc, argv);
-    if(!coll)
-        exit(1);
-    if (coll->cnt == 0) {
-	fprintf(stderr,
-		"pan(%s): Must supply a file collection or a command\n",
-		panname);
-	exit(1);
-    }
-
-    if (Debug & Dsetup)
-	dump_coll(coll);
-
-    /* a place to store the pgrps we're watching */
-    running = (struct tag_pgrp *)malloc((keep_active + 1) * sizeof(struct tag_pgrp));
-    memset(running, 0, keep_active * sizeof(struct tag_pgrp));
-    running[keep_active].pgrp = -1;	/* end sentinel */
-
-    /* a head to the orphaned pgrp list */
-    orphans = (struct orphan_pgrp *) malloc(sizeof(struct orphan_pgrp));
-    memset(orphans, 0, sizeof(struct orphan_pgrp));
-
-    srand48(time(NULL) ^ (getpid() + (getpid() << 15)));
-
-    /* Supply a default for starts.  If we are in sequential mode, use
-     * the number of commands available; otherwise 1.
-     */
-    if (timed == 1 && starts == -1) {	/* timed, infinite by default */
-	starts = -1;
-    } else if (starts == -1) {
-	if (sequential) {
-	    starts = coll->cnt;
-	} else {
-	    starts = 1;
-	}
-    } else if (starts == 0) {	/* if the user specified infinite, set it */
-	starts = -1;
-    } else {			/* else, make sure we are starting at least keep_active processes */
-	if (starts < keep_active)
-	    starts = keep_active;
-    }
-
-    /* if we're buffering output, but we're only running on process at a time,
-     * then essentially "turn off buffering"
-     */
-    if (test_out_dir && (keep_active == 1)) {
-	free(test_out_dir);
-	test_out_dir = NULL;
-    }
-
-    if (test_out_dir) {
-	struct stat sbuf;
-
-	if (stat(test_out_dir, &sbuf) < 0) {
-	    fprintf(stderr,
-		    "pan(%s): stat of -O arg '%s' failed.  errno: %d  %s\n",
-		    panname, test_out_dir, errno, strerror(errno));
-	    exit(1);
-	}
-	if (!S_ISDIR(sbuf.st_mode)) {
-	    fprintf(stderr, "pan(%s): -O arg '%s' must be a directory.\n",
-		    panname, test_out_dir);
-	    exit(1);
-	}
-	if (access(test_out_dir, W_OK | R_OK | X_OK) < 0) {
-	    fprintf(stderr,
-		    "pan(%s): permission denied on -O arg '%s'.  errno: %d  %s\n",
-		    panname, test_out_dir, errno, strerror(errno));
-	    exit(1);
-	}
-    }
-
-    if (outputfilename) {
-	if (!freopen(outputfilename, "a+", stdout)) {
-	    fprintf(stderr,
-		    "pan(%s): Error %s (%d) openning output file '%s'\n",
-		    panname, strerror(errno), errno, outputfilename);
-	    exit(1);
-	}
-    }
-
-    if (failcmdfilename) {
-    	if (!(failcmdfile = fopen(failcmdfilename, "a+"))) {
-	    fprintf(stderr,
-		    "pan(%s): Error %s (%d) opening fail cmd file '%s'\n",
-		    panname, strerror(errno), errno, failcmdfilename);
-	    exit(1);
-    	}
-    }
-
-    if ((zoofile = zoo_open(zooname)) == NULL) {
-	fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-	exit(1);
-    }
-    if (zoo_mark_args(zoofile, getpid(), panname, argc, argv)) {
-	fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-	exit(1);
-    }
-
-    /* Allocate N spaces for max-arg commands.
-     * this is an "active file cleanliness" thing
-     */
-    {
-	char *av[2], bigarg[82];
-
-	memset(bigarg, '.', 81);
-	bigarg[81] = '\0';
-	av[0] = bigarg;
-	av[1] = NULL;
-
-	for (c = 0; c < keep_active; c++) {
-	    if (zoo_mark_cmdline(zoofile, c, panname, "")) {
-		fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-		exit(1);
-	    }
-	}
-	for (c = 0; c < keep_active; c++) {
-	    if (zoo_clear(zoofile, c)) {
-		fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-		exit(1);
-	    }
-	}
-    }
-
-    rec_signal = send_signal = 0;
-    if (run_time != -1) { alarm(run_time); }
-
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags = 0;
-    sa.sa_handler = wait_handler;
-
-    sigaction(SIGALRM, &sa, NULL);
-    sigaction(SIGINT, &sa, NULL);
-    sigaction(SIGTERM, &sa, NULL);
-    sigaction(SIGHUP, &sa, NULL);
-    sigaction(SIGUSR1, &sa, NULL);	/* ignore fork_in_road */
-    sigaction(SIGUSR2, &sa, NULL);	/* stop the scheduler */
-
-    c = 0;			/* in this loop, c is the command index */
-    stop = 0;
-    exit_stat = 0;
-    go_idle = 0;
-    while (1) {
-
-	while ((num_active < keep_active) && (starts != 0)) {
-	    if (stop || rec_signal || go_idle)
-		break;
-
-	    if (!sequential)
-		c = lrand48() % coll->cnt;
-
-	    /* find a slot for the child */
-	    for (i = 0; i < keep_active; ++i) {
-		if (running[i].pgrp == 0)
-		    break;
-	    }
-	    if (i == keep_active) {
-		fprintf(stderr, "pan(%s): Aborting: i == keep_active = %d\n",
-			panname, i);
-		wait_handler(SIGINT);
-		exit_stat++;
-		break;
-	    }
-
-	    cpid = run_child(coll->ary[c], running + i, quiet_mode);
-	    if (cpid != -1)
-		++num_active;
-	    if ((cpid != -1 || sequential) && starts > 0)
-		--starts;
-
-	    if (sequential)
-		if (++c >= coll->cnt)
-		    c = 0;
-
-	} /* while( (num_active < keep_active) && (starts != 0) ) */
-
-	if (starts == 0)
-	{ 
-		if (!quiet_mode)
-			printf("incrementing stop\n"); 
-		++stop; 
-	}
-	else if (starts == -1) //wjh
-	{
-	   FILE *f = (FILE*)-1;
-	   if ((f = fopen(PAN_STOP_FILE, "r")) != 0)
-	   {  printf("Got %s Stopping!\n", PAN_STOP_FILE);
-		  fclose(f); unlink(PAN_STOP_FILE); stop++; 
-	   }
-	}
-
-	if (rec_signal) {
-	    /* propagate everything except sigusr2 */
-
-	    if (rec_signal == SIGUSR2) {
-		if (fork_in_road)
-		    ++go_idle;
-		else
-		    ++stop;
-		rec_signal = send_signal = 0;
-	    } else {
-		if (rec_signal == SIGUSR1)
-		    fork_in_road = 0;
-		propagate_signal(running, keep_active, orphans);
-		if (fork_in_road)
-		    ++go_idle;
-		else
-		    ++stop;
-	    }
-	}
-
-	err = check_pids(running, &num_active, keep_active, logfile,
-			 failcmdfile, orphans, fmt_print, &failcnt, quiet_mode);
-	if (Debug & Drunning) {
-	    pids_running(running, keep_active);
-	    orphans_running(orphans);
-	}
-	if (err) {
-	    if (fork_in_road)
-		++go_idle;
-	    if (track_exit_stats)
-		exit_stat++;
-	    if (has_brakes) {
-		fprintf(stderr, "pan(%s): All stop!%s\n", panname,
-			go_idle ? " (idling)" : "");
-		wait_handler(SIGINT);
-	    }
-	}
-
-	if (stop && (num_active == 0))
-	    break;
-
-	if (go_idle && (num_active == 0)) {
-	    go_idle = 0;	/* It is idle, now resume scheduling. */
-	    wait_handler(0);	/* Reset the signal ratchet. */
-	}
-    }
-
-    /* Wait for orphaned pgrps */
-    while (1) {
-	for (orph = orphans; orph != NULL; orph = orph->next) {
-	    if (orph->pgrp == 0)
-		continue;
-	    /* Yes, we have orphaned pgrps */
-	    sleep(5);
-	    if (!rec_signal) {
-		/* force an artificial signal, move us
-		 * through the signal ratchet.
-		 */
-		wait_handler(SIGINT);
-	    }
-	    propagate_signal(running, keep_active, orphans);
-	    if (Debug & Drunning)
-		orphans_running(orphans);
-	    break;
-	}
-	if (orph == NULL)
-	    break;
-    }
-
-    if (zoo_clear(zoofile, getpid())) {
-	fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-	++exit_stat;
-    }
-    fclose(zoofile);
-	if (logfile && fmt_print)
-	{
-		if (uname(&unamebuf) == -1)
-			fprintf(stderr, "ERROR: uname(): %s\n", strerror(errno));
-		fprintf(logfile, "\n-----------------------------------------------\n");
-		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
-		fprintf(logfile, "Total Failures: %d\n", failcnt);
-		fprintf(logfile, "Kernel Version: %s\n", unamebuf.release);
-		fprintf(logfile, "Machine Architecture: %s\n", unamebuf.machine);
-		fprintf(logfile, "Hostname: %s\n\n", unamebuf.nodename);
-	}
-    if (logfile && (logfile != stdout))
-	fclose(logfile);
-
-    exit(exit_stat);
-}
-
-
-
-static void
-propagate_signal(struct tag_pgrp *running, int keep_active,
-		 struct orphan_pgrp *orphans)
-{
-    int i;
-
-    if (Debug & Dshutdown)
-	fprintf(stderr, "pan was signaled with sig %d...\n", rec_signal);
-
-    if (rec_signal == SIGALRM)
-    {
-       printf("PAN stop Alarm was received\n");
-       rec_signal = SIGTERM;
-    }
-
-    for (i = 0; i < keep_active; ++i) {
-	if (running[i].pgrp == 0)
-	    continue;
-
-	if (Debug & Dshutdown)
-	    fprintf(stderr, "  propagating sig %d to %d\n",
-		    send_signal, -running[i].pgrp);
-	if (kill(-running[i].pgrp, send_signal) != 0) {
-	    fprintf(stderr,
-		    "pan(%s): kill(%d,%d) failed on tag (%s).  errno:%d  %s\n",
-		    panname, -running[i].pgrp, send_signal,
-		    running[i].cmd->name, errno, strerror(errno));
-	}
-	running[i].stopping = 1;
-    }
-
-    check_orphans(orphans, send_signal);
-
-    rec_signal = send_signal = 0;
-}
-
-
-static int
-check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
-	   FILE * logfile, FILE * failcmdfile, struct orphan_pgrp *orphans,
-	   int fmt_print, int *failcnt, int quiet_mode)
-{
-    int w;
-    pid_t cpid;
-    int stat_loc;
-    int ret = 0;
-    int i;
-    time_t t;
-    char *status;
-    int signaled = 0;
-    struct tms tms1, tms2;
-    clock_t tck;
-
-    check_orphans(orphans, 0);
-
-    tck = times(&tms1);
-    if (tck == -1) {
-	fprintf(stderr, "pan(%s): times(&tms1) failed.  errno:%d  %s\n",
-		panname, errno, strerror(errno));
-    }
-    cpid = wait(&stat_loc);
-    tck = times(&tms2);
-    if (tck == -1) {
-	fprintf(stderr, "pan(%s): times(&tms2) failed.  errno:%d  %s\n",
-		panname, errno, strerror(errno));
-    }
-
-    if (cpid < 0) {
-	if (errno == EINTR) {
-	    if (Debug)
-		fprintf(stderr, "pan(%s): wait() interrupted\n", panname);
-	} else if (errno != ECHILD) {
-	    fprintf(stderr, "pan(%s): wait() failed.  errno:%d  %s\n",
-		    panname, errno, strerror(errno));
-	}
-    } else if (cpid > 0) {
-
-	if (WIFSIGNALED(stat_loc)) {
-	    w = WTERMSIG(stat_loc);
-	    status = "signaled";
-	    if (Debug & Dexit)
-		fprintf(stderr, "child %d terminated with signal %d\n", cpid,
-			w);
-	    --*num_active;
-	    signaled = 1;
-	} else if (WIFEXITED(stat_loc)) {
-	    w = WEXITSTATUS(stat_loc);
-	    status = "exited";
-	    if (Debug & Dexit)
-		fprintf(stderr, "child %d exited with status %d\n", cpid, w);
-	    --*num_active;
-	    if (w != 0)
-		ret++;
-	} else if (WIFSTOPPED(stat_loc)) {	/* should never happen */
-	    w = WSTOPSIG(stat_loc);
-	    status = "stopped";
-	    ret++;
-	} else {		/* should never happen */
-	    w = 0;
-	    status = "unknown";
-	    ret++;
-	}
-
-	for (i = 0; i < keep_active; ++i) {
-	    if (running[i].pgrp == cpid) {
-		if ((w == 130) && running[i].stopping &&
-		    (strcmp(status, "exited") == 0)) {
-		    /* The child received sigint, but
-		     * did not trap for it?  Compensate
-		     * for it here.
-		     */
-		    w = 0;
-		    ret--;	/* undo */
-		    if (Debug & Drunning)
-			fprintf(stderr,
-				"pan(%s): tag=%s exited 130, known to be signaled; will give it an exit 0.\n",
-				panname, running[i].cmd->name);
-		}
-		time(&t);
-		if (logfile != NULL) {
-			if (!fmt_print)
-				fprintf(logfile,
-				 "tag=%s stime=%d dur=%d exit=%s stat=%d core=%s cu=%d cs=%d\n",
-					running[i].cmd->name, (int) (running[i].mystime),
-					(int) (t - running[i].mystime), status, w,
-					(stat_loc & 0200) ? "yes" : "no",
-					(int) (tms2.tms_cutime - tms1.tms_cutime),
-					(int) (tms2.tms_cstime - tms1.tms_cstime));
-			else
-			{
-					if (w != 0) 
-						++*failcnt;
-					fprintf(logfile, "%-30.30s %-10.10s %-5d\n", 
-							running[i].cmd->name, ((w != 0) ? "FAIL" : "PASS"),
-							w);
-			}
-
-				fflush(logfile);
-		}
-
-		if ((failcmdfile != NULL) && (w !=0)) {
-			fprintf(failcmdfile, "%s %s\n", running[i].cmd->name, running[i].cmd->cmdline);
-		}
-
-		if (running[i].stopping)
-		    status = "driver_interrupt";
-
-		if (test_out_dir) {
-			if (!quiet_mode)
-				write_test_start(running+i, "ok");
-			copy_buffered_output(running + i);
-			unlink(running[i].output);
-		}
-		if (!quiet_mode)
-			write_test_end(running+i, t, status,
-			   stat_loc, w, &tms1, &tms2);
-
-		/* If signaled and we weren't expecting
-		 * this to be stopped then the proc
-		 * had a problem.
-		 */
-		if (signaled && !running[i].stopping)
-		    ret++;
-
-		running[i].pgrp = 0;
-		if (zoo_clear(zoofile, cpid)) {
-		    fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-		    exit(1);
-		}
-
-		/* Check for orphaned pgrps */
-		if ((kill(-cpid, 0) == 0) || (errno == EPERM)) {
-		    if (zoo_mark_cmdline(zoofile, cpid, "panorphan",
-					  running[i].cmd->cmdline)) {
-			fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-			exit(1);
-		    }
-		    mark_orphan(orphans, cpid);
-		    /* status of kill doesn't matter */
-		    kill(-cpid, SIGTERM);
-		}
-
-		break;
-	    }
-	}
-    }
-    return ret;
-}
-
-
-static pid_t
-run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode)
-{
-    int cpid;
-    int c_stdout = -1;		/* child's stdout, stderr */
-    int capturing = 0;		/* output is going to a file instead of stdout */
-    char *c_cmdline;
-    static long cmdno = 0;
-    int errpipe[2];		/* way to communicate to parent that the tag  */
-    char errbuf[1024];		/* didn't actually start */
-    int errlen;
-
-    /* Try to open the file that will be stdout for the test */
-    if (test_out_dir) {
-	capturing = 1;
-	do {
-	    sprintf(active->output, "%s/%s.%ld",
-		    test_out_dir, colle->name, cmdno++);
-	    c_stdout = open(active->output, O_CREAT | O_RDWR | O_EXCL | O_SYNC, 0666);
-	} while (c_stdout < 0 && errno == EEXIST);
-	if (c_stdout < 0) {
-	    fprintf(stderr,
-		    "pan(%s): open of stdout file failed (tag %s).  errno: %d  %s\n  file: %s\n",
-		    panname, colle->name, errno, strerror(errno),
-		    active->output);
-	    return -1;
-	}
-    } 
-
-    /* get the tag's command line arguments ready.  subst_pcnt_f() uses a
-     * static counter, that's why we do it here instead of after we fork.
-     */
-    if (colle->pcnt_f) {
-	c_cmdline = subst_pcnt_f(colle);
-    } else {
-	c_cmdline = colle->cmdline;
-    }
-    
-    if (pipe(errpipe) < 0) {
-	fprintf(stderr, "pan(%s): pipe() failed. errno:%d %s\n",
-			panname, errno, strerror(errno));
-	if (capturing) {
-	    close(c_stdout);
-            unlink(active->output);
-        }
-	return -1;
-    }
-
-    if ((cpid = fork()) < 0) {
-	fprintf(stderr, "pan(%s): fork failed (tag %s).  errno:%d  %s\n",
-		panname, colle->name, errno, strerror(errno));
-	if (capturing) {
-            unlink(active->output);
-	    close(c_stdout);
-        }
-	close(errpipe[0]);
-	close(errpipe[1]);
-	return -1;
-    } else if (cpid == 0) {
-	/* child */
-
-	fclose(zoofile);
-	close(errpipe[0]);
-	fcntl(errpipe[1], F_SETFD, 1);  /* close the pipe if we succeed */
-	setpgrp();
-
-	umask(0);
-
-	/* if we're putting output into a buffer file, we need to do the
-	 * redirection now.  If we fail
-	 */
-	if (capturing) {
-	    if (dup2(c_stdout, fileno(stdout)) == -1) {
-		errlen = sprintf(errbuf, "pan(%s): couldn't redirect stdout for tag %s.  errno:%d  %s",
-				panname, colle->name, errno, strerror(errno));
-		write(errpipe[1], &errlen, sizeof(errlen));
-		write(errpipe[1], errbuf, errlen);
-		exit(2);
-	    }
-	    if (dup2(c_stdout, fileno(stderr)) == -1) {
-		errlen = sprintf(errbuf, "pan(%s): couldn't redirect stderr for tag %s.  errno:%d  %s",
-				panname, colle->name, errno, strerror(errno));
-		write(errpipe[1], &errlen, sizeof(errlen));
-		write(errpipe[1], errbuf, errlen);
-		exit(2);
-	    }
-	} else { /* stderr still needs to be redirected */
-	    if (dup2(fileno(stdout), fileno(stderr)) == -1) {
-		errlen = sprintf(errbuf, "pan(%s): couldn't redirect stderr for tag %s.  errno:%d  %s",
-				panname, colle->name, errno, strerror(errno));
-		write(errpipe[1], &errlen, sizeof(errlen));
-		write(errpipe[1], errbuf, errlen);
-		exit(2);
-	    }
-	}
-	/* If there are any shell-type characters in the cmdline
-	 * such as '>', '<', '$', '|', etc, then we exec a shell and
-	 * run the cmd under a shell.
-	 *
-	 * Otherwise, break the cmdline at white space and exec the
-	 * cmd directly.
-	 */
-	if (strpbrk(c_cmdline, "\"';|<>$\\")) {
-	    execlp("sh", "sh", "-c", c_cmdline, (char*)0);
-	    errlen = sprintf(errbuf, 
-		    "pan(%s): execlp of '%s' (tag %s) failed.  errno:%d %s",
-		    panname, c_cmdline, colle->name, errno, strerror(errno));
-	} else {
-	    char **arg_v;
-
-	    arg_v = (char **)splitstr(c_cmdline, NULL, NULL);
-	    
-	    execvp(arg_v[0], arg_v);
-    	    errlen = sprintf(errbuf,
-		    "pan(%s): execvp of '%s' (tag %s) failed.  errno:%d  %s",
-		    panname, arg_v[0], colle->name, errno, strerror(errno));
-	}
-	write(errpipe[1], &errlen, sizeof(errlen));
-	write(errpipe[1], errbuf, errlen);
-	exit(errno);
-    }
-
-    /* parent */
-
-    /* subst_pcnt_f() allocates the command line dynamically
-     * free the malloc to prevent a memory leak
-     */
-    if (colle->pcnt_f) free(c_cmdline); 
-
-    close(errpipe[1]);
-    time(&active->mystime);
-    active->cmd = colle;
-
-    /* if the child couldn't go through with the exec, 
-     * clean up the mess, note it, and move on
-     */
-    if(read(errpipe[0], &errlen, sizeof(errlen))) {
-	int status;
-	time_t end_time;
-	int termid;
-	char *termtype;
-	struct tms notime = {0, 0, 0, 0};
-
-	read(errpipe[0], errbuf, errlen);
-	close(errpipe[0]);
-	errbuf[errlen] = '\0';
-	/* fprintf(stderr, "%s", errbuf); */
-	waitpid(cpid, &status, 0);
-	if (WIFSIGNALED(status)) {
-	    termid = WTERMSIG(status);
-	    termtype = "signaled";
-	} else if (WIFEXITED(status)) {
-	    termid = WEXITSTATUS(status);
-	    termtype = "exited";
-	} else if (WIFSTOPPED(status)) {
-	    termid = WSTOPSIG(status);
-	    termtype = "stopped";
-	} else {
-	    termid = 0;
-	    termtype = "unknown";
-	}
-	time(&end_time);
-	if (!quiet_mode) 
-	{
-		write_test_start(active, errbuf);
-		write_test_end(active, end_time, termtype, status, 
-			termid, &notime, &notime);
-	}
-        if (capturing) {
-            close(c_stdout);
-            unlink(active->output);
-        }
-	return -1;
-    }
-
-    close(errpipe[0]);
-    if (capturing) close(c_stdout);
-	
-    if (!test_out_dir) 
-	if (!quiet_mode)
-		write_test_start(active, "ok");
-
-    active->pgrp = cpid;
-    active->stopping = 0;
-
-    if (zoo_mark_cmdline(zoofile, cpid, colle->name, colle->cmdline)) {
-	fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-	exit(1);
-    }
-
-    if (Debug & Dstartup)
-	fprintf(stderr, "started %s cpid=%d at %s",
-		colle->name, cpid, ctime(&active->mystime));
-
-    if (Debug & Dstart) {
-	fprintf(stderr, "Executing test = %s as %s", colle->name, colle->cmdline);
-	if (capturing)
-	    fprintf(stderr, "with output file = %s\n", active->output);
-	else
-    	    fprintf(stderr, "\n");
-    }
-
-    return cpid;
-}
-
-
-static char *
-subst_pcnt_f(struct coll_entry *colle)
-{
-    static int counter = 1;
-    char pid_and_counter[20];
-    char new_cmdline[1024];
-
-    /* if we get called falsely, do the right thing anyway */
-    if (!colle->pcnt_f) 
-	return colle->cmdline;
-
-    snprintf(pid_and_counter, 20, "%d_%d", getpid(), counter++);
-    snprintf(new_cmdline, 1024, colle->cmdline, pid_and_counter);
-    return strdup(new_cmdline);
-}
-
-static struct collection *
-get_collection(char *file, int optind, int argc, char **argv)
-{
-    char *buf, *a, *b;
-    struct coll_entry *head, *p, *n;
-    struct collection *coll;
-    int i;
-
-    buf = slurp(file);
-    if(!buf)
-        return NULL;
-
-    coll = (struct collection *) malloc(sizeof(struct collection));
-    coll->cnt = 0;
-
-    head = p = n = NULL;
-    a = b = buf;
-    while (a) {
-	/* set b to the start of the next line and add a NULL character
-	 * to separate the two lines */
-	if ((b = strchr(a, '\n')) != NULL)
-            *b++ = '\0';
-
-	/* If this is line isn't a comment */
-	if ((*a != '#') && (*a != '\0') && (*a != ' ')) {
-	    n = (struct coll_entry *) malloc(sizeof(struct coll_entry));
-	    if ((n->pcnt_f = strstr(a, "%f"))) {
-		n->pcnt_f[1] = 's';
-	    }
-	    n->name = strdup(strsep(&a, " \t"));
-	    n->cmdline = strdup(a);
-	    n->next = NULL;
-	    
-	    if (p) {
-		p->next = n;
-	    }
-	    if (head == NULL) {
-		head = n;
-	    }
-	    p = n;
-	    coll->cnt++;
-	}
-        a = b;
-    }
-    free(buf);
-
-    /* is there something on the commandline to be counted? */
-    if (optind < argc) {
-	char workstr[1024] = "";
-	int workstr_left = 1023;
-	
-	/* fill arg list */
-	for (i = 0; optind < argc; ++optind, ++i) {
-	    strncat(workstr, argv[optind], workstr_left);
-	    workstr_left = workstr_left - strlen(argv[optind]);
-	    strncat(workstr, " ", workstr_left);
-	    workstr_left--;
-	}
-
-    	n = (struct coll_entry *) malloc(sizeof(struct coll_entry));
-    	if ((n->pcnt_f = strstr(workstr, "%f"))) {
-	    n->pcnt_f[1] = 's';
-	}
-	n->cmdline = strdup(workstr);
-	n->name = "cmdln";
-	n->next = NULL;
-	if (p) {
-	    p->next = n;
-	}
-	if (head == NULL) {
-	    head = n;
-	}
-	coll->cnt++;
-    }
-
-    /* get an array */
-    coll->ary = (struct coll_entry **) malloc(coll->cnt *
-					      sizeof(struct coll_entry *));
-
-    /* fill the array */
-    i = 0;
-    n = head;
-    while (n != NULL) {
-	coll->ary[i] = n;
-	n = n->next;
-	++i;
-    }
-    if (i != coll->cnt)
-	fprintf(stderr, "pan(%s): i doesn't match cnt\n", panname);
-
-    return coll;
-}
-
-
-static char *
-slurp(char *file)
-{
-    char *buf;
-    int fd;
-    struct stat sbuf;
-
-    if ((fd = open(file, O_RDONLY)) < 0) {
-	fprintf(stderr, "pan(%s): open(%s,O_RDONLY) failed.  errno:%d  %s\n",
-		panname, file, errno, strerror(errno));
-	return NULL;
-    }
-
-    if (fstat(fd, &sbuf) < 0) {
-	fprintf(stderr, "pan(%s): fstat(%s) failed.  errno:%d  %s\n",
-		panname, file, errno, strerror(errno));
-	return NULL;
-    }
-
-    buf = (char *) malloc(sbuf.st_size + 1);
-    if (read(fd, buf, sbuf.st_size) != sbuf.st_size) {
-	fprintf(stderr, "pan(%s): slurp failed.  errno:%d  %s\n",
-		panname, errno, strerror(errno));
-	return NULL;
-    }
-    buf[sbuf.st_size] = '\0';
-
-    close(fd);
-    return buf;
-}
-
-static void
-check_orphans(struct orphan_pgrp *orphans, int sig)
-{
-    struct orphan_pgrp *orph;
-
-    for (orph = orphans; orph != NULL; orph = orph->next) {
-	if (orph->pgrp == 0)
-	    continue;
-
-	if (Debug & Dshutdown)
-	    fprintf(stderr, "  propagating sig %d to orphaned pgrp %d\n",
-		    sig, -(orph->pgrp));
-	if (kill(-(orph->pgrp), sig) != 0) {
-	    if (errno == ESRCH) {
-		/* This pgrp is now empty */
-		if (zoo_clear(zoofile, orph->pgrp)) {
-		    fprintf(stderr, "pan(%s): %s\n", panname, zoo_error);
-		}
-		orph->pgrp = 0;
-	    } else {
-		fprintf(stderr,
-			"pan(%s): kill(%d,%d) on orphaned pgrp failed.  errno:%d  %s\n",
-			panname, -(orph->pgrp), sig, errno, strerror(errno));
-	    }
-	}
-    }
-}
-
-
-static void
-mark_orphan(struct orphan_pgrp *orphans, pid_t cpid)
-{
-    struct orphan_pgrp *orph;
-
-    for (orph = orphans; orph != NULL; orph = orph->next) {
-	if (orph->pgrp == 0)
-	    break;
-    }
-    if (orph == NULL) {
-	/* make a new struct */
-	orph = (struct orphan_pgrp *) malloc(sizeof(struct orphan_pgrp));
-
-	/* plug in the new struct just after the head */
-	orph->next = orphans->next;
-	orphans->next = orph;
-    }
-    orph->pgrp = cpid;
-}
-
-
-
-static void
-copy_buffered_output(struct tag_pgrp *running)
-{
-    char *tag_output;
-
-    tag_output = slurp(running->output);
-    if (tag_output) {
-	printf("%s", tag_output);
-	/* make sure the output ends with a newline */
-	if (tag_output[strlen(tag_output) - 1] != '\n')
-	    printf("\n");
-	fflush(stdout);
-	free(tag_output);
-    }
-}
-
-
-static void
-write_test_start(struct tag_pgrp *running, const char *init_status)
-{
-    if (!strcmp(reporttype, "rts")) {
-
-	printf("%s\ntag=%s stime=%ld\ncmdline=\"%s\"\ncontacts=\"%s\"\nanalysis=%s\ninitiation_status=\"%s\"\n%s\n",
-			"<<<test_start>>>",
-			running->cmd->name, running->mystime, running->cmd->cmdline, "",
-			"exit", init_status,
-			"<<<test_output>>>");
-    }
-    fflush(stdout);
-}
-
-
-static void
-write_test_end(struct tag_pgrp *running, time_t exit_time,
-	       char *term_type, int stat_loc, int term_id,
-	       struct tms *tms1, struct tms *tms2)
-{
-    if (!strcmp(reporttype, "rts")) {
-	printf("%s\nduration=%ld termination_type=%s termination_id=%d corefile=%s\ncutime=%d cstime=%d\n%s\n",
-		  	"<<<execution_status>>>", 
-			(long) (exit_time - running->mystime),
-			term_type, term_id, (stat_loc & 0200) ? "yes" : "no",
-			(int) (tms2->tms_cutime - tms1->tms_cutime),
-			(int) (tms2->tms_cstime - tms1->tms_cstime),
-			"<<<test_end>>>");
-    }
-    fflush(stdout);
-}
-
-/* The functions below are all debugging related */
-
-static void
-pids_running(struct tag_pgrp *running, int keep_active)
-{
-    int i;
-
-    fprintf(stderr, "pids still running: ");
-    for (i = 0; i < keep_active; ++i) {
-	if (running[i].pgrp != 0)
-	    fprintf(stderr, "%d ", running[i].pgrp);
-    }
-    fprintf(stderr, "\n");
-}
-
-static void
-orphans_running(struct orphan_pgrp *orphans)
-{
-    struct orphan_pgrp *orph;
-
-    fprintf(stderr, "orphans still running: ");
-    for (orph = orphans; orph != NULL; orph = orph->next) {
-	if (orph->pgrp != 0)
-	    fprintf(stderr, "%d ", -(orph->pgrp));
-    }
-    fprintf(stderr, "\n");
-}
-
-static void
-dump_coll(struct collection *coll)
-{
-    int i;
-
-    for (i = 0; i < coll->cnt; ++i) {
-	fprintf(stderr, "coll %d\n", i);
-	fprintf(stderr, "  name=%s cmdline=%s\n", coll->ary[i]->name,
-		coll->ary[i]->cmdline);
-    }
-}
-
-void
-wait_handler( int sig )
-{
-    static int lastsent = 0;
-
-    if( sig == 0 ){
-	lastsent = 0;
-    } else {
-	rec_signal = sig;
-	if( sig == SIGUSR2 )
-	    return;
-	if( lastsent == 0 )
-	    send_signal = sig;
-	else if( lastsent == SIGUSR1 )
-	    send_signal = SIGINT;
-	else if( lastsent == sig )
-	    send_signal = SIGTERM;
-	else if( lastsent == SIGTERM )
-	    send_signal = SIGHUP;
-	else if( lastsent == SIGHUP )
-	    send_signal = SIGKILL;
-	lastsent = send_signal;
-    }
-}
Index: ltp-full-20090430/pan/scanner.c
===================================================================
--- ltp-full-20090430.orig/pan/scanner.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/* $Id: scanner.c,v 1.1 2000/09/21 21:35:06 alaffin Exp $ */
-/*
- * An RTS/pan driver output processing program.
- *
- * This program reads an RTS/pan driver output format file, parses it using lex
- * and saves the information into an in-memory hierarchical keyword table.
- *
- * The reporting segment of the program reads that keyword table to produce
- * it's reports.  
- *
- * Synopsis:
- * 	scanner [ -e ] [ -D area:level ] [ -h ]
- *
- * Description:
- *   Scanner is part of the RTS 2.0 reporting mechanism or pan.
- *   It processes RTS/pan driver format output and produces a single simple report
- *   of each test tag executed, the TCIDs it executed, and their testcases.
- *
- * Options:
- *   -e
- *	use an "extended" output format
- *
- *   -D
- *	enable debug statements.  Areas are listed in report2.h and levels
- *	are in the code.  Must be compiled with "-DDEBUGGING"
- *
- *   -h
- *	print out a command usage statement and exit.
- *
- * INPUT
- *   The input must conform to the RTS/pan driver format.
- *
- * Report Format
- *   A single report style is used.  It consists of a header made of all
- *   keywords in the rts_keywords fields of the driver output, and the test
- *   information.
- *	interpretation of CUTS "number of testcases" field when there are
- *	multiple TCIDs.  It must be the sum of all TCIDs' testcases.
- *
- * System Configuration:
- * ARCHITECTURE         IOS_MODEL_E CRAY_YMP YMP7XX 
- * CONFIG               JOBCNTL AVL BMD EMA HPM SECURE TFM_UDB_6 SDS SSD 
- * RELEASE              82 
- * UNAME                sn1703c cool 8.2.0ae d82.25
- * date                 03/24/94
- *
- * tag		tcid		testcase	status		contact
- * ------------------------------------------------------------------------
- *
- *   When a report is made for only a tag, the TCID and Testcase fields
- *   contain a dash ( "-" ).  The intention is that the output be usable
- *   by other Unix programs.
- *
- *   When a report is made for all TCIDs and Testcases, a star ( "*" ) is used.
- *
- *   When in extended mode, an additional output line is produced for each
- *   tag.
- *
- *	This line is identified with a "!" in the TCID and Testcase fields.
- *
- *	It has no minimum and maximum field widths, so the output does not
- *	line up in columns
- *
- *	the "status" field contains the initiation status
- *
- *	the "contact" field does not expand multiple comma-separated contacts
- *
- *	fields:
- *		tag, tcid, testcase, status, contact,
- *		start time, duration, termination type, termination id,
- *		output starting line, output ending line
- *
- * RELATED DOCUMENTS
- *	Regression Test System Phase 2 Test Result Reporting System
- *
- * AUTHOR
- *   Glen Overby wrote the code.
- *
- * Internal Data Format
- *   All data is maintained in a hierarchical key database.  While there are
- *   many available databases, this impliments a simple ASCII comma-separated
- *   keyed database.
- *
- *   Key Naming
- *	- The top-level keys are named after the RTS or pan test tags.
- *	- The top-level key named "_RTS" contains the RTS Keywords
- *	- Each tag has a "_keys" tag that contains the key fields from
- *	  the TEST_START and EXECUTION_STATUS fields.
- */
-#include <stdio.h>
-#include <stdlib.h>
-#include <malloc.h>
-#include <unistd.h>
-#include <stdarg.h>
-#include <string.h>
-#include "scan.h"
-#include "debug.h"
-#include "reporter.h"
-#include "symbol.h"
-
-char *cfn;			/* current filename */
-int extended=0;			/* -e option */
-
-int
-main(argc, argv)
-    int argc;
-    char **argv;
-{
-    SYM tags;			/* tag data */
-
-    /* Argument parsing */
-    int r;
-    char c;
-    extern char *optarg;
-    extern int optind, opterr, optopt;
-
-    while(( r = getopt(argc, argv, "D:ehi")) != -1) {
-	c = (char) r;
-	switch(c) {
-	case 'i':
-	    set_iscanner();
-	    break;
-	case 'D':
-	    set_debug(optarg);
-	    break;
-	case 'e':
-	    extended++;
-	    break;
-	case 'h':
-	    fprintf(stderr, "%s [-e] [-i] [ -D area, level ] input-filenames\n",
-		    argv[0]);
-	    exit(0);
-	    break;
-	default:
-	    fprintf(stderr, "invalid argument, %c\n", c);
-	    exit(1);
-	}
-    }
-
-    lex_files(&argv[optind]);	/* I hope that argv[argc+1] == NULL */
-    tags = sym_open(0, 0, 0);
-
-    scanner(tags);
-#ifdef DEBUGGING
-    DEBUG(D_INIT, 1)
-	sym_dump_s(tags, 0);
-#endif
-    reporter(tags);
-
-    exit(0);
-}
Index: ltp-full-20090430/runltp
===================================================================
--- ltp-full-20090430.orig/runltp
+++ ltp-full-20090430/runltp
@@ -33,7 +33,7 @@
 #               Oct 08 2003 - Modified - Manoj Iyer
 #               - fixed bug in creating results directory
 #               - all checks should be enlclosed in " " to avoid bash error
-#               - exit with error if pan is not found in pan directory
+#               - exit with error if ltp-pan is not found in pan directory
 #
 #               Jul 22 2007 - Modified - Ricardo Salveti de Araujo
 #               - added support to put more then one file at CMDLINE (-f)
@@ -85,9 +85,9 @@ setup()
         exit 1
     }
 
-    [ -e $LTPROOT/pan/pan ] ||
+    [ -e $LTPROOT/pan/ltp-pan ] ||
     {
-        echo "FATAL: Test suite driver 'pan' not found"
+        echo "FATAL: Test suite driver 'ltp-pan' not found"
         echo "INFO: as root user type 'make ; make install'"
         exit 1
     }
@@ -709,7 +709,7 @@ main()
     fi
 
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
-    PAN_COMMAND="${LTPROOT}/pan/pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
+    PAN_COMMAND="${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE"
     if [ ! -z "$VERBOSE_MODE" ] ; then
       echo "COMMAND:    $PAN_COMMAND"
@@ -740,14 +740,14 @@ main()
 
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
-    ${LTPROOT}/pan/pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
+    ${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
      
     if [ $? -eq 0 ]; then
-      echo "INFO: pan reported all tests PASS"
+      echo "INFO: ltp-pan reported all tests PASS"
       VALUE=0
       export LTP_EXIT_VALUE=0;
     else
-      echo "INFO: pan reported some tests FAIL"
+      echo "INFO: ltp-pan reported some tests FAIL"
       VALUE=1
       export LTP_EXIT_VALUE=1;
     fi
Index: ltp-full-20090430/runltplite.sh
===================================================================
--- ltp-full-20090430.orig/runltplite.sh
+++ ltp-full-20090430/runltplite.sh
@@ -57,9 +57,9 @@ setup()
         exit 1
     }
 
-    [ -e $LTPROOT/pan/pan ] ||
+    [ -e $LTPROOT/pan/ltp-pan ] ||
     {
-        echo "FATAL: Test suite driver 'pan' not found"
+        echo "FATAL: Test suite driver 'ltp-pan' not found"
         echo "INFO: as root user type 'make ; make install'"
         exit 1
     }
@@ -284,7 +284,7 @@ main()
     }
 
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
-    PAN_COMMAND="${LTPROOT}/pan/pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
+    PAN_COMMAND="${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE"
     if [ ! -z "$VERBOSE_MODE" ] ; then
       echo "COMMAND:    $PAN_COMMAND"
@@ -295,14 +295,14 @@ main()
     #$PAN_COMMAND #Duplicated code here, because otherwise if we fail, only "PAN_COMMAND" gets output
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
-    ${LTPROOT}/pan/pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
+    ${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE
     
     if [ $? -eq 0 ]; then
-      echo "INFO: pan reported all tests PASS"
+      echo "INFO: ltp-pan reported all tests PASS"
       VALUE=0
     else
-      echo "INFO: pan reported some tests FAIL"
+      echo "INFO: ltp-pan reported some tests FAIL"
       VALUE=1
     fi
     cd ..
Index: ltp-full-20090430/testscripts/diskio.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/diskio.sh
+++ ltp-full-20090430/testscripts/diskio.sh
@@ -27,11 +27,11 @@ export PATH="${PATH}:${LTPROOT}/testcase
  
 ${LTPROOT}/ver_linux
 
-${LTPROOT}/pan/pan -e -l /tmp/diskiopan.log -S -a ltpdiskio -n ltpdiskio -f ${LTPROOT}/runtest/io_floppy -f ${LTPROOT}/runtest/io_cd
+${LTPROOT}/pan/ltp-pan -e -l /tmp/diskiopan.log -S -a ltpdiskio -n ltpdiskio -f ${LTPROOT}/runtest/io_floppy -f ${LTPROOT}/runtest/io_cd
 
 if [ $? -eq "0" ]; then
-  echo pan reported PASS
+  echo ltp-pan reported PASS
 else
-  echo pan reported FAIL
+  echo ltp-pan reported FAIL
 fi
 
Index: ltp-full-20090430/testscripts/ltp-aiodio.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/ltp-aiodio.sh
+++ ltp-full-20090430/testscripts/ltp-aiodio.sh
@@ -229,7 +229,7 @@ echo "************ Running aio-stress te
 echo "current working dir = ${PWD}"
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part1 > ${TMPBASE}/ltp-aio-stress.part1
 
-${LTPROOT}/pan/pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part1 &
+${LTPROOT}/pan/ltp-pan -e -S -a ltpaiostresspart1 -n ltp-aiostresspart1 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part1 &
 
 wait $!
 
@@ -241,7 +241,7 @@ if [ "$runExtendedStress" -eq 1 ];then
 echo "************ Running EXTENDED aio-stress tests " 
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aio-stress.part2 > ${TMPBASE}/ltp-aio-stress.part2
 
-${LTPROOT}/pan/pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part2 &
+${LTPROOT}/pan/ltp-pan -e -S -a ltpaiostresspart2 -n ltp-aiostresspart2 -l ltpaiostress.logfile -o ltpaiostress.outfile -p -f ${TMPBASE}/ltp-aio-stress.part2 &
 
 wait $!
 sync
@@ -256,7 +256,7 @@ dd if=$file1 of=/test/aiodio/ff3      bs
 echo "************ Running aiocp tests " 
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part1 > ${TMPBASE}/ltp-aiodio.part1
 
-${LTPROOT}/pan/pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltpaiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
+${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart1 -n ltp-aiodiopart1 -l ltpaiodio1.logfile -o ltpaiodio1.outfile -p -f ${TMPBASE}/ltp-aiodio.part1 &
 
 wait $!
 sync
@@ -266,7 +266,7 @@ echo ""
 echo "************ Running aiodio_sparse tests " 
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part2 > ${TMPBASE}/ltp-aiodio.part2
 
-${LTPROOT}/pan/pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltpaiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
+${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart2 -n ltp-aiodiopart2 -l ltpaiodio2.logfile -o ltpaiodio2.outfile -p -f ${TMPBASE}/ltp-aiodio.part2 &
 
 wait $!
 sync
@@ -278,7 +278,7 @@ if [ "$runExtendedStress" -eq 1 ];then
 echo "************ Running fsx-linux tests "
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part3 > ${TMPBASE}/ltp-aiodio.part3
 
-${LTPROOT}/pan/pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltpaiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
+${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart3 -n ltp-aiodiopart3 -l ltpaiodio3.logfile -o ltpaiodio3.outfile -p -f ${TMPBASE}/ltp-aiodio.part3 &
 
 
 
@@ -296,7 +296,7 @@ dd if=$file1 of=/test/aiodio/file5      
  
 echo "************ Running dio_sparse & miscellaneous tests "
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/ltp-aiodio.part4 > ${TMPBASE}/ltp-aiodio.part4
-${LTPROOT}/pan/pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltpaiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
+${LTPROOT}/pan/ltp-pan -e -S -a ltpaiodiopart4 -n ltp-aiodiopart4 -l ltpaiodio4.logfile -o ltpaiodio4.outfile -p -f ${TMPBASE}/ltp-aiodio.part4 &
 
 wait $!
 sync
Index: ltp-full-20090430/testscripts/ltp-scsi_debug.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/ltp-scsi_debug.sh
+++ ltp-full-20090430/testscripts/ltp-scsi_debug.sh
@@ -206,7 +206,7 @@ echo "----- Running tests ----- " 
 echo "The test may take about 2 hours to finish..."
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/scsi_debug.part1 > ${TMPBASE}/scsi_debug
  
-${LTPROOT}/pan/pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/fs-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug 
+${LTPROOT}/pan/ltp-pan -e -S -a scsi_debug -n scsi_debug -l ${TMPBASE}/fs-scsi_debug.log -o ${TMPBASE}/fs-scsi_debug.out -f ${TMPBASE}/scsi_debug 
 
 wait $!
 
Index: ltp-full-20090430/testscripts/ltpfslvm.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/ltpfslvm.sh
+++ ltp-full-20090430/testscripts/ltpfslvm.sh
@@ -158,7 +158,7 @@ mount -v /dev/ram                       
 echo "************ Running tests " 
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/lvm.part1 > ${TMPBASE}/lvm.part1
 
-${LTPROOT}/pan/pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
+${LTPROOT}/pan/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
 
 wait $!
 
@@ -190,7 +190,7 @@ mount -v -t jfs    /dev/hdc1           /
 echo "************ Running EXT3 & JFS tests...  " 
 ${LTPROOT}/tools/rand_lines -g ${LTPROOT}/runtest/lvm.part2 > ${TMPBASE}/lvm.part2
 
-${LTPROOT}/pan/pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
+${LTPROOT}/pan/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
 
 wait $!
 
Index: ltp-full-20090430/testscripts/ltpfsnolvm.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/ltpfsnolvm.sh
+++ ltp-full-20090430/testscripts/ltpfsnolvm.sh
@@ -118,7 +118,7 @@ mount -v /dev/ram                       
 echo "************ Running tests " 
 ${LTPROOT}/../tools/rand_lines -g ${LTPROOT}/../runtest/lvm.part1 > ${TMPBASE}/lvm.part1
 
-${LTPROOT}/../pan/pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
+${LTPROOT}/../pan/ltp-pan -e -S -a lvmpart1 -n lvmpart1 -l lvmlogfile -f ${TMPBASE}/lvm.part1 &
 
 wait $!
 
@@ -140,7 +140,7 @@ mount -v -t jfs    /dev/$part1         /
 echo "************ Running EXT3 & JFS tests...  " 
 ${LTPROOT}/../tools/rand_lines -g ${LTPROOT}/../runtest/lvm.part2 > ${TMPBASE}/lvm.part2
 
-${LTPROOT}/../pan/pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
+${LTPROOT}/../pan/ltp-pan -e -S -a lvmpart2 -n lvmpart2 -l lvmlogfile -f ${TMPBASE}/lvm.part2 &
 
 wait $!
 
Index: ltp-full-20090430/testscripts/ltpstress.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/ltpstress.sh
+++ ltp-full-20090430/testscripts/ltpstress.sh
@@ -275,9 +275,9 @@ output1=${TMPBASE}/ltpstress.$$.output1
 output2=${TMPBASE}/ltpstress.$$.output2
 output3=${TMPBASE}/ltpstress.$$.output3
 
-${LTPROOT}/pan/pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l $logfile -f ${TMP}/stress.part1 -o $output1 & 
-${LTPROOT}/pan/pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l $logfile -f ${TMP}/stress.part2 -o $output2 &
-${LTPROOT}/pan/pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l $logfile -f ${TMP}/stress.part3 -o $output3 &
+${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l $logfile -f ${TMP}/stress.part1 -o $output1 & 
+${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l $logfile -f ${TMP}/stress.part2 -o $output2 &
+${LTPROOT}/pan/ltp-pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l $logfile -f ${TMP}/stress.part3 -o $output3 &
 
 echo "Running LTP Stress for $hours hour(s) using $(($memsize/1024)) Mb"
 echo ""
@@ -286,7 +286,7 @@ echo "        $output1"
 echo "        $output2"
 echo "        $output3"
 
-# Sleep a little longer than duration to let pan "try" to gracefully end itself.
+# Sleep a little longer than duration to let ltp-pan "try" to gracefully end itself.
 sleep $(($duration + 10))  
 
 if [ $Sar -eq 1 ]; then
@@ -295,7 +295,7 @@ fi
 if [ $Top -eq 1 ]; then
   kill $SCREEN_PID >/dev/null 2>&1
 fi
-killall -9 pan >/dev/null 2>&1
+killall -9 ltp-pan >/dev/null 2>&1
 killall -9 genload >/dev/null 2>&1
 if [ $NO_NETWORK -eq 0 ];then
   killall -9 netpipe.sh >/dev/null 2>&1
Index: ltp-full-20090430/testscripts/networkstress.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/networkstress.sh
+++ ltp-full-20090430/testscripts/networkstress.sh
@@ -124,15 +124,15 @@ if [ ${VERBOSE} = "yes" ]; then
 	cat $TMPDIR/network_stress.tests
 	${LTPROOT}/ver_linux
 	echo ""
-	echo ${LTPROOT}/pan/pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
+	echo ${LTPROOT}/pan/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
 fi
 
-${LTPROOT}/pan/pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
+${LTPROOT}/pan/ltp-pan -e -l /tmp/netstress.log -S -a netstress -n netstress -f ${TMPDIR}/network_stress.tests
 
 if [ $? -eq "0" ]; then
-  echo pan reported PASS
+  echo ltp-pan reported PASS
 else
-  echo pan reported FAIL
+  echo ltp-pan reported FAIL
 fi
 
 rm -rf ${TMPDIR}
Index: ltp-full-20090430/testscripts/networktests.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/networktests.sh
+++ ltp-full-20090430/testscripts/networktests.sh
@@ -119,15 +119,15 @@ if [ ${VERBOSE} = "yes" ]; then
     cat $CMDFILE
     ${LTPROOT}/ver_linux
     echo ""
-    echo ${LTPROOT}/pan/pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+    echo ${LTPROOT}/pan/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
 fi
 
-${LTPROOT}/pan/pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+${LTPROOT}/pan/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
 
 if [ $? -eq "0" ]; then
-  echo pan reported PASS
+  echo ltp-pan reported PASS
 else
-  echo pan reported FAIL
+  echo ltp-pan reported FAIL
 fi
 
 rm -rf ${TMPDIR}
Index: ltp-full-20090430/testscripts/runEALtests.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/runEALtests.sh
+++ ltp-full-20090430/testscripts/runEALtests.sh
@@ -207,12 +207,12 @@ fi
 # display versions of installed software
 ${LTPROOT}/../ver_linux
 
-${LTPROOT}/../pan/pan $quiet_mode -e -S $instances $duration -a $$ -n $$ $pretty_prt -f ${TMP}/alltests $logfile 
+${LTPROOT}/../pan/ltp-pan $quiet_mode -e -S $instances $duration -a $$ -n $$ $pretty_prt -f ${TMP}/alltests $logfile 
 
 if [ $? -eq 0 ]; then
-  echo pan reported PASS
+  echo ltp-pan reported PASS
 else
-  echo pan reported FAIL
+  echo ltp-pan reported FAIL
 fi
 
 if [ $GenLoad -eq 1 ]
Index: ltp-full-20090430/testscripts/runpan.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/runpan.sh
+++ ltp-full-20090430/testscripts/runpan.sh
@@ -14,10 +14,10 @@ cd /tmp/runpan-$$
 
 export PATH="${PATH}:${LTPROOT}/doio:${LTPROOT}/testcases/bin"
  
-${LTPROOT}/pan/pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
+${LTPROOT}/pan/ltp-pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
 
 if [ $? -eq "0" ]; then
-  echo pan reported PASS
+  echo ltp-pan reported PASS
 else
-  echo pan reported FAIL
+  echo ltp-pan reported FAIL
 fi
Index: ltp-full-20090430/testscripts/test_containers.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/test_containers.sh
+++ ltp-full-20090430/testscripts/test_containers.sh
@@ -41,7 +41,7 @@ fi
 # Check the role and mode testsuite is being executed under.
 echo "Running the containers testsuite..."
 
-$LTPROOT/pan/pan -S -a $LTPROOT/results/containers -n ltp-containers -l $LTPROOT/results/containers.logfile -o $LTPROOT/results/containers.outfile -p -f $LTPROOT/runtest/containers
+$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/containers -n ltp-containers -l $LTPROOT/results/containers.logfile -o $LTPROOT/results/containers.outfile -p -f $LTPROOT/runtest/containers
 
 echo "Done."
 exit 0
Index: ltp-full-20090430/testscripts/test_filecaps.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/test_filecaps.sh
+++ ltp-full-20090430/testscripts/test_filecaps.sh
@@ -41,7 +41,7 @@ fi
 # Check the role and mode testsuite is being executed under.
 echo "Running the file capabilities testsuite..."
 
-$LTPROOT/pan/pan -S -a $LTPROOT/results/filecaps -n ltp-filecaps -l $LTPROOT/results/filecaps.logfile -o $LTPROOT/results/filecaps.outfile -p -f $LTPROOT/runtest/filecaps
+$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/filecaps -n ltp-filecaps -l $LTPROOT/results/filecaps.logfile -o $LTPROOT/results/filecaps.outfile -p -f $LTPROOT/runtest/filecaps
 
 echo "Done."
 exit 0
Index: ltp-full-20090430/testscripts/test_selinux.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/test_selinux.sh
+++ ltp-full-20090430/testscripts/test_selinux.sh
@@ -120,7 +120,7 @@ export SELINUXTMPDIR=/tmp/selinux
 SAVEBINTYPE=`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' | awk -F: '{ print $3 }'`
 /usr/bin/chcon -t test_file_t $LTPROOT/testcases/bin
 
-$LTPROOT/pan/pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $LTPROOT/runtest/selinux  
+$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $LTPROOT/runtest/selinux  
 
 # cleanup before exiting    
 
Index: ltp-full-20090430/testscripts/tpm_tools.sh
===================================================================
--- ltp-full-20090430.orig/testscripts/tpm_tools.sh
+++ ltp-full-20090430/testscripts/tpm_tools.sh
@@ -167,7 +167,7 @@ export P11_USER_PWD="P11 USER PWD"
 export NEW_P11_USER_PWD="NEW P11 USER PWD"
 
 echo "Running the tpm-tools testsuite..."
-$LTPROOT/pan/pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-tools -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.outfile -p -f $LTPROOT/runtest/tpm_tools
+$LTPROOT/pan/ltp-pan -d 5 -S -a $LTPROOT/results/tpm_tools -n ltp-tpm-tools -l $LTPROOT/results/tpm_tools.logfile -o $LTPROOT/results/tpm_tools.outfile -p -f $LTPROOT/runtest/tpm_tools
 
 echo "Done."
 exit 0

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--bp/iNruPH9dso1Pn--

