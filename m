Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Tfmpu-0006B5-Kb
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 07:22:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tfmpt-0005O0-RP
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 07:22:34 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qB47MXnb017391
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Dec 2012 15:22:34 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 4 Dec 2012 15:21:54 +0800
Message-Id: <1354605716-4747-2-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1354605716-4747-1-git-send-email-penght@cn.fujitsu.com>
References: <1354605716-4747-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/4] runnetnstest.sh: fix a fail of vsftpd is disabled
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

When vsftpd is disabled, runnetnstest.sh should start vsftpd first.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/runnetnstest.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
index d2a7fec..fb494a2 100755
--- a/testcases/kernel/containers/netns/runnetnstest.sh
+++ b/testcases/kernel/containers/netns/runnetnstest.sh
@@ -106,6 +106,15 @@ echo
 #fi
 #echo
 
+. cmdlib.sh
+flag=0
+
+status_daemon vsftpd
+if [ $? -ne 0 ]; then
+	start_daemon vsftpd
+	flag=1
+fi
+
 par_chld_ftp
 rc=$?
 if [ $rc -ne 0 ]; then
@@ -115,5 +124,10 @@ if [ $rc -ne 0 ]; then
 else
    echo "par_chld_ftp: PASS"
 fi
+
+if [ $flag -eq 1 ]; then
+	stop_daemon vsftpd
+fi
+
 echo
 exit $exit_code
-- 
1.8.0


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
