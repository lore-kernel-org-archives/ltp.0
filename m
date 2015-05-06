Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YpwQI-0002TN-FN
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 10:19:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YpwQH-0004wJ-EF
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 10:19:26 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t46AI0pJ016856
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 18:18:00 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 6 May 2015 18:18:22 +0800
Message-ID: <1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] kernel/mem/mmapstress: fix resource leak
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

Including memory and fd leak.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/mem/mmapstress/mmapstress01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 0baf0e2..1db8147 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -657,6 +657,8 @@ int fileokay(char *file, uchar_t * expbuf)
 			perror("read error");
 			/***** LTP Port *****/
 			local_flag = FAILED;
+			free(readbuf);
+			close(fd);
 			anyfail();
 			/*****	**	*****/
 			return 0;
@@ -668,6 +670,8 @@ int fileokay(char *file, uchar_t * expbuf)
 				(void)fprintf(stderr, "read %d of %ld bytes\n",
 					      (i * pagesize) + cnt,
 					      (long)mapsize);
+				free(readbuf);
+				close(fd);
 				return 0;
 			}
 		}
@@ -688,10 +692,13 @@ int fileokay(char *file, uchar_t * expbuf)
 					      "(fsize %ld)\n", i, j,
 					      statbuf.st_size);
 #endif /* LARGE_FILE */
+				free(readbuf);
+				close(fd);
 				return 0;
 			}
 		}
 	}
+	free(readbuf);
 	close(fd);
 
 	return 1;
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
