Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RkSQV-0006Pe-UW
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:31:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RkSQU-0003cu-LC
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:31:07 +0000
Date: Tue, 10 Jan 2012 11:30:52 +0800
From: Eryu Guan <eguan@redhat.com>
Message-ID: <20120110033052.GE27172@eguan-t400.redhat.com>
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
	<1326164470-16612-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326164470-16612-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v2] syscalls/xattr: fix compile when xattr.h not
 exist
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

On Tue, Jan 10, 2012 at 11:01:10AM +0800, Caspar Zhang wrote:
> 
> if <attr/xattr.h> doesn't exist, compliation will fail. Fix it in
> autotools level.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

Thanks.
> ---
>  configure.ac                                    |    1 +
>  testcases/kernel/syscalls/getxattr/getxattr01.c |   16 +++++++++++++---
>  testcases/kernel/syscalls/getxattr/getxattr02.c |   17 +++++++++++++----
>  testcases/kernel/syscalls/setxattr/setxattr01.c |   16 +++++++++++++---
>  testcases/kernel/syscalls/setxattr/setxattr02.c |   17 +++++++++++++----
>  5 files changed, 53 insertions(+), 14 deletions(-)
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
> index 8db6743..de4824c 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr01.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
> @@ -35,19 +35,24 @@
>   * 4. Verify the attribute got by getxattr(2) is same as the value we set
>   */
>  
> +#include "config.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "getxattr01";
> +
> +#ifdef HAVE_ATTR_XATTR_H
>  #define XATTR_TEST_KEY "user.testkey"
>  #define XATTR_TEST_VALUE "this is a test value"
>  #define XATTR_TEST_VALUE_SIZE 20
> @@ -56,7 +61,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "getxattr01";
>  char filename[BUFSIZ];
>  
>  struct test_case {
> @@ -171,3 +175,9 @@ static void cleanup(void)
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
> index 54d8949..503fcd0 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
> @@ -38,10 +38,10 @@
>   *    return -1 and set errno to ENODATA
>   */
>  
> +#include "config.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -49,10 +49,15 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "getxattr02";
> +
> +#ifdef HAVE_ATTR_XATTR_H
>  #define XATTR_TEST_KEY "user.testkey"
>  
>  #define FIFO "getxattr02fifo"
> @@ -63,8 +68,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "getxattr02";
> -
>  static char *tc[] = {
>  	FIFO,	/* case 00, get attr from fifo */
>  	CHR,	/* case 01, get attr from char special */
> @@ -150,3 +153,9 @@ static void cleanup(void)
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
> index fedb777..425fcf3 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr01.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
> @@ -43,10 +43,10 @@
>   *    setxattr(2) should succeed
>   */
>  
> +#include "config.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -54,10 +54,15 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "setxattr01";
> +
> +#ifdef HAVE_ATTR_XATTR_H
>  #define XATTR_NAME_MAX 255
>  #define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
>  #define XATTR_SIZE_MAX 65536
> @@ -68,7 +73,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "setxattr01";
>  char filename[BUFSIZ];
>  char long_key[XATTR_NAME_LEN];
>  char *long_value;
> @@ -221,3 +225,9 @@ static void cleanup(void)
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
> index f4ba566..465796c 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr02.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -42,10 +42,10 @@
>   *    return -1 and set errno to EPERM
>   */
>  
> +#include "config.h"
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include <attr/xattr.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -53,10 +53,15 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
>  #include "test.h"
>  #include "usctest.h"
>  
> +char *TCID = "setxattr02";
> +
> +#ifdef HAVE_ATTR_XATTR_H
>  #define XATTR_TEST_KEY "user.testkey"
>  #define XATTR_TEST_VALUE "this is a test value"
>  #define XATTR_TEST_VALUE_SIZE 20
> @@ -72,8 +77,6 @@
>  static void setup(void);
>  static void cleanup(void);
>  
> -char *TCID = "setxattr02";
> -
>  struct test_case {
>  	char *fname;
>  	char *key;
> @@ -233,3 +236,9 @@ static void cleanup(void)
>  	TEST_CLEANUP;
>  	tst_rmdir();
>  }
> +#else /* HAVE_ATTR_XATTR_H */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> +}
> +#endif

> ------------------------------------------------------------------------------
> Write once. Port to many.
> Get the SDK and tools to simplify cross-platform app development. Create 
> new or port existing apps to sell to consumers worldwide. Explore the 
> Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
> http://p.sf.net/sfu/intel-appdev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
