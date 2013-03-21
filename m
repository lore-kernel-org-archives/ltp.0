Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UIh6c-0003UB-Qp
	for ltp-list@lists.sourceforge.net; Thu, 21 Mar 2013 15:08:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UIh6b-0006N4-1X
	for ltp-list@lists.sourceforge.net; Thu, 21 Mar 2013 15:08:38 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2LF8VEv013935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Mar 2013 11:08:31 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Mar 2013 16:08:26 +0100
Message-Id: <e1988db86146bef7ddd363142fbe3174ccecadfd.1363878323.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] pan: fix potential overrun in tag_report
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

  char *cuts_info[5];
  ...
  while (tok_num < 5 &&
      (cuts_info[++tok_num] = strtok(NULL, "\t ")) != NULL) ;

While above can run for tok_num == 4, in which case:
  cuts_info[++tok_num] becomes cuts_info[5]
and that is outside of cuts_info array.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 pan/tag_report.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pan/tag_report.c b/pan/tag_report.c
index 473bed1..61caabd 100644
--- a/pan/tag_report.c
+++ b/pan/tag_report.c
@@ -425,7 +425,7 @@ SYM tags;
 int cuts_testcase(tag, keys)
 SYM tag, keys;
 {
-	char *cuts_info[5];
+	char *cuts_info[6];
 	char key[KEYSIZE];
 	char *oldresult, *newresult, *worst_case();
 	int tok_num = 0;
-- 
1.7.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
