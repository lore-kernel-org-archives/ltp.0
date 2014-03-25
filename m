Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1WSRGo-0000ZU-3E
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 13:19:58 +0000
Received: from smtp-out3.electric.net ([72.35.12.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSRGl-00079C-UU
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 13:19:58 +0000
Received: from 1WSRGf-0000mM-UT by out3a.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1WSRGg-0000oP-T4
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 06:19:50 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3a.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1WSRGf-0000mM-UT
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 06:19:49 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Tue, 25 Mar 2014 13:21:43 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C548C89@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Suggested patch for Debian distro testing, part 1 of 2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Greetings!

Let's give this a whirl.  I'm posting from my work account, which (sadly) i=
nterposes Outlook whether I want it or not.
Apologies in advance if a lexical garble happens -- intellectual garbles ar=
e of course my own fault. :-)

This first part contains changes I'm pretty sure are minimal.
Mainly just changing "sh" to "bash" on the shebang line, where my test runs=
 had tripped up.
Two pull the shebang line back to the top after a copyright header submerge=
d it.
And one removes a bash-ism from an m4 file, so `./configure` won't choke ei=
ther.

Thanks!

Joseph
----
Joseph Beckenbach, senior QA engineer : Automation

=3D=3D=3D=3D
diff --git a/ltpmenu b/ltpmenu
index d1d890f..6a2338b 100755
--- a/ltpmenu
+++ b/ltpmenu
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ##########################################################################=
######
 ##                                                                        =
    ##
 ## Copyright (c) International Business Machines  Corp., 2001             =
    ##
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
index ba53bc1..fd3d328 100644
--- a/m4/ltp-kernel_devel.m4
+++ b/m4/ltp-kernel_devel.m4
@@ -54,7 +54,7 @@ if test -f "$LINUX_DIR/Makefile"; then
 ^PATCHLEVEL =3D ,,p' ${LINUX_DIR}/Makefile`
 fi
 =

-if [[ -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_VERSION_PATCH" ]]; then
+if test -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_VERSION_PATCH"; then
 	WITH_MODULES=3D"yes"
 else
 	WITH_MODULES=3D"no"
diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index a17b748..cd015bd 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #*********************************************************************
 #   Copyright (c) International Business Machines  Corp., 2003, 2004
 #
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kern=
el/containers/container_test.sh
index 59077a5..5ad1414 100755
--- a/testcases/kernel/containers/container_test.sh
+++ b/testcases/kernel/containers/container_test.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # This test performs capability tests for file operations.
 #
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b=
/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 782e1d7..30476bd 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/bash
 =

 ##########################################################################=
######
 ##                                                                        =
    ##
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh =
b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
index 95e89de..2b47df1 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/bash
 =

 ##########################################################################=
######
 ##                                                                        =
    ##
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/t=
estcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 9d1a971..fcca228 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/bash
 =

 ##########################################################################=
######
 ##                                                                        =
    ##
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/=
testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 0247353..9b49725 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/bash
 =

 ##########################################################################=
######
 ##                                                                        =
    ##
diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh b=
/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
index edd3f98..319924d 100755
--- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
+++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#!/bin/bash
 =

 ##########################################################################=
######
 ##                                                                        =
    ##
@@ -29,6 +29,8 @@ export TST_COUNT=3D1
 =

 export TESTROOT=3D`pwd`
 export LOGFILE=3D$LTPROOT/output/cgroup_fj_log_`date +%F`.txt
+[ -d `dirname $LOGFILE` ] || mkdir `dirname $LOGFILE` || { \
+	tst_resm TBROK "could not create directory for logfile" ; exit 1 ; }
 export TMPFILE=3D$TESTROOT/tmp_tasks
 export CASENO1=3D0
 export CASENO2=3D0
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01=
.sh
index 19a8f71..c5e9952 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ##########################################################################=
######
 ##                                                                        =
    ##
 ## Copyright (c) International Business Machines  Corp., 2007             =
    ##
diff --git a/testcases/realtime/run.sh b/testcases/realtime/run.sh
index a66e4e5..303b818 100755
--- a/testcases/realtime/run.sh
+++ b/testcases/realtime/run.sh
@@ -1,3 +1,4 @@
+#! /bin/bash
 ##########################################################################=
######
 ##                                                                        =
    ##
 ## Copyright =C2=A9  International Business Machines  Corp., 2007, 2008   =
         ##
@@ -19,7 +20,6 @@
 ##########################################################################=
######
 =

 =

-#! /bin/bash
 #
 # Script to run the tests in rt-test
 #
diff --git a/testscripts/runEALtests.sh b/testscripts/runEALtests.sh
index be41c12..bcd3f29 100755
--- a/testscripts/runEALtests.sh
+++ b/testscripts/runEALtests.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 =

 =

 #
diff --git a/testscripts/test_realtime.sh b/testscripts/test_realtime.sh
index 0d424fc..e741309 100755
--- a/testscripts/test_realtime.sh
+++ b/testscripts/test_realtime.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 ##########################################################################=
######
 ##                                                                        =
    ##
 ## Copyright =C2=A9  International Business Machines  Corp., 2007, 2008   =
         ##
@@ -19,7 +20,6 @@
 ##########################################################################=
######
 =

 =

-#! /bin/bash
 #
 # Script to run the tests in testcases/realtime
 #
diff --git a/utils/benchmark/kernbench-0.42/kernbench b/utils/benchmark/ker=
nbench-0.42/kernbench
index 65e2c63..2d5817b 100644
--- a/utils/benchmark/kernbench-0.42/kernbench
+++ b/utils/benchmark/kernbench-0.42/kernbench
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # kernbench by Con Kolivas <kernbench@kolivas.org>
 # based on a benchmark by Martin J. Bligh
 trap 'echo "ABORTING";exit' 1 2 15


---------------------------------------------------------------------------=
---
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
