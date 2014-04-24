Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WdG60-0007Pv-DK
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 09:37:32 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 62D02AC47
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Apr 2014 09:37:23 +0000 (UTC)
Date: Thu, 24 Apr 2014 11:36:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20140424093638.GA20266@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] MAINTAINERS: update maintainership of LTP
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This patch updates Linux kernel MAINTAINERS file to reflect current
state.

Add your signed-of-by if you are OK with the changes.

If nobody objects I will send it to kernel devs next week.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e67ea24..ed8f529 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5479,15 +5479,15 @@ F:	Documentation/hwmon/ltc4261
 F:	drivers/hwmon/ltc4261.c
 
 LTP (Linux Test Project)
-M:	Shubham Goyal <shubham@linux.vnet.ibm.com>
 M:	Mike Frysinger <vapier@gentoo.org>
 M:	Cyril Hrubis <chrubis@suse.cz>
-M:	Caspar Zhang <caspar@casparzhang.com>
 M:	Wanlong Gao <gaowanlong@cn.fujitsu.com>
+M:	Jan Stancek <jstancek@redhat.com>
+M:	Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+M:	Alexey Kodanev <alexey.kodanev@oracle.com>
 L:	ltp-list@lists.sourceforge.net (subscribers-only)
-W:	http://ltp.sourceforge.net/
+W:	http://linux-test-project.github.io/
 T:	git git://github.com/linux-test-project/ltp.git
-T:	git git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev
 S:	Maintained
 
 M32R ARCHITECTURE
-- 
1.8.3.2


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
