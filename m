Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TTUeI-00006o-5Z
	for ltp-list@lists.sourceforge.net; Wed, 31 Oct 2012 09:31:46 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TTUeH-0007bT-4g
	for ltp-list@lists.sourceforge.net; Wed, 31 Oct 2012 09:31:46 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q9V9Vdq8027270
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 31 Oct 2012 02:31:39 -0700 (PDT)
From: <jin.li@windriver.com>
Date: Wed, 31 Oct 2012 17:31:34 +0800
Message-ID: <1351675894-4843-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1351675894-4843-1-git-send-email-jin.li@windriver.com>
References: <1351675894-4843-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] number overcommit_memory test name in runtest/mm
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
To: jin.li@windriver.com, ltp-list@lists.sourceforge.net

From: Jin Li <jin.li@windriver.com>

---
 runtest/mm | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 0f59ef7..a8bd605 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -91,12 +91,12 @@ vma04 vma04
 
 zram01 zram01
 
-overcommit_memory overcommit_memory
-overcommit_memory overcommit_memory -R 0
-overcommit_memory overcommit_memory -R 30
-overcommit_memory overcommit_memory -R 80
-overcommit_memory overcommit_memory -R 100
-overcommit_memory overcommit_memory -R 200
+overcommit_memory01 overcommit_memory
+overcommit_memory02 overcommit_memory -R 0
+overcommit_memory03 overcommit_memory -R 30
+overcommit_memory04 overcommit_memory -R 80
+overcommit_memory05 overcommit_memory -R 100
+overcommit_memory06 overcommit_memory -R 200
 
 max_map_count max_map_count -i 10
 
-- 
1.7.11


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
