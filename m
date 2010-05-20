Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OFAjx-00084u-D2
	for ltp-list@lists.sourceforge.net; Thu, 20 May 2010 18:45:05 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 27BFF867E2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 May 2010 20:44:57 +0200 (CEST)
Date: Thu, 20 May 2010 20:54:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100520185446.GA15427@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
Subject: [LTP] [PATCH] mq_timedreceive have wrong _XOPEN_SOURCE
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
The mq_timedreceive01.c test defines _XOPEN_SOURCE 500 on the beginning but
this causes missing prototypes for seteuid() and mq_timedreceive() as they need
_XOPEN_SOURCE >= 600. Following patch fixes that.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--TB36FDmn/VVEgNH/
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="fix-mq_timedreceive-XOPEN_SOURCE.patch"

Index: ltp-full-20100430/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
===================================================================
--- ltp-full-20100430.orig/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ ltp-full-20100430/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -45,7 +45,7 @@
 /* History:     Porting from Crackerjack to LTP is done by                    */
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
-#define _XOPEN_SOURCE 500
+#define _XOPEN_SOURCE 600
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/stat.h>

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--TB36FDmn/VVEgNH/--

