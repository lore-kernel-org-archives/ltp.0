From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:47 +0000
Subject: [LTP] [PATCH v3 04/12] hugeshmctl01: Fix warning about
	signed/unsigned comparison
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-5-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The macro N_ATTACH is assumed to be a signed integer which results in
the below warning when compiling -

warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (buf.shm_nattch != N_ATTACH + stat_time) {
                     ^~

Fix this by explicitly marking N_ATTACH to be an unsigned integer and
fixing the resulting fallout.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 78a642973..c639c8e5f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -46,7 +46,7 @@
 
 #define FIRST		0
 #define SECOND		1
-#define N_ATTACH	4
+#define N_ATTACH	4U
 #define NEWMODE		0066
 
 static size_t shm_size;
@@ -138,7 +138,7 @@ void *set_shmat(void)
  */
 static void stat_setup(void)
 {
-	int i;
+	unsigned int i;
 	void *test;
 	pid_t pid;
 
@@ -237,7 +237,8 @@ fail:
  */
 static void stat_cleanup(void)
 {
-	int i, status;
+	unsigned int i;
+	int status;
 
 	/* wake up the childern so they can detach the memory and exit */
 	TST_CHECKPOINT_WAKE2(1, N_ATTACH);
-- 
2.15.0

