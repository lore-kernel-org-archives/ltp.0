From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jun 2020 18:05:06 +0800
Subject: [LTP] [PATCH v2] tst_cgroup: fix tst_cgroup_version to cover more
 situations
Message-ID: <20200622100506.4285-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

  * system doesn't support any cgroup(v1, v2): TCONF
  * system only support cgroup v1: choose v1
  * system only support cgroup v2: choose v2
  * system support v1 & v2 but mounting v1: chosse v1
  * systep support v1 & v2 but mounting v2: choose v2

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_cgroup.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 0118dd7b2..010baa69e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -38,18 +38,19 @@ static int tst_cgroup_check(const char *cgroup)
 
 enum tst_cgroup_ver tst_cgroup_version(void)
 {
-	if (tst_cgroup_check("cgroup2")) {
-		if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
-			return TST_CGROUP_V1;
-		else
-			return TST_CGROUP_V2;
-	}
+	enum tst_cgroup_ver cg_ver;
 
 	if (tst_cgroup_check("cgroup"))
-		return TST_CGROUP_V1;
+		cg_ver = TST_CGROUP_V1;
+
+	if (tst_cgroup_check("cgroup2"))
+		if (!cg_ver || tst_is_mounted("cgroup2"))
+			cg_ver = TST_CGROUP_V2;
+
+	if (!cg_ver)
+		tst_brk(TCONF, "Cgroup is not configured");
 
-	tst_brk(TCONF, "Cgroup is not configured");
-	return TST_CGROUP_V1; /* fix -Werror=return-type */
+	return cg_ver;
 }
 
 static void tst_cgroup1_mount(const char *name, const char *option,
-- 
2.21.1

