From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Apr 2020 11:39:34 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200401083228.GA18685@dell5510>
References: <20200401083228.GA18685@dell5510>
Message-ID: <20200401093934.GA23773@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP compilation breaks with -fno-common (we don't use as the default).
> This is the default for GCC 10, is there a way to fix it or do we need to disable it?
> 
> Compilation on gcc-10 (or gcc-9 with CFLAGS="-fno-common":
> 
> gcc-9 -Werror=implicit-function-declaration -fno-common -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -W  -I../../include -I../../include -I../../include/old/   -L../../lib  tst_checkpoint_wait_timeout.c   -lltp -o tst_checkpoint_wait_timeout
> /usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: ../../lib/libltp.a(tst_test.o):ltp.git/lib/../include/tst_test.h:325: multiple definition of `TCID'; /tmp/cc49yYO6.o:ltp.git/lib/tests/tst_strsig.c:27: first defined here
> /usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: ../../lib/libltp.a(tst_sys_conf.o):ltp.git/lib/../include/tst_test.h:325: multiple definition of `TCID'; /tmp/cc49yYO6.o:ltp.git/lib/tests/tst_strsig.c:27: first defined here
> 
> It's somehow related to the "hack" in include/tst_test.h:
> 
> /*
>  * This is a hack to make the testcases link without defining TCID
>  */
> extern const char *TCID;

This is not the original line, the original line is without the extern.

Now this will not be easy to solve since the problem is:

* All old style test define TCID in the test source that also implements main()

* The test library uses that variable in various places

* The variable definition is in the tst_test.h so that all new test also
  define TCID

We cannot move that definition into tst_test.c beacuse that would mean
that old API test would end up with multiple definitions one in the
corresponding test and one in the new library library code.

Maybe we can add it with a weak linker attribute. What about this patch:

diff --git a/include/tst_test.h b/include/tst_test.h
index 259d87d60..352e2cd64 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -322,9 +322,7 @@ int main(int argc, char *argv[])
 
 #define TST_TEST_TCONF(message)                                 \
         static struct tst_test test = { .tconf_msg = message  } \
-/*
- * This is a hack to make the testcases link without defining TCID
- */
-const char *TCID;
+
+extern const char *TCID;
 
 #endif /* TST_TEST_H__ */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 73827d472..4ce8cc301 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -32,6 +32,11 @@
 #include "old_device.h"
 #include "old_tmpdir.h"
 
+/*
+ * Hack to get TCID defined in newlib tests
+ */
+const char *TCID __attribute__((weak));
+
 #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"



I guess that we can even drop the TCID extern definition from the tst_test.h
header if the weak attribute works fine.


-- 
Cyril Hrubis
chrubis@suse.cz
