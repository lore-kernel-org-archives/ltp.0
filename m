From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2016 17:34:28 +0800
Subject: [LTP] [PATCH 4/4] mm/oom: enable ksm before OOM-KSM testing
In-Reply-To: <1457602468-24268-3-git-send-email-liwang@redhat.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
 <1457602468-24268-2-git-send-email-liwang@redhat.com>
 <1457602468-24268-3-git-send-email-liwang@redhat.com>
Message-ID: <1457602468-24268-4-git-send-email-liwang@redhat.com>
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
 testcases/kernel/mem/include/mem.h | 1 +
 testcases/kernel/mem/ksm/ksm05.c   | 2 --
 testcases/kernel/mem/lib/mem.c     | 3 +++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 18388ee..9dea888 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -43,6 +43,7 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 /* KSM */
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
+int ksm_run_orig;
 int max_page_sharing;
 int merge_across_nodes;
 
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 2baca3b..4037ff3 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -72,8 +72,6 @@ int TST_TOTAL = 1;
 
 #ifdef HAVE_MADV_MERGEABLE
 
-static int ksm_run_orig;
-
 static void sighandler(int sig);
 
 int main(int argc, char *argv[])
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index d37d6a4..0ecde55 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -224,7 +224,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &ksm_run_orig);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "run", "1");
 		oom(KSM, lite, retcode, allow_sigkill);
+		FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
 	}
 }
 
-- 
1.8.3.1

