From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 12 Oct 2018 16:10:57 +0300
Subject: [LTP] [PATCH V2 5/5] Remove numa from the default scenario
In-Reply-To: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1539349857-10633-5-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the move_pages tests are in syscalls and numa01.sh is known
to be broken.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 - In V1 I removed move_pages* from numa, here I remove numa
   from the default scenario

 scenario_groups/default |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index 160d66c..9adb75d 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -19,7 +19,6 @@ fcntl-locktests
 connectors
 timers
 power_management_tests
-numa
 hugetlb
 commands
 hyperthreading
-- 
1.7.1

