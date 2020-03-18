From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 18 Mar 2020 12:55:02 +0800
Subject: [LTP] [PATCH] ltp_tpci.c: fix a null pointer
Message-ID: <1584507302-23515-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit 3dd286bdbee ("ltp_tpci.c: Update legacy code"),
it introduced a warning as below:
../ltp_tpci.c: In function ?probe_pci_dev?:
../ltp_tpci.c:107:8: warning: ?dev? is used uninitialized in this function [-Wuninitialized]
  struct pci_dev *dev;
  dev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), bus, slot)

This will lead to system crash when we run this case because it triggers a null pointer.
Use 0 domain intead of pci_domain_nr.

ps: I want to use a dymaic domain to fix it but failed. If someone know,
please tell me. Also, this case failed when merging this patch because
test 13 (test_assign_resources) report no space error as below:
[754930.757585] ltp_tpci: test-case 13
[754930.757585] ltp_tpci: assign resources
[754930.757585] ltp_tpci: assign resource #0
[754930.757586] ltp_tpci: name = 0000:00:08.0, flags = 262401, start 0xc140, end 0xc17f
[754930.757586] ltp_tpci: assign resource #1
[754930.757587] ltp_tpci: name = 0000:00:08.0, flags = 262656, start 0xfebd7000, end 0xfebd7fff
[754930.757587] ltp_tpci: assign resource #2
[754930.757587] ltp_tpci: name = 0000:00:08.0, flags = 0, start 0x0, end 0x0
[754930.757588] ltp_tpci: assign resource #3
[754930.757588] ltp_tpci: name = 0000:00:08.0, flags = 0, start 0x0, end 0x0
[754930.757588] ltp_tpci: assign resource #4
[754930.757589] ltp_tpci: name = 0000:00:08.0, flags = 538190348, start 0xfe80c000, end 0xfe80ffff
[754930.757593] virtio-pci 0000:00:08.0: BAR 4: no space for [mem size 0x00004000 64bit pref]
[754930.757594] virtio-pci 0000:00:08.0: BAR 4: failed to assign [mem size 0x00004000 64bit pref

Fixes: 3dd286b ("ltp_tpci.c: Update legacy code")
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
index 7cbabfaa5..a57953db6 100644
--- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
@@ -104,7 +104,7 @@ static int probe_pci_dev(unsigned int bus, unsigned int slot)
 		ltp_pci.dev = NULL;
 	}
 
-	dev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), bus, slot);
+	dev = pci_get_domain_bus_and_slot(0, bus, slot);
 	if (!dev || !dev->driver)
 		return -ENODEV;
 
-- 
2.18.1



