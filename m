Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuriy.kolerov@synopsys.com>) id 1ZXuOk-00056B-SK
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2015 17:03:34 +0000
Received: from smtprelay4.synopsys.com ([198.182.47.9]
	helo=smtprelay.synopsys.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZXuOh-0003AD-1g
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2015 17:03:34 +0000
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com
	[10.12.235.98])
	by smtprelay.synopsys.com (Postfix) with ESMTP id 523BD24E055E
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2015 10:03:23 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com
	(us02secmta2.internal.synopsys.com [127.0.0.1])
	by us02secmta2.internal.synopsys.com (Service) with ESMTP id 4500D55F17
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2015 10:03:23 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
	by us02secmta2.internal.synopsys.com (Service) with ESMTP id
	28DDD55F02 for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Sep 2015 10:03:23 -0700 (PDT)
From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri,  4 Sep 2015 20:02:55 +0300
Message-Id: <1441386175-23123-1-git-send-email-yuriy.kolerov@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.2.0"
Subject: [LTP] [PATCH] Enable including config.mk and features.mk for *clean
	targets
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
Cc: Anton.Kolesov@synopsys.com, Francois.Bedard@synopsys.com

This is a multi-part message in MIME format.
--------------2.2.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: quoted-printable


It's necessary for correct cleaning. E.g. open_posix_testsuite
is not cleaned without including these .mk files. However it's
not an error if these files does not exist while cleaning.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 include/mk/env_pre.mk | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


--------------2.2.0
Content-Type: text/x-patch;
	name="0001-Enable-including-config.mk-and-features.mk-for-clean.patch"
Content-Disposition: attachment;
	filename="0001-Enable-including-config.mk-and-features.mk-for-clean.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index f1584a8..a6beb5b 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -94,11 +94,18 @@ ifeq ($(srcdir),)
 srcdir				:=3D .
 endif
=20
-# autotools, *clean, and help don't require config.mk, features.mk, etc.=
..
-ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOA=
LS)),)
+# autotools and help don't require config.mk, features.mk, etc...
+ifeq ($(filter autotools .gitignore gitignore.% help,$(MAKECMDGOALS)),)
=20
+# If config.mk and features.mk does not exist it's not an error for *cle=
an
+# targets.
+ifeq ($(filter %clean,$(MAKECMDGOALS)),)
 include $(abs_top_builddir)/include/mk/config.mk
 include $(abs_top_builddir)/include/mk/features.mk
+else
+-include $(abs_top_builddir)/include/mk/config.mk
+-include $(abs_top_builddir)/include/mk/features.mk
+endif
=20
 # START out-of-build-tree check.
 ifneq ($(abs_builddir),$(abs_srcdir))

--------------2.2.0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------2.2.0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------2.2.0--



