Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yxu@suse.de>) id 1P2l4n-0002GU-TC
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:27:33 +0000
Message-ID: <4CA9D1B2.7070107@suse.de>
Date: Mon, 04 Oct 2010 15:08:02 +0200
From: Yi Xu <yxu@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020604070800000800070404"
Subject: [LTP] patch to define PTRACE_KILL and PTRACE_CONT
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
To: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--------------020604070800000800070404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

this patch solves compiling error that appears with certain GCC version.

Regards,
Yi
-- 
Yi Xu                           yxu@suse.de

SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nuernberg)

--------------020604070800000800070404
Content-Type: text/x-patch;
 name="define_PTRACE_PARAM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="define_PTRACE_PARAM.patch"

--- testcases/kernel/syscalls/ptrace/ptrace.h.orig	2010-09-13 15:46:24.145591000 +0200
+++ testcases/kernel/syscalls/ptrace/ptrace.h	2010-09-13 16:18:40.732974000 +0200
@@ -4,6 +4,15 @@
 
 #ifndef __LTP_PTRACE_H__
 #define __LTP_PTRACE_H__
+#endif
+
+#ifndef __PTRACE_KILL__
+#define __PTRACE_KILL__
+#endif
+
+#ifndef __PTRACE_CONT__
+#define __PTRACE_CONT__
+#endif
 
 #ifdef HAVE_SYS_PTRACE_H
 # include <sys/ptrace.h>
@@ -30,4 +39,3 @@ typedef struct pt_regs ptrace_regs;
 typedef struct user_regs_struct ptrace_regs;
 #endif
 
-#endif

--------------020604070800000800070404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
--------------020604070800000800070404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020604070800000800070404--

