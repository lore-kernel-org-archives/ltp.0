Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QvUkW-0001uR-I9
	for ltp-list@lists.sourceforge.net; Mon, 22 Aug 2011 13:41:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QvUkS-0006uD-En
	for ltp-list@lists.sourceforge.net; Mon, 22 Aug 2011 13:41:08 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7MDewbi012322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Aug 2011 09:40:58 -0400
Message-ID: <4E525C68.4040903@redhat.com>
Date: Mon, 22 Aug 2011 15:40:56 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050402060103000400030302"
Subject: [LTP] [PATCH] memcg_test_2.c: clear all fields of sigaction
	structure
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
Cc: jburke@redhat.com

This is a multi-part message in MIME format.
--------------050402060103000400030302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This test didn't set all fields of sigaction structure before
using it, which caused some of them to be left in random state.
Namely sa_flags could end up with SA_RESTORER, which after
receiving signal would call invalid pointer in sa_restorer.

Something, we apparently hit here:
Bug 731954 - segfault on s390x when setting memory.limit_in_bytes
https://bugzilla.redhat.com/show_bug.cgi?id=731954

Fix this by zero-ing whole structure before usage.
Clearing just sa_flags should be enough, but let's match the style
of other test in this group: memcg_test_4.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../controllers/memcg/regression/memcg_test_2.c    |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)



--------------050402060103000400030302
Content-Type: text/x-patch;
	name="0001-memcg_test_2.c-clear-all-fields-of-sigaction-structu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-memcg_test_2.c-clear-all-fields-of-sigaction-structu.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_2.c b/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
index e147e27..1643408 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_2.c
@@ -41,7 +41,7 @@ int main(void)
 {
 	struct sigaction sigusr_action;
 
-	sigemptyset(&sigusr_action.sa_mask);
+	memset(&sigusr_action, 0, sizeof(sigusr_action));
 	sigusr_action.sa_handler = &sigusr_handler;
 	sigaction(SIGUSR1, &sigusr_action, NULL);
 
@@ -49,4 +49,4 @@ int main(void)
 		sleep(1);
 
 	return 0;
-}
\ No newline at end of file
+}


--------------050402060103000400030302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------050402060103000400030302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050402060103000400030302--

