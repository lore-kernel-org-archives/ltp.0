Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Syg6T-00023q-5x
	for ltp-list@lists.sourceforge.net; Tue, 07 Aug 2012 09:29:29 +0000
Received: from rcsinet15.oracle.com ([148.87.113.117])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Syg6P-0004oP-Cy
	for ltp-list@lists.sourceforge.net; Tue, 07 Aug 2012 09:29:29 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by rcsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id q779TIas003041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Aug 2012 09:29:19 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	q779TIE3027132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Aug 2012 09:29:18 GMT
Received: from abhmt118.oracle.com (abhmt118.oracle.com [141.146.116.70])
	by acsmt356.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id
	q779TIJe022009
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Aug 2012 04:29:18 -0500
From: Simon Xu <xu.simon@oracle.com>
Date: Tue,  7 Aug 2012 17:29:12 +0800
Message-Id: <1344331752-817-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH 1/1] runltp: fix -d option processing
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

When converting the path specified for -d to absolute path, an extra '/' is
added, e.g. if '/mypath' is specified, TMPBASE will be '//mypath'.
Some testcases fail because of this, e.g. chdir01A fails with:

chdir01     1  TFAIL  :  symlink(object, symbolic) was succesful.
mkdir(object, 0700) was successful
chdir(2) returned successfully, but getcwd(3) indicated new current
working directory location /ext4/ltp-2nHcAjcGKr/chd2Y4XkO/object not equal
to expected //ext4/ltp-2nHcAjcGKr/chd2Y4XkO/object

Use readlink to get absolute path.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 runltp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 0d77a6e..bf5f975 100755
--- a/runltp
+++ b/runltp
@@ -235,7 +235,7 @@ main()
             esac ;;
                    
         d)  # convert the user path to absolute path.
-            export TMPBASE=`cd \`dirname ${OPTARG}\`; pwd`/`basename ${OPTARG}` ;;
+            export TMPBASE=$(readlink -f "$OPTARG") ;;
 
         D)  NUM_PROCS=1; NUM_FILES=1; NUM_BYTES=$((1024 * 1024 * 1024)); CLEAN_FLAG=0
             ARGUMENT_LIST=$OPTARG
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
