From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 16 Dec 2020 10:01:20 +0000
Subject: [LTP] [RFC PATCH 4/5] CGroup test guidelines
In-Reply-To: <20201216100121.16683-1-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
Message-ID: <20201216100121.16683-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 doc/test-writing-guidelines.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 99fb34628..d1cdb70e0 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2148,16 +2148,18 @@ the field value of file.
 
 2.2.36 Using Control Group
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
-Some of LTP tests need Control Group in their configuration, tst_cgroup.h provides
-APIs to make cgroup unified mounting at setup phase to be possible. The method?is
+
+Some of LTP tests need Control Groups in their configurations, tst_cgroup.h provides
+APIs to discover and use CGroups. The method?is
 extracted from mem.h with the purpose of?extendible for further developing, and
 trying to compatible the current two versions of cgroup.
 
-Considering there are many differences between cgroup v1 and v2, here we capsulate
+Considering there are many differences between cgroup v1 and v2, here we encapsulate
 the detail of cgroup mounting in high-level functions, which will be easier to use
-cgroup without caring about too much technical thing.? ?
+cgroup without caring about too much technical thing.
 
 Also, we do cgroup mount/umount work for the different hierarchy automatically.
+If that is required.
 
 [source,c]
 -------------------------------------------------------------------------------
@@ -2167,8 +2169,8 @@ static void run(void)
 {
 	...
 
-	tst_cgroup_move_current(PATH_TMP_CG_MEM);
-	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, MEMSIZE);
+	tst_cgroup_move_current(TST_CGROUP_MEMORY);
+	tst_cgroup_mem_set_maxbytes(MEMSIZE);
 
 	// do test under cgroup
 	...
@@ -2176,12 +2178,12 @@ static void run(void)
 
 static void setup(void)
 {
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
 }
 
 static void cleanup(void)
 {
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	tst_cgroup_cleanup(NULL);
 }
 
 struct tst_test test = {
-- 
2.29.2

