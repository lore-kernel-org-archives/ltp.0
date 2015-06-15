Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UP8-0002oJ-8C
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:26:22 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UP7-0004F9-0T
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:26:22 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ00UG7MNQL4C0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:26:14 +0900 (KST)
Date: Mon, 15 Jun 2015 13:26:14 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <647249605.1047811434374774166.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 1/1] io: fix memory leak
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

This patch fixes memory leak for ibuff and obuff
if default case of switch hit.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 testcases/kernel/io/disktest/dump.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/io/disktest/dump.c b/testcases/kernel/io/disktest/dump.c
index ffb5ce1..615e8b4 100644
--- a/testcases/kernel/io/disktest/dump.c
+++ b/testcases/kernel/io/disktest/dump.c
@@ -163,6 +163,8 @@ int dump_data(FILE * stream, const char *buff, const size_t buff_siz,
 			fprintf(stream, "%s\n", obuff);
 			break;
 		default:
+			FREE(ibuff);
+			FREE(obuff);
 			return (-1);
 		}
 	}
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
