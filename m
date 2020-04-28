From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 28 Apr 2020 17:47:26 +0200
Subject: [LTP] [PATCH v2 1/2] tst_is_virt(): Allow checking for any
 hypervisor
Message-ID: <20200428154727.29206-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add two more valid arguments for tst_is_virt():
- VIRT_ANY: return 1 if any hypervisor is detected
- VIRT_OTHER: return 1 if an unrecognized hypervisor is detected

Also fix bugs in try_systemd_detect_virt() and return -1 on error.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

The is_kvm() fallback test pretty much doesn't work anywhere except in our
OpenQA setup. But looking at SystemD sources (yuck), detecting KVM properly
will be a major pain in the ass, never mind any other hypervisor. So I'll
leave any further improvements as an exercise for the reader.

BTW, systemd-detect-virt can't detect the PowerPC LPAR hypervisor.

 include/tst_cpu.h |  2 ++
 lib/tst_virt.c    | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/tst_cpu.h b/include/tst_cpu.h
index db6138f43..c83a58260 100644
--- a/include/tst_cpu.h
+++ b/include/tst_cpu.h
@@ -9,8 +9,10 @@ long tst_ncpus(void);
 long tst_ncpus_conf(void);
 long tst_ncpus_max(void);
 
+#define VIRT_ANY	0	/* catch-all argument for tst_is_virt() */
 #define VIRT_XEN	1	/* xen dom0/domU */
 #define VIRT_KVM	2	/* only default virtual CPU */
+#define VIRT_OTHER	0xffff	/* unrecognized hypervisor */
 
 int tst_is_virt(int virt_type);
 
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 090e6334c..53d33e69c 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -49,7 +49,7 @@ static int is_kvm(void)
 
 static int is_xen(void)
 {
-	char hypervisor_type[3];
+	char hypervisor_type[4];
 
 	if (access("/proc/xen", F_OK) == 0)
 		return 1;
@@ -90,30 +90,41 @@ static int try_systemd_detect_virt(void)
 	 * systemd-detect-virt not found by shell or no virtualization detected
 	 * (systemd-detect-virt returns non-zero)
          */
+	if (ret < 0 || (WIFEXITED(ret) && WEXITSTATUS(ret) == 127))
+		return -1;
+
 	if (ret)
 		return 0;
 
-	if (strncmp("kvm", virt_type, 3))
+	if (!strncmp("kvm", virt_type, 3))
 		return VIRT_KVM;
 
-	if (strncmp("xen", virt_type, 3))
+	if (!strncmp("xen", virt_type, 3))
 		return VIRT_XEN;
 
-	return 0;
+	return VIRT_OTHER;
 }
 
 int tst_is_virt(int virt_type)
 {
 	int ret = try_systemd_detect_virt();
 
-	if (ret)
-		return ret == virt_type;
+	if (ret >= 0) {
+		if (virt_type == VIRT_ANY)
+			return ret != 0;
+		else
+			return ret == virt_type;
+	}
 
 	switch (virt_type) {
+	case VIRT_ANY:
+		return is_xen() || is_kvm();
 	case VIRT_XEN:
 		return is_xen();
 	case VIRT_KVM:
 		return is_kvm();
+	case VIRT_OTHER:
+		return 0;
 	}
 
 	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
-- 
2.26.0

