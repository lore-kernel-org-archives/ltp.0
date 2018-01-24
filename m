From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:07 +0100
Subject: [LTP] [PATCH 14/19] fix unused parameter in tpci.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-15-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/device-drivers/pci/tpci_user/tpci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index 5f9367b36..659c54261 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -47,7 +47,7 @@ static void cleanup(void)
 		tst_module_unload(NULL, module_name);
 }
 
-void setup(int argc, char *argv[])
+void setup(void)
 {
 	tst_require_root();
 
@@ -105,9 +105,9 @@ static void test_run(void)
 	}
 }
 
-int main(int argc, char *argv[])
+int main(void)
 {
-	setup(argc, argv);
+	setup();
 
 	test_run();
 
-- 
2.13.6

