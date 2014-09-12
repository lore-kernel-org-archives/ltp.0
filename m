Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XSNEh-0000F2-2I
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 09:33:47 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XSNEe-00083U-S9
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 09:33:47 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s8C9Xcj8003046
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Sep 2014 05:33:38 -0400
Date: Fri, 12 Sep 2014 05:33:38 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <135933154.22109342.1410514418669.JavaMail.zimbra@redhat.com>
In-Reply-To: <79378c28685642da5fa56683fc1385eca55d1328.1410513010.git.jstancek@redhat.com>
References: <79378c28685642da5fa56683fc1385eca55d1328.1410513010.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ldd01: remove all -m32/-m64 logic
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
To: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 12 September, 2014 11:14:56 AM
> Subject: [LTP] [PATCH] ldd01: remove all -m32/-m64 logic
> 
> and build all binaries with same CFLAGS as rest of LTP build.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/commands/ade/ldd/Makefile   |   13 ++++++++-
>  testcases/commands/ade/ldd/ldd01      |   42
>  +++-----------------------------
>  testcases/commands/ade/ldd/lddfile1.c |    2 +-
>  testcases/commands/ade/ldd/lddfile2.c |    2 +-
>  testcases/commands/ade/ldd/lddfile3.c |    2 +-
>  testcases/commands/ade/ldd/lddfile4.c |    2 +-
>  testcases/commands/ade/ldd/lddfile5.c |    2 +-
>  testcases/commands/ade/ldd/main.c     |   12 ++++----
>  8 files changed, 26 insertions(+), 51 deletions(-)

This is proposed as alternative to:
  [PATCH] ldd01: using 'ppc' to check powerpc arch
  http://article.gmane.org/gmane.linux.ltp/21545

> 
> diff --git a/testcases/commands/ade/ldd/Makefile
> b/testcases/commands/ade/ldd/Makefile
> index eae06cd..7119290 100644
> --- a/testcases/commands/ade/ldd/Makefile
> +++ b/testcases/commands/ade/ldd/Makefile
> @@ -28,9 +28,18 @@ CPPFLAGS		+= -fpic
>  
>  INSTALL_TARGETS		:= ldd01
>  
> -MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard
> $(abs_srcdir)/*.c))
> +LDD_C_FILES		:= $(wildcard $(abs_srcdir)/lddfile*.c)
> +LDD_SO_FILES		:= $(patsubst $(abs_srcdir)/%.c,%.obj.so,$(LDD_C_FILES))
> +MAKE_TARGETS		:= $(LDD_SO_FILES) lddfile.out
> +CLEAN_TARGETS		+= *.obj
>  
> -$(MAKE_TARGETS): %.obj: %.o
> +%.obj: %.o
>  	mv $^ $@
>  
> +%.obj.so: %.obj
> +	$(CC) $(CFLAGS) -shared -o $@ $^
> +
> +lddfile.out: main.obj $(LDD_SO_FILES)
> +	$(CC) $(CFLAGS) -O -o $@ $(LDD_SO_FILES) main.obj
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/commands/ade/ldd/ldd01
> b/testcases/commands/ade/ldd/ldd01
> index c60d3ac..de91eee 100755
> --- a/testcases/commands/ade/ldd/ldd01
> +++ b/testcases/commands/ade/ldd/ldd01
> @@ -35,64 +35,30 @@ $trace_logic
>  CC=${CC:=gcc}
>  LDD=${LDD:=ldd}
>  TCdat=${TCdat:-`pwd`}
> -TCtmp=${TCtmp:-/tmp/ldd01-$$}
> -
> -do_cleanup()
> -{
> -	rm -rf $TCtmp
> -}
> -
> -do_setup()
> -{
> -	mkdir $TCtmp
> -
> -	# Check for ppc64 architecture or x86_64 architecture
> -	if uname -a | grep -iq powerpc; then
> -		file lddfile1.obj | grep 64-bit >/dev/null 2>&1
> -		if [ $? -eq 0 ]; then
> -			CFLAGS="-m64"
> -		fi
> -	elif uname -a | grep -iq x86_64; then
> -		file lddfile1.obj | grep 32-bit >/dev/null 2>&1
> -		if [ $? -eq 0 ]; then
> -			CFLAGS="-m32"
> -		fi
> -	fi
> -	$CC $CFLAGS -shared -o $TCtmp/lddfile1.obj.so $TCdat/lddfile1.obj
> -	$CC $CFLAGS -shared -o $TCtmp/lddfile2.obj.so $TCdat/lddfile2.obj
> -	$CC $CFLAGS -shared -o $TCtmp/lddfile3.obj.so $TCdat/lddfile3.obj
> -	$CC $CFLAGS -shared -o $TCtmp/lddfile4.obj.so $TCdat/lddfile4.obj
> -	$CC $CFLAGS -shared -o $TCtmp/lddfile5.obj.so $TCdat/lddfile5.obj
> -	$CC $CFLAGS -O -o $TCtmp/a.out $TCtmp/lddfile*.obj.so $TCdat/main.obj
> -}
>  
>  do_test()
>  {
> -	echo "  ASSERTION 1  "
> +	export LD_LIBRARY_PATH=.:$LTPROOT/testcases/bin/:$LD_LIBRARY_PATH
>  
> -	$LDD $TCtmp/a.out | grep -E
> "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
> +	echo "  ASSERTION 1  "
> +	$LDD lddfile.out | grep -E
> "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
>  	if [ $? -eq 0 ]; then
>  		echo "ASSERTION #1 PASS"
>  	else
>  		echo "ASSERTION #1 FAIL"
> -		do_cleanup
>  		return 1
>  	fi
>  
>  	echo " ASSERTION 2  "
> -
> -	$LDD -v $TCtmp/a.out | grep -E
> "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
> +	$LDD -v lddfile.out | grep -E
> "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
>  	if [ $? -eq 0 ]; then
>  		echo "ASSERTION #2 PASS"
>  	else
>  		echo "ASSERTION #2 FAIL"
> -		do_cleanup
>  		return 1
>  	fi
>  
>  	echo "TEST PASSES"
> -	do_cleanup
>  	return 0
>  }
> -do_setup
>  do_test
> diff --git a/testcases/commands/ade/ldd/lddfile1.c
> b/testcases/commands/ade/ldd/lddfile1.c
> index 377f7a3..ccb5786 100644
> --- a/testcases/commands/ade/ldd/lddfile1.c
> +++ b/testcases/commands/ade/ldd/lddfile1.c
> @@ -1,5 +1,5 @@
>  #include <stdio.h>
> -void file1()
> +void file1(void)
>  {
>  	printf("Control in function %s\n", __func__);
>  }
> diff --git a/testcases/commands/ade/ldd/lddfile2.c
> b/testcases/commands/ade/ldd/lddfile2.c
> index 5fd2b4b..20aede3 100644
> --- a/testcases/commands/ade/ldd/lddfile2.c
> +++ b/testcases/commands/ade/ldd/lddfile2.c
> @@ -1,5 +1,5 @@
>  #include <stdio.h>
> -void file2()
> +void file2(void)
>  {
>  	printf("Control in function %s\n", __func__);
>  }
> diff --git a/testcases/commands/ade/ldd/lddfile3.c
> b/testcases/commands/ade/ldd/lddfile3.c
> index d6b4cc9..a4529f7 100644
> --- a/testcases/commands/ade/ldd/lddfile3.c
> +++ b/testcases/commands/ade/ldd/lddfile3.c
> @@ -1,5 +1,5 @@
>  #include <stdio.h>
> -void file3()
> +void file3(void)
>  {
>  	printf("Control in function %s\n", __func__);
>  }
> diff --git a/testcases/commands/ade/ldd/lddfile4.c
> b/testcases/commands/ade/ldd/lddfile4.c
> index 1db89bb..9dc339d 100644
> --- a/testcases/commands/ade/ldd/lddfile4.c
> +++ b/testcases/commands/ade/ldd/lddfile4.c
> @@ -1,5 +1,5 @@
>  #include <stdio.h>
> -void file4()
> +void file4(void)
>  {
>  	printf("Control in function %s\n", __func__);
>  }
> diff --git a/testcases/commands/ade/ldd/lddfile5.c
> b/testcases/commands/ade/ldd/lddfile5.c
> index 2f46cdb..3fbb7f6 100644
> --- a/testcases/commands/ade/ldd/lddfile5.c
> +++ b/testcases/commands/ade/ldd/lddfile5.c
> @@ -1,5 +1,5 @@
>  #include <stdio.h>
> -void file5()
> +void file5(void)
>  {
>  	printf("Control in function %s\n", __func__);
>  }
> diff --git a/testcases/commands/ade/ldd/main.c
> b/testcases/commands/ade/ldd/main.c
> index 0f23b8b..69e278e 100644
> --- a/testcases/commands/ade/ldd/main.c
> +++ b/testcases/commands/ade/ldd/main.c
> @@ -1,12 +1,12 @@
>  #include <stdio.h>
>  
> -void file1();
> -void file2();
> -void file3();
> -void file4();
> -void file5();
> +void file1(void);
> +void file2(void);
> +void file3(void);
> +void file4(void);
> +void file5(void);
>  
> -int main()
> +int main(void)
>  {
>  	file1();
>  	file2();
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Want excitement?
> Manually upgrade your production database.
> When you want reliability, choose Perforce
> Perforce version control. Predictably reliable.
> http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
