Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vq5fF-00024k-Bg
	for ltp-list@lists.sourceforge.net; Mon, 09 Dec 2013 18:34:41 +0000
Date: Mon, 9 Dec 2013 19:34:05 +0100
From: chrubis@suse.cz
Message-ID: <20131209183405.GB21160@rei.suse.cz>
References: <1386057585.1559.11.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1386057585.1559.11.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] creat/creat06.c: add new errors test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
>  	TEST_EXP_ENOS(exp_enos);
> @@ -175,6 +204,21 @@ static void setup(void)
>  	SAFE_TOUCH(cleanup, "file1", MODE1, NULL);
>  
>  	SAFE_MKDIR(cleanup, "dir6", MODE2);
> +
> +	SAFE_SETEUID(cleanup, 0);
> +
> +	tst_mkfs(NULL, device, fstype, NULL);
> +	SAFE_MKDIR(cleanup, "mntpoint", MODE2);
> +	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +
> +	SAFE_SYMLINK(cleanup, TEST8_FILE, "test_file_eloop2");
> +	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST8_FILE);
> +
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);

You don't have to set the seteuid back and forth. You should be able to
create test temporary directory, then mount the image and then switch
the user id. The test temporary directory should be world writeable.

>  }
>  
>  #if !defined(UCLINUX)
> @@ -185,9 +229,26 @@ static void bad_addr_setup(int i)
>  }
>  #endif
>  
> +static void test8_setup(void)
> +{
> +	SAFE_SETEUID(cleanup, 0);
> +}

This breaks the execution on -i 2 (test 6 fails because UID is set to
0). You should either add test cleanup function that sets the effective
user id back to nobody after test8 is executed or move the EROFS into
separate test.


PS: Patch rebased to apply on my changes in the cleanup is attached.

-- 
Cyril Hrubis
chrubis@suse.cz

--KsGdsel6WgEHnImy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-creat-creat06.c-add-new-errors-test.patch"

From 02522b91b23459184fa094d5a0389bb4e3165c84 Mon Sep 17 00:00:00 2001
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Tue, 3 Dec 2013 15:59:45 +0800
Subject: [PATCH] creat/creat06.c: add new errors test

add ELOOP, EROFS in creat06.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat06.c | 67 +++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index f892200..5445653 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -26,6 +26,8 @@
  *	4.	ENOTDIR
  *	5.	EFAULT
  *	6.	EACCES
+ *	7.	EROFS
+ *	8.	ELOOP
  *
  *
  * ALGORITHM
@@ -41,6 +43,10 @@
  *		and test for EFAULT
  *	6.	Attempt to creat(2) a file in a directory with no
  *		execute permission and test for EACCES
+ *	7.	Attempt to creat(2) a file in a Read-only file system
+ *		and test for EROFS
+ *	8.	Attempt to creat(2) a file which links the other file that
+ *		links the former and test for ELOOP
  */
 
 #include <stdio.h>
@@ -51,6 +57,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <sys/mount.h>
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -59,17 +66,30 @@
 #define	NO_DIR		"testfile/testdir"
 #define	NOT_DIR		"file1/testdir"
 #define	TEST6_FILE	"dir6/file6"
+#define	TEST7_FILE	"mntpoint/tmp"
+#define	TEST8_FILE	"file8"
 
 #define	MODE1		0444
 #define	MODE2		0666
 
 static void setup(void);
 static void cleanup(void);
+static void test8_setup(void);
+static void help(void);
 #if !defined(UCLINUX)
 static void bad_addr_setup(int);
 #endif
 
 static char long_name[PATH_MAX+2];
+static char *fstype = "ext2";
+static char *device;
+static int dflag;
+static int mount_flag;
+static option_t options[] = {
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
+	{NULL, NULL, NULL}
+};
 static struct test_case_t {
 	char *fname;
 	int mode;
@@ -84,12 +104,14 @@ static struct test_case_t {
 	{NULL, MODE1, EFAULT, bad_addr_setup},
 #endif
 	{TEST6_FILE, MODE1, EACCES, NULL},
+	{TEST7_FILE, MODE1, EROFS, NULL},
+	{TEST8_FILE, MODE1, ELOOP, test8_setup},
 };
 
 char *TCID = "creat06";
 int TST_TOTAL = ARRAY_SIZE(TC);
-static int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR,
-			  EFAULT, EACCES, 0 };
+static int exp_enos[] = {EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR,
+			 EFAULT, EACCES, EROFS, ELOOP, 0};
 
 int main(int ac, char **av)
 {
@@ -97,9 +119,16 @@ int main(int ac, char **av)
 	char *msg;
 	int i;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, options, help);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
+	if (!dflag) {
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "-D option");
+	}
+
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
@@ -158,6 +187,21 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, "file1", MODE1, NULL);
 
 	SAFE_MKDIR(cleanup, "dir6", MODE2);
+
+	SAFE_SETEUID(cleanup, 0);
+
+	tst_mkfs(NULL, device, fstype, NULL);
+	SAFE_MKDIR(cleanup, "mntpoint", MODE2);
+	if (mount(device, "mntpoint", fstype, MS_RDONLY, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	SAFE_SYMLINK(cleanup, TEST8_FILE, "test_file_eloop2");
+	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST8_FILE);
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 }
 
 #if !defined(UCLINUX)
@@ -168,9 +212,26 @@ static void bad_addr_setup(int i)
 }
 #endif
 
+static void test8_setup(void)
+{
+	SAFE_SETEUID(cleanup, 0);
+}
+
 static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (mount_flag && umount("mntpoint") < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "umount device:%s failed", device);
+	}
+
 	tst_rmdir();
 }
+
+static void help(void)
+{
+	printf("-T type   : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
+}
-- 
1.8.3.2


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
--KsGdsel6WgEHnImy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--KsGdsel6WgEHnImy--

