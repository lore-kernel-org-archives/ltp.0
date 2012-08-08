Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Sz1bk-00089p-F9
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 08:27:12 +0000
Date: Wed, 8 Aug 2012 09:44:54 +0200
From: chrubis@suse.cz
Message-ID: <20120808074454.GB29383@saboteur.suse.cz>
References: <5019BB3E.4070500@mips.com>
	<20120803113838.GA6622@saboteur.suse.cz>
	<501C33DC.7070903@mips.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <501C33DC.7070903@mips.com>
Subject: Re: [LTP] Using LTP on Andriod - Current State, Latest Patch,
 and EMail address of folks involved with this effort.
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
To: Pete/Piet Delaney <piet@mips.com>
Cc: ltp-list@lists.sourceforge.net, Stericson.G1@gmail.com, "Dearman,  Chris" <chris@mips.com>, Pete Delaney <piet.delaney@gmail.com>, domschuermann@gmail.com

Hi!
> Yesterday we got the MIPS env starting to build the LTP test, currently
> we aren't
> using the Android.mk approach, just minor tweaks to the stock LTP repo. 
> I'm also
> building Busybox using:
> 
>    *http://code.google.com/p/busybox-android/downloads/detail?name=.config
> *
> as a guide. I've applied Sterisco's busybox patch but didn't apply his
> Bionic patch (yet). It's starting to build and like LPT it's starting to
> compile.

That seems to be way better than the Android.mk mess. And it would
certainly be great to have Android HOWTO document bundled with ltp
sources.

> Currently my changes to the git-hub LTP master branch are just a bunch
> of hacks. Seemed like a clear concept on how to do it cleanly wasn't
> clear yet
> and it made more sense to get something starting to work and then clean it
> up once a clear approach was precipitating out. I'm using the attached
> Setup
> script to use the r8 NDK crosstools and will test with a jellyBean (jb)
> MIPS emulator.

The patch seems to be relatively small. Is this all that is necessary to
build LTP on Android? Have build the open posix testsuite?

Looking at the patch itself. The ifdef 0 shouldn't be there, the
!defined(_ANDROID) is better. The FILTER_OUT_DIRS should be either
triggered by Android environment or the testcases should be fixed.

The GLIBC_PREREQ() in the accept4_01 should be moved to configure
script.

The GLIBC_PREREQ() from tst_tmpdir() is about to be removed. Hm and why
is that defined to 0? The uclibc implements mkdtemp() or not?

> Supporting Android in the LTP and Busybox repositories seems like a good
> idea to me. I see little sense in folks re-doing this procedure from email
> descriptions.

Well I can't do much for Busybox but I could help to fix LTP to build on
Android ;).

> diff --git a/include/tlibio.h b/include/tlibio.h
> index 0ac52e4..14ad640 100644
> --- a/include/tlibio.h
> +++ b/include/tlibio.h
> @@ -142,7 +142,7 @@ int  lio_check_asyncio(char *io_type, int size, struct iosw *status);
>  int  lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp);
>  int  lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method);
>  #endif /* sgi */
> -#if defined(__linux__) && !defined(__UCLIBC__)
> +#if defined(__linux__) && !defined(__UCLIBC__) && 0
>  #include <aio.h>
>  int  lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp);
>  int  lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method);
> diff --git a/lib/Makefile b/lib/Makefile
> index 453cf95..a0081d6 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -24,6 +24,8 @@ top_srcdir		?= ..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
> +CFLAGS			+=-D__UCLIBC__
> +
>  ifeq ($(UCLINUX),1)
>  CFLAGS			+= -D_USC_LIB_
>  endif
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index eaaaaa0..7bb507f 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -108,7 +108,7 @@
>  #include <string.h>  /* bzero */
>  #endif
>  #if defined(__linux__) || defined(__sun) || defined(__hpux) || defined(_AIX)
> -#if !defined(UCLINUX) && !defined(__UCLIBC__)
> +#if !defined(UCLINUX) && !defined(__UCLIBC__) && !defined(_ANDROID)
>  #include <aio.h>
>  #endif
>  #endif
> @@ -561,7 +561,7 @@ long wrd;	/* to allow future features, use zero for now */
>      aiocb_t *aiolist[1]; /* list of aio control blocks for lio_listio */
>      off64_t poffset;	/* pwrite(2) offset */
>  #endif
> -#if defined(__linux__) && !defined(__UCLIBC__)
> +#if defined(__linux__) && !defined(__UCLIBC__) && 0
>  	struct aiocb aiocbp;	/* POSIX aio control block */
>  	struct aiocb *aiolist[1]; /* list of aio control blocks for lio_listio */
>  	off64_t poffset;	/* pwrite(2) offset */
> @@ -595,7 +595,7 @@ long wrd;	/* to allow future features, use zero for now */
>      iov.iov_base = buffer;
>      iov.iov_len = size;
>  #endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> +#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__) && 0)
>  #if defined(sgi)
>      memset(&aiocbp, 0x00, sizeof(aiocb_t));
>  #else
> @@ -841,7 +841,7 @@ long wrd;	/* to allow future features, use zero for now */
>  	return ret;
>  
>  #endif
> -#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
> +#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__)) && 0
>  
>  	aiocbp.aio_lio_opcode = LIO_WRITE;
>  	listio_cmd=LIO_WAIT;
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index d112e3e..3e50eaf 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -132,7 +132,9 @@ void tst_tmpdir(void)
>  	int  no_cleanup = 0;	/* !0 means TDIRECTORY env var was set */
>  	char *env_tmpdir;	/* temporary storage for TMPDIR env var */
>  	/* This is an AWFUL hack to figure out if mkdtemp() is available */
> -#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2,2)
> +
> +// #if 0 && defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2,2)
> +#if 0 
>  #define HAVE_MKDTEMP
>  #endif
>  
> diff --git a/testcases/Makefile b/testcases/Makefile
> index 61993fe..fa3986a 100644
> --- a/testcases/Makefile
> +++ b/testcases/Makefile
> @@ -28,7 +28,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  # 1. kdump shouldn't be compiled by default, because it's runtime based and
>  #    WILL crash the build host (the tests need to be fixed to just build, not
>  #    run).
> -FILTER_OUT_DIRS		:= kdump
> +FILTER_OUT_DIRS		:= kdump commands
>  
>  ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
>  FILTER_OUT_DIRS		+= open_posix_testsuite
> diff --git a/testcases/commands/Makefile b/testcases/commands/Makefile
> index 9da27c3..ec85f8b 100644
> --- a/testcases/commands/Makefile
> +++ b/testcases/commands/Makefile
> @@ -24,7 +24,9 @@
>  top_srcdir		?= ../..
>  
>  ifneq ($(WITH_EXPECT),yes)
> -FILTER_OUT_SUBDIRS	:= tpm-tools
> +FILTER_OUT_SUBDIRS	:= tpm-tools cpio
> +else
> +FILTER_OUT_SUBDIRS      := cpio
>  endif
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
> diff --git a/testcases/kernel/syscalls/Makefile b/testcases/kernel/syscalls/Makefile
> index cee99e9..facf741 100644
> --- a/testcases/kernel/syscalls/Makefile
> +++ b/testcases/kernel/syscalls/Makefile
> @@ -29,4 +29,6 @@ FILTER_OUT_DIRS	+= capget capset chmod chown clone fork getcontext llseek \
>  		   nftw profil remap_file_pages
>  endif
>  
> +FILTER_OUT_DIRS += add_key adjtimex bdflush
> +
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
> index d3a39df..e270d39 100644
> --- a/testcases/kernel/syscalls/accept4/accept4_01.c
> +++ b/testcases/kernel/syscalls/accept4/accept4_01.c
> @@ -135,7 +135,8 @@ void setup()
>  	TEST_PAUSE;
>  	tst_tmpdir();
>  }
> -#if !(__GLIBC_PREREQ(2,10))
> +// #if !(__GLIBC_PREREQ(2,10))
> +#if 1
>  static int
>  accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
>  {
> @@ -192,7 +193,8 @@ do_test(int lfd, struct sockaddr_in *conn_addr,
>  		die("Connect Error");
>  
>  	addrlen = sizeof(struct sockaddr_in);
> -	#if !(__GLIBC_PREREQ(2,10))
> +//	#if !(__GLIBC_PREREQ(2,10))
> +	#if 1
>  	acceptfd = accept4_01(lfd, (struct sockaddr *)&claddr, &addrlen,
>                             closeonexec_flag | nonblock_flag);
>  	#else
> diff --git a/testcases/kernel/syscalls/chmod/Makefile b/testcases/kernel/syscalls/chmod/Makefile
> index bd617d8..f293025 100644
> --- a/testcases/kernel/syscalls/chmod/Makefile
> +++ b/testcases/kernel/syscalls/chmod/Makefile
> @@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> +FILTER_OUT_MAKE_TARGETS := chmod06
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/ptrace/Makefile b/testcases/kernel/syscalls/ptrace/Makefile
> index 078792b..486ab56 100644
> --- a/testcases/kernel/syscalls/ptrace/Makefile
> +++ b/testcases/kernel/syscalls/ptrace/Makefile
> @@ -44,6 +44,6 @@ include $(top_srcdir)/include/mk/testcases.mk
>  #  make: *** [testcases-all] Error 2
>  #
>  
> -FILTER_OUT_MAKE_TARGETS	:= ptrace06 simple_tracer
> +FILTER_OUT_MAKE_TARGETS	:= ptrace03 ptrace04 ptrace06 simple_tracer
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/utils/benchmark/ebizzy-0.3/Makefile b/utils/benchmark/ebizzy-0.3/Makefile
> index 41aadd4..b23ded6 100644
> --- a/utils/benchmark/ebizzy-0.3/Makefile
> +++ b/utils/benchmark/ebizzy-0.3/Makefile
> @@ -27,7 +27,7 @@ top_srcdir		?= ../../..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
> -LDLIBS			+= -lpthread
> +# LDLIBS			+= -lpthread
>  
>  WCPPFLAGS		+= -Wshadow
>  
> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
> index 7c2c2c1..7b87f42 100644
> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
> @@ -218,9 +218,10 @@ read_options(int argc, char *argv[])
>  			"\"never mmap\" option specified\n");
>  		usage();
>  	}
> -
> +#if 0
>  	if (never_mmap)
>  		mallopt(M_MMAP_MAX, 0);
> +#endif
>  
>  	if (chunk_size < record_size) {
>  		fprintf(stderr, "Chunk size %u smaller than record size %u\n",
> @@ -533,4 +534,4 @@ main(int argc, char *argv[])
>  	start_threads();
>  
>  	return 0;
> -}
> \ No newline at end of file
> +}

> export LTP_ROOT=`pwd`
> 
> export NDK_ROOT=/home/piet/src/dev-mips-jb/mozilla/android-ndk-r8
> 
> export MIPS_TOOL_CHAIN=${NDK_ROOT}/toolchains/mipsel-linux-android-4.4.3/prebuilt/linux-x86
> 
> # export MIPS_INCLUDES=${NDK_ROOT}/platforms/android-3/arch-mips/usr/include
> export MIPS_INCLUDES=${NDK_ROOT}/platforms/android-14/arch-mips/usr/include
> 
> export PATH=${MIPS_TOOL_CHAIN}/bin:$PATH
> 
> export ARCH=mips
> 
> export CROSS_COMPILE=mipsel-linux-android-
> 
> 
> export CC=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}gcc
> 
> export LD=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}ld
> 
> export AR=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}ar
> 
> export STRIP=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}strip
> 
> export RANLIB=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}ranlib
> 
> export CXX=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}c++
> 
> export AS=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}as
> 
> export GXX=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}g++
> 
> export GCC=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}gcc
> 
> export NM=${MIPS_TOOL_CHAIN}/bin/${CROSS_COMPILE}nm
> 
> export CPPFLAGS=-I${MIPS_INCLUDES}/
> 
> export CFLAGS='-nostdlib -DDEV_BSIZE=512'
> 
> # export WCFLAGS='-pedantic -std=c99'
> # export WCFLAGS='-pedantic'
> export WCFLAGS=''
> 
> # export LDFLAGS=-Wl,???entry=main,???no-undefined,-rpath-link=${MIPS_TOOL_CHAIN}/lib/-L${MIPS_TOOL_CHAIN}/lib/
> export LDFLAGS=-Wl,-rpath-link=${MIPS_TOOL_CHAIN}/lib/-L${MIPS_TOOL_CHAIN}/lib/
> 
> # export LIBS=-lc
> export LIBS=
> 
> 
> # ./configure --host=mipsel-linux-android  --target=emulator-5554 --build=x86_64-linux-gnu --prefix=${LTP_ROOT}/objdir
> ./configure --host=mipsel-linux            --target=emulator-5554 --build=x86_64-linux-gnu --prefix=${LTP_ROOT}/objdir


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
