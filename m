From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  1 Jun 2021 11:55:20 +0100
Subject: [LTP] [PATCH v3 5/6] API/cgroups: tst_require fail gracefully with
 unknown controller
In-Reply-To: <20210601105521.27459-1-rpalethorpe@suse.com>
References: <20210601105521.27459-1-rpalethorpe@suse.com>
Message-ID: <20210601105521.27459-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 74746f13e..6d94ea41c 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -599,6 +599,12 @@ void tst_cgroup_require(const char *const ctrl_name,
 	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
 	struct cgroup_root *root;
 
+	if (!ctrl) {
+		tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
+		tst_brk(TBROK, "Calling %s in cleanup?", __func__);
+		return;
+	}
+
 	if (!options)
 		options = &default_opts;
 
-- 
2.31.1

