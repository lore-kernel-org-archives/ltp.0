Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MMR2l-0007p2-EY
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 18:29:59 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMILB-0002Am-4k
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 09:12:28 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6298iuJ001326
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 05:08:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6295Z0u214958
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 05:05:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n62938U4031361
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 05:03:08 -0400
Date: Thu, 2 Jul 2009 02:05:32 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090702090532.GF19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090702084828.GC19135@count0.beaverton.ibm.com>
Subject: [LTP] [PATCH 4/4] netns: Change interpretters from sh to bash
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

As best I can tell these tests do not use true sh syntax -- they use bash
syntax. Rather than bother hunting down all the bash-isms just convert
them to use bash as their interpretter.

Also found with my fedora 10 KVM image.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>
Cc: Sudhir Kumar <skumar@linux.vnet.ibm.com>
Cc: Veerendra C <vechandr@in.ibm.com>
Cc: Munipradeep <mbeeraka@in.ibm.com>
Cc: ltp@list.sourceforge.net
---
 testcases/kernel/containers/netns/ch_ftp.sh          |    2 +-
 testcases/kernel/containers/netns/child.sh           |    2 +-
 testcases/kernel/containers/netns/child_1.sh         |    2 +-
 testcases/kernel/containers/netns/child_2.sh         |    2 +-
 testcases/kernel/containers/netns/child_propagate.sh |    2 +-
 testcases/kernel/containers/netns/childipv6.sh       |    2 +-
 testcases/kernel/containers/netns/childns.sh         |    2 +-
 testcases/kernel/containers/netns/delchild.sh        |    2 +-
 testcases/kernel/containers/netns/initialize.sh      |    2 +-
 testcases/kernel/containers/netns/par_ftp.sh         |    2 +-
 testcases/kernel/containers/netns/parent.sh          |    2 +-
 testcases/kernel/containers/netns/parent_1.sh        |    2 +-
 testcases/kernel/containers/netns/parent_2.sh        |    2 +-
 testcases/kernel/containers/netns/parent_share.sh    |    2 +-
 testcases/kernel/containers/netns/parent_view.sh     |    2 +-
 testcases/kernel/containers/netns/parentns.sh        |    2 +-
 testcases/kernel/containers/netns/paripv6.sh         |    2 +-
 testcases/kernel/containers/netns/rename_net.sh      |    8 ++++----
 testcases/kernel/containers/netns/runnetnstest.sh    |    2 +-
 19 files changed, 22 insertions(+), 22 deletions(-)

Index: ltp/testcases/kernel/containers/netns/rename_net.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/rename_net.sh
+++ ltp/testcases/kernel/containers/netns/rename_net.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
@@ -46,9 +46,9 @@ export TST_TOTAL
     ip link set $vnet1 name $newdev
     ifconfig $newdev $IP2/24 up > /dev/null 2>&1
 
-    if [ $? == 0 ] ; then
+    if [ $? -eq 0 ] ; then
         tst_resm TINFO "Successfully Renamed device to $newdev"
-        if [ DEBUG == 1 ]; then
+        if [ DEBUG -eq 1 ]; then
                 ifconfig
         fi
     else
@@ -56,7 +56,7 @@ export TST_TOTAL
         status=-1
     fi
 
-    if [ $status == 0 ] ; then
+    if [ $status -eq 0 ] ; then
         echo $sshpid > /tmp/FIFO3
         echo $newdev > /tmp/FIFO4
     else
Index: ltp/testcases/kernel/containers/netns/runnetnstest.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/runnetnstest.sh
+++ ltp/testcases/kernel/containers/netns/runnetnstest.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/ch_ftp.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/ch_ftp.sh
+++ ltp/testcases/kernel/containers/netns/ch_ftp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
Index: ltp/testcases/kernel/containers/netns/child.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/child.sh
+++ ltp/testcases/kernel/containers/netns/child.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/child_1.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/child_1.sh
+++ ltp/testcases/kernel/containers/netns/child_1.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 ################################################################################ 
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
Index: ltp/testcases/kernel/containers/netns/child_2.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/child_2.sh
+++ ltp/testcases/kernel/containers/netns/child_2.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/child_propagate.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/child_propagate.sh
+++ ltp/testcases/kernel/containers/netns/child_propagate.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/childipv6.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/childipv6.sh
+++ ltp/testcases/kernel/containers/netns/childipv6.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/childns.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/childns.sh
+++ ltp/testcases/kernel/containers/netns/childns.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/delchild.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/delchild.sh
+++ ltp/testcases/kernel/containers/netns/delchild.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/initialize.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/initialize.sh
+++ ltp/testcases/kernel/containers/netns/initialize.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/par_ftp.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/par_ftp.sh
+++ ltp/testcases/kernel/containers/netns/par_ftp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/parent.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parent.sh
+++ ltp/testcases/kernel/containers/netns/parent.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/parent_1.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parent_1.sh
+++ ltp/testcases/kernel/containers/netns/parent_1.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/parent_2.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parent_2.sh
+++ ltp/testcases/kernel/containers/netns/parent_2.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/parent_share.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parent_share.sh
+++ ltp/testcases/kernel/containers/netns/parent_share.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/parent_view.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parent_view.sh
+++ ltp/testcases/kernel/containers/netns/parent_view.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/parentns.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parentns.sh
+++ ltp/testcases/kernel/containers/netns/parentns.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##
Index: ltp/testcases/kernel/containers/netns/paripv6.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/paripv6.sh
+++ ltp/testcases/kernel/containers/netns/paripv6.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################ 
 ##                                                                            ##

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
