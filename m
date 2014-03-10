Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1WMqcx-0004ma-VU
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 03:11:44 +0000
Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WMqcx-0004bH-9Y
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 03:11:43 +0000
Received: by mail-pb0-f43.google.com with SMTP id um1so6624306pbc.16
	for <ltp-list@lists.sourceforge.net>;
	Sun, 09 Mar 2014 20:11:37 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 10 Mar 2014 11:11:30 +0800
Message-Id: <1394421090-2780-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCHv2] containers/netns: Add missed definition for
	check_netns_enabled.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

CLONE_NEWNET and CLONE_NEWNS are defined in bit/sched.h, and need __USE_GNU
defined first. Do the same as par_chld_ipv6.c and two_children_ns.c did, just
define _GNU_SOURCE directly.

Also remove duplicate CLONE_NEWNET definition cause we won't run netns test if
CLONE_NEWNET and CLONE_NEWNS are not defined.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/libclone/libclone.h         | 4 ----
 testcases/kernel/containers/netns/check_netns_enabled.c | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index 9380cec..50e00f7 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -73,10 +73,6 @@
 #define CLONE_NEWPID            0x20000000
 #endif
 
-#ifndef CLONE_NEWNET
-#define CLONE_NEWNET		0x40000000
-#endif
-
 extern int create_net_namespace(char *, char *);
 
 /*
diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c b/testcases/kernel/containers/netns/check_netns_enabled.c
index ab8ee2f..9c1d84a 100644
--- a/testcases/kernel/containers/netns/check_netns_enabled.c
+++ b/testcases/kernel/containers/netns/check_netns_enabled.c
@@ -19,6 +19,9 @@
 * assume they are not enabled.  Kernels after that, check for -EINVAL
 * when trying to use CLONE_NEWNET and CLONE_NEWNS.
 ***************************************************************************/
+
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <sched.h>
 #include "config.h"
-- 
1.8.1.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
