From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 18 Jun 2021 15:05:35 +0200
Subject: [LTP] [PATCH 1/2] tpci: fix NULL pointer dereference on wrong test
 invocation
Message-ID: <20210618130536.54806-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix NULL pointer dereference when a ltp_tpci test case is started before
choosing the device:

    ltp_tpci: test-case 12
    ltp_tpci: assign resources
    ltp_tpci: assign resource #0
    BUG: kernel NULL pointer dereference, address: 00000000000003b8
    ...
     Call Trace:
      dev_attr_store+0x17/0x30
      sysfs_kf_write+0x3e/0x50
      kernfs_fop_write_iter+0x13c/0x1d0
      new_sync_write+0x113/0x1a0
      vfs_write+0x1c5/0x200
      ksys_write+0x67/0xe0
      __x64_sys_write+0x1a/0x20
      do_syscall_64+0x49/0xc0
      entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 5b48aa0c7ece..f2d4a4ba497c 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -556,6 +556,11 @@ static int test_case(unsigned int cmd)
 {
 	int rc = TSKIP;
 
+	if (!ltp_pci.dev || !ltp_pci.bus) {
+		prk_err("device or bus not selected for test");
+		return TFAIL;
+	}
+
 	switch (cmd) {
 	case PCI_ENABLE:
 		rc = pci_enable();
-- 
2.27.0

