Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VoOQG-00050j-0G
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 02:12:12 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VoOQF-00075S-8e
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 02:12:11 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rB52C56T031510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 02:12:05 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB52C482007881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 02:12:04 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB52C332022278
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 02:12:04 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu,  5 Dec 2013 10:11:58 +0800
Message-Id: <1386209518-599-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP]  [PATCH] asapi_07: fix data types
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

The test always fails because some data types are wrong.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/lib6/asapi_07.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/lib6/asapi_07.c b/testcases/network/lib6/asapi_07.c
index 2968cc8..f401725 100644
--- a/testcases/network/lib6/asapi_07.c
+++ b/testcases/network/lib6/asapi_07.c
@@ -104,19 +104,19 @@ struct etent {
 	"sizeof(struct iovec *)"}}, {
 		"msghdr msg_iovlen", EXISTS, SOCKET_H, "msghdr",
 		    "msg_iovlen", NULL, {
-	"sizeof(struct iovec *)"}}, {
+	"sizeof(size_t)"}}, {
 		"msghdr msg_control", EXISTS, SOCKET_H, "msghdr",
 		    "msg_control", NULL, {
 	"sizeof(void *)"}}, {
 		"msghdr msg_controllen", EXISTS, SOCKET_H, "msghdr",
 		    "msg_controllen", NULL, {
-	"sizeof(socklen_t)"}}, {
+	"sizeof(size_t)"}}, {
 		"msghdr msg_flags", EXISTS, SOCKET_H, "msghdr",
 		    "msg_flags", NULL, {
 	"sizeof(int)"}}, {
 		"cmsghdr cmsg_len", EXISTS, SOCKET_H, "cmsghdr",
 		    "cmsg_len", NULL, {
-	"sizeof(socklen_t)"}}, {
+	"sizeof(size_t)"}}, {
 		"cmsghdr cmsg_level", EXISTS, SOCKET_H, "cmsghdr",
 		    "cmsg_level", NULL, {
 	"sizeof(int)"}}, {
-- 
1.8.4.2


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
