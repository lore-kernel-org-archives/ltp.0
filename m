From: Petr Vorel <petr.vorel@suse.com>
Date: Mon, 22 Jun 2020 09:43:13 +0200
Subject: [LTP] [PATCH 1/2] cgroup: Fix build with -Werror=return-type
Message-ID: <20200622074314.22098-1-petr.vorel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Adding bogus return to keep compiler happy.

Fixes: 3b716981b ("lib: add new cgroup test API")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

IMHO using pragma would be better, but I don't know how to write it portable way.

Kind regards,
Petr

 lib/tst_cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index f55d8818d..0118dd7b2 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -49,6 +49,7 @@ enum tst_cgroup_ver tst_cgroup_version(void)
 		return TST_CGROUP_V1;
 
 	tst_brk(TCONF, "Cgroup is not configured");
+	return TST_CGROUP_V1; /* fix -Werror=return-type */
 }
 
 static void tst_cgroup1_mount(const char *name, const char *option,
-- 
2.27.0

