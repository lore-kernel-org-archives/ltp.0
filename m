Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SZgAa-0003Y7-Go
	for ltp-list@lists.sourceforge.net; Wed, 30 May 2012 10:30:24 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SZgAZ-0001SI-JA
	for ltp-list@lists.sourceforge.net; Wed, 30 May 2012 10:30:24 +0000
Received: by pbbrq2 with SMTP id rq2so7205959pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 May 2012 03:30:17 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed, 30 May 2012 18:28:54 +0800
Message-Id: <1338373734-21691-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH] gitmodules: update mce-test repo URL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


According to mce-test maintainer Chen Gong, the project repo URL has
been moved to git.kernel.org, so update the URL.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .gitmodules |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0001-gitmodules-update-mce-test-repo-URL.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-gitmodules-update-mce-test-repo-URL.patch"

diff --git a/.gitmodules b/.gitmodules
index e9eefdb..1c9e9c3 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,3 @@
 [submodule "testcases/kernel/mce-test"]
 	path = testcases/kernel/mce-test
-	url = git://github.com/andikleen/mce-test.git
+	url = git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



