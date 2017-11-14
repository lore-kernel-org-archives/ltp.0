From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 14 Nov 2017 15:59:20 +0000
Subject: [LTP] [PATCH v2 04/13] hugeshmctl01: Fix warning about
	signed/unsigned comparison
In-Reply-To: <20171114155929.24237-1-punit.agrawal@arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
Message-ID: <20171114155929.24237-5-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The macro N_ATTACH is assumed to be a signed intenger which results in
the below warning when compiling -

warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (buf.shm_nattch != N_ATTACH + stat_time) {
                     ^~

Fix this by explicitly marking N_ATTACH to be an unsigned integer and
fixing the resulting fallout.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 1808995ed..3e7f12691 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -47,7 +47,7 @@
 
 #define FIRST		0
 #define SECOND		1
-#define N_ATTACH	4
+#define N_ATTACH	4U
 #define NEWMODE		0066
 
 static size_t shm_size;
@@ -139,7 +139,7 @@ void *set_shmat(void)
  */
 static void stat_setup(void)
 {
-	int i;
+	unsigned int i;
 	void *test;
 	pid_t pid;
 
-- 
2.14.2

