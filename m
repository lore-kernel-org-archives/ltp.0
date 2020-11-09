From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon,  9 Nov 2020 15:56:57 +0100
Subject: [LTP] [PATCH v2 1/1] lib/tst_virt: support IBM/Z LPAR and z/VM
 virtualization environments
Message-ID: <20201109145657.602251-1-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add 3 new virtualization types for IBM System Z architecture:
* VIRT_IBMZ (either LPAR ot z/VM)
* VIRT_IBMZ_LPAR (LPAR only)
* VIRT_IBMZ_ZVM (z/VM only)

VIRT_IBMZ is true when either VIRT_IBMZ_LPAR or VIRT_IBMZ_ZVM is true.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---

 v1 -> v2:
  * Remove redundancy by merging is_ibmz_lpar() and is_ibmz_zvm()
    into is_ibmz_vm()
  * Fix variable naming in is_ibmz_vm()

 include/tst_cpu.h |  3 +++
 lib/tst_virt.c    | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/tst_cpu.h b/include/tst_cpu.h
index c83a58260..117e27087 100644
--- a/include/tst_cpu.h
+++ b/include/tst_cpu.h
@@ -12,6 +12,9 @@ long tst_ncpus_max(void);
 #define VIRT_ANY	0	/* catch-all argument for tst_is_virt() */
 #define VIRT_XEN	1	/* xen dom0/domU */
 #define VIRT_KVM	2	/* only default virtual CPU */
+#define VIRT_IBMZ	3	/* ibm system z */
+#define VIRT_IBMZ_LPAR	4	/* ibm system z lpar */
+#define VIRT_IBMZ_ZVM	5	/* ibm system z zvm */
 #define VIRT_OTHER	0xffff	/* unrecognized hypervisor */
 
 int tst_is_virt(int virt_type);
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 914a08d96..86e7cf729 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -64,6 +64,41 @@ static int is_xen(void)
 	return 0;
 }
 
+static int is_ibmz_vm(int virt_type)
+{
+	FILE *sysinfo;
+	char line[64];
+	int found_lpar, found_zvm;
+
+	if (virt_type != VIRT_IBMZ_LPAR && virt_type != VIRT_IBMZ_ZVM)
+		return 0;
+
+	if (access("/proc/sysinfo", F_OK) != 0)
+		return 0;
+
+	sysinfo = SAFE_FOPEN(NULL, "/proc/sysinfo", "r");
+	found_lpar = 0;
+	found_zvm = 0;
+	while (fgets(line, sizeof(line), sysinfo) != NULL) {
+		if (strstr(line, "LPAR"))
+			found_lpar = 1;
+		else if (strstr(line, "z/VM"))
+			found_zvm = 1;
+	}
+
+	SAFE_FCLOSE(NULL, sysinfo);
+
+	if (virt_type == VIRT_IBMZ_LPAR)
+		return found_lpar && !found_zvm;
+	else
+		return found_lpar && found_zvm;
+}
+
+static int is_ibmz(void)
+{
+	return is_ibmz_vm(VIRT_IBMZ_LPAR) || is_ibmz_vm(VIRT_IBMZ_ZVM);
+}
+
 static int try_systemd_detect_virt(void)
 {
 	FILE *f;
@@ -102,6 +137,9 @@ static int try_systemd_detect_virt(void)
 	if (!strncmp("xen", virt_type, 3))
 		return VIRT_XEN;
 
+	if (!strncmp("zvm", virt_type, 3))
+		return VIRT_IBMZ_ZVM;
+
 	return VIRT_OTHER;
 }
 
@@ -118,11 +156,17 @@ int tst_is_virt(int virt_type)
 
 	switch (virt_type) {
 	case VIRT_ANY:
-		return is_xen() || is_kvm();
+		return is_xen() || is_kvm() || is_ibmz();
 	case VIRT_XEN:
 		return is_xen();
 	case VIRT_KVM:
 		return is_kvm();
+	case VIRT_IBMZ:
+		return is_ibmz();
+	case VIRT_IBMZ_LPAR:
+		return is_ibmz_vm(VIRT_IBMZ_LPAR);
+	case VIRT_IBMZ_ZVM:
+		return is_ibmz_vm(VIRT_IBMZ_ZVM);
 	case VIRT_OTHER:
 		return 0;
 	}
-- 
2.26.2

