Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1YVEdN-0003An-LW
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 07:31:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVEdL-0001pO-Qe
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 07:31:21 +0000
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Mar 2015 15:31:00 +0800
Message-Id: <1425972660-2489-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH v2] commands/ade/ar01: the touched timestamp of
	file01.in should be newer than current
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

* Upate the timestamp form stable to dynamic.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/commands/ade/ar/ar01 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
index 32fef11..ad88582 100755
--- a/testcases/commands/ade/ar/ar01
+++ b/testcases/commands/ade/ar/ar01
@@ -483,7 +483,7 @@ do
 	File2time=`ar -tv $TCtmp/lib.a | grep file2.in`
 
 	#sleep 5
-	touch -c -t 201503030303.55 file0.in
+	touch -c -t $(date --date='next day' +"%Y%m%d%H%M") file0.in
 
 	ar -ru $TCtmp/lib.a file0.in file2.in 2>&1 1>/dev/null
 	File1time1=`ar -tv $TCtmp/lib.a | grep file0.in`
-- 
1.8.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
