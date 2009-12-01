Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFbn0-0005UI-Cb
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:05:46 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFbmv-0000wa-N2
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:05:46 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 441C313EF2F5B
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Dec 2009 00:05:36 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1NFbkl-0003lh-00
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 00:03:27 +0100
Date: Wed, 02 Dec 2009 00:01:39 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u397n915cfnueu@debian>
Subject: [LTP] [PATCH] Refer to checkforlibcap.sh by its real name
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091201230139.gGn5DoAm8LRjCT1jQpQPcLYthUxpfekbP-iKyhfyvtk@z>

Hello,

checkforlibcap doesn't exist, the script's proper name is checkforlibcap.sh.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/security/filecaps/filecapstest.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
index c95291a..149cbc1 100755
--- a/testcases/kernel/security/filecaps/filecapstest.sh
+++ b/testcases/kernel/security/filecaps/filecapstest.sh
@@ -19,7 +19,7 @@
 ##                                                                            ##
 ################################################################################
 
-checkforlibcap
+checkforlibcap.sh
 ret=$?
 if [ $ret -ne 0 ]; then
 	echo "Filecaps 0 CONF : System doesn't support execution of the test"
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
