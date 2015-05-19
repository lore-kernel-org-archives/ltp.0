Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YuYHX-0002S0-57
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 03:33:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YuYHV-0003tP-Ki
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 03:33:27 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4J3Vt0C001039
	for <ltp-list@lists.sourceforge.net>; Tue, 19 May 2015 11:31:56 +0800
Message-ID: <1432006441.27486.26.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 19 May 2015 11:34:01 +0800
In-Reply-To: <1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mmapstress01: Modify readbuf's type and define it to
	uchar_t
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

readbuf is defined to char. That is different with the previous
defined. If readbuf's value is more than 127, that would be regarded
as negative number. And expbuf is uchar_t, the value is always
nonegative. That will make the test fail because the different data
type.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/mmapstress/mmapstress01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index ed1466a..81566f2 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -604,7 +604,7 @@ int fileokay(char *file, uchar_t * expbuf)
 	size_t mapsize;
 	unsigned mappages;
 	unsigned pagesize = sysconf(_SC_PAGE_SIZE);
-	char readbuf[pagesize];
+	uchar_t readbuf[pagesize];
 	int fd;
 	int cnt;
 	unsigned i, j;
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
