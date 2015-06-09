Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z2J70-0000Wx-Vh
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 12:58:38 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2J6z-00082L-0Q
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 12:58:38 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t59CwUb6016225
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 12:58:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t59CwUgV014973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 12:58:30 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t59CwUSV017936
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 12:58:30 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  9 Jun 2015 16:01:38 +0300
Message-Id: <1433854898-11064-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] lib6/in6_2: don't assume that machine has 'eth0'
	interface name
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

systemd can rename network interfaces. We should look at LHOST_IFACES
variable for pre-defined test interface names.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: use sscanf() instead of strchr()
    allocate buffer on the stack

 testcases/network/lib6/in6_02.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index fea1827..7cb3626 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -255,4 +255,23 @@ void initest(void)
 void setup(void)
 {
 	TEST_PAUSE;
+
+	tst_resm(TINFO, "get interface name from LHOST_IFACES var");
+
+	char *ifnames = getenv("LHOST_IFACES");
+
+	if (!ifnames) {
+		tst_resm(TWARN, "LHOST_IFACES not defined, default to eth0");
+		return;
+	}
+
+	static char name[256];
+
+	sscanf(ifnames, "%255s", name);
+
+	if (!strcmp(name, n2i[1].name))
+		return;
+
+	tst_resm(TINFO, "change default 'eth0' name to '%s'", name);
+	n2i[1].name = name;
 }
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
