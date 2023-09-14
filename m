Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3D4EEAA45
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 14:33:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D5623CE753
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 16:33:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9D043CA0F0
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 16:33:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFE2E14044C6
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 16:33:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C370221850;
 Thu, 14 Sep 2023 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694702006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qtv50XYpbjgjGoUySqDD4l5s6DKKMjhC6MRD0rc3ruk=;
 b=hENvpGIgMLDeimCXtz+kNIZoAMhU4MqcVyxvHbhR4eIZxloNarF5SCMinOkPupQ0j7QuoX
 OqRy7oU0XmRL4yMhZyzCIMzeZQgPe4ARAdxNI+GmC3c5bvpffngG4vBWdbk1zr/cT/2ty+
 TIgFcvF1xEJ7vU8E4tOObGvLSLWFzqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694702006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qtv50XYpbjgjGoUySqDD4l5s6DKKMjhC6MRD0rc3ruk=;
 b=uWH4Oy/euqZYKzDkwbBc7iiEYEtlYuV4aBW/lyqy0Yx7vmtx1ozJ7OjpQz3KNM5T3Ivj0Q
 yV71AV6a9CZsSABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5F9C139DB;
 Thu, 14 Sep 2023 14:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zhwJJ7YZA2V+dgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 14 Sep 2023 14:33:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Sep 2023 16:33:25 +0200
Message-Id: <20230914143325.3902-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Clean kernel/containers folder
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Cleaned up the containers Makefile from unused dependences, removed
legacy files and splitted .gitignore into subfolders.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/.gitignore        | 14 ------
 testcases/kernel/containers/README            | 48 -------------------
 testcases/kernel/containers/TEST_PLAN.txt     | 27 -----------
 .../kernel/containers/mountns/.gitignore      |  4 ++
 testcases/kernel/containers/mqns/Makefile     |  2 +-
 testcases/kernel/containers/pidns/Makefile    |  2 +-
 testcases/kernel/containers/userns/.gitignore |  9 ++++
 testcases/kernel/containers/userns/Makefile   | 20 ++------
 testcases/kernel/containers/utsname/Makefile  |  3 --
 9 files changed, 18 insertions(+), 111 deletions(-)
 delete mode 100644 testcases/kernel/containers/.gitignore
 delete mode 100644 testcases/kernel/containers/README
 delete mode 100644 testcases/kernel/containers/TEST_PLAN.txt
 create mode 100644 testcases/kernel/containers/mountns/.gitignore
 create mode 100644 testcases/kernel/containers/userns/.gitignore

diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
deleted file mode 100644
index 5c2b90312..000000000
--- a/testcases/kernel/containers/.gitignore
+++ /dev/null
@@ -1,14 +0,0 @@
-/check_for_unshare
-mountns/mountns01
-mountns/mountns02
-mountns/mountns03
-mountns/mountns04
-userns/userns01
-userns/userns02
-userns/userns03
-userns/userns04
-userns/userns05
-userns/userns06_capcheck
-userns/userns06
-userns/userns07
-userns/userns08
diff --git a/testcases/kernel/containers/README b/testcases/kernel/containers/README
deleted file mode 100644
index df909e526..000000000
--- a/testcases/kernel/containers/README
+++ /dev/null
@@ -1,48 +0,0 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-
-CONTAINER TESTS AUTOMATION SUITE
-----------------------------
-The tests requires the Kernel to be compiled with the following configs
-
-CONFIG_DUMMY=y(or =m)
-CONFIG_NAMESPACES=y
-CONFIG_UTS_NS=y
-CONFIG_IPC_NS=y
-CONFIG_USER_NS=y
-CONFIG_PID_NS=y
-CONFIG_NET_NS=y
-CONFIG_VETH=y(or =m)
-CONFIG_MACVLAN=y(optional)
-
-The container test automation suite helps run the container functionality
-(e.g: utsname etc..) tests and report results. Please refer the following
-each functionality README file for detail:
-
-sysvipc/*
-	Contains all the testcases related to IPC NS tests.
-posixmq/*
-	Contains all the testcases related to POSIX MQ NS tests.  These
-	are strictly speaking a part of the ipc namespaces, but can be
-	enabled in the kernel without SYSV IPC support.
-utsname/*
-	Contains all the testcases related to utsname tests.
-netns/*
-        Contains the testcases related to the network NS tests.
diff --git a/testcases/kernel/containers/TEST_PLAN.txt b/testcases/kernel/containers/TEST_PLAN.txt
deleted file mode 100644
index 809abaecb..000000000
--- a/testcases/kernel/containers/TEST_PLAN.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-################################################################################
-## Copyright (c) International Business Machines  Corp., 2007
-##
-## This program is free software;  you can redistribute it and#or modify
-## it under the terms of the GNU General Public License as published by
-## the Free Software Foundation; either version 2 of the License, or
-## (at your option) any later version.
-## This program is distributed in the hope that it will be useful, but
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-## for more details.
-## You should have received a copy of the GNU General Public License
-## along with this program;  if not, write to the Free Software
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-################################################################################
-
-Following are tentative Testcases to be included into LTP-Containers in future:
-
-NAME						TENTATIVE-TIME
-=================================================================================
-PID NAMESPACES					(NEAR FUTURE)
-NETWORK NAMESPACES				(NEAR FUTURE)
-POSIX IPC NAMESPACES				(NEAR FUTURE)
-TTY+CONSOLE+DEVPTS NAMESPACES			(NEAR FUTURE)
-PROC+SYSFS ISOLATION				(NEAR FUTURE)
-PER-CONTAINER CAPABILITY/SECURITY TESTS		(NEAR FUTURE)
-=================================================================================
diff --git a/testcases/kernel/containers/mountns/.gitignore b/testcases/kernel/containers/mountns/.gitignore
new file mode 100644
index 000000000..0555e9b3b
--- /dev/null
+++ b/testcases/kernel/containers/mountns/.gitignore
@@ -0,0 +1,4 @@
+mountns01
+mountns02
+mountns03
+mountns04
diff --git a/testcases/kernel/containers/mqns/Makefile b/testcases/kernel/containers/mqns/Makefile
index f66aa0ffb..01e90ec33 100644
--- a/testcases/kernel/containers/mqns/Makefile
+++ b/testcases/kernel/containers/mqns/Makefile
@@ -7,6 +7,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			:= -lpthread -lrt $(LDLIBS)
+LDLIBS			:= -lrt $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/pidns/Makefile b/testcases/kernel/containers/pidns/Makefile
index b99df9f74..180bc7c90 100644
--- a/testcases/kernel/containers/pidns/Makefile
+++ b/testcases/kernel/containers/pidns/Makefile
@@ -5,6 +5,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			:= -lpthread -lrt $(LDLIBS)
+LDLIBS			:= -lrt $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/userns/.gitignore b/testcases/kernel/containers/userns/.gitignore
new file mode 100644
index 000000000..dbd4aee27
--- /dev/null
+++ b/testcases/kernel/containers/userns/.gitignore
@@ -0,0 +1,9 @@
+userns01
+userns02
+userns03
+userns04
+userns05
+userns06_capcheck
+userns06
+userns07
+userns08
diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
index cc1d14604..1531d1de6 100644
--- a/testcases/kernel/containers/userns/Makefile
+++ b/testcases/kernel/containers/userns/Makefile
@@ -1,20 +1,6 @@
-###############################################################################
-#                                                                            ##
-# Copyright (c) Huawei Technologies Co., Ltd., 2015                          ##
-#                                                                            ##
-# This program is free software;  you can redistribute it and#or modify      ##
-# it under the terms of the GNU General Public License as published by       ##
-# the Free Software Foundation; either version 2 of the License, or          ##
-# (at your option) any later version.                                        ##
-#                                                                            ##
-# This program is distributed in the hope that it will be useful, but        ##
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-# for more details.                                                          ##
-#                                                                            ##
-# You should have received a copy of the GNU General Public License          ##
-# along with this program.                                                   ##
-###############################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Huawei Technologies Co., Ltd., 2015
+# Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/containers/utsname/Makefile b/testcases/kernel/containers/utsname/Makefile
index 603a3cd6e..b6beb8b8f 100644
--- a/testcases/kernel/containers/utsname/Makefile
+++ b/testcases/kernel/containers/utsname/Makefile
@@ -4,7 +4,4 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			:= $(LDLIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
