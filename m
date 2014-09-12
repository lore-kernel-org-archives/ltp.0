Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XSLHv-0006ol-51
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 07:28:59 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XSLHs-00048y-Ne
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 07:28:58 +0000
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 12 Sep 2014 01:28:51 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5824A3E4003D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Sep 2014 01:28:48 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id s8C7SmOe43122694
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Sep 2014 09:28:48 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id s8C7SmiM023348
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Sep 2014 01:28:48 -0600
Received: from localhost.localdomain ([9.115.120.242])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s8C7Sl9P023300
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Sep 2014 01:28:47 -0600
Date: Fri, 12 Sep 2014 15:28:45 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20140912072845.GA3585@localhost.localdomain>
References: <20140911022709.GA16027@localhost.localdomain>
	<5411B499.8020309@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5411B499.8020309@redhat.com>
Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
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

On Thu, Sep 11, 2014 at 04:41:29PM +0200, Jan Stancek wrote:
> Would you be willing to try attached patch, which moves the build
> of .so and a.out into Makefile? 
I have tested your patch but ldd cannot find the lib files:

% sudo ./ldd01 
  ASSERTION 1  
        lddfile1.obj.so => not found
        lddfile2.obj.so => not found
        lddfile3.obj.so => not found
        lddfile4.obj.so => not found
        lddfile5.obj.so => not found
ASSERTION #1 PASS
 ASSERTION 2  
        lddfile1.obj.so => not found
        lddfile2.obj.so => not found
        lddfile3.obj.so => not found
        lddfile4.obj.so => not found
        lddfile5.obj.so => not found
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
                ld64.so.1 (GLIBC_PRIVATE) => /lib64/ld64.so.1
                ld64.so.1 (GLIBC_2.3) => /lib64/ld64.so.1
ASSERTION #2 PASS
TEST PASSES

on the contray, with my patch lib files can be found:

% ./ldd01
  ASSERTION 1  
        /tmp/ldd01-9497/lddfile1.obj.so (0x00000fffad800000)
        /tmp/ldd01-9497/lddfile2.obj.so (0x00000fffad7e0000)
        /tmp/ldd01-9497/lddfile3.obj.so (0x00000fffad7c0000)
        /tmp/ldd01-9497/lddfile4.obj.so (0x00000fffad7a0000)
        /tmp/ldd01-9497/lddfile5.obj.so (0x00000fffad780000)
ASSERTION #1 PASS
 ASSERTION 2  
        /tmp/ldd01-9497/lddfile1.obj.so (0x00000fffb1d20000)
        /tmp/ldd01-9497/lddfile2.obj.so (0x00000fffb1d00000)
        /tmp/ldd01-9497/lddfile3.obj.so (0x00000fffb1ce0000)
        /tmp/ldd01-9497/lddfile4.obj.so (0x00000fffb1cc0000)
        /tmp/ldd01-9497/lddfile5.obj.so (0x00000fffb1ca0000)
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
        /tmp/ldd01-9497/lddfile1.obj.so:
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
        /tmp/ldd01-9497/lddfile2.obj.so:
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
        /tmp/ldd01-9497/lddfile3.obj.so:
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
        /tmp/ldd01-9497/lddfile4.obj.so:
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
        /tmp/ldd01-9497/lddfile5.obj.so:
                libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
                libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
                ld64.so.1 (GLIBC_PRIVATE) => /lib64/ld64.so.1
                ld64.so.1 (GLIBC_2.3) => /lib64/ld64.so.1
ASSERTION #2 PASS
TEST PASSES


> Or alternatively, can you describe
> the ppc system where this is failing, so I could try to reproduce
> it myself?
This is a power 6 system, which running a beta version rhel5.11. Without
my patch, it failed with those messages:

% ./ldd01
/usr/bin/ld: warning: powerpc:common64 architecture of input file `/testcases/ltp/testcases/commands/ade/ldd/lddfile1.obj' is incompatible with powerpc:common output
/usr/bin/ld: warning: powerpc:common64 architecture of input file `/testcases/ltp/testcases/commands/ade/ldd/lddfile2.obj' is incompatible with powerpc:common output
/usr/bin/ld: warning: powerpc:common64 architecture of input file `/testcases/ltp/testcases/commands/ade/ldd/lddfile3.obj' is incompatible with powerpc:common output
/usr/bin/ld: warning: powerpc:common64 architecture of input file `/testcases/ltp/testcases/commands/ade/ldd/lddfile4.obj' is incompatible with powerpc:common output
/usr/bin/ld: warning: powerpc:common64 architecture of input file `/testcases/ltp/testcases/commands/ade/ldd/lddfile5.obj' is incompatible with powerpc:common output
/usr/bin/ld: warning: powerpc:common64 architecture of input file `/testcases/ltp/testcases/commands/ade/ldd/main.obj' is incompatible with powerpc:common output
/testcases/ltp/testcases/commands/ade/ldd/main.obj: In function `main':
/home/hpt/ltp-full-20130503.64b/testcases/commands/ade/ldd/main.c:11: relocation truncated to fit: R_PPC64_REL24 against `file1'
/home/hpt/ltp-full-20130503.64b/testcases/commands/ade/ldd/main.c:12: relocation truncated to fit: R_PPC64_REL24 against `file2'
/home/hpt/ltp-full-20130503.64b/testcases/commands/ade/ldd/main.c:13: relocation truncated to fit: R_PPC64_REL24 against `file3'
/home/hpt/ltp-full-20130503.64b/testcases/commands/ade/ldd/main.c:14: relocation truncated to fit: R_PPC64_REL24 against `file4'
/home/hpt/ltp-full-20130503.64b/testcases/commands/ade/ldd/main.c:15: relocation truncated to fit: R_PPC64_REL24 against `file5'
/home/hpt/ltp-full-20130503.64b/testcases/commands/ade/ldd/main.c:16: relocation truncated to fit: R_PPC64_REL24 against `puts'
collect2: ld returned 1 exit status
  ASSERTION 1  
ldd: /tmp/ldd01-14133/a.out: No such file or directory
ASSERTION #1 FAIL

> >From 1ea966268e7a55f21d9254b62462d4adb40c7a0a Mon Sep 17 00:00:00 2001
> Message-Id: <1ea966268e7a55f21d9254b62462d4adb40c7a0a.1410445852.git.jstancek@redhat.com>
> From: Jan Stancek <jstancek@redhat.com>
> Date: Thu, 11 Sep 2014 14:57:37 +0200
> Subject: [PATCH] v1
> 
> ---
>  testcases/commands/ade/ldd/Makefile   |   13 +++++++++++--
>  testcases/commands/ade/ldd/ldd01      |   28 ++++------------------------
>  testcases/commands/ade/ldd/lddfile1.c |    2 +-
>  testcases/commands/ade/ldd/lddfile2.c |    2 +-
>  testcases/commands/ade/ldd/lddfile3.c |    2 +-
>  testcases/commands/ade/ldd/lddfile4.c |    2 +-
>  testcases/commands/ade/ldd/lddfile5.c |    2 +-
>  7 files changed, 20 insertions(+), 31 deletions(-)
> 
> diff --git a/testcases/commands/ade/ldd/Makefile b/testcases/commands/ade/ldd/Makefile
> index eae06cd..7119290 100644
> --- a/testcases/commands/ade/ldd/Makefile
> +++ b/testcases/commands/ade/ldd/Makefile
> @@ -28,9 +28,18 @@ CPPFLAGS		+= -fpic
> 
>  INSTALL_TARGETS		:= ldd01
> 
> -MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c))
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
> diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ldd/ldd01
> index c60d3ac..54188f7 100755
> --- a/testcases/commands/ade/ldd/ldd01
> +++ b/testcases/commands/ade/ldd/ldd01
> @@ -35,42 +35,22 @@ $trace_logic
>  CC=${CC:=gcc}
>  LDD=${LDD:=ldd}
>  TCdat=${TCdat:-`pwd`}
> -TCtmp=${TCtmp:-/tmp/ldd01-$$}
> 
>  do_cleanup()
>  {
> -	rm -rf $TCtmp
> +	:
>  }
> 
>  do_setup()
>  {
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
> +	:
>  }
> 
>  do_test()
>  {
>  	echo "  ASSERTION 1  "
> 
> -	$LDD $TCtmp/a.out | grep -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
> +	$LDD lddfile.out | grep -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
>  	if [ $? -eq 0 ]; then
>  		echo "ASSERTION #1 PASS"
>  	else
> @@ -81,7 +61,7 @@ do_test()
> 
>  	echo " ASSERTION 2  "
> 
> -	$LDD -v $TCtmp/a.out | grep -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
> +	$LDD -v lddfile.out | grep -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
>  	if [ $? -eq 0 ]; then
>  		echo "ASSERTION #2 PASS"
>  	else
> diff --git a/testcases/commands/ade/ldd/lddfile1.c b/testcases/commands/ade/ldd/lddfile1.c
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
> diff --git a/testcases/commands/ade/ldd/lddfile2.c b/testcases/commands/ade/ldd/lddfile2.c
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
> diff --git a/testcases/commands/ade/ldd/lddfile3.c b/testcases/commands/ade/ldd/lddfile3.c
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
> diff --git a/testcases/commands/ade/ldd/lddfile4.c b/testcases/commands/ade/ldd/lddfile4.c
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
> diff --git a/testcases/commands/ade/ldd/lddfile5.c b/testcases/commands/ade/ldd/lddfile5.c
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
> -- 
> 1.7.1
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
