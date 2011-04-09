Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q8Omf-0006n4-NQ
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 03:24:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8Omf-0005HE-2l
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 03:24:25 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p393OJEP001309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Apr 2011 23:24:19 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Sat,  9 Apr 2011 11:24:09 +0800
Message-Id: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v2 1/2] [mm] mbind01: not working on 32bit systems
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


when executing mem/mbind01 testcase under 32bit systems, it returns
ENOSYS error, indicating that the test is not suitable for running on
32bit systems. This patch checks wordsize before executing the actual
case.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mbind/mbind01.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-mm-mbind01-not-working-on-32bit-systems.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-mbind01-not-working-on-32bit-systems.patch"

diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
index 80a56c4..497df24 100644
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -67,6 +67,11 @@ int main(int argc, char** argv)
 	msg = parse_opts(argc, argv, options, usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+#if __WORDSIZE == 32
+	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+#endif
+
 	if (opt_node) {
 		node = atoi(optarg);
 		if (node < 1)
@@ -138,4 +143,4 @@ int main(void) {
 	tst_resm(TCONF, "no NUMA development packages installed.");
 	tst_exit();
 }
-#endif
\ No newline at end of file
+#endif

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



