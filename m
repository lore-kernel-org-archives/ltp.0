From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  4 May 2018 02:21:19 +0800
Subject: [LTP] [PATCH ltp] fs/acls/acl_test01: delete test user in
	do_setup() before create it
Message-ID: <20180503182119.24738-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If $TEST_USER1 exist on the system (e.g. test existed abnomarlly),
do_setup() will always failed and it will never go to do_cleanup().
So delete user in do_setup if it exists before create it.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/fs/acls/acl_test01 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index c91eb5686..9d8247630 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -111,6 +111,7 @@ do_setup()
 		setenforce 0
 	fi
 
+	userdel $TEST_USER1 > /dev/null 2>&1
 	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "Could not add test user $TEST_USER1."
-- 
2.14.1

