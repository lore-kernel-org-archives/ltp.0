Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RkCpR-0002kc-M5
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 10:51:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkCpM-0005sP-2x
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 10:51:49 +0000
Date: Mon, 9 Jan 2012 18:51:33 +0800
From: Eryu Guan <eguan@redhat.com>
Message-ID: <20120109105133.GB27172@eguan-t400.redhat.com>
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] syscalls/xattr: fix compile when xattr.h not exist
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, Jan 09, 2012 at 05:44:35PM +0800, Caspar Zhang wrote:
> 
> if <attr/xattr.h> doesn't exist, compliation will fail. Fix it in
> autotools level.

Tested on system without xattr.h and everything worked fine.

Thanks for fixing this!

Eryu Guan
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  configure.ac                                    |    1 +
>  testcases/kernel/syscalls/getxattr/getxattr01.c |   15 +++++++++++++--
>  testcases/kernel/syscalls/getxattr/getxattr02.c |   16 +++++++++++++---
>  testcases/kernel/syscalls/setxattr/setxattr01.c |   15 +++++++++++++--
>  testcases/kernel/syscalls/setxattr/setxattr02.c |   16 +++++++++++++---
>  5 files changed, 53 insertions(+), 10 deletions(-)
> 

> diff --git a/configure.ac b/configure.ac
> index 00d3720..6b3870a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -36,6 +36,7 @@ AC_CHECK_HEADERS([ \
>      libaio.h \
>      mm.h \
>      pthread.h \
> +    attr/xattr.h \
>      linux/genetlink.h \
>      linux/mempolicy.h \
>      linux/module.h \
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
> index 8db6743..c74ffc9 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr01.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
> @@ -37,7 +37,6 @@
>  
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -45,9 +44,16 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> +#include "config.h"
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "getxattr01";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +
> +#include <attr/xattr.h>
> +
>  #define XATTR_TEST_KEY "user.testkey"
>  #define XATTR_TEST_VALUE "this is a test value"
>  #define XATTR_TEST_VALUE_SIZE 20
> @@ -56,7 +62,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "getxattr01";
>  char filename[BUFSIZ];
>  
>  struct test_case {
> @@ -171,3 +176,9 @@ static void cleanup(void)
>  	TEST_CLEANUP;
>  	tst_rmdir();
>  }
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
> index 54d8949..52c5812 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
> @@ -41,7 +41,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -50,9 +49,16 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> +#include "config.h"
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "getxattr02";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +
> +#include <attr/xattr.h>
> +
>  #define XATTR_TEST_KEY "user.testkey"
>  
>  #define FIFO "getxattr02fifo"
> @@ -63,8 +69,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "getxattr02";
> -
>  static char *tc[] = {
>  	FIFO,	/* case 00, get attr from fifo */
>  	CHR,	/* case 01, get attr from char special */
> @@ -150,3 +154,9 @@ static void cleanup(void)
>  	TEST_CLEANUP;
>  	tst_rmdir();
>  }
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
> index fedb777..581e008 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr01.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
> @@ -46,7 +46,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -55,9 +54,16 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> +#include "config.h"
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "setxattr01";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +
> +#include <attr/xattr.h>
> +
>  #define XATTR_NAME_MAX 255
>  #define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
>  #define XATTR_SIZE_MAX 65536
> @@ -68,7 +74,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "setxattr01";
>  char filename[BUFSIZ];
>  char long_key[XATTR_NAME_LEN];
>  char *long_value;
> @@ -221,3 +226,9 @@ static void cleanup(void)
>  	TEST_CLEANUP;
>  	tst_rmdir();
>  }
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
> index f4ba566..6d36a0e 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr02.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -45,7 +45,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -54,9 +53,16 @@
>  #include <stdlib.h>
>  #include <string.h>
>  
> +#include "config.h"
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "setxattr02";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +
> +#include <attr/xattr.h>
> +
>  #define XATTR_TEST_KEY "user.testkey"
>  #define XATTR_TEST_VALUE "this is a test value"
>  #define XATTR_TEST_VALUE_SIZE 20
> @@ -72,8 +78,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "setxattr02";
> -
>  struct test_case {
>  	char *fname;
>  	char *key;
> @@ -233,3 +237,9 @@ static void cleanup(void)
>  	TEST_CLEANUP;
>  	tst_rmdir();
>  }
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
