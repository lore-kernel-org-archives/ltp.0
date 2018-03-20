From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 20 Mar 2018 16:02:30 +0300
Subject: [LTP] [PATCH V2 1/2] restore_max_page_sharing: restore the value
	only if it was saved
In-Reply-To: <20180320120134.GB9226@ai>
References: <20180320120134.GB9226@ai>
Message-ID: <1521550951-8124-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Documentation/vm/ksm.txt states that the minimum value for max_page_sharing
is 2, so we can use it as a flag to test if save_max_page_sharing()
was called before.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes to V1:
 - made the change to restore_max_page_sharing() following Cyril's proposal
 - split V1 into two patches, one - restore_max_page_sharing(), the other - ksm tests


 testcases/kernel/mem/lib/mem.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 4992843..f36b33a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -250,6 +250,15 @@ void save_max_page_sharing(void)
 
 void restore_max_page_sharing(void)
 {
+	/*
+	 * Documentation/vm/ksm.txt states that the minimum
+	 * value for max_page_sharing is 2, so on
+	 * max_page_sharing != 0 after save_max_page_sharing()
+	 * returns.
+	 */
+	if (!max_page_sharing)
+		return;
+
 	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
 	        FILE_PRINTF(PATH_KSM "max_page_sharing",
 	                         "%d", max_page_sharing);
-- 
1.7.1

