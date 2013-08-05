Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V6M1i-0003Eg-Di
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 14:44:50 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V6M1e-0006ru-O4
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 14:44:50 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r75Eicuw014842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Aug 2013 14:44:38 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r75EibGu026553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Aug 2013 14:44:38 GMT
Received: from abhmt118.oracle.com (abhmt118.oracle.com [141.146.116.70])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r75EibbX014507
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Aug 2013 14:44:37 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon,  5 Aug 2013 18:44:06 +0400
Message-Id: <1375713846-24291-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1375713846-24291-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1375713846-24291-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] quota_remount_test01: SELinux workaround and other
	fixes
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

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

* now it uses tst_kvercmp (to support kernels >= 3)
* some distros doesn't allow creation of quota files in
directories with SELinux file_t type. Now we explicitly
change file type of the test directory to tmp_t

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../fs/quota_remount/quota_remount_test01.sh       |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index 98b15d6..7790d16 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -47,14 +47,8 @@ then
 fi
 MNTDIR=$TMPDIR/mnt
 
-uname -r | {
-	IFS='.-'
-	read MAJOR MINOR RELEASE REST
-	if [ "$MAJOR" -lt 2 -o "$MINOR" -lt 6 -o "$RELEASE" -lt 26 ]; then
-		exit 1
-	fi
-	exit 0; }
-if [ $? -gt 0 ]; then
+tst_kvercmp 2 6 26
+if [ $? -eq 0 ]; then
         tst_resm TCONF "Remounting with quotas enabled is not supported!"
         tst_resm TCONF "You should have kernel 2.6.26 and above running....."
         exit 0
@@ -83,6 +77,13 @@ mkdir $MNTDIR || die 2 "Could not create the mountpoint"
 mount -t ext3 -o loop,usrquota,grpquota $IMAGE $MNTDIR || die 2 "Could not mount the filesystem"
 tst_resm TINFO "Successfully mounted the File System"
 
+# some distros (CentOS 6.x, for example) doesn't permit creating
+# of quota files in a directory with SELinux file_t type
+if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
+	chcon -t tmp_t $MNTDIR || die 2 "Could not change SELinux file type"
+	tst_resm TINFO "Successfully changed SELinux file type"
+fi
+
 quotacheck -cug $MNTDIR || die 2 "Could not create quota files"
 tst_resm TINFO "Successfully Created Quota Files"
 
-- 
1.7.1


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
