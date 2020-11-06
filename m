From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Fri,  6 Nov 2020 14:06:24 +0100
Subject: [LTP] [PATCH 2/2] lib/tst_virt: support IBM/Z LPAR and z/VM
 virtualization environments
In-Reply-To: <20201106130624.454614-1-egorenar@linux.ibm.com>
References: <20201106130624.454614-1-egorenar@linux.ibm.com>
Message-ID: <20201106130624.454614-3-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>

Add 3 new virtualization types for IBM System Z architecture:
* VIRT_IBMZ (either LPAR ot z/VM)
* VIRT_IBMZ_LPAR (LPAR only)
* VIRT_IBMZ_ZVM (z/VM only)

VIRT_IBMZ is true when either VIRT_IBMZ_LPAR or VIRT_IBMZ_ZVM is true.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 include/tst_cpu.h |  3 +++
 lib/tst_virt.c    | 62 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

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
index 914a08d96..c57d4fcfc 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -64,6 +64,57 @@ static int is_xen(void)
 	return 0;
 }
 
+static int is_ibmz_lpar(void)
+{
+	FILE *cpuinfo;
+	char line[64];
+	int found_lpar, found_zvm;
+
+	if (access("/proc/sysinfo", F_OK) != 0)
+		return 0;
+
+	cpuinfo = SAFE_FOPEN(NULL, "/proc/sysinfo", "r");
+	found_lpar = 0;
+	found_zvm = 0;
+	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
+		if (strstr(line, "LPAR"))
+			found_lpar = 1;
+		else if (strstr(line, "z/VM"))
+			found_zvm = 1;
+	}
+
+	SAFE_FCLOSE(NULL, cpuinfo);
+	return found_lpar && !found_zvm;
+}
+
+static int is_ibmz_zvm(void)
+{
+	FILE *cpuinfo;
+	char line[64];
+	int found_lpar, found_zvm;
+
+	if (access("/proc/sysinfo", F_OK) != 0)
+		return 0;
+
+	cpuinfo = SAFE_FOPEN(NULL, "/proc/sysinfo", "r");
+	found_lpar = 0;
+	found_zvm = 0;
+	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
+		if (strstr(line, "LPAR"))
+			found_lpar = 1;
+		else if (strstr(line, "z/VM"))
+			found_zvm = 1;
+	}
+
+	SAFE_FCLOSE(NULL, cpuinfo);
+	return found_lpar && found_zvm;
+}
+
+static int is_ibmz(void)
+{
+	return is_ibmz_lpar() || is_ibmz_zvm();
+}
+
 static int try_systemd_detect_virt(void)
 {
 	FILE *f;
@@ -102,6 +153,9 @@ static int try_systemd_detect_virt(void)
 	if (!strncmp("xen", virt_type, 3))
 		return VIRT_XEN;
 
+	if (!strncmp("zvm", virt_type, 3))
+		return VIRT_IBMZ_ZVM;
+
 	return VIRT_OTHER;
 }
 
@@ -118,11 +172,17 @@ int tst_is_virt(int virt_type)
 
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
+		return is_ibmz_lpar();
+	case VIRT_IBMZ_ZVM:
+		return is_ibmz_zvm();
 	case VIRT_OTHER:
 		return 0;
 	}
-- 
2.26.2

