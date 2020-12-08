From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Dec 2020 16:18:19 +0530
Subject: [LTP] [PATCH] Update .gitignore for .mod files
Message-ID: <dd3f6d5df505895a30dbcefe5336f95592816920.1607424494.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Following files are getting built currently and are showing up in git
status, this ignores them from git commands.

testcases/commands/insmod/ltp_insmod01.mod
testcases/commands/lsmod/ltp_lsmod01.mod
testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.mod
testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.mod
testcases/kernel/device-drivers/uaccess/ltp_uaccess.mod
testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.mod
testcases/kernel/syscalls/delete_module/dummy_del_mod.mod
testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.mod

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 86d8190a3a65..769d4be8873e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@ core
 lib*.a
 .cache.mk
 *.dwo
+*.mod
 
 /aclocal.m4
 autom4te.cache
-- 
2.25.0.rc1.19.g042ed3e048af

