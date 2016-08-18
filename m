From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 14:38:09 +0200
Subject: [LTP] [PATCH] tst_virt: Make use of systemd-detect-virt if available
Message-ID: <20160818123809.GA26650@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The problem is that there is no defined way to detect if we are inside
of a virtual machine, only bunch of heuristics. If you look at the
src/basic/virt.c in systemd source code it's ~500 lines of code that
tries many different things to try to guess if we are running
virtualized and under what hypervisor.

Currenlty LTP fails to detect KVM in OpenStack Cloud (and possibly many
more) since the /proc/cpuinfo does not contain the QEMU string there.
You can also boot QEMU with non-default -cpu option and you will get the
same result.

The easiest solution is to try the systemd-detect-virt first if it
exists, then we fall back to the previously implemented detections for
older distributions. This is not complete solution though, as the
detection still fails with older and non-systemd distributions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_virt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 87f73dc..d40ba39 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -64,8 +64,51 @@ static int is_xen(void)
 	return 0;
 }
 
+static int try_systemd_detect_virt(void)
+{
+	FILE *f;
+	char virt_type[64];
+	int ret;
+
+	/* See tst_run_cmd.c */
+	void *old_handler = signal(SIGCHLD, SIG_DFL);
+
+	f = popen("systemd-detect-virt", "r");
+	if (!f) {
+		signal(SIGCHLD, old_handler);
+		return 0;
+	}
+
+	if (!fgets(virt_type, sizeof(virt_type), f))
+		virt_type[0] = '\0';
+
+	ret = pclose(f);
+
+	signal(SIGCHLD, old_handler);
+
+	/*
+	 * systemd-detect-virt not found by shell or no virtualization detected
+	 * (systemd-detect-virt returns non-zero)
+         */
+	if (ret)
+		return 0;
+
+	if (strncmp("kvm", virt_type, 3))
+		return VIRT_KVM;
+
+	if (strncmp("xen", virt_type, 3))
+		return VIRT_XEN;
+
+	return 0;
+}
+
 int tst_is_virt(int virt_type)
 {
+	int ret = try_systemd_detect_virt();
+
+	if (ret)
+		return ret == virt_type;
+
 	switch (virt_type) {
 	case VIRT_XEN:
 		return is_xen();
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
