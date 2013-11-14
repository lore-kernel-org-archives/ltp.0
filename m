Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VgnnY-00065v-4j
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:52 +0000
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VgnnW-0002sS-VD
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:52 +0000
Received: by mail-pb0-f48.google.com with SMTP id mc17so1402055pbc.35
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 19:40:45 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:36 +0800
Message-Id: <1384400319-30776-5-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 5/8] ltp-networking/nfs: fix nfsstat01 typo
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
Cc: linaro-networking@linaro.org

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/nfs/nfsstat01/nfsstat01 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index f08f758..229e2c3 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -48,7 +48,7 @@ HOST=`hostname`
 CLEANUP=${CLEANUP:="ON"}
 VERSION=${VERSION:=3}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-NFS_TYPE=${NFS_TYPE:nfs}
+NFS_TYPE=${NFS_TYPE:=nfs}
 export TCID=$TC
 export TST_TOTAL=1
 export TST_COUNT=1
--
1.7.9.5


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
