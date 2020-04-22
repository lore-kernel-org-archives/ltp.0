From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Apr 2020 09:13:21 +0200
Subject: [LTP] [PATCH] lib/tst_hugepage: TCONF when huge pages are not
 supported
Message-ID: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/sys/kernel/mm/hugepages is not present when there are no
supported hugepage sizes. This is common for ppc64le KVM guests,
when hypervisor does not enable hugepages. Guest will boot with:
  hugetlbfs: disabling because there are no supported hugepage sizes

  # cat /proc/filesystems  | grep huge; echo $?
  1

End the test with TCONF to avoid TBROK on mmap, set_sys_tune, etc.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_hugepage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 52667a14e8ff..eb66c4fbbc91 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -18,7 +18,7 @@ unsigned long tst_request_hugepages(unsigned long hpages)
 
 	if (access(PATH_HUGEPAGES, F_OK)) {
 		tst_hugepages = 0;
-		goto out;
+		tst_brk(TCONF, "Huge pages not supported.");
 	}
 
 	if (nr_opt)
-- 
2.18.1

