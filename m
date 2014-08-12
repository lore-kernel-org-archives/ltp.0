Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XHAjx-0000WC-15
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 11:59:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHAjw-00026U-0H
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 11:59:44 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s7CBxaqE001977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Aug 2014 11:59:38 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s7CBxag6012276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Aug 2014 11:59:36 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s7CBxZdI027161
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Aug 2014 11:59:35 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 12 Aug 2014 15:59:30 +0400
Message-Id: <1407844770-15011-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140812112652.GA1656@rei.suse.cz>
References: <20140812112652.GA1656@rei.suse.cz>
Subject: [LTP] [PATCH] rt_sigaction.h: define HAVE_SA_RESTORER for most
	platforms
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
Cc: vasily.isaenko@oracle.com

On some platforms LTP fails to compile, because (struct sigaction)
doesn't have .sa_restorer member. For example - ia64.

To overcome such failures we employ HAVE_SA_RESTORER define.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Verified on SPARC, x86_64, i386.


 include/lapi/rt_sigaction.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 9ea5e0f..46f6a50 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -40,6 +40,11 @@ struct kernel_sigaction {
 	sigset_t sa_mask;
 };
 
+/* This macro marks if (struct sigaction) has .sa_restorer member */
+#if !defined(__ia64__) && !defined(__alpha__) && !defined(__hppa__)
+# define HAVE_SA_RESTORER
+#endif
+
 #ifdef __x86_64__
 
 /*
@@ -59,7 +64,6 @@ struct kernel_sigaction {
  * (struct sigaction).sa_restorer for this architecture.
  */
 #undef SA_RESTORER
-#define HAVE_SA_RESTORER
 #define SA_RESTORER     0x04000000
 
 void (*restore_rt)(void);
@@ -203,7 +207,9 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 			memcpy(&oact->sa_mask, &koact.sa_mask,
 				sizeof(sigset_t));
 			oact->sa_flags = koact.sa_flags;
+#ifdef HAVE_SA_RESTORER
 			oact->sa_restorer = koact.sa_restorer;
+#endif
 		}
 	}
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
