Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7EVq-0000g1-PT
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:09:42 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7EVo-0002J2-E4
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:09:42 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SKxh3W024860
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 16:59:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3SL9YR1153992
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 17:09:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3SL9YKA031111
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 17:09:34 -0400
Date: Wed, 28 Apr 2010 16:09:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100428210936.GA20642@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100428210906.GA20572@us.ibm.com>
Subject: [LTP] [PATCH 2/4] pidns30: strip leading / from name passed to
	mq_open
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 testcases/kernel/containers/pidns/pidns30.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index ea8c54c..5975b53 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -59,7 +59,7 @@
 char *TCID = "pidns30";
 int TST_TOTAL = 1;
 
-char *mqname = "/mq1";
+char *mqname = "mq1";
 int result = TFAIL;
 
 int errno;
-- 
1.7.0


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
