Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIZiV-0008D1-Dy
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:57:07 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIZiT-00033X-VA
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:57:07 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2D229100C5B04
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:35:44 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXVf-0004of-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:35:44 +0200
Date: Wed, 10 Jun 2009 13:13:02 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwhd7oulwynca@debian>
Subject: [LTP] [PATCH] Don't overwrite the exit code with junk value in
	acl_test01
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
Message-ID: <20090610111302.L5ba2mmK_nnIcNJ23XHEXxLr5uXwfZx5o4ziL8ApoDY@z>

Hello,

the variable EXIT_CODE which contains the result of acl01 test, is overwritten at the end of the test. This patch makes it preserve the correct value.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/fs/acls/acl_test01 |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index 376a46c..01d068f 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -155,8 +155,6 @@ else
    		export TCbin=$PWD
 	fi
 	
-	EXIT_CODE=$?
-	
 	do_cleanup
 fi	
 
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
