Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6SHp-0000or-AN
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 17:40:01 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 211B29486B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 19:39:53 +0200 (CEST)
Date: Mon, 26 Apr 2010 19:47:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426174733.GA14970@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Subject: [LTP] [PATCH] don't install man files with x permission
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
To: ltp-list@lists.sourceforge.net


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
While packaging ltp-full-20100228 I've found out that man files are installed
with executable bits and that's caused by INSTALL_MODE := 00775 that is pulled
from generic_leaf_target.mk that pulls in env_post.mk. Fixing explicitly 
INSTALL_MODE to 00644 in man.mk fixes this for me. Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--+HP7ph2BbKc20aGI
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="install_man_witout_exec_bit.patch"

Index: ltp-full-20100228/include/mk/man.mk
===================================================================
--- ltp-full-20100228.orig/include/mk/man.mk
+++ ltp-full-20100228/include/mk/man.mk
@@ -28,6 +28,8 @@ include $(top_srcdir)/include/mk/env_pre
 
 INSTALL_DIR	:= $(mandir)/man$(MANPREFIX)
 
+INSTALL_MODE    := 00644
+
 INSTALL_TARGETS	?= *.$(MANPREFIX)
 
 MAKE_TARGETS	:=

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--+HP7ph2BbKc20aGI--

