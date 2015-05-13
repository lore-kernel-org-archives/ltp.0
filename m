Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YsUiG-0005Qr-Rk
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsUiF-0002oq-UY
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:32 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4DBJ6ud004331
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 19:19:06 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 13 May 2015 19:19:45 +0800
Message-ID: <1431515986-22287-4-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/5] testcases/kernel/fs/doio: free memory
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

free the memory that allocated by malloc and strdup.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/fs/doio/doio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index 4b0dec5..f5b9d66 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -1360,6 +1360,7 @@ char *format_rw(struct io_req *ioreq, int fd, void *buffer, int signo,
 		break;
 
 	}
+	free(aio_strat);
 
 	return errbuf;
 }
@@ -2071,6 +2072,8 @@ char *format_listio(struct io_req *ioreq, int lcmd, struct listreq *list,
 		    sprintf(cp, "          io completion strategy is %s\n",
 			    aio_strat);
 	}
+	free(aio_strat);
+
 	return errbuf;
 }
 #endif /* CRAY */
@@ -2558,6 +2561,7 @@ struct status *sy_listio(struct io_req *req, struct syscall_info *sysc, int fd,
 	}
 	status->aioid = malloc((nents + 1) * sizeof(int));
 	if (status->aioid == NULL) {
+		free(status);
 		doio_fprintf(stderr, "malloc failed, %s/%d\n",
 			     __FILE__, __LINE__);
 		return NULL;
@@ -2567,6 +2571,8 @@ struct status *sy_listio(struct io_req *req, struct syscall_info *sysc, int fd,
 
 	lio_req = malloc(nents * sizeof(struct listreq));
 	if (lio_req == NULL) {
+		free(status->aioid);
+		free(status);
 		doio_fprintf(stderr, "malloc failed, %s/%d\n",
 			     __FILE__, __LINE__);
 		return NULL;
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
