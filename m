Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1YTNut-0004Mv-PL
	for ltp-list@lists.sourceforge.net; Thu, 05 Mar 2015 05:01:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YTNur-0004r0-GM
	for ltp-list@lists.sourceforge.net; Thu, 05 Mar 2015 05:01:47 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2551cIq002457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Mar 2015 00:01:39 -0500
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t2551Y28028030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Mar 2015 00:01:37 -0500
From: Li Wang <liwang@redhat.com>
Date: Thu,  5 Mar 2015 13:01:31 +0800
Message-Id: <1425531691-19211-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] commands/ade/ar01: the touched timestatp of file01.in
	should be newer than now
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

Since the timestatp is older than now it cause this testcase
failed like this:
+ touch -c -t 201503030303.55 file0.in
+ ar -ru /tmp/ar01-28953/lib.a file0.in file2.in
...
FAIL - ar with -u flag failed

From the AR(1) Manual pager, ar -u:
If you would like to insert only those of the files you list
that are newer than existing members of the same names, use
this modifier.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/commands/ade/ar/ar01 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
index 32fef11..c5181a3 100755
--- a/testcases/commands/ade/ar/ar01
+++ b/testcases/commands/ade/ar/ar01
@@ -483,7 +483,7 @@ do
 	File2time=`ar -tv $TCtmp/lib.a | grep file2.in`
 
 	#sleep 5
-	touch -c -t 201503030303.55 file0.in
+	touch -c -t 208503030303.55 file0.in
 
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
