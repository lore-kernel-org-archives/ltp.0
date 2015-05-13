Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YsVCr-00007R-QZ
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:52:09 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YsVCq-0007CS-4s
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:52:09 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4DBq1pk007078
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 11:52:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4DBq1Z7000795
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 11:52:01 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4DBq12T008033
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 11:52:01 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 13 May 2015 14:54:45 +0300
Message-Id: <1431518085-8950-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib6/in6_2: don't assume that machine has 'eth0'
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
variable for predefined test interface names.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/lib6/in6_02.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index fea1827..dadb2a5 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -255,4 +255,36 @@ void initest(void)
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
+	char *end = strchr(ifnames, ' ');
+
+	if (!end)
+		end = strchr(ifnames, '\0');
+
+	if (!end || end <= ifnames)
+		return;
+
+	size_t size = end - ifnames + 1;
+
+	char *name = malloc(size);
+
+	strncpy(name, ifnames, size - 1);
+	name[size] = '\0';
+
+	if (!strcmp(name, n2i[1].name)) {
+		free(name);
+		return;
+	}
+
+	tst_resm(TINFO, "change default 'eth0' name to '%s'", name);
+	n2i[1].name = name;
 }
-- 
1.7.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
