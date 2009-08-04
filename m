Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mohan@in.ibm.com>) id 1MYJ59-00082N-MI
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:25:31 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYJ52-0003Vh-Ky
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:25:31 +0000
Date: Tue, 4 Aug 2009 17:53:56 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Message-ID: <20090804122356.GC19594@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] Remove pidns14 test case reference
Reply-To: mohan@in.ibm.com
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, sukadev@linux.vnet.ibm.com, sachinp@in.ibm.com

[PATCH] Remove pidns14 test case reference

pidns14 test case is removed in the July 2009 LTP release. So remove the
reference to pidns14 test case in the runpidnstest.sh script.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 testcases/kernel/containers/pidns/runpidnstest.sh |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/containers/pidns/runpidnstest.sh b/testcases/kernel/containers/pidns/runpidnstest.sh
index 12d3b34..03fed38 100644
--- a/testcases/kernel/containers/pidns/runpidnstest.sh
+++ b/testcases/kernel/containers/pidns/runpidnstest.sh
@@ -85,12 +85,6 @@ if [ $rc -ne 0 ] && [ -z $err_code ]; then
 	err_code=$rc
 fi
 
-pidns14
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
 pidns16
 rc=$?
 if [ $rc -ne 0 ] && [ -z $err_code ]; then
-- 
1.6.2.5


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
