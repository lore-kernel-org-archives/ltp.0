Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@linux.vnet.ibm.com>) id 1MROhE-0006zJ-Va
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 11:00:16 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MROh6-00085p-DS
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 11:00:11 +0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 16 Jul 2009 06:59:56 -0400
Message-Id: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
Mime-Version: 1.0
Subject: [LTP] ltp: IMA cross platform fixes
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
To: ltp-list <ltp-list@lists.sf.net>
Cc: waqar afridi <afridi.waqar@gmail.com>, Shaz <shazalive@gmail.com>

- Instead of using the default platform shell, explicitly use bash.
- To create a file using 'sudo -u', some platforms require 'user' to exist.
- Document verifying PCR-10 fails on Ubuntu on reboot due to kexec.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>

Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################
 ##                                                                            ##
@@ -137,12 +137,13 @@ test03()
 
 	# create file user-test.txt
 	mkdir -m 0700 $LTPIMA/user
-	chown 99.99 $LTPIMA/user
+	chown nobody.nobody $LTPIMA/user
 	cd $LTPIMA/user
 	hash=0
 
-	# As user 99, create and cat the new file
-	sudo -u \#99 sh -c "echo `date` - create test.txt > ./test.txt;
+	# As user nobody, create and cat the new file
+	# (The LTP tests assumes existence of 'nobody'.)
+	sudo -u nobody sh -c "echo `date` - create test.txt > ./test.txt;
 				cat ./test.txt > /dev/null"
 
 	# Calculating the hash will add the measurement to the measurement
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ################################################################################
 ##                                                                            ##
 ## Copyright (C) 2009 IBM Corporation                                         ##
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ################################################################################
 ##                                                                            ##
 ## Copyright (C) 2009 IBM Corporation                                         ##
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################
 ##                                                                            ##
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ################################################################################
 ##                                                                            ##
 ## Copyright (C) 2009 IBM Corporation                                         ##
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/README
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/README
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/README
@@ -52,6 +52,10 @@ open for read by root. If the default po
 another measurement policy will fail, as the policy may only be replaced
 once per boot. Some of the policy dependency tests might also fail as well.
 
+ima_tpm.sh: test02, verifying the PCR-10 value, requires a hard reboot.
+[On Ubuntu, before running the ltp tests, disable /etc/init.d/kexec-load
+and reboot.]
+
 Run tests
 ---------
 After doing 'make' and 'make install' from the top-level,



------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
