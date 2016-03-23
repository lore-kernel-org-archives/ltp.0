From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Mar 2016 12:25:57 +0800
Subject: [LTP] [PATCH V2 3/3] mm/oom: enable ksm before OOM-KSM testing
In-Reply-To: <1458707157-31233-2-git-send-email-liwang@redhat.com>
References: <1458707157-31233-1-git-send-email-liwang@redhat.com>
 <1458707157-31233-2-git-send-email-liwang@redhat.com>
Message-ID: <1458707157-31233-3-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In the alloc_mem() function, the memory flag is set to 'MADV_MERGEABLE',
	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
			return errno;
But it still doesn't send the whole item for test, unless the ksm is enabled.

Generally, the '../ksm/run' default is 0, it should be changed to 1 to activate ksm.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 084e5a4..1200d1d 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -211,6 +211,8 @@ static void set_global_mempolicy(int mempolicy)
 
 void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 {
+	int ksm_run_orig;
+
 	set_global_mempolicy(mempolicy);
 
 	tst_resm(TINFO, "start normal OOM testing.");
@@ -224,7 +226,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		SAFE_FILE_SCANF(cleanup, PATH_KSM "run", "%d", &ksm_run_orig);
+		SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
 		oom(KSM, lite, retcode, allow_sigkill);
+		SAFE_FILE_PRINTF(cleanup,PATH_KSM "run", "%d", ksm_run_orig);
 	}
 }
 
-- 
1.8.3.1

