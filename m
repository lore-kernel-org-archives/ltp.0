From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Sep 2021 17:02:20 +0200
Subject: [LTP] [PATCH] lib: tst_virt: Add option to override virt detection
Message-ID: <20210914150220.2467-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There seems to be cases where systemd-detect-virt does not detect
virtualization correctly. To work around this bugs this commit adds a
a support for LTP_VIRT_OVERRIDE environment variable that if set is used
instead of the output from the systemd-detect-virt command.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_virt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index d23d7f564..0fda20a17 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -100,8 +100,18 @@ static int is_ibmz(int virt_type)
 static int try_systemd_detect_virt(void)
 {
 	FILE *f;
-	char virt_type[64];
+	char virt_buf[64];
 	int ret;
+	char *virt_type = getenv("LTP_VIRT_OVERRIDE");
+
+	if (virt_type) {
+		if (!strcmp("", virt_type))
+			return 0;
+
+		goto cmp;
+	}
+
+	virt_type = virt_buf;
 
 	/* See tst_cmd.c */
 	void *old_handler = signal(SIGCHLD, SIG_DFL);
@@ -129,6 +139,7 @@ static int try_systemd_detect_virt(void)
 	if (ret)
 		return 0;
 
+cmp:
 	if (!strncmp("kvm", virt_type, 3))
 		return VIRT_KVM;
 
-- 
2.26.3

