From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 25 Oct 2015 13:16:18 +0100
Subject: [LTP] [PATCH] Fix mlockall tests unprivileged execution
Message-ID: <20151025121618.GA15376@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a small patch that fix mlockall(2) testcases when run as
an unprivileged user ... It adds some missing tst_require_root()
needed for later seteuid() calls.

Thanks.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit dd780251d77b41bea12de4948b8900badcf7aa3f
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sun Oct 25 13:08:00 2015 +0100

    mlockall/mlockall0[23]: Fix unprivileged behaviour
    
    Add missing tst_require_root() needed for seteuid().
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index db2516c..f1ec962 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -164,6 +164,8 @@ int main(int ac, char **av)
 void setup(void)
 {
 
+	tst_require_root();
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 29997c0..5bdbdd0 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -183,6 +183,8 @@ int main(int ac, char **av)
 void setup(void)
 {
 
+	tst_require_root();
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
