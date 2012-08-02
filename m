Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1SwxXf-00007r-Hz
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 15:42:27 +0000
Received: from rcsinet15.oracle.com ([148.87.113.117])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SwxXe-0004PN-QV
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 15:42:27 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by rcsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id q72FgKLv010888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Aug 2012 15:42:21 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu,  2 Aug 2012 23:42:11 +0800
Message-Id: <1343922131-1520-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH 1/1] runltp: avoid using --tmpdir with mktemp
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

'--tmpdir' is not supported by older mktemp, and runltp encounters error:

mktemp: invalid option -- -
Usage: mktemp [-V] | [-dqtu] [-p prefix] [template]

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 runltp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 0d77a6e..f94f1f8 100755
--- a/runltp
+++ b/runltp
@@ -693,7 +693,7 @@ main()
     fi
 
     if [ -n "$DEVICE" ]; then
-        mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`
+        mnt_pnt=`mktemp -d "${TMP}/mnt_pnt.XXXXXX"`
         if [ -n "$DEVICE_FS_TYPE" ]; then
             mount -t $DEVICE_FS_TYPE $DEVICE $mnt_pnt
         else
-- 
1.7.11.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
