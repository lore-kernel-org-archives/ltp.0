Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnW-0000EA-3p
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:46 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAnV-00027f-7J
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:46 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDudnr012798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:39 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuccf008453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:39 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDucAD008449
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:38 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:25 +0400
Message-Id: <1395928590-28408-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/7] rpc-tirpc: introduced bound_socket()
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

The "bottom level" TI-RPC functions require a bound network socket.

This function is to avoid code duplication.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c    |   52 ++++++++++++++++++++
 .../rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h    |   13 +++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c
index 68abbd8..7bc4e32 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c
@@ -15,3 +15,55 @@
  * along with this program; if not, write the Free Software Foundation,
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/ip.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+int bound_socket(int domain, int type)
+{
+	int sock;
+	struct sockaddr_storage addr;
+	struct sockaddr_in *addr4 = (struct sockaddr_in *)&addr;
+	struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&addr;
+	socklen_t slen;
+
+	switch (domain) {
+	case AF_INET:
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = 0;
+		addr4->sin_addr.s_addr = INADDR_ANY;
+		slen = sizeof(*addr4);
+		break;
+
+	case AF_INET6:
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = 0;
+		addr6->sin6_addr = in6addr_any;
+		slen = sizeof(*addr6);
+		break;
+
+	default:
+		errno = EAFNOSUPPORT;
+		return -1;
+	}
+
+	if ((type != SOCK_STREAM) && (type != SOCK_DGRAM)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	sock = socket(domain, type, 0);
+	if (sock < 0)
+		return -1;
+
+	if (bind(sock, (struct sockaddr *)&addr, slen) < 0) {
+		close(sock);
+		return -1;
+	}
+
+	return sock;
+}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h
index 68abbd8..1293f2a 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h
@@ -15,3 +15,16 @@
  * along with this program; if not, write the Free Software Foundation,
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+
+#ifndef __LIBRPC_TIRPC_H__
+#define __LIBRPC_TIRPC_H__
+
+/*
+ * Returns a network socket bound to an arbitrary port.
+ * domain - AF_INET or AF_INET6,
+ * type - SOCK_DGRAM, SOCK_STREAM
+ * Returns -1 if failed (with set errno)
+ */
+int bound_socket(int domain, int type);
+
+#endif /* __LIBRPC_TIRPC_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
