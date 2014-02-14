Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WEGPk-0002QU-1V
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 10:54:36 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WEGPi-0005XW-Ak
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 10:54:35 +0000
Date: Fri, 14 Feb 2014 05:54:26 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1615091378.3633979.1392375266510.JavaMail.zimbra@redhat.com>
In-Reply-To: <1392372746.2085.11.camel@G08JYZSD130126>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1392372746.2085.11.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] mlock/mlock02.c: add EPERM errno test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Friday, 14 February, 2014 11:12:26 AM
> Subject: [LTP] [PATCH 2/2] mlock/mlock02.c: add EPERM errno test
> 
> Add EPERM errno test for mlock(2).
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/mlock/mlock02.c | 42
>  +++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mlock/mlock02.c
> b/testcases/kernel/syscalls/mlock/mlock02.c
> index a635d24..1e87777 100644
> --- a/testcases/kernel/syscalls/mlock/mlock02.c
> +++ b/testcases/kernel/syscalls/mlock/mlock02.c
> @@ -20,11 +20,15 @@
>   * ALGORITHM
>   * 	test 1:
>   *		Call mlock with a NULL address.  ENOMEM should be returned

Hi,

ENOMEM (Linux 2.6.9 and later) the caller had a non-zero RLIMIT_MEMLOCK soft resource limit,
       but tried to lock more memory than the limit permitted.
ENOMEM Some of the specified address range does not correspond to mapped pages in
       the address space of the process.

We seem to be mixing these two together. Will test 1 return ENOMEM
because we passed NULL or because RLIMIT_MEMLOCK was low enough?
Consider this example:

$ cat a.c
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <sys/resource.h>
#include <stdio.h>

int main(void)
{
        char dummy[4096];
        struct rlimit rl;

        rl.rlim_cur = 1;
        rl.rlim_max = 1;

        if (mlock(NULL, 1024))
                perror("mlock(NULL, 1024)");

        if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0)
                perror("setrlimit");

        if (mlock(dummy, 1024))
                perror("mlock(dummy, 1024)");

        return 0;
}

$ ./a.out
mlock(NULL, 1024): Cannot allocate memory
mlock(dummy, 1024): Cannot allocate memory


> + *	test 2:
> + *		The  caller  was  not  privileged and its RLIMIT_MEMLOCK soft
> + *		resource limit was 0. EPERM should be returned
>   */
>  
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> +#include <pwd.h>
>  #include "test.h"
>  #include "usctest.h"
>  #include "safe_macros.h"
> @@ -32,20 +36,26 @@
>  char *TCID = "mlock02";
>  
>  static void *addr1;
> +static struct passwd *ltpuser;
>  static void setup(void);
>  static void mlock_verify(int);
> +static void setup2(void);
> +static void cleanup2(void);
>  static void cleanup(void);
>  
>  static struct test_case_t {
>  	void **addr;
>  	int len;
>  	int error;
> +	void (*setupfunc) ();
> +	void (*cleanupfunc) ();
>  } TC[] = {
> -	{&addr1, 1024, ENOMEM},
> +	{&addr1, 1024, ENOMEM, NULL, NULL},
> +	{&addr1, 1024, EPERM, setup2, cleanup2},
>  };
>  
>  int TST_TOTAL = ARRAY_SIZE(TC);
> -static int exp_enos[] = { ENOMEM, 0 };
> +static int exp_enos[] = { ENOMEM, EPERM, 0 };
>  
>  #if !defined(UCLINUX)
>  
> @@ -85,6 +95,8 @@ int main(void)
>  
>  static void setup(void)
>  {
> +	struct rlimit rl;
> +
>  	TEST_PAUSE;
>  
>  #ifdef __ia64__
> @@ -92,12 +104,28 @@ static void setup(void)
>  #else
>  	addr1 = NULL;
>  #endif
> +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
> +
> +	rl.rlim_cur = 0;

rlim_max is not initialised, so it can fail if you run mlock02 as user
and it has non-zero value:
setrlimit(RLIMIT_MEMLOCK, {rlim_cur=0, rlim_max=4216848}) = -1 EPERM (Operation not permitted)

Initialising it to zero:
    +rl.rlim_max = 0;
will make the testcase work for root, but it's failing for unprivileged user:

$ ./mlock02
mlock02     1  TFAIL  :  mlock didn't fail as expected; expected - 12 : Cannot allocate memory: TEST_ERRNO=EPERM(1): Operation not permitted
mlock02     2  TBROK  :  seteuid failed at mlock02.c:146: errno=EPERM(1): Operation not permitted
mlock02     3  TBROK  :  Remaining cases broken

Regards,
Jan

> +
> +	if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
> +		tst_resm(TWARN,
> +			 "setrlimit failed to set the resource for "
> +			 "RLIMIT_MEMLOCK to check for mlock()");
> +		return;
> +	}
>  }
>  
>  static void mlock_verify(int i)
>  {
> +	if (TC[i].setupfunc != NULL)
> +		TC[i].setupfunc();
> +
>  	TEST(mlock(*(TC[i].addr), TC[i].len));
>  
> +	if (TC[i].cleanupfunc != NULL)
> +		TC[i].cleanupfunc();
> +
>  	if (TEST_RETURN != -1) {
>  		tst_resm(TFAIL, "mlock succeeded unexpectedly");
>  		return;
> @@ -112,6 +140,16 @@ static void mlock_verify(int i)
>  	}
>  }
>  
> +static void setup2(void)
> +{
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> +}
> +
> +static void cleanup2(void)
> +{
> +	SAFE_SETEUID(cleanup, 0);
> +}
> +
>  static void cleanup(void)
>  {
>  	TEST_CLEANUP;
> --
> 1.8.4.2
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Android apps run on BlackBerry 10
> Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
> Now with support for Jelly Bean, Bluetooth, Mapview and more.
> Get your Android app in front of a whole new audience.  Start now.
> http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
