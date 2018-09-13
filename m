From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Sep 2018 17:44:42 +0300
Subject: [LTP] [RFC PATCH 5/5] runtest/numa: remove move_pages* test cases
In-Reply-To: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1536849882-28897-6-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

since they are already defined in runtest/syscalls.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/numa | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/runtest/numa b/runtest/numa
index 12aedbb..510c353 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -1,13 +1 @@
 Numa-testcases numa01.sh
-move_pages01 move_pages01
-move_pages02 move_pages02
-move_pages03 move_pages03
-move_pages04 move_pages04
-move_pages05 move_pages05
-move_pages06 move_pages06
-move_pages07 move_pages07
-move_pages08 move_pages08
-move_pages09 move_pages09
-move_pages10 move_pages10
-move_pages11 move_pages11
-move_pages12 move_pages12
-- 
1.8.3.1

