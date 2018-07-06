From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri,  6 Jul 2018 16:29:27 +0100
Subject: [LTP] [PATCH] acl_test01: Add setfacl as an explicit dependency
Message-ID: <20180706152927.26646-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

acl_test01 calls setfacl during execution but does not explicitly
check for its presence during setup.

Add this dependency to correctly report the failure mode when setfacl
is not found.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/fs/acls/acl_test01 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index c91eb5686..14b62e895 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -64,6 +64,7 @@ fi
 do_setup()
 {
 	tst_require_root
+	tst_check_cmds setfacl
 
 	if ! ( test -d $TMP/tacl || mkdir -m 777 $TMP/tacl) ; then
 		tst_brkm TBROK "Failed to create $TMP/tacl directory."
-- 
2.17.1

