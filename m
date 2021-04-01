From: Wang Xin <wangxin410@huawei.com>
Date: Thu, 1 Apr 2021 12:51:27 +0000
Subject: [LTP] [PATCH] ltp_tpci.c: Add release operation before allocation
Message-ID: <20210401125127.45600-1-wangxin410@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we run the test case, the following results will be obtained:
test_pci  283  TPASS  :  PCI bus 7d slot 00 : Test-case '11'
test_pci  284  TFAIL  :  tpci.c:74: PCI bus 7d slot 00 : Test-case '12'
...
test_pci  300  TFAIL  :  tpci.c:74: PCI bus 7d slot 01 : Test-case '12'
test_pci  301  TPASS  :  PCI bus 7d slot 01 : Test-case '13'

The analysis is that the space allocated by the bios is insufficient.
The solution to this problem can be in add pci_release_resource(dev, i)
before system resources are reallocated.Because the resources have been
allocated when the system is initialized.If it is redistributed, it
should be released and then allocated.

Signed-off-by: Wang Xin <wangxin410@huawei.com>
---
 testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index e29821dda..5b0896093 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -439,6 +439,7 @@ static int test_assign_resources(void)
 		if (r->flags & IORESOURCE_MEM &&
 			r->flags & IORESOURCE_PREFETCH) {
+			pci_release_resource(dev, i);
 			ret = pci_assign_resource(dev, i);
 			prk_info("assign resource to '%d', ret '%d'", i, ret);
 			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
2.17.1

