From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 10:01:57 +0200
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost: skip test on virtual
 machines
Message-ID: <20210623080157.26424-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testing CPU frequency boost on a virtual machines is not reliable.  Even
if cpufreq driver reports boost frequencies, the underlying hypervisor
might decide otherwise.

For example on AWS x1e.xlarge instance (claimed to be running on Intel
Xeon E7 8880) under Xen hypervisor the test always fails:

    cpufreq_boost    0  TINFO  :  found 'intel_pstate' driver, sysfs knob '/sys/devices/system/cpu/intel_pstate/no_turbo'
    cpufreq_boost    0  TINFO  :  maximum speed is 3100000 KHz
    cpufreq_boost    0  TINFO  :  load CPU0 with boost enabled
    cpufreq_boost    0  TINFO  :  elapsed time is 1155 ms
    cpufreq_boost    0  TINFO  :  load CPU0 with boost disabled
    cpufreq_boost    0  TINFO  :  elapsed time is 1155 ms
    cpufreq_boost    1  TFAIL  :  cpufreq_boost.c:186: compare time spent with and without boost (-2%)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index b9739db37cb7..67917b3fea25 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -90,6 +90,9 @@ static void setup(void)
 	unsigned int i;
 	tst_require_root();
 
+	if (tst_is_virt(VIRT_ANY))
+		tst_brkm(TCONF, NULL, "running in a virtual machine, overclock not reliably measureable");
+
 	for (i = 0; i < ARRAY_SIZE(cdrv); ++i) {
 		fd = open(cdrv[i].file, O_RDWR);
 		if (fd == -1)
-- 
2.27.0

