Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YlSiD-0005Tv-Fg
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlSiC-0007kf-Fh
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:25 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O1k9HE025626
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 09:46:09 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 09:46:41 +0800
Message-ID: <1429840001-4970-5-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 5/5] network/sockets/ltpClient: close fd to avoid leak
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
To: ltp-list@lists.sourceforge.net

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/network/sockets/ltpClient.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/network/sockets/ltpClient.c b/testcases/network/sockets/ltpClient.c
index b4754a3..2981737 100644
--- a/testcases/network/sockets/ltpClient.c
+++ b/testcases/network/sockets/ltpClient.c
@@ -401,6 +401,7 @@ int network_listener(char *hostName, int pid)
 		}
 	}
 
+	close(rawSocket);
 	return (0);
 }
 
@@ -547,6 +548,8 @@ void ping_network(struct sockaddr_in *rawAddr, int pid)
 			break;
 		}
 	}
+
+	close(rawSocket);
 }
 
 /**********************************************************************
-- 
1.9.3


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
