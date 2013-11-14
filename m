Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VgnnV-0003Xj-K4
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:49 +0000
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VgnnU-0002sN-Sz
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:40:49 +0000
Received: by mail-pa0-f43.google.com with SMTP id fa1so1452162pad.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 19:40:43 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:35 +0800
Message-Id: <1384400319-30776-4-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 4/8] ltp-networking/nfs: remove absolute path for
	showmount.
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

Showmount doesn't locate at /user/sbin/showmount on Ubuntu 12.04.

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/nfs/nfs02/nfs02         |    2 +-
 testcases/network/nfs/nfsstat01/nfsstat01 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs02/nfs02 b/testcases/network/nfs/nfs02/nfs02
index 89b65cf..c192d96 100755
--- a/testcases/network/nfs/nfs02/nfs02
+++ b/testcases/network/nfs/nfs02/nfs02
@@ -103,7 +103,7 @@ $trace_logic
    fi

    #Verify export
-   /usr/sbin/showmount -e $RHOST | grep $TESTDIR
+   showmount -e $RHOST | grep $TESTDIR
    [ $? -eq 0 ] || end_testcase "$TESTDIR not exported"

    #Create $TCtmp for mount point
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 7b1ac43..f08f758 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -100,7 +100,7 @@ $trace_logic
    fi

    #Verify export
-   /usr/sbin/showmount -e $HOST | grep $EXPORTDIR > /dev/null
+   showmount -e $HOST | grep $EXPORTDIR > /dev/null
    [ $? -eq 0 ] || end_testcase "$EXPORTDIR not exported"

    #Create mount point
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
