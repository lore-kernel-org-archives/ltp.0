From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 28 Aug 2019 18:14:15 +0800
Subject: [LTP] [PATCH 2/2] runtest/numa: add migrate_pages*
In-Reply-To: <1566987255-3010-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1566987255-3010-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1566987255-3010-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since migrate_pages must depend on numa, add it into
runtest/numa.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/numa | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/runtest/numa b/runtest/numa
index 7885be90c..45d15e768 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -12,6 +12,10 @@ move_pages10 move_pages10
 move_pages11 move_pages11
 move_pages12 move_pages12
 
+migrate_pages01 migrate_pages01
+migrate_pages02 migrate_pages02
+migrate_pages03 migrate_pages03
+
 set_mempolicy01 set_mempolicy01
 set_mempolicy02 set_mempolicy02
 set_mempolicy03 set_mempolicy03
-- 
2.18.1



