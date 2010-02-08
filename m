Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1NeRPs-0005fR-Co
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 11:04:32 +0000
Received: from kuber.nabble.com ([216.139.236.158])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NeRPp-0000xv-Oy
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 11:04:32 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1NeRPk-00071V-Ds
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 03:04:24 -0800
Message-ID: <27498190.post@talk.nabble.com>
Date: Mon, 8 Feb 2010 03:04:24 -0800 (PST)
From: shachin <er_sachin@rediffmail.com>
In-Reply-To: <cc0b83a21002041616i7cf66f4apbfa1628c69d20dfe@mail.gmail.com>
MIME-Version: 1.0
References: <cc0b83a21002041616i7cf66f4apbfa1628c69d20dfe@mail.gmail.com>
Subject: Re: [LTP] Got warning message "FATAL: Test suite not installed
 correctly INFO: as root user type 'make ;
 make install'" on ltp-full-20100131 while running ./runltp even i have
 installed correctly
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


Hi shachin here,
Even i am unable to use  ltp-full-20100131 build i also got warning message
"FATAL: Test suite not installed correctly
INFO: as root user type 'make ; make install'
[root@mwg5 ltp-full-20100131]#' 
even i have installed it correctly.

[root@mwg5 ltp-full-20100131]# uname -a
Linux mwg5 2.6.27-19.mlos1-x86_64-smp #1 SMP Thu Jan 21 16:57:58 CET 2010
x86_64 x86_64 x86_64 GNU/Linux
[root@mwg5 ltp-full-20100131]# uname -r
2.6.27-19.mlos1-x86_64-smp
[root@mwg5 ltp-full-20100131]#

is anybody can help out on this?

thanks
shachin

 

Peter Lee-11 wrote:
> 
> Hi,
> 
> I got the following warning messages when running "./configure" on
> ltp-full-20100131. I ignored them at first and went on to "make all" and
> "make install". After that, when trying to run "./runalltests.sh", it says
> the test suite is not installed correctly and tells me to run "make ; make
> install" again.
> 
> I've been searching for a solution on the internet for weeks and did not
> find one. I've also tried to look at the config.log, but it is beyond my
> capability to understand what is wrong.
> 
> Any help would be greatly appreciated.
> 
> ------------------------------------------
> Kernel: 2.6.29.6 with the RTLinux patch applied
> OS: 64bit OpenSUSE
> 
> Warning message from ./configure:
> 
> configure: WARNING: linux/genetlink.h: present but cannot be compiled
> configure: WARNING: linux/genetlink.h:     check for missing prerequisite
> headers?
> configure: WARNING: linux/genetlink.h: see the Autoconf documentation
> configure: WARNING: linux/genetlink.h:     section "Present But Cannot Be
> Compiled"
> configure: WARNING: linux/genetlink.h: proceeding with the compiler's
> result
> configure: WARNING:     ##
> ------------------------------------------------
> ##
> configure: WARNING:     ## Report this to
> ltp-results@lists.sourceforge.net##
> configure: WARNING:     ##
> ------------------------------------------------
> ##
> 
> configure: WARNING: linux/netlink.h: present but cannot be compiled
> configure: WARNING: linux/netlink.h:     check for missing prerequisite
> headers?
> configure: WARNING: linux/netlink.h: see the Autoconf documentation
> configure: WARNING: linux/netlink.h:     section "Present But Cannot Be
> Compiled"
> configure: WARNING: linux/netlink.h: proceeding with the compiler's result
> configure: WARNING:     ##
> ------------------------------------------------
> ##
> configure: WARNING:     ## Report this to
> ltp-results@lists.sourceforge.net##
> configure: WARNING:     ##
> ------------------------------------------------
> ##
> 
> Related thread?:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08685.html
> 
> config.log and configure.ac are attached.
> ------------------------------------------
> 
> Thanks,
> Peter Lee
> 
> This file contains any messages produced by compilers while
> running configure, to aid debugging if configure makes a mistake.
> 
> It was created by ltp configure LTP_VERSION, which was
> generated by GNU Autoconf 2.64.  Invocation command line was
> 
>   $ ./configure 
> 
> ## --------- ##
> ## Platform. ##
> ## --------- ##
> 
> hostname = linux-qelv
> uname -m = x86_64
> uname -r = 2.6.29.6-rt24-0.1-desktop
> uname -s = Linux
> uname -v = #1 SMP PREEMPT RT Fri Jan 22 18:26:36 CST 2010
> 
> /usr/bin/uname -p = unknown
> /bin/uname -X     = unknown
> 
> /bin/arch              = x86_64
> /usr/bin/arch -k       = unknown
> /usr/convex/getsysinfo = unknown
> /usr/bin/hostinfo      = unknown
> /bin/machine           = unknown
> /usr/bin/oslevel       = unknown
> /bin/universe          = unknown
> 
> PATH: /home/lims/bin
> PATH: /usr/local/bin
> PATH: /usr/bin
> PATH: /sbin
> PATH: /usr/sbin
> PATH: /bin
> PATH: /usr/bin/X11
> PATH: /usr/X11R6/bin
> PATH: /usr/games
> PATH: /usr/lib64/jvm/jre/bin
> PATH: /usr/lib/mit/bin
> PATH: /usr/lib/mit/sbin
> 
> 
> ## ----------- ##
> ## Core tests. ##
> ## ----------- ##
> 
> configure:2333: checking for a BSD-compatible install
> configure:2401: result: /usr/bin/install -c
> configure:2412: checking whether build environment is sane
> configure:2449: result: yes
> configure:2474: checking for a thread-safe mkdir -p
> configure:2513: result: /bin/mkdir -p
> configure:2526: checking for gawk
> configure:2542: found /usr/bin/gawk
> configure:2553: result: gawk
> configure:2564: checking whether make sets $(MAKE)
> configure:2586: result: yes
> configure:2786: checking build system type
> configure:2800: result: x86_64-unknown-linux-gnu
> configure:2820: checking host system type
> configure:2833: result: x86_64-unknown-linux-gnu
> configure:2902: checking for gcc
> configure:2918: found /usr/bin/gcc
> configure:2929: result: gcc
> configure:3158: checking for C compiler version
> configure:3167: gcc --version >&5
> gcc (SUSE Linux) 4.4.1 [gcc-4_4-branch revision 150839]
> Copyright (C) 2009 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> 
> configure:3178: $? = 0
> configure:3167: gcc -v >&5
> Using built-in specs.
> Target: x86_64-suse-linux
> Configured with: ../configure --prefix=/usr --infodir=/usr/share/info
> --mandir=/usr/share/man --libdir=/usr/lib64 --libexecdir=/usr/lib64
> --enable-languages=c,c++,objc,fortran,obj-c++,java,ada
> --enable-checking=release --with-gxx-include-dir=/usr/include/c++/4.4
> --enable-ssp --disable-libssp --with-bugurl=http://bugs.opensuse.org/
> --with-pkgversion='SUSE Linux' --disable-libgcj --disable-libmudflap
> --with-slibdir=/lib64 --with-system-zlib --enable-__cxa_atexit
> --enable-libstdcxx-allocator=new --disable-libstdcxx-pch
> --enable-version-specific-runtime-libs --program-suffix=-4.4
> --enable-linux-futex --without-system-libunwind --with-arch-32=i586
> --with-tune=generic --build=x86_64-suse-linux
> Thread model: posix
> gcc version 4.4.1 [gcc-4_4-branch revision 150839] (SUSE Linux) 
> configure:3178: $? = 0
> configure:3167: gcc -V >&5
> gcc: '-V' option must have argument
> configure:3178: $? = 1
> configure:3167: gcc -qversion >&5
> gcc: unrecognized option '-qversion'
> gcc: no input files
> configure:3178: $? = 1
> configure:3200: checking for C compiler default output file name
> configure:3222: gcc    conftest.c  >&5
> configure:3226: $? = 0
> configure:3263: result: a.out
> configure:3279: checking whether the C compiler works
> configure:3288: ./a.out
> configure:3292: $? = 0
> configure:3307: result: yes
> configure:3314: checking whether we are cross compiling
> configure:3316: result: no
> configure:3319: checking for suffix of executables
> configure:3326: gcc -o conftest    conftest.c  >&5
> configure:3330: $? = 0
> configure:3352: result: 
> configure:3358: checking for suffix of object files
> configure:3380: gcc -c   conftest.c >&5
> configure:3384: $? = 0
> configure:3405: result: o
> configure:3409: checking whether we are using the GNU C compiler
> configure:3428: gcc -c   conftest.c >&5
> configure:3428: $? = 0
> configure:3437: result: yes
> configure:3446: checking whether gcc accepts -g
> configure:3466: gcc -c -g  conftest.c >&5
> configure:3466: $? = 0
> configure:3507: result: yes
> configure:3524: checking for gcc option to accept ISO C89
> configure:3588: gcc  -c -g -O2  conftest.c >&5
> configure:3588: $? = 0
> configure:3601: result: none needed
> configure:3632: checking for style of include used by make
> configure:3660: result: GNU
> configure:3685: checking dependency style of gcc
> configure:3776: result: none
> configure:3837: checking for ar
> configure:3853: found /usr/bin/ar
> configure:3864: result: ar
> configure:3891: checking for flex
> configure:3907: found /usr/bin/flex
> configure:3918: result: flex
> configure:3955: flex conftest.l
> configure:3959: $? = 0
> configure:3961: checking lex output file root
> configure:3975: result: lex.yy
> configure:3980: checking lex library
> configure:3994: gcc -o conftest -g -O2   conftest.c   >&5
> /tmp/ccIimiDV.o: In function `input':
> /home/lims/Download/ltp-full-20100131/lex.yy.c:1168: undefined reference
> to `yywrap'
> /tmp/ccIimiDV.o: In function `yylex':
> /home/lims/Download/ltp-full-20100131/lex.yy.c:867: undefined reference to
> `yywrap'
> /tmp/ccIimiDV.o: In function `main':
> /home/lims/Download/ltp-full-20100131/conftest.l:17: undefined reference
> to `yywrap'
> collect2: ld returned 1 exit status
> configure:3994: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | /* end confdefs.h.  */
> | 
> | #line 3 "lex.yy.c"
> | 
> | #define  YY_INT_ALIGNED short int
> | 
> | /* A lexical scanner generated by flex */
> | 
> | #define FLEX_SCANNER
> | #define YY_FLEX_MAJOR_VERSION 2
> | #define YY_FLEX_MINOR_VERSION 5
> | #define YY_FLEX_SUBMINOR_VERSION 35
> | #if YY_FLEX_SUBMINOR_VERSION > 0
> | #define FLEX_BETA
> | #endif
> | 
> | /* First, we deal with  platform-specific or compiler-specific issues.
> */
> | 
> | /* begin standard C headers. */
> | #include <stdio.h>
> | #include <string.h>
> | #include <errno.h>
> | #include <stdlib.h>
> | 
> | /* end standard C headers. */
> | 
> | /* flex integer type definitions */
> | 
> | #ifndef FLEXINT_H
> | #define FLEXINT_H
> | 
> | /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
> | 
> | #if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
> | 
> | /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
> |  * if you want the limit (max/min) macros for int types. 
> |  */
> | #ifndef __STDC_LIMIT_MACROS
> | #define __STDC_LIMIT_MACROS 1
> | #endif
> | 
> | #include <inttypes.h>
> | typedef int8_t flex_int8_t;
> | typedef uint8_t flex_uint8_t;
> | typedef int16_t flex_int16_t;
> | typedef uint16_t flex_uint16_t;
> | typedef int32_t flex_int32_t;
> | typedef uint32_t flex_uint32_t;
> | #else
> | typedef signed char flex_int8_t;
> | typedef short int flex_int16_t;
> | typedef int flex_int32_t;
> | typedef unsigned char flex_uint8_t; 
> | typedef unsigned short int flex_uint16_t;
> | typedef unsigned int flex_uint32_t;
> | #endif /* ! C99 */
> | 
> | /* Limits of integral types. */
> | #ifndef INT8_MIN
> | #define INT8_MIN               (-128)
> | #endif
> | #ifndef INT16_MIN
> | #define INT16_MIN              (-32767-1)
> | #endif
> | #ifndef INT32_MIN
> | #define INT32_MIN              (-2147483647-1)
> | #endif
> | #ifndef INT8_MAX
> | #define INT8_MAX               (127)
> | #endif
> | #ifndef INT16_MAX
> | #define INT16_MAX              (32767)
> | #endif
> | #ifndef INT32_MAX
> | #define INT32_MAX              (2147483647)
> | #endif
> | #ifndef UINT8_MAX
> | #define UINT8_MAX              (255U)
> | #endif
> | #ifndef UINT16_MAX
> | #define UINT16_MAX             (65535U)
> | #endif
> | #ifndef UINT32_MAX
> | #define UINT32_MAX             (4294967295U)
> | #endif
> | 
> | #endif /* ! FLEXINT_H */
> | 
> | #ifdef __cplusplus
> | 
> | /* The "const" storage-class-modifier is valid. */
> | #define YY_USE_CONST
> | 
> | #else	/* ! __cplusplus */
> | 
> | /* C99 requires __STDC__ to be defined as 1. */
> | #if defined (__STDC__)
> | 
> | #define YY_USE_CONST
> | 
> | #endif	/* defined (__STDC__) */
> | #endif	/* ! __cplusplus */
> | 
> | #ifdef YY_USE_CONST
> | #define yyconst const
> | #else
> | #define yyconst
> | #endif
> | 
> | /* Returned upon end-of-file. */
> | #define YY_NULL 0
> | 
> | /* Promotes a possibly negative, possibly signed char to an unsigned
> |  * integer for use as an array index.  If the signed char is negative,
> |  * we want to instead treat it as an 8-bit unsigned char, hence the
> |  * double cast.
> |  */
> | #define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
> | 
> | /* Enter a start condition.  This macro really ought to take a
> parameter,
> |  * but we do it the disgusting crufty way forced on us by the ()-less
> |  * definition of BEGIN.
> |  */
> | #define BEGIN (yy_start) = 1 + 2 *
> | 
> | /* Translate the current start state into a value that can be later
> handed
> |  * to BEGIN to return to the state.  The YYSTATE alias is for lex
> |  * compatibility.
> |  */
> | #define YY_START (((yy_start) - 1) / 2)
> | #define YYSTATE YY_START
> | 
> | /* Action number for EOF rule of a given start state. */
> | #define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
> | 
> | /* Special action meaning "start processing a new file". */
> | #define YY_NEW_FILE yyrestart(yyin  )
> | 
> | #define YY_END_OF_BUFFER_CHAR 0
> | 
> | /* Size of default input buffer. */
> | #ifndef YY_BUF_SIZE
> | #define YY_BUF_SIZE 16384
> | #endif
> | 
> | /* The state buf must be large enough to hold one state per character in
> the main buffer.
> |  */
> | #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))
> | 
> | #ifndef YY_TYPEDEF_YY_BUFFER_STATE
> | #define YY_TYPEDEF_YY_BUFFER_STATE
> | typedef struct yy_buffer_state *YY_BUFFER_STATE;
> | #endif
> | 
> | extern int yyleng;
> | 
> | extern FILE *yyin, *yyout;
> | 
> | #define EOB_ACT_CONTINUE_SCAN 0
> | #define EOB_ACT_END_OF_FILE 1
> | #define EOB_ACT_LAST_MATCH 2
> | 
> |     #define YY_LESS_LINENO(n)
> |     
> | /* Return all but the first "n" matched characters back to the input
> stream. */
> | #define yyless(n) \
> | 	do \
> | 		{ \
> | 		/* Undo effects of setting up yytext. */ \
> |         int yyless_macro_arg = (n); \
> |         YY_LESS_LINENO(yyless_macro_arg);\
> | 		*yy_cp = (yy_hold_char); \
> | 		YY_RESTORE_YY_MORE_OFFSET \
> | 		(yy_c_buf_p) = yy_cp = yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
> | 		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
> | 		} \
> | 	while ( 0 )
> | 
> | #define unput(c) yyunput( c, (yytext_ptr)  )
> | 
> | #ifndef YY_TYPEDEF_YY_SIZE_T
> | #define YY_TYPEDEF_YY_SIZE_T
> | typedef size_t yy_size_t;
> | #endif
> | 
> | #ifndef YY_STRUCT_YY_BUFFER_STATE
> | #define YY_STRUCT_YY_BUFFER_STATE
> | struct yy_buffer_state
> | 	{
> | 	FILE *yy_input_file;
> | 
> | 	char *yy_ch_buf;		/* input buffer */
> | 	char *yy_buf_pos;		/* current position in input buffer */
> | 
> | 	/* Size of input buffer in bytes, not including room for EOB
> | 	 * characters.
> | 	 */
> | 	yy_size_t yy_buf_size;
> | 
> | 	/* Number of characters read into yy_ch_buf, not including EOB
> | 	 * characters.
> | 	 */
> | 	int yy_n_chars;
> | 
> | 	/* Whether we "own" the buffer - i.e., we know we created it,
> | 	 * and can realloc() it to grow it, and should free() it to
> | 	 * delete it.
> | 	 */
> | 	int yy_is_our_buffer;
> | 
> | 	/* Whether this is an "interactive" input source; if so, and
> | 	 * if we're using stdio for input, then we want to use getc()
> | 	 * instead of fread(), to make sure we stop fetching input after
> | 	 * each newline.
> | 	 */
> | 	int yy_is_interactive;
> | 
> | 	/* Whether we're considered to be at the beginning of a line.
> | 	 * If so, '^' rules will be active on the next match, otherwise
> | 	 * not.
> | 	 */
> | 	int yy_at_bol;
> | 
> |     int yy_bs_lineno; /**< The line count. */
> |     int yy_bs_column; /**< The column count. */
> |     
> | 	/* Whether to try to fill the input buffer when we reach the
> | 	 * end of it.
> | 	 */
> | 	int yy_fill_buffer;
> | 
> | 	int yy_buffer_status;
> | 
> | #define YY_BUFFER_NEW 0
> | #define YY_BUFFER_NORMAL 1
> | 	/* When an EOF's been seen but there's still some text to process
> | 	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
> | 	 * shouldn't try reading from the input source any more.  We might
> | 	 * still have a bunch of tokens to match, though, because of
> | 	 * possible backing-up.
> | 	 *
> | 	 * When we actually see the EOF, we change the status to "new"
> | 	 * (via yyrestart()), so that the user can continue scanning by
> | 	 * just pointing yyin at a new input file.
> | 	 */
> | #define YY_BUFFER_EOF_PENDING 2
> | 
> | 	};
> | #endif /* !YY_STRUCT_YY_BUFFER_STATE */
> | 
> | /* Stack of input buffers. */
> | static size_t yy_buffer_stack_top = 0; /**< index of top of stack. */
> | static size_t yy_buffer_stack_max = 0; /**< capacity of stack. */
> | static YY_BUFFER_STATE * yy_buffer_stack = 0; /**< Stack as an array. */
> | 
> | /* We provide macros for accessing buffer states in case in the
> |  * future we want to put the buffer states in a more general
> |  * "scanner state".
> |  *
> |  * Returns the top of the stack, or NULL.
> |  */
> | #define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
> |                           ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
> |                           : NULL)
> | 
> | /* Same as previous macro, but useful when we know that the buffer stack
> is not
> |  * NULL or when we need an lvalue. For internal use only.
> |  */
> | #define YY_CURRENT_BUFFER_LVALUE
> (yy_buffer_stack)[(yy_buffer_stack_top)]
> | 
> | /* yy_hold_char holds the character lost when yytext is formed. */
> | static char yy_hold_char;
> | static int yy_n_chars;		/* number of characters read into yy_ch_buf */
> | int yyleng;
> | 
> | /* Points to current character in buffer. */
> | static char *yy_c_buf_p = (char *) 0;
> | static int yy_init = 0;		/* whether we need to initialize */
> | static int yy_start = 0;	/* start state number */
> | 
> | /* Flag which is used to allow yywrap()'s to do buffer switches
> |  * instead of setting up a fresh yyin.  A bit of a hack ...
> |  */
> | static int yy_did_buffer_switch_on_eof;
> | 
> | void yyrestart (FILE *input_file  );
> | void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
> | YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
> | void yy_delete_buffer (YY_BUFFER_STATE b  );
> | void yy_flush_buffer (YY_BUFFER_STATE b  );
> | void yypush_buffer_state (YY_BUFFER_STATE new_buffer  );
> | void yypop_buffer_state (void );
> | 
> | static void yyensure_buffer_stack (void );
> | static void yy_load_buffer_state (void );
> | static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
> | 
> | #define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
> | 
> | YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
> | YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
> | YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
> | 
> | void *yyalloc (yy_size_t  );
> | void *yyrealloc (void *,yy_size_t  );
> | void yyfree (void *  );
> | 
> | #define yy_new_buffer yy_create_buffer
> | 
> | #define yy_set_interactive(is_interactive) \
> | 	{ \
> | 	if ( ! YY_CURRENT_BUFFER ){ \
> |         yyensure_buffer_stack (); \
> | 		YY_CURRENT_BUFFER_LVALUE =    \
> |             yy_create_buffer(yyin,YY_BUF_SIZE ); \
> | 	} \
> | 	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive = is_interactive; \
> | 	}
> | 
> | #define yy_set_bol(at_bol) \
> | 	{ \
> | 	if ( ! YY_CURRENT_BUFFER ){\
> |         yyensure_buffer_stack (); \
> | 		YY_CURRENT_BUFFER_LVALUE =    \
> |             yy_create_buffer(yyin,YY_BUF_SIZE ); \
> | 	} \
> | 	YY_CURRENT_BUFFER_LVALUE->yy_at_bol = at_bol; \
> | 	}
> | 
> | #define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
> | 
> | /* Begin user sect3 */
> | 
> | typedef unsigned char YY_CHAR;
> | 
> | FILE *yyin = (FILE *) 0, *yyout = (FILE *) 0;
> | 
> | typedef int yy_state_type;
> | 
> | extern int yylineno;
> | 
> | int yylineno = 1;
> | 
> | extern char *yytext;
> | #define yytext_ptr yytext
> | 
> | static yy_state_type yy_get_previous_state (void );
> | static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
> | static int yy_get_next_buffer (void );
> | static void yy_fatal_error (yyconst char msg[]  );
> | 
> | /* Done after the current pattern has been matched and before the
> |  * corresponding action - sets up yytext.
> |  */
> | #define YY_DO_BEFORE_ACTION \
> | 	(yytext_ptr) = yy_bp; \
> | 	(yytext_ptr) -= (yy_more_len); \
> | 	yyleng = (size_t) (yy_cp - (yytext_ptr)); \
> | 	(yy_hold_char) = *yy_cp; \
> | 	*yy_cp = '\0'; \
> | 	(yy_c_buf_p) = yy_cp;
> | 
> | #define YY_NUM_RULES 8
> | #define YY_END_OF_BUFFER 9
> | /* This struct is not used in this scanner,
> |    but its presence is necessary. */
> | struct yy_trans_info
> | 	{
> | 	flex_int32_t yy_verify;
> | 	flex_int32_t yy_nxt;
> | 	};
> | static yyconst flex_int16_t yy_acclist[23] =
> |     {   0,
> |         9,    7,    8,    8,    1,    7,    8,    2,    7,    8,
> |         3,    7,    8,    4,    7,    8,    5,    7,    8,    6,
> |         7,    8
> |     } ;
> | 
> | static yyconst flex_int16_t yy_accept[14] =
> |     {   0,
> |         1,    1,    1,    2,    4,    5,    8,   11,   14,   17,
> |        20,   23,   23
> |     } ;
> | 
> | static yyconst flex_int32_t yy_ec[256] =
> |     {   0,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    3,    4,    5,    6,
> | 
> |         7,    8,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> | 
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> |         1,    1,    1,    1,    1
> |     } ;
> | 
> | static yyconst flex_int32_t yy_meta[9] =
> |     {   0,
> |         1,    1,    1,    1,    1,    1,    1,    1
> |     } ;
> | 
> | static yyconst flex_int16_t yy_base[13] =
> |     {   0,
> |         0,    0,    9,   10,   10,   10,   10,   10,   10,   10,
> |        10,   10
> |     } ;
> | 
> | static yyconst flex_int16_t yy_def[13] =
> |     {   0,
> |        12,    1,   12,   12,   12,   12,   12,   12,   12,   12,
> |        12,    0
> |     } ;
> | 
> | static yyconst flex_int16_t yy_nxt[19] =
> |     {   0,
> |         4,    5,    6,    7,    8,    9,   10,   11,   12,    3,
> |        12,   12,   12,   12,   12,   12,   12,   12
> |     } ;
> | 
> | static yyconst flex_int16_t yy_chk[19] =
> |     {   0,
> |         1,    1,    1,    1,    1,    1,    1,    1,    3,   12,
> |        12,   12,   12,   12,   12,   12,   12,   12
> |     } ;
> | 
> | extern int yy_flex_debug;
> | int yy_flex_debug = 0;
> | 
> | static yy_state_type *yy_state_buf=0, *yy_state_ptr=0;
> | static char *yy_full_match;
> | static int yy_lp;
> | #define REJECT \
> | { \
> | *yy_cp = (yy_hold_char); /* undo effects of setting up yytext */ \
> | yy_cp = (yy_full_match); /* restore poss. backed-over text */ \
> | ++(yy_lp); \
> | goto find_rule; \
> | }
> | 
> | static int yy_more_flag = 0;
> | static int yy_more_len = 0;
> | #define yymore() ((yy_more_flag) = 1)
> | #define YY_MORE_ADJ (yy_more_len)
> | #define YY_RESTORE_YY_MORE_OFFSET
> | char *yytext;
> | #line 1 "conftest.l"
> | #line 468 "lex.yy.c"
> | 
> | #define INITIAL 0
> | 
> | #ifndef YY_NO_UNISTD_H
> | /* Special case for "unistd.h", since it is non-ANSI. We include it way
> |  * down here because we want the user's section 1 to have been scanned
> first.
> |  * The user has a chance to override it with an option.
> |  */
> | #include <unistd.h>
> | #endif
> | 
> | #ifndef YY_EXTRA_TYPE
> | #define YY_EXTRA_TYPE void *
> | #endif
> | 
> | static int yy_init_globals (void );
> | 
> | /* Accessor methods to globals.
> |    These are made visible to non-reentrant scanners for convenience. */
> | 
> | int yylex_destroy (void );
> | 
> | int yyget_debug (void );
> | 
> | void yyset_debug (int debug_flag  );
> | 
> | YY_EXTRA_TYPE yyget_extra (void );
> | 
> | void yyset_extra (YY_EXTRA_TYPE user_defined  );
> | 
> | FILE *yyget_in (void );
> | 
> | void yyset_in  (FILE * in_str  );
> | 
> | FILE *yyget_out (void );
> | 
> | void yyset_out  (FILE * out_str  );
> | 
> | int yyget_leng (void );
> | 
> | char *yyget_text (void );
> | 
> | int yyget_lineno (void );
> | 
> | void yyset_lineno (int line_number  );
> | 
> | /* Macros after this point can all be overridden by user definitions in
> |  * section 1.
> |  */
> | 
> | #ifndef YY_SKIP_YYWRAP
> | #ifdef __cplusplus
> | extern "C" int yywrap (void );
> | #else
> | extern int yywrap (void );
> | #endif
> | #endif
> | 
> |     static void yyunput (int c,char *buf_ptr  );
> |     
> | #ifndef yytext_ptr
> | static void yy_flex_strncpy (char *,yyconst char *,int );
> | #endif
> | 
> | #ifdef YY_NEED_STRLEN
> | static int yy_flex_strlen (yyconst char * );
> | #endif
> | 
> | #ifndef YY_NO_INPUT
> | 
> | #ifdef __cplusplus
> | static int yyinput (void );
> | #else
> | static int input (void );
> | #endif
> | 
> | #endif
> | 
> | /* Amount of stuff to slurp up with each read. */
> | #ifndef YY_READ_BUF_SIZE
> | #define YY_READ_BUF_SIZE 8192
> | #endif
> | 
> | /* Copy whatever the last rule matched to the standard output. */
> | #ifndef ECHO
> | /* This used to be an fputs(), but since the string might contain NUL's,
> |  * we now use fwrite().
> |  */
> | #define ECHO fwrite( yytext, yyleng, 1, yyout )
> | #endif
> | 
> | /* Gets input and stuffs it into "buf".  number of characters read, or
> YY_NULL,
> |  * is returned in "result".
> |  */
> | #ifndef YY_INPUT
> | #define YY_INPUT(buf,result,max_size) \
> | 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
> | 		{ \
> | 		int c = '*'; \
> | 		int n; \
> | 		for ( n = 0; n < max_size && \
> | 			     (c = getc( yyin )) != EOF && c != '\n'; ++n ) \
> | 			buf[n] = (char) c; \
> | 		if ( c == '\n' ) \
> | 			buf[n++] = (char) c; \
> | 		if ( c == EOF && ferror( yyin ) ) \
> | 			YY_FATAL_ERROR( "input in flex scanner failed" ); \
> | 		result = n; \
> | 		} \
> | 	else \
> | 		{ \
> | 		errno=0; \
> | 		while ( (result = fread(buf, 1, max_size, yyin))==0 && ferror(yyin)) \
> | 			{ \
> | 			if( errno != EINTR) \
> | 				{ \
> | 				YY_FATAL_ERROR( "input in flex scanner failed" ); \
> | 				break; \
> | 				} \
> | 			errno=0; \
> | 			clearerr(yyin); \
> | 			} \
> | 		}\
> | \
> | 
> | #endif
> | 
> | /* No semi-colon after return; correct usage is to write
> "yyterminate();" -
> |  * we don't want an extra ';' after the "return" because that will cause
> |  * some compilers to complain about unreachable statements.
> |  */
> | #ifndef yyterminate
> | #define yyterminate() return YY_NULL
> | #endif
> | 
> | /* Number of entries by which start-condition stack grows. */
> | #ifndef YY_START_STACK_INCR
> | #define YY_START_STACK_INCR 25
> | #endif
> | 
> | /* Report a fatal error. */
> | #ifndef YY_FATAL_ERROR
> | #define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
> | #endif
> | 
> | /* end tables serialization structures and prototypes */
> | 
> | /* Default declaration of generated scanner - a define so the user can
> |  * easily add parameters.
> |  */
> | #ifndef YY_DECL
> | #define YY_DECL_IS_OURS 1
> | 
> | extern int yylex (void);
> | 
> | #define YY_DECL int yylex (void)
> | #endif /* !YY_DECL */
> | 
> | /* Code executed at the beginning of each rule, after yytext and yyleng
> |  * have been set up.
> |  */
> | #ifndef YY_USER_ACTION
> | #define YY_USER_ACTION
> | #endif
> | 
> | /* Code executed at the end of each rule. */
> | #ifndef YY_BREAK
> | #define YY_BREAK break;
> | #endif
> | 
> | #define YY_RULE_SETUP \
> | 	YY_USER_ACTION
> | 
> | /** The main scanner function which does all the work.
> |  */
> | YY_DECL
> | {
> | 	register yy_state_type yy_current_state;
> | 	register char *yy_cp, *yy_bp;
> | 	register int yy_act;
> |     
> | #line 1 "conftest.l"
> | 
> | #line 652 "lex.yy.c"
> | 
> | 	if ( !(yy_init) )
> | 		{
> | 		(yy_init) = 1;
> | 
> | #ifdef YY_USER_INIT
> | 		YY_USER_INIT;
> | #endif
> | 
> |         /* Create the reject buffer large enough to save one state per
> allowed character. */
> |         if ( ! (yy_state_buf) )
> |             (yy_state_buf) = (yy_state_type *)yyalloc(YY_STATE_BUF_SIZE 
> );
> |             if ( ! (yy_state_buf) )
> |                 YY_FATAL_ERROR( "out of dynamic memory in yylex()" );
> | 
> | 		if ( ! (yy_start) )
> | 			(yy_start) = 1;	/* first start state */
> | 
> | 		if ( ! yyin )
> | 			yyin = stdin;
> | 
> | 		if ( ! yyout )
> | 			yyout = stdout;
> | 
> | 		if ( ! YY_CURRENT_BUFFER ) {
> | 			yyensure_buffer_stack ();
> | 			YY_CURRENT_BUFFER_LVALUE =
> | 				yy_create_buffer(yyin,YY_BUF_SIZE );
> | 		}
> | 
> | 		yy_load_buffer_state( );
> | 		}
> | 
> | 	while ( 1 )		/* loops until end-of-file is reached */
> | 		{
> | 		(yy_more_len) = 0;
> | 		if ( (yy_more_flag) )
> | 			{
> | 			(yy_more_len) = (yy_c_buf_p) - (yytext_ptr);
> | 			(yy_more_flag) = 0;
> | 			}
> | 		yy_cp = (yy_c_buf_p);
> | 
> | 		/* Support of yytext. */
> | 		*yy_cp = (yy_hold_char);
> | 
> | 		/* yy_bp points to the position in yy_ch_buf of the start of
> | 		 * the current run.
> | 		 */
> | 		yy_bp = yy_cp;
> | 
> | 		yy_current_state = (yy_start);
> | 
> | 		(yy_state_ptr) = (yy_state_buf);
> | 		*(yy_state_ptr)++ = yy_current_state;
> | 
> | yy_match:
> | 		do
> | 			{
> | 			register YY_CHAR yy_c = yy_ec[YY_SC_TO_UI(*yy_cp)];
> | 			while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state
> )
> | 				{
> | 				yy_current_state = (int) yy_def[yy_current_state];
> | 				if ( yy_current_state >= 13 )
> | 					yy_c = yy_meta[(unsigned int) yy_c];
> | 				}
> | 			yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int)
> yy_c];
> | 			*(yy_state_ptr)++ = yy_current_state;
> | 			++yy_cp;
> | 			}
> | 		while ( yy_base[yy_current_state] != 10 );
> | 
> | yy_find_action:
> | 		yy_current_state = *--(yy_state_ptr);
> | 		(yy_lp) = yy_accept[yy_current_state];
> | find_rule: /* we branch to this label when backing up */
> | 		for ( ; ; ) /* until we find what rule we matched */
> | 			{
> | 			if ( (yy_lp) && (yy_lp) < yy_accept[yy_current_state + 1] )
> | 				{
> | 				yy_act = yy_acclist[(yy_lp)];
> | 					{
> | 					(yy_full_match) = yy_cp;
> | 					break;
> | 					}
> | 				}
> | 			--yy_cp;
> | 			yy_current_state = *--(yy_state_ptr);
> | 			(yy_lp) = yy_accept[yy_current_state];
> | 			}
> | 
> | 		YY_DO_BEFORE_ACTION;
> | 
> | do_action:	/* This label is used only to access EOF actions. */
> | 
> | 		switch ( yy_act )
> | 	{ /* beginning of action switch */
> | case 1:
> | YY_RULE_SETUP
> | #line 2 "conftest.l"
> | { ECHO; }
> | 	YY_BREAK
> | case 2:
> | YY_RULE_SETUP
> | #line 3 "conftest.l"
> | { REJECT; }
> | 	YY_BREAK
> | case 3:
> | YY_RULE_SETUP
> | #line 4 "conftest.l"
> | { yymore (); }
> | 	YY_BREAK
> | case 4:
> | YY_RULE_SETUP
> | #line 5 "conftest.l"
> | { yyless (1); }
> | 	YY_BREAK
> | case 5:
> | YY_RULE_SETUP
> | #line 6 "conftest.l"
> | { yyless (input () != 0); }
> | 	YY_BREAK
> | case 6:
> | YY_RULE_SETUP
> | #line 7 "conftest.l"
> | { unput (yytext[0]); }
> | 	YY_BREAK
> | case 7:
> | YY_RULE_SETUP
> | #line 8 "conftest.l"
> | { BEGIN INITIAL; }
> | 	YY_BREAK
> | case 8:
> | YY_RULE_SETUP
> | #line 9 "conftest.l"
> | ECHO;
> | 	YY_BREAK
> | #line 790 "lex.yy.c"
> | 			case YY_STATE_EOF(INITIAL):
> | 				yyterminate();
> | 
> | 	case YY_END_OF_BUFFER:
> | 		{
> | 		/* Amount of text matched not including the EOB char. */
> | 		int yy_amount_of_matched_text = (int) (yy_cp - (yytext_ptr)) - 1;
> | 
> | 		/* Undo the effects of YY_DO_BEFORE_ACTION. */
> | 		*yy_cp = (yy_hold_char);
> | 		YY_RESTORE_YY_MORE_OFFSET
> | 
> | 		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_NEW )
> | 			{
> | 			/* We're scanning a new file or input source.  It's
> | 			 * possible that this happened because the user
> | 			 * just pointed yyin at a new source and called
> | 			 * yylex().  If so, then we have to assure
> | 			 * consistency between YY_CURRENT_BUFFER and our
> | 			 * globals.  Here is the right place to do so, because
> | 			 * this is the first action (other than possibly a
> | 			 * back-up) that will match for the new input source.
> | 			 */
> | 			(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
> | 			YY_CURRENT_BUFFER_LVALUE->yy_input_file = yyin;
> | 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status = YY_BUFFER_NORMAL;
> | 			}
> | 
> | 		/* Note that here we test for yy_c_buf_p "<=" to the position
> | 		 * of the first EOB in the buffer, since yy_c_buf_p will
> | 		 * already have been incremented past the NUL character
> | 		 * (since all states make transitions on EOB to the
> | 		 * end-of-buffer state).  Contrast this with the test
> | 		 * in input().
> | 		 */
> | 		if ( (yy_c_buf_p) <=
> &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
> | 			{ /* This was really a NUL. */
> | 			yy_state_type yy_next_state;
> | 
> | 			(yy_c_buf_p) = (yytext_ptr) + yy_amount_of_matched_text;
> | 
> | 			yy_current_state = yy_get_previous_state(  );
> | 
> | 			/* Okay, we're now positioned to make the NUL
> | 			 * transition.  We couldn't have
> | 			 * yy_get_previous_state() go ahead and do it
> | 			 * for us because it doesn't know how to deal
> | 			 * with the possibility of jamming (and we don't
> | 			 * want to build jamming into it because then it
> | 			 * will run more slowly).
> | 			 */
> | 
> | 			yy_next_state = yy_try_NUL_trans( yy_current_state );
> | 
> | 			yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> | 
> | 			if ( yy_next_state )
> | 				{
> | 				/* Consume the NUL. */
> | 				yy_cp = ++(yy_c_buf_p);
> | 				yy_current_state = yy_next_state;
> | 				goto yy_match;
> | 				}
> | 
> | 			else
> | 				{
> | 				yy_cp = (yy_c_buf_p);
> | 				goto yy_find_action;
> | 				}
> | 			}
> | 
> | 		else switch ( yy_get_next_buffer(  ) )
> | 			{
> | 			case EOB_ACT_END_OF_FILE:
> | 				{
> | 				(yy_did_buffer_switch_on_eof) = 0;
> | 
> | 				if ( yywrap( ) )
> | 					{
> | 					/* Note: because we've taken care in
> | 					 * yy_get_next_buffer() to have set up
> | 					 * yytext, we can now set up
> | 					 * yy_c_buf_p so that if some total
> | 					 * hoser (like flex itself) wants to
> | 					 * call the scanner after we return the
> | 					 * YY_NULL, it'll still work - another
> | 					 * YY_NULL will get returned.
> | 					 */
> | 					(yy_c_buf_p) = (yytext_ptr) + YY_MORE_ADJ;
> | 
> | 					yy_act = YY_STATE_EOF(YY_START);
> | 					goto do_action;
> | 					}
> | 
> | 				else
> | 					{
> | 					if ( ! (yy_did_buffer_switch_on_eof) )
> | 						YY_NEW_FILE;
> | 					}
> | 				break;
> | 				}
> | 
> | 			case EOB_ACT_CONTINUE_SCAN:
> | 				(yy_c_buf_p) =
> | 					(yytext_ptr) + yy_amount_of_matched_text;
> | 
> | 				yy_current_state = yy_get_previous_state(  );
> | 
> | 				yy_cp = (yy_c_buf_p);
> | 				yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> | 				goto yy_match;
> | 
> | 			case EOB_ACT_LAST_MATCH:
> | 				(yy_c_buf_p) =
> | 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
> | 
> | 				yy_current_state = yy_get_previous_state(  );
> | 
> | 				yy_cp = (yy_c_buf_p);
> | 				yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> | 				goto yy_find_action;
> | 			}
> | 		break;
> | 		}
> | 
> | 	default:
> | 		YY_FATAL_ERROR(
> | 			"fatal flex scanner internal error--no action found" );
> | 	} /* end of action switch */
> | 		} /* end of scanning one token */
> | } /* end of yylex */
> | 
> | /* yy_get_next_buffer - try to read in a new buffer
> |  *
> |  * Returns a code representing an action:
> |  *	EOB_ACT_LAST_MATCH -
> |  *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
> |  *	EOB_ACT_END_OF_FILE - end of file
> |  */
> | static int yy_get_next_buffer (void)
> | {
> |     	register char *dest = YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
> | 	register char *source = (yytext_ptr);
> | 	register int number_to_move, i;
> | 	int ret_val;
> | 
> | 	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) +
> 1] )
> | 		YY_FATAL_ERROR(
> | 		"fatal flex scanner internal error--end of buffer missed" );
> | 
> | 	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer == 0 )
> | 		{ /* Don't try to fill the buffer, so this is an EOF. */
> | 		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ == 1 )
> | 			{
> | 			/* We matched a single character, the EOB, so
> | 			 * treat this as a final EOF.
> | 			 */
> | 			return EOB_ACT_END_OF_FILE;
> | 			}
> | 
> | 		else
> | 			{
> | 			/* We matched some text prior to the EOB, first
> | 			 * process it.
> | 			 */
> | 			return EOB_ACT_LAST_MATCH;
> | 			}
> | 		}
> | 
> | 	/* Try to read more data. */
> | 
> | 	/* First move last chars to start of buffer. */
> | 	number_to_move = (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
> | 
> | 	for ( i = 0; i < number_to_move; ++i )
> | 		*(dest++) = *(source++);
> | 
> | 	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status ==
> YY_BUFFER_EOF_PENDING )
> | 		/* don't do the read, it's not guaranteed to return an EOF,
> | 		 * just force an EOF
> | 		 */
> | 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars) = 0;
> | 
> | 	else
> | 		{
> | 			int num_to_read =
> | 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
> | 
> | 		while ( num_to_read <= 0 )
> | 			{ /* Not enough room in the buffer - grow it. */
> | 
> | 			YY_FATAL_ERROR(
> | "input buffer overflow, can't enlarge buffer because scanner uses
> REJECT" );
> | 
> | 			}
> | 
> | 		if ( num_to_read > YY_READ_BUF_SIZE )
> | 			num_to_read = YY_READ_BUF_SIZE;
> | 
> | 		/* Read in more data. */
> | 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
> | 			(yy_n_chars), (size_t) num_to_read );
> | 
> | 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> | 		}
> | 
> | 	if ( (yy_n_chars) == 0 )
> | 		{
> | 		if ( number_to_move == YY_MORE_ADJ )
> | 			{
> | 			ret_val = EOB_ACT_END_OF_FILE;
> | 			yyrestart(yyin  );
> | 			}
> | 
> | 		else
> | 			{
> | 			ret_val = EOB_ACT_LAST_MATCH;
> | 			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =
> | 				YY_BUFFER_EOF_PENDING;
> | 			}
> | 		}
> | 
> | 	else
> | 		ret_val = EOB_ACT_CONTINUE_SCAN;
> | 
> | 	if ((yy_size_t) ((yy_n_chars) + number_to_move) >
> YY_CURRENT_BUFFER_LVALUE->yy_buf_size) {
> | 		/* Extend the array by 50%, plus the number we really need. */
> | 		yy_size_t new_size = (yy_n_chars) + number_to_move + ((yy_n_chars) >>
> 1);
> | 		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf = (char *) yyrealloc((void *)
> YY_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
> | 		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
> | 			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
> | 	}
> | 
> | 	(yy_n_chars) += number_to_move;
> | 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] =
> YY_END_OF_BUFFER_CHAR;
> | 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] =
> YY_END_OF_BUFFER_CHAR;
> | 
> | 	(yytext_ptr) = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
> | 
> | 	return ret_val;
> | }
> | 
> | /* yy_get_previous_state - get the state just before the EOB char was
> reached */
> | 
> |     static yy_state_type yy_get_previous_state (void)
> | {
> | 	register yy_state_type yy_current_state;
> | 	register char *yy_cp;
> |     
> | 	yy_current_state = (yy_start);
> | 
> | 	(yy_state_ptr) = (yy_state_buf);
> | 	*(yy_state_ptr)++ = yy_current_state;
> | 
> | 	for ( yy_cp = (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy_cp
> )
> | 		{
> | 		register YY_CHAR yy_c = (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
> | 		while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> | 			{
> | 			yy_current_state = (int) yy_def[yy_current_state];
> | 			if ( yy_current_state >= 13 )
> | 				yy_c = yy_meta[(unsigned int) yy_c];
> | 			}
> | 		yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int)
> yy_c];
> | 		*(yy_state_ptr)++ = yy_current_state;
> | 		}
> | 
> | 	return yy_current_state;
> | }
> | 
> | /* yy_try_NUL_trans - try to make a transition on the NUL character
> |  *
> |  * synopsis
> |  *	next_state = yy_try_NUL_trans( current_state );
> |  */
> |     static yy_state_type yy_try_NUL_trans  (yy_state_type
> yy_current_state )
> | {
> | 	register int yy_is_jam;
> |     
> | 	register YY_CHAR yy_c = 1;
> | 	while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> | 		{
> | 		yy_current_state = (int) yy_def[yy_current_state];
> | 		if ( yy_current_state >= 13 )
> | 			yy_c = yy_meta[(unsigned int) yy_c];
> | 		}
> | 	yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int)
> yy_c];
> | 	yy_is_jam = (yy_current_state == 12);
> | 	if ( ! yy_is_jam )
> | 		*(yy_state_ptr)++ = yy_current_state;
> | 
> | 	return yy_is_jam ? 0 : yy_current_state;
> | }
> | 
> |     static void yyunput (int c, register char * yy_bp )
> | {
> | 	register char *yy_cp;
> |     
> |     yy_cp = (yy_c_buf_p);
> | 
> | 	/* undo effects of setting up yytext */
> | 	*yy_cp = (yy_hold_char);
> | 
> | 	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
> | 		{ /* need to shift things up to make room */
> | 		/* +2 for EOB chars. */
> | 		register int number_to_move = (yy_n_chars) + 2;
> | 		register char *dest = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
> | 					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
> | 		register char *source =
> | 				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
> | 
> | 		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
> | 			*--dest = *--source;
> | 
> | 		yy_cp += (int) (dest - source);
> | 		yy_bp += (int) (dest - source);
> | 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =
> | 			(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
> | 
> | 		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
> | 			YY_FATAL_ERROR( "flex scanner push-back overflow" );
> | 		}
> | 
> | 	*--yy_cp = (char) c;
> | 
> | 	(yytext_ptr) = yy_bp;
> | 	(yy_hold_char) = *yy_cp;
> | 	(yy_c_buf_p) = yy_cp;
> | }
> | 
> | #ifndef YY_NO_INPUT
> | #ifdef __cplusplus
> |     static int yyinput (void)
> | #else
> |     static int input  (void)
> | #endif
> | 
> | {
> | 	int c;
> |     
> | 	*(yy_c_buf_p) = (yy_hold_char);
> | 
> | 	if ( *(yy_c_buf_p) == YY_END_OF_BUFFER_CHAR )
> | 		{
> | 		/* yy_c_buf_p now points to the character we want to return.
> | 		 * If this occurs *before* the EOB characters, then it's a
> | 		 * valid NUL; if not, then we've hit the end of the buffer.
> | 		 */
> | 		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)]
> )
> | 			/* This was really a NUL. */
> | 			*(yy_c_buf_p) = '\0';
> | 
> | 		else
> | 			{ /* need more input */
> | 			int offset = (yy_c_buf_p) - (yytext_ptr);
> | 			++(yy_c_buf_p);
> | 
> | 			switch ( yy_get_next_buffer(  ) )
> | 				{
> | 				case EOB_ACT_LAST_MATCH:
> | 					/* This happens because yy_g_n_b()
> | 					 * sees that we've accumulated a
> | 					 * token and flags that we need to
> | 					 * try matching the token before
> | 					 * proceeding.  But for input(),
> | 					 * there's no matching to consider.
> | 					 * So convert the EOB_ACT_LAST_MATCH
> | 					 * to EOB_ACT_END_OF_FILE.
> | 					 */
> | 
> | 					/* Reset buffer status. */
> | 					yyrestart(yyin );
> | 
> | 					/*FALLTHROUGH*/
> | 
> | 				case EOB_ACT_END_OF_FILE:
> | 					{
> | 					if ( yywrap( ) )
> | 						return EOF;
> | 
> | 					if ( ! (yy_did_buffer_switch_on_eof) )
> | 						YY_NEW_FILE;
> | #ifdef __cplusplus
> | 					return yyinput();
> | #else
> | 					return input();
> | #endif
> | 					}
> | 
> | 				case EOB_ACT_CONTINUE_SCAN:
> | 					(yy_c_buf_p) = (yytext_ptr) + offset;
> | 					break;
> | 				}
> | 			}
> | 		}
> | 
> | 	c = *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
> | 	*(yy_c_buf_p) = '\0';	/* preserve yytext */
> | 	(yy_hold_char) = *++(yy_c_buf_p);
> | 
> | 	return c;
> | }
> | #endif	/* ifndef YY_NO_INPUT */
> | 
> | /** Immediately switch to a different input stream.
> |  * @param input_file A readable stream.
> |  * 
> |  * @note This function does not reset the start condition to @c INITIAL
> .
> |  */
> |     void yyrestart  (FILE * input_file )
> | {
> |     
> | 	if ( ! YY_CURRENT_BUFFER ){
> |         yyensure_buffer_stack ();
> | 		YY_CURRENT_BUFFER_LVALUE =
> |             yy_create_buffer(yyin,YY_BUF_SIZE );
> | 	}
> | 
> | 	yy_init_buffer(YY_CURRENT_BUFFER,input_file );
> | 	yy_load_buffer_state( );
> | }
> | 
> | /** Switch to a different input buffer.
> |  * @param new_buffer The new input buffer.
> |  * 
> |  */
> |     void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
> | {
> |     
> | 	/* TODO. We should be able to replace this entire function body
> | 	 * with
> | 	 *		yypop_buffer_state();
> | 	 *		yypush_buffer_state(new_buffer);
> |      */
> | 	yyensure_buffer_stack ();
> | 	if ( YY_CURRENT_BUFFER == new_buffer )
> | 		return;
> | 
> | 	if ( YY_CURRENT_BUFFER )
> | 		{
> | 		/* Flush out information for old buffer. */
> | 		*(yy_c_buf_p) = (yy_hold_char);
> | 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
> | 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> | 		}
> | 
> | 	YY_CURRENT_BUFFER_LVALUE = new_buffer;
> | 	yy_load_buffer_state( );
> | 
> | 	/* We don't actually know whether we did this switch during
> | 	 * EOF (yywrap()) processing, but the only time this flag
> | 	 * is looked at is after yywrap() is called, so it's safe
> | 	 * to go ahead and always set it.
> | 	 */
> | 	(yy_did_buffer_switch_on_eof) = 1;
> | }
> | 
> | static void yy_load_buffer_state  (void)
> | {
> |     	(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
> | 	(yytext_ptr) = (yy_c_buf_p) = YY_CURRENT_BUFFER_LVALUE->yy_buf_pos;
> | 	yyin = YY_CURRENT_BUFFER_LVALUE->yy_input_file;
> | 	(yy_hold_char) = *(yy_c_buf_p);
> | }
> | 
> | /** Allocate and initialize an input buffer state.
> |  * @param file A readable stream.
> |  * @param size The character buffer size in bytes. When in doubt, use @c
> YY_BUF_SIZE.
> |  * 
> |  * @return the allocated buffer state.
> |  */
> |     YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
> | {
> | 	YY_BUFFER_STATE b;
> |     
> | 	b = (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
> | 	if ( ! b )
> | 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
> | 
> | 	b->yy_buf_size = size;
> | 
> | 	/* yy_ch_buf has to be 2 characters longer than the size given because
> | 	 * we need to put in 2 end-of-buffer characters.
> | 	 */
> | 	b->yy_ch_buf = (char *) yyalloc(b->yy_buf_size + 2  );
> | 	if ( ! b->yy_ch_buf )
> | 		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
> | 
> | 	b->yy_is_our_buffer = 1;
> | 
> | 	yy_init_buffer(b,file );
> | 
> | 	return b;
> | }
> | 
> | /** Destroy the buffer.
> |  * @param b a buffer created with yy_create_buffer()
> |  * 
> |  */
> |     void yy_delete_buffer (YY_BUFFER_STATE  b )
> | {
> |     
> | 	if ( ! b )
> | 		return;
> | 
> | 	if ( b == YY_CURRENT_BUFFER ) /* Not sure if we should pop here. */
> | 		YY_CURRENT_BUFFER_LVALUE = (YY_BUFFER_STATE) 0;
> | 
> | 	if ( b->yy_is_our_buffer )
> | 		yyfree((void *) b->yy_ch_buf  );
> | 
> | 	yyfree((void *) b  );
> | }
> | 
> | #ifndef __cplusplus
> | extern int isatty (int );
> | #endif /* __cplusplus */
> |     
> | /* Initializes or reinitializes a buffer.
> |  * This function is sometimes called more than once on the same buffer,
> |  * such as during a yyrestart() or at EOF.
> |  */
> |     static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
> | 
> | {
> | 	int oerrno = errno;
> |     
> | 	yy_flush_buffer(b );
> | 
> | 	b->yy_input_file = file;
> | 	b->yy_fill_buffer = 1;
> | 
> |     /* If b is the current buffer, then yy_init_buffer was _probably_
> |      * called from yyrestart() or through yy_get_next_buffer.
> |      * In that case, we don't want to reset the lineno or column.
> |      */
> |     if (b != YY_CURRENT_BUFFER){
> |         b->yy_bs_lineno = 1;
> |         b->yy_bs_column = 0;
> |     }
> | 
> |         b->yy_is_interactive = file ? (isatty( fileno(file) ) > 0) : 0;
> |     
> | 	errno = oerrno;
> | }
> | 
> | /** Discard all buffered characters. On the next scan, YY_INPUT will be
> called.
> |  * @param b the buffer state to be flushed, usually @c
> YY_CURRENT_BUFFER.
> |  * 
> |  */
> |     void yy_flush_buffer (YY_BUFFER_STATE  b )
> | {
> |     	if ( ! b )
> | 		return;
> | 
> | 	b->yy_n_chars = 0;
> | 
> | 	/* We always need two end-of-buffer characters.  The first causes
> | 	 * a transition to the end-of-buffer state.  The second causes
> | 	 * a jam in that state.
> | 	 */
> | 	b->yy_ch_buf[0] = YY_END_OF_BUFFER_CHAR;
> | 	b->yy_ch_buf[1] = YY_END_OF_BUFFER_CHAR;
> | 
> | 	b->yy_buf_pos = &b->yy_ch_buf[0];
> | 
> | 	b->yy_at_bol = 1;
> | 	b->yy_buffer_status = YY_BUFFER_NEW;
> | 
> | 	if ( b == YY_CURRENT_BUFFER )
> | 		yy_load_buffer_state( );
> | }
> | 
> | /** Pushes the new state onto the stack. The new state becomes
> |  *  the current state. This function will allocate the stack
> |  *  if necessary.
> |  *  @param new_buffer The new state.
> |  *  
> |  */
> | void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
> | {
> |     	if (new_buffer == NULL)
> | 		return;
> | 
> | 	yyensure_buffer_stack();
> | 
> | 	/* This block is copied from yy_switch_to_buffer. */
> | 	if ( YY_CURRENT_BUFFER )
> | 		{
> | 		/* Flush out information for old buffer. */
> | 		*(yy_c_buf_p) = (yy_hold_char);
> | 		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
> | 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> | 		}
> | 
> | 	/* Only push if top exists. Otherwise, replace top. */
> | 	if (YY_CURRENT_BUFFER)
> | 		(yy_buffer_stack_top)++;
> | 	YY_CURRENT_BUFFER_LVALUE = new_buffer;
> | 
> | 	/* copied from yy_switch_to_buffer. */
> | 	yy_load_buffer_state( );
> | 	(yy_did_buffer_switch_on_eof) = 1;
> | }
> | 
> | /** Removes and deletes the top of the stack, if present.
> |  *  The next element becomes the new top.
> |  *  
> |  */
> | void yypop_buffer_state (void)
> | {
> |     	if (!YY_CURRENT_BUFFER)
> | 		return;
> | 
> | 	yy_delete_buffer(YY_CURRENT_BUFFER );
> | 	YY_CURRENT_BUFFER_LVALUE = NULL;
> | 	if ((yy_buffer_stack_top) > 0)
> | 		--(yy_buffer_stack_top);
> | 
> | 	if (YY_CURRENT_BUFFER) {
> | 		yy_load_buffer_state( );
> | 		(yy_did_buffer_switch_on_eof) = 1;
> | 	}
> | }
> | 
> | /* Allocates the stack if it does not exist.
> |  *  Guarantees space for at least one push.
> |  */
> | static void yyensure_buffer_stack (void)
> | {
> | 	int num_to_alloc;
> |     
> | 	if (!(yy_buffer_stack)) {
> | 
> | 		/* First allocation is just for 2 elements, since we don't know if
> this
> | 		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
> | 		 * immediate realloc on the next call.
> |          */
> | 		num_to_alloc = 1;
> | 		(yy_buffer_stack) = (struct yy_buffer_state**)yyalloc
> | 								(num_to_alloc * sizeof(struct yy_buffer_state*)
> | 								);
> | 		if ( ! (yy_buffer_stack) )
> | 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
> | 								  
> | 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct
> yy_buffer_state*));
> | 				
> | 		(yy_buffer_stack_max) = num_to_alloc;
> | 		(yy_buffer_stack_top) = 0;
> | 		return;
> | 	}
> | 
> | 	if ((yy_buffer_stack_top) >= ((yy_buffer_stack_max)) - 1){
> | 
> | 		/* Increase the buffer to prepare for a possible push. */
> | 		int grow_size = 8 /* arbitrary grow size */;
> | 
> | 		num_to_alloc = (yy_buffer_stack_max) + grow_size;
> | 		(yy_buffer_stack) = (struct yy_buffer_state**)yyrealloc
> | 								((yy_buffer_stack),
> | 								num_to_alloc * sizeof(struct yy_buffer_state*)
> | 								);
> | 		if ( ! (yy_buffer_stack) )
> | 			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
> | 
> | 		/* zero only the new slots.*/
> | 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size *
> sizeof(struct yy_buffer_state*));
> | 		(yy_buffer_stack_max) = num_to_alloc;
> | 	}
> | }
> | 
> | /** Setup the input buffer state to scan directly from a user-specified
> character buffer.
> |  * @param base the character buffer
> |  * @param size the size in bytes of the character buffer
> |  * 
> |  * @return the newly allocated buffer state object. 
> |  */
> | YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
> | {
> | 	YY_BUFFER_STATE b;
> |     
> | 	if ( size < 2 ||
> | 	     base[size-2] != YY_END_OF_BUFFER_CHAR ||
> | 	     base[size-1] != YY_END_OF_BUFFER_CHAR )
> | 		/* They forgot to leave room for the EOB's. */
> | 		return 0;
> | 
> | 	b = (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
> | 	if ( ! b )
> | 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
> | 
> | 	b->yy_buf_size = size - 2;	/* "- 2" to take care of EOB's */
> | 	b->yy_buf_pos = b->yy_ch_buf = base;
> | 	b->yy_is_our_buffer = 0;
> | 	b->yy_input_file = 0;
> | 	b->yy_n_chars = b->yy_buf_size;
> | 	b->yy_is_interactive = 0;
> | 	b->yy_at_bol = 1;
> | 	b->yy_fill_buffer = 0;
> | 	b->yy_buffer_status = YY_BUFFER_NEW;
> | 
> | 	yy_switch_to_buffer(b  );
> | 
> | 	return b;
> | }
> | 
> | /** Setup the input buffer state to scan a string. The next call to
> yylex() will
> |  * scan from a @e copy of @a str.
> |  * @param yystr a NUL-terminated string to scan
> |  * 
> |  * @return the newly allocated buffer state object.
> |  * @note If you want to scan bytes that may contain NUL values, then use
> |  *       yy_scan_bytes() instead.
> |  */
> | YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
> | {
> |     
> | 	return yy_scan_bytes(yystr,strlen(yystr) );
> | }
> | 
> | /** Setup the input buffer state to scan the given bytes. The next call
> to yylex() will
> |  * scan from a @e copy of @a bytes.
> |  * @param bytes the byte buffer to scan
> |  * @param len the number of bytes in the buffer pointed to by @a bytes.
> |  * 
> |  * @return the newly allocated buffer state object.
> |  */
> | YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int 
> _yybytes_len )
> | {
> | 	YY_BUFFER_STATE b;
> | 	char *buf;
> | 	yy_size_t n;
> | 	int i;
> |     
> | 	/* Get memory for full buffer, including space for trailing EOB's. */
> | 	n = _yybytes_len + 2;
> | 	buf = (char *) yyalloc(n  );
> | 	if ( ! buf )
> | 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
> | 
> | 	for ( i = 0; i < _yybytes_len; ++i )
> | 		buf[i] = yybytes[i];
> | 
> | 	buf[_yybytes_len] = buf[_yybytes_len+1] = YY_END_OF_BUFFER_CHAR;
> | 
> | 	b = yy_scan_buffer(buf,n );
> | 	if ( ! b )
> | 		YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
> | 
> | 	/* It's okay to grow etc. this buffer, and we should throw it
> | 	 * away when we're done.
> | 	 */
> | 	b->yy_is_our_buffer = 1;
> | 
> | 	return b;
> | }
> | 
> | #ifndef YY_EXIT_FAILURE
> | #define YY_EXIT_FAILURE 2
> | #endif
> | 
> | static void yy_fatal_error (yyconst char* msg )
> | {
> |     	(void) fprintf( stderr, "%s\n", msg );
> | 	exit( YY_EXIT_FAILURE );
> | }
> | 
> | /* Redefine yyless() so it works in section 3 code. */
> | 
> | #undef yyless
> | #define yyless(n) \
> | 	do \
> | 		{ \
> | 		/* Undo effects of setting up yytext. */ \
> |         int yyless_macro_arg = (n); \
> |         YY_LESS_LINENO(yyless_macro_arg);\
> | 		yytext[yyleng] = (yy_hold_char); \
> | 		(yy_c_buf_p) = yytext + yyless_macro_arg; \
> | 		(yy_hold_char) = *(yy_c_buf_p); \
> | 		*(yy_c_buf_p) = '\0'; \
> | 		yyleng = yyless_macro_arg; \
> | 		} \
> | 	while ( 0 )
> | 
> | /* Accessor  methods (get/set functions) to struct members. */
> | 
> | /** Get the current line number.
> |  * 
> |  */
> | int yyget_lineno  (void)
> | {
> |         
> |     return yylineno;
> | }
> | 
> | /** Get the input stream.
> |  * 
> |  */
> | FILE *yyget_in  (void)
> | {
> |         return yyin;
> | }
> | 
> | /** Get the output stream.
> |  * 
> |  */
> | FILE *yyget_out  (void)
> | {
> |         return yyout;
> | }
> | 
> | /** Get the length of the current token.
> |  * 
> |  */
> | int yyget_leng  (void)
> | {
> |         return yyleng;
> | }
> | 
> | /** Get the current token.
> |  * 
> |  */
> | 
> | char *yyget_text  (void)
> | {
> |         return yytext;
> | }
> | 
> | /** Set the current line number.
> |  * @param line_number
> |  * 
> |  */
> | void yyset_lineno (int  line_number )
> | {
> |     
> |     yylineno = line_number;
> | }
> | 
> | /** Set the input stream. This does not discard the current
> |  * input buffer.
> |  * @param in_str A readable stream.
> |  * 
> |  * @see yy_switch_to_buffer
> |  */
> | void yyset_in (FILE *  in_str )
> | {
> |         yyin = in_str ;
> | }
> | 
> | void yyset_out (FILE *  out_str )
> | {
> |         yyout = out_str ;
> | }
> | 
> | int yyget_debug  (void)
> | {
> |         return yy_flex_debug;
> | }
> | 
> | void yyset_debug (int  bdebug )
> | {
> |         yy_flex_debug = bdebug ;
> | }
> | 
> | static int yy_init_globals (void)
> | {
> |         /* Initialization is the same as for the non-reentrant scanner.
> |      * This function is called from yylex_destroy(), so don't allocate
> here.
> |      */
> | 
> |     (yy_buffer_stack) = 0;
> |     (yy_buffer_stack_top) = 0;
> |     (yy_buffer_stack_max) = 0;
> |     (yy_c_buf_p) = (char *) 0;
> |     (yy_init) = 0;
> |     (yy_start) = 0;
> | 
> |     (yy_state_buf) = 0;
> |     (yy_state_ptr) = 0;
> |     (yy_full_match) = 0;
> |     (yy_lp) = 0;
> | 
> | /* Defined in main.c */
> | #ifdef YY_STDINIT
> |     yyin = stdin;
> |     yyout = stdout;
> | #else
> |     yyin = (FILE *) 0;
> |     yyout = (FILE *) 0;
> | #endif
> | 
> |     /* For future reference: Set errno on error, since we are called by
> |      * yylex_init()
> |      */
> |     return 0;
> | }
> | 
> | /* yylex_destroy is for both reentrant and non-reentrant scanners. */
> | int yylex_destroy  (void)
> | {
> |     
> |     /* Pop the buffer stack, destroying each element. */
> | 	while(YY_CURRENT_BUFFER){
> | 		yy_delete_buffer(YY_CURRENT_BUFFER  );
> | 		YY_CURRENT_BUFFER_LVALUE = NULL;
> | 		yypop_buffer_state();
> | 	}
> | 
> | 	/* Destroy the stack itself. */
> | 	yyfree((yy_buffer_stack) );
> | 	(yy_buffer_stack) = NULL;
> | 
> |     yyfree ( (yy_state_buf) );
> |     (yy_state_buf)  = NULL;
> | 
> |     /* Reset the globals. This is important in a non-reentrant scanner
> so the next time
> |      * yylex() is called, initialization will occur. */
> |     yy_init_globals( );
> | 
> |     return 0;
> | }
> | 
> | /*
> |  * Internal utility routines.
> |  */
> | 
> | #ifndef yytext_ptr
> | static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
> | {
> | 	register int i;
> | 	for ( i = 0; i < n; ++i )
> | 		s1[i] = s2[i];
> | }
> | #endif
> | 
> | #ifdef YY_NEED_STRLEN
> | static int yy_flex_strlen (yyconst char * s )
> | {
> | 	register int n;
> | 	for ( n = 0; s[n]; ++n )
> | 		;
> | 
> | 	return n;
> | }
> | #endif
> | 
> | void *yyalloc (yy_size_t  size )
> | {
> | 	return (void *) malloc( size );
> | }
> | 
> | void *yyrealloc  (void * ptr, yy_size_t  size )
> | {
> | 	/* The cast to (char *) in the following accommodates both
> | 	 * implementations that use char* generic pointers, and those
> | 	 * that use void* generic pointers.  It works with the latter
> | 	 * because both ANSI C and C++ allow castless assignment from
> | 	 * any pointer type to void*, and deal with argument conversions
> | 	 * as though doing an assignment.
> | 	 */
> | 	return (void *) realloc( (char *) ptr, size );
> | }
> | 
> | void yyfree (void * ptr )
> | {
> | 	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
> | }
> | 
> | #define YYTABLES_NAME "yytables"
> | 
> | #line 9 "conftest.l"
> | 
> | 
> | #ifdef YYTEXT_POINTER
> | extern char *yytext;
> | #endif
> | int
> | main (void)
> | {
> |   return ! yylex () + ! yywrap ();
> | }
> configure:3994: gcc -o conftest -g -O2   conftest.c -lfl  >&5
> configure:3994: $? = 0
> configure:4004: result: -lfl
> configure:4010: checking whether yytext is a pointer
> configure:4026: gcc -o conftest -g -O2   conftest.c -lfl  >&5
> configure:4026: $? = 0
> configure:4034: result: yes
> configure:4087: checking for ranlib
> configure:4103: found /usr/bin/ranlib
> configure:4114: result: ranlib
> configure:4180: checking for strip
> configure:4196: found /usr/bin/strip
> configure:4207: result: strip
> configure:4233: checking for bison
> configure:4249: found /usr/local/bin/bison
> configure:4260: result: bison -y
> configure:4280: checking how to run the C preprocessor
> configure:4311: gcc -E  conftest.c
> configure:4311: $? = 0
> configure:4325: gcc -E  conftest.c
> conftest.c:12:28: error: ac_nonexistent.h: No such file or directory
> configure:4325: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | /* end confdefs.h.  */
> | #include <ac_nonexistent.h>
> configure:4350: result: gcc -E
> configure:4370: gcc -E  conftest.c
> configure:4370: $? = 0
> configure:4384: gcc -E  conftest.c
> conftest.c:12:28: error: ac_nonexistent.h: No such file or directory
> configure:4384: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | /* end confdefs.h.  */
> | #include <ac_nonexistent.h>
> configure:4413: checking for grep that handles long lines and -e
> configure:4471: result: /usr/bin/grep
> configure:4476: checking for egrep
> configure:4538: result: /usr/bin/grep -E
> configure:4543: checking for ANSI C header files
> configure:4563: gcc -c -g -O2  conftest.c >&5
> configure:4563: $? = 0
> configure:4636: gcc -o conftest -g -O2   conftest.c  >&5
> configure:4636: $? = 0
> configure:4636: ./conftest
> configure:4636: $? = 0
> configure:4647: result: yes
> configure:4660: checking for sys/types.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for sys/stat.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for stdlib.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for string.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for memory.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for strings.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for inttypes.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for stdint.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4660: checking for unistd.h
> configure:4660: gcc -c -g -O2  conftest.c >&5
> configure:4660: $? = 0
> configure:4660: result: yes
> configure:4691: checking dmapi.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> conftest.c:55:19: error: dmapi.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <dmapi.h>
> configure:4691: result: no
> configure:4691: checking dmapi.h presence
> configure:4691: gcc -E  conftest.c
> conftest.c:22:19: error: dmapi.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | /* end confdefs.h.  */
> | #include <dmapi.h>
> configure:4691: result: no
> configure:4691: checking for dmapi.h
> configure:4691: result: no
> configure:4691: checking ifaddrs.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking ifaddrs.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking for ifaddrs.h
> configure:4691: result: yes
> configure:4691: checking libaio.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> conftest.c:56:20: error: libaio.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <libaio.h>
> configure:4691: result: no
> configure:4691: checking libaio.h presence
> configure:4691: gcc -E  conftest.c
> conftest.c:23:20: error: libaio.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | /* end confdefs.h.  */
> | #include <libaio.h>
> configure:4691: result: no
> configure:4691: checking for libaio.h
> configure:4691: result: no
> configure:4691: checking mm.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> conftest.c:56:16: error: mm.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <mm.h>
> configure:4691: result: no
> configure:4691: checking mm.h presence
> configure:4691: gcc -E  conftest.c
> conftest.c:23:16: error: mm.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | /* end confdefs.h.  */
> | #include <mm.h>
> configure:4691: result: no
> configure:4691: checking for mm.h
> configure:4691: result: no
> configure:4691: checking pthread.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking pthread.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking for pthread.h
> configure:4691: result: yes
> configure:4691: checking linux/genetlink.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> In file included from /usr/include/linux/genetlink.h:5,
>                  from conftest.c:57:
> /usr/include/linux/netlink.h:34: error: expected specifier-qualifier-list
> before 'sa_family_t'
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <linux/genetlink.h>
> configure:4691: result: no
> configure:4691: checking linux/genetlink.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: WARNING: linux/genetlink.h: present but cannot be compiled
> configure:4691: WARNING: linux/genetlink.h:     check for missing
> prerequisite headers?
> configure:4691: WARNING: linux/genetlink.h: see the Autoconf documentation
> configure:4691: WARNING: linux/genetlink.h:     section "Present But
> Cannot Be Compiled"
> configure:4691: WARNING: linux/genetlink.h: proceeding with the compiler's
> result
> configure:4691: checking for linux/genetlink.h
> configure:4691: result: no
> configure:4691: checking linux/mempolicy.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking linux/mempolicy.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking for linux/mempolicy.h
> configure:4691: result: yes
> configure:4691: checking linux/module.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> conftest.c:58:26: error: linux/module.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <linux/module.h>
> configure:4691: result: no
> configure:4691: checking linux/module.h presence
> configure:4691: gcc -E  conftest.c
> conftest.c:25:26: error: linux/module.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | #include <linux/module.h>
> configure:4691: result: no
> configure:4691: checking for linux/module.h
> configure:4691: result: no
> configure:4691: checking linux/netlink.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> In file included from conftest.c:58:
> /usr/include/linux/netlink.h:34: error: expected specifier-qualifier-list
> before 'sa_family_t'
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <linux/netlink.h>
> configure:4691: result: no
> configure:4691: checking linux/netlink.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: WARNING: linux/netlink.h: present but cannot be compiled
> configure:4691: WARNING: linux/netlink.h:     check for missing
> prerequisite headers?
> configure:4691: WARNING: linux/netlink.h: see the Autoconf documentation
> configure:4691: WARNING: linux/netlink.h:     section "Present But Cannot
> Be Compiled"
> configure:4691: WARNING: linux/netlink.h: proceeding with the compiler's
> result
> configure:4691: checking for linux/netlink.h
> configure:4691: result: no
> configure:4691: checking sys/acl.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> conftest.c:58:21: error: sys/acl.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <sys/acl.h>
> configure:4691: result: no
> configure:4691: checking sys/acl.h presence
> configure:4691: gcc -E  conftest.c
> conftest.c:25:21: error: sys/acl.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | #include <sys/acl.h>
> configure:4691: result: no
> configure:4691: checking for sys/acl.h
> configure:4691: result: no
> configure:4691: checking sys/epoll.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking sys/epoll.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking for sys/epoll.h
> configure:4691: result: yes
> configure:4691: checking sys/inotify.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking sys/inotify.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking for sys/inotify.h
> configure:4691: result: yes
> configure:4691: checking sys/jfsdmapi.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> conftest.c:60:26: error: sys/jfsdmapi.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <sys/jfsdmapi.h>
> configure:4691: result: no
> configure:4691: checking sys/jfsdmapi.h presence
> configure:4691: gcc -E  conftest.c
> conftest.c:27:26: error: sys/jfsdmapi.h: No such file or directory
> configure:4691: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | /* end confdefs.h.  */
> | #include <sys/jfsdmapi.h>
> configure:4691: result: no
> configure:4691: checking for sys/jfsdmapi.h
> configure:4691: result: no
> configure:4691: checking sys/prctl.h usability
> configure:4691: gcc -c -g -O2  conftest.c >&5
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking sys/prctl.h presence
> configure:4691: gcc -E  conftest.c
> configure:4691: $? = 0
> configure:4691: result: yes
> configure:4691: checking for sys/prctl.h
> configure:4691: result: yes
> configure:4719: checking sys/capability.h usability
> configure:4719: gcc -c -g -O2  conftest.c >&5
> configure:4719: $? = 0
> configure:4719: result: yes
> configure:4719: checking sys/capability.h presence
> configure:4719: gcc -E  conftest.c
> configure:4719: $? = 0
> configure:4719: result: yes
> configure:4719: checking for sys/capability.h
> configure:4719: result: yes
> configure:4727: checking attr/xattr.h usability
> configure:4727: gcc -c -g -O2  conftest.c >&5
> conftest.c:62:24: error: attr/xattr.h: No such file or directory
> configure:4727: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <attr/xattr.h>
> configure:4727: result: no
> configure:4727: checking attr/xattr.h presence
> configure:4727: gcc -E  conftest.c
> conftest.c:29:24: error: attr/xattr.h: No such file or directory
> configure:4727: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | /* end confdefs.h.  */
> | #include <attr/xattr.h>
> configure:4727: result: no
> configure:4727: checking for attr/xattr.h
> configure:4727: result: no
> configure:4738: checking for cap_free in -lcap
> configure:4763: gcc -o conftest -g -O2   conftest.c -lcap   >&5
> configure:4763: $? = 0
> configure:4772: result: yes
> configure:4776: checking for cap_from_text in -lcap
> configure:4801: gcc -o conftest -g -O2   conftest.c -lcap   >&5
> configure:4801: $? = 0
> configure:4810: result: yes
> configure:4814: checking for cap_set_proc in -lcap
> configure:4839: gcc -o conftest -g -O2   conftest.c -lcap   >&5
> configure:4839: $? = 0
> configure:4848: result: yes
> configure:4852: checking for cap_compare in -lcap
> configure:4877: gcc -o conftest -g -O2   conftest.c -lcap   >&5
> configure:4877: $? = 0
> configure:4886: result: yes
> configure:4903: checking whether CAP_BSET_DROP is declared
> configure:4903: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:36: error: 'CAP_BSET_DROP' undeclared (first use in this
> function)
> conftest.c:36: error: (Each undeclared identifier is reported only once
> conftest.c:36: error: for each function it appears in.)
> configure:4903: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | /* end confdefs.h.  */
> | #include <sys/capability.h>
> | 
> | 
> | int
> | main ()
> | {
> | #ifndef CAP_BSET_DROP
> |   (void) CAP_BSET_DROP;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:4903: result: no
> configure:4915: checking whether CAP_BSET_READ is declared
> configure:4915: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:37: error: 'CAP_BSET_READ' undeclared (first use in this
> function)
> conftest.c:37: error: (Each undeclared identifier is reported only once
> conftest.c:37: error: for each function it appears in.)
> configure:4915: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | /* end confdefs.h.  */
> | #include <sys/capability.h>
> | 
> | 
> | int
> | main ()
> | {
> | #ifndef CAP_BSET_READ
> |   (void) CAP_BSET_READ;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:4915: result: no
> configure:4927: checking whether PR_CAPBSET_READ is declared
> configure:4927: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:38: error: 'PR_CAPBSET_READ' undeclared (first use in this
> function)
> conftest.c:38: error: (Each undeclared identifier is reported only once
> conftest.c:38: error: for each function it appears in.)
> configure:4927: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | /* end confdefs.h.  */
> | #include <sys/capability.h>
> | 
> | 
> | int
> | main ()
> | {
> | #ifndef PR_CAPBSET_READ
> |   (void) PR_CAPBSET_READ;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:4927: result: no
> configure:4939: checking whether cap_compare is declared
> configure:4939: gcc -c -g -O2  conftest.c >&5
> configure:4939: $? = 0
> configure:4939: result: yes
> configure:4951: checking whether cap_free is declared
> configure:4951: gcc -c -g -O2  conftest.c >&5
> configure:4951: $? = 0
> configure:4951: result: yes
> configure:4963: checking whether cap_from_text is declared
> configure:4963: gcc -c -g -O2  conftest.c >&5
> configure:4963: $? = 0
> configure:4963: result: yes
> configure:4975: checking whether cap_get_proc is declared
> configure:4975: gcc -c -g -O2  conftest.c >&5
> configure:4975: $? = 0
> configure:4975: result: yes
> configure:4987: checking whether cap_set_file is declared
> configure:4987: gcc -c -g -O2  conftest.c >&5
> configure:4987: $? = 0
> configure:4987: result: yes
> configure:4999: checking whether cap_set_flag is declared
> configure:4999: gcc -c -g -O2  conftest.c >&5
> configure:4999: $? = 0
> configure:4999: result: yes
> configure:5011: checking whether cap_set_proc is declared
> configure:5011: gcc -c -g -O2  conftest.c >&5
> configure:5011: $? = 0
> configure:5011: result: yes
> configure:5023: checking whether cap_to_text is declared
> configure:5023: gcc -c -g -O2  conftest.c >&5
> configure:5023: $? = 0
> configure:5023: result: yes
> configure:5044: checking openssl/sha.h usability
> configure:5044: gcc -c -g -O2  conftest.c >&5
> conftest.c:73:25: error: openssl/sha.h: No such file or directory
> configure:5044: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <openssl/sha.h>
> configure:5044: result: no
> configure:5044: checking openssl/sha.h presence
> configure:5044: gcc -E  conftest.c
> conftest.c:40:25: error: openssl/sha.h: No such file or directory
> configure:5044: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | /* end confdefs.h.  */
> | #include <openssl/sha.h>
> configure:5044: result: no
> configure:5044: checking for openssl/sha.h
> configure:5044: result: no
> configure:5066: checking sys/ptrace.h usability
> configure:5066: gcc -c -g -O2  conftest.c >&5
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking sys/ptrace.h presence
> configure:5066: gcc -E  conftest.c
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking for sys/ptrace.h
> configure:5066: result: yes
> configure:5066: checking sys/reg.h usability
> configure:5066: gcc -c -g -O2  conftest.c >&5
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking sys/reg.h presence
> configure:5066: gcc -E  conftest.c
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking for sys/reg.h
> configure:5066: result: yes
> configure:5066: checking asm/ptrace.h usability
> configure:5066: gcc -c -g -O2  conftest.c >&5
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking asm/ptrace.h presence
> configure:5066: gcc -E  conftest.c
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking for asm/ptrace.h
> configure:5066: result: yes
> configure:5066: checking linux/ptrace.h usability
> configure:5066: gcc -c -g -O2  conftest.c >&5
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking linux/ptrace.h presence
> configure:5066: gcc -E  conftest.c
> configure:5066: $? = 0
> configure:5066: result: yes
> configure:5066: checking for linux/ptrace.h
> configure:5066: result: yes
> configure:5079: checking for struct user_regs_struct
> configure:5079: gcc -c -g -O2  -I./testcases/kernel/syscalls/ptrace
> conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:49: error: invalid application of 'sizeof' to incomplete type
> 'struct user_regs_struct' 
> configure:5079: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | /* end confdefs.h.  */
> | #include "ptrace.h"
> | 
> | int
> | main ()
> | {
> | if (sizeof (struct user_regs_struct))
> | 	 return 0;
> |   ;
> |   return 0;
> | }
> configure:5079: result: no
> configure:5089: checking for struct pt_regs
> configure:5089: gcc -c -g -O2  -I./testcases/kernel/syscalls/ptrace
> conftest.c >&5
> configure:5089: $? = 0
> configure:5089: gcc -c -g -O2  -I./testcases/kernel/syscalls/ptrace
> conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:49: error: expected expression before ')' token
> configure:5089: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | /* end confdefs.h.  */
> | #include "ptrace.h"
> | 
> | int
> | main ()
> | {
> | if (sizeof ((struct pt_regs)))
> | 	    return 0;
> |   ;
> |   return 0;
> | }
> configure:5089: result: yes
> configure:5100: checking whether PTRACE_GETSIGINFO is declared
> configure:5100: gcc -c -g -O2  -I./testcases/kernel/syscalls/ptrace
> conftest.c >&5
> configure:5100: $? = 0
> configure:5100: result: yes
> configure:5111: checking whether PTRACE_O_TRACEVFORKDONE is declared
> configure:5111: gcc -c -g -O2  -I./testcases/kernel/syscalls/ptrace
> conftest.c >&5
> configure:5111: $? = 0
> configure:5111: result: yes
> configure:5122: checking whether PTRACE_SETOPTIONS is declared
> configure:5122: gcc -c -g -O2  -I./testcases/kernel/syscalls/ptrace
> conftest.c >&5
> configure:5122: $? = 0
> configure:5122: result: yes
> configure:5140: checking selinux/selinux.h usability
> configure:5140: gcc -c -g -O2  conftest.c >&5
> conftest.c:81:29: error: selinux/selinux.h: No such file or directory
> configure:5140: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <selinux/selinux.h>
> configure:5140: result: no
> configure:5140: checking selinux/selinux.h presence
> configure:5140: gcc -E  conftest.c
> conftest.c:48:29: error: selinux/selinux.h: No such file or directory
> configure:5140: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | /* end confdefs.h.  */
> | #include <selinux/selinux.h>
> configure:5140: result: no
> configure:5140: checking for selinux/selinux.h
> configure:5140: result: no
> configure:5199: checking for struct sigaction.sa_sigaction
> configure:5199: gcc -c -g -O2  conftest.c >&5
> configure:5199: $? = 0
> configure:5199: result: yes
> configure:5216: checking for libaio.h
> configure:5216: result: no
> configure:5300: checking for modify_ldt
> configure:5300: gcc -o conftest -g -O2   conftest.c  >&5
> configure:5300: $? = 0
> configure:5300: result: yes
> configure:5311: checking asm/ldt.h usability
> configure:5311: gcc -c -g -O2  conftest.c >&5
> configure:5311: $? = 0
> configure:5311: result: yes
> configure:5311: checking asm/ldt.h presence
> configure:5311: gcc -E  conftest.c
> configure:5311: $? = 0
> configure:5311: result: yes
> configure:5311: checking for asm/ldt.h
> configure:5311: result: yes
> configure:5322: checking for struct user_desc
> configure:5322: gcc -c -g -O2  conftest.c >&5
> configure:5322: $? = 0
> configure:5322: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:57: error: expected expression before ')' token
> configure:5322: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | /* end confdefs.h.  */
> | #include <asm/ldt.h>
> | 
> | 
> | int
> | main ()
> | {
> | if (sizeof ((struct user_desc)))
> | 	    return 0;
> |   ;
> |   return 0;
> | }
> configure:5322: result: yes
> configure:5333: checking for struct modify_ldt_ldt_s
> configure:5333: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:58: error: invalid application of 'sizeof' to incomplete type
> 'struct modify_ldt_ldt_s' 
> configure:5333: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | /* end confdefs.h.  */
> | #include <asm/ldt.h>
> | 
> | 
> | int
> | main ()
> | {
> | if (sizeof (struct modify_ldt_ldt_s))
> | 	 return 0;
> |   ;
> |   return 0;
> | }
> configure:5333: result: no
> configure:5349: checking for linux/mempolicy.h
> configure:5349: result: yes
> configure:5359: checking for numa_alloc_onnode
> configure:5359: gcc -o conftest -g -O2   conftest.c  >&5
> /tmp/ccM1b9Ir.o: In function `main':
> /home/lims/Download/ltp-full-20100131/conftest.c:87: undefined reference
> to `numa_alloc_onnode'
> collect2: ld returned 1 exit status
> configure:5359: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | /* Define numa_alloc_onnode to an innocuous variant, in case <limits.h>
> declares numa_alloc_onnode.
> |    For example, HP-UX 11i <limits.h> declares gettimeofday.  */
> | #define numa_alloc_onnode innocuous_numa_alloc_onnode
> | 
> | /* System header to define __stub macros and hopefully few prototypes,
> |     which can conflict with char numa_alloc_onnode (); below.
> |     Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
> |     <limits.h> exists even on freestanding compilers.  */
> | 
> | #ifdef __STDC__
> | # include <limits.h>
> | #else
> | # include <assert.h>
> | #endif
> | 
> | #undef numa_alloc_onnode
> | 
> | /* Override any GCC internal prototype to avoid an error.
> |    Use char because int might match the return type of a GCC
> |    builtin and then its argument prototype would still apply.  */
> | #ifdef __cplusplus
> | extern "C"
> | #endif
> | char numa_alloc_onnode ();
> | /* The GNU C library defines this for functions which it implements
> |     to always fail with ENOSYS.  Some functions are actually named
> |     something starting with __ and the normal name is an alias.  */
> | #if defined __stub_numa_alloc_onnode || defined
> __stub___numa_alloc_onnode
> | choke me
> | #endif
> | 
> | int
> | main ()
> | {
> | return numa_alloc_onnode ();
> |   ;
> |   return 0;
> | }
> configure:5359: result: no
> configure:5369: checking for numa_available in -lnuma
> configure:5394: gcc -o conftest -g -O2   conftest.c -lnuma   >&5
> /usr/lib64/gcc/x86_64-suse-linux/4.4/../../../../x86_64-suse-linux/bin/ld:
> cannot find -lnuma
> collect2: ld returned 1 exit status
> configure:5394: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | 
> | /* Override any GCC internal prototype to avoid an error.
> |    Use char because int might match the return type of a GCC
> |    builtin and then its argument prototype would still apply.  */
> | #ifdef __cplusplus
> | extern "C"
> | #endif
> | char numa_available ();
> | int
> | main ()
> | {
> | return numa_available ();
> |   ;
> |   return 0;
> | }
> configure:5403: result: no
> configure:5412: checking whether MPOL_BIND is declared
> configure:5412: gcc -c -g -O2  conftest.c >&5
> conftest.c:53:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:59: error: 'MPOL_BIND' undeclared (first use in this function)
> conftest.c:59: error: (Each undeclared identifier is reported only once
> conftest.c:59: error: for each function it appears in.)
> configure:5412: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_BIND
> |   (void) MPOL_BIND;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5412: result: no
> configure:5426: checking whether MPOL_DEFAULT is declared
> configure:5426: gcc -c -g -O2  conftest.c >&5
> conftest.c:54:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:60: error: 'MPOL_DEFAULT' undeclared (first use in this
> function)
> conftest.c:60: error: (Each undeclared identifier is reported only once
> conftest.c:60: error: for each function it appears in.)
> configure:5426: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_DEFAULT
> |   (void) MPOL_DEFAULT;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5426: result: no
> configure:5440: checking whether MPOL_F_ADDR is declared
> configure:5440: gcc -c -g -O2  conftest.c >&5
> conftest.c:55:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:61: error: 'MPOL_F_ADDR' undeclared (first use in this
> function)
> conftest.c:61: error: (Each undeclared identifier is reported only once
> conftest.c:61: error: for each function it appears in.)
> configure:5440: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_F_ADDR
> |   (void) MPOL_F_ADDR;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5440: result: no
> configure:5454: checking whether MPOL_F_MEMS_ALLOWED is declared
> configure:5454: gcc -c -g -O2  conftest.c >&5
> conftest.c:56:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:62: error: 'MPOL_F_MEMS_ALLOWED' undeclared (first use in this
> function)
> conftest.c:62: error: (Each undeclared identifier is reported only once
> conftest.c:62: error: for each function it appears in.)
> configure:5454: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_F_MEMS_ALLOWED
> |   (void) MPOL_F_MEMS_ALLOWED;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5454: result: no
> configure:5468: checking whether MPOL_F_NODE is declared
> configure:5468: gcc -c -g -O2  conftest.c >&5
> conftest.c:57:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:63: error: 'MPOL_F_NODE' undeclared (first use in this
> function)
> conftest.c:63: error: (Each undeclared identifier is reported only once
> conftest.c:63: error: for each function it appears in.)
> configure:5468: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_F_NODE
> |   (void) MPOL_F_NODE;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5468: result: no
> configure:5482: checking whether MPOL_INTERLEAVE is declared
> configure:5482: gcc -c -g -O2  conftest.c >&5
> conftest.c:58:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:64: error: 'MPOL_INTERLEAVE' undeclared (first use in this
> function)
> conftest.c:64: error: (Each undeclared identifier is reported only once
> conftest.c:64: error: for each function it appears in.)
> configure:5482: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_INTERLEAVE
> |   (void) MPOL_INTERLEAVE;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5482: result: no
> configure:5496: checking whether MPOL_PREFERRED is declared
> configure:5496: gcc -c -g -O2  conftest.c >&5
> conftest.c:59:20: error: numaif.h: No such file or directory
> conftest.c: In function 'main':
> conftest.c:65: error: 'MPOL_PREFERRED' undeclared (first use in this
> function)
> conftest.c:65: error: (Each undeclared identifier is reported only once
> conftest.c:65: error: for each function it appears in.)
> configure:5496: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> | 
> | int
> | main ()
> | {
> | #ifndef MPOL_PREFERRED
> |   (void) MPOL_PREFERRED;
> | #endif
> | 
> |   ;
> |   return 0;
> | }
> configure:5496: result: no
> configure:5349: checking numa.h usability
> configure:5349: gcc -c -g -O2  conftest.c >&5
> conftest.c:93:18: error: numa.h: No such file or directory
> configure:5349: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <numa.h>
> configure:5349: result: no
> configure:5349: checking numa.h presence
> configure:5349: gcc -E  conftest.c
> conftest.c:60:18: error: numa.h: No such file or directory
> configure:5349: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | /* end confdefs.h.  */
> | #include <numa.h>
> configure:5349: result: no
> configure:5349: checking for numa.h
> configure:5349: result: no
> configure:5349: checking numaif.h usability
> configure:5349: gcc -c -g -O2  conftest.c >&5
> conftest.c:93:20: error: numaif.h: No such file or directory
> configure:5349: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | /* end confdefs.h.  */
> | #include <stdio.h>
> | #ifdef HAVE_SYS_TYPES_H
> | # include <sys/types.h>
> | #endif
> | #ifdef HAVE_SYS_STAT_H
> | # include <sys/stat.h>
> | #endif
> | #ifdef STDC_HEADERS
> | # include <stdlib.h>
> | # include <stddef.h>
> | #else
> | # ifdef HAVE_STDLIB_H
> | #  include <stdlib.h>
> | # endif
> | #endif
> | #ifdef HAVE_STRING_H
> | # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
> | #  include <memory.h>
> | # endif
> | # include <string.h>
> | #endif
> | #ifdef HAVE_STRINGS_H
> | # include <strings.h>
> | #endif
> | #ifdef HAVE_INTTYPES_H
> | # include <inttypes.h>
> | #endif
> | #ifdef HAVE_STDINT_H
> | # include <stdint.h>
> | #endif
> | #ifdef HAVE_UNISTD_H
> | # include <unistd.h>
> | #endif
> | #include <numaif.h>
> configure:5349: result: no
> configure:5349: checking numaif.h presence
> configure:5349: gcc -E  conftest.c
> conftest.c:60:20: error: numaif.h: No such file or directory
> configure:5349: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | /* end confdefs.h.  */
> | #include <numaif.h>
> configure:5349: result: no
> configure:5349: checking for numaif.h
> configure:5349: result: no
> configure:5543: gcc -c -g -O2  conftest.c >&5
> configure:5543: $? = 0
> configure:5587: checking for signalfd
> configure:5587: gcc -o conftest -g -O2   conftest.c  >&5
> configure:5587: $? = 0
> configure:5587: result: yes
> configure:5599: checking sys/signalfd.h usability
> configure:5599: gcc -c -g -O2  conftest.c >&5
> configure:5599: $? = 0
> configure:5599: result: yes
> configure:5599: checking sys/signalfd.h presence
> configure:5599: gcc -E  conftest.c
> configure:5599: $? = 0
> configure:5599: result: yes
> configure:5599: checking for sys/signalfd.h
> configure:5599: result: yes
> configure:5599: checking linux/types.h usability
> configure:5599: gcc -c -g -O2  conftest.c >&5
> configure:5599: $? = 0
> configure:5599: result: yes
> configure:5599: checking linux/types.h presence
> configure:5599: gcc -E  conftest.c
> configure:5599: $? = 0
> configure:5599: result: yes
> configure:5599: checking for linux/types.h
> configure:5599: result: yes
> configure:5613: checking for linux/signalfd.h
> configure:5613: gcc -c -g -O2  conftest.c >&5
> configure:5613: $? = 0
> configure:5613: result: yes
> configure:5613: checking for signalfd.h
> configure:5613: gcc -c -g -O2  conftest.c >&5
> conftest.c:70:22: error: signalfd.h: No such file or directory
> configure:5613: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | #define HAS_QUOTAV2 1
> | #define HAVE_SIGNALFD 1
> | #define HAVE_SYS_SIGNALFD_H 1
> | #define HAVE_LINUX_TYPES_H 1
> | #define HAVE_LINUX_SIGNALFD_H 1
> | /* end confdefs.h.  */
> | #ifdef HAVE_LINUX_TYPES_H
> | #include <linux/types.h>
> | #endif
> | 
> | 
> | #include <signalfd.h>
> configure:5613: result: no
> configure:5630: checking for struct signalfd_siginfo.ssi_signo
> configure:5630: gcc -c -g -O2  conftest.c >&5
> configure:5630: $? = 0
> configure:5630: result: yes
> configure:5649: checking for struct signalfd_siginfo.signo
> configure:5649: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:81: error: 'struct signalfd_siginfo' has no member named
> 'signo'
> configure:5649: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | #define HAS_QUOTAV2 1
> | #define HAVE_SIGNALFD 1
> | #define HAVE_SYS_SIGNALFD_H 1
> | #define HAVE_LINUX_TYPES_H 1
> | #define HAVE_LINUX_SIGNALFD_H 1
> | #define HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO 1
> | /* end confdefs.h.  */
> | #if defined HAVE_SYS_SIGNALFD_H
> | #include <sys/signalfd.h>
> | #elif defined HAVE_LINUX_SIGNALFD_H
> | #ifdef HAVE_LINUX_TYPES_H
> | #include <linux/types.h>
> | #endif
> | #include <linux/signalfd.h>
> | #elif defined HAVE_SIGNALFD_H
> | #include <signalfd.h>
> | #endif
> | 
> | int
> | main ()
> | {
> | static struct signalfd_siginfo ac_aggr;
> | if (ac_aggr.signo)
> | return 0;
> |   ;
> |   return 0;
> | }
> configure:5649: gcc -c -g -O2  conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:81: error: 'struct signalfd_siginfo' has no member named
> 'signo'
> configure:5649: $? = 1
> configure: failed program was:
> | /* confdefs.h */
> | #define PACKAGE_NAME "ltp"
> | #define PACKAGE_TARNAME "ltp"
> | #define PACKAGE_VERSION "LTP_VERSION"
> | #define PACKAGE_STRING "ltp LTP_VERSION"
> | #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> | #define PACKAGE_URL ""
> | #define PACKAGE "ltp"
> | #define VERSION "LTP_VERSION"
> | #define YYTEXT_POINTER 1
> | #define STDC_HEADERS 1
> | #define HAVE_SYS_TYPES_H 1
> | #define HAVE_SYS_STAT_H 1
> | #define HAVE_STDLIB_H 1
> | #define HAVE_STRING_H 1
> | #define HAVE_MEMORY_H 1
> | #define HAVE_STRINGS_H 1
> | #define HAVE_INTTYPES_H 1
> | #define HAVE_STDINT_H 1
> | #define HAVE_UNISTD_H 1
> | #define HAVE_IFADDRS_H 1
> | #define HAVE_PTHREAD_H 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_SYS_EPOLL_H 1
> | #define HAVE_SYS_INOTIFY_H 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_DECL_CAP_BSET_DROP 0
> | #define HAVE_DECL_CAP_BSET_READ 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> | #define HAVE_DECL_CAP_COMPARE 1
> | #define HAVE_DECL_CAP_FREE 1
> | #define HAVE_DECL_CAP_FROM_TEXT 1
> | #define HAVE_DECL_CAP_GET_PROC 1
> | #define HAVE_DECL_CAP_SET_FILE 1
> | #define HAVE_DECL_CAP_SET_FLAG 1
> | #define HAVE_DECL_CAP_SET_PROC 1
> | #define HAVE_DECL_CAP_TO_TEXT 1
> | #define HAVE_SYS_PTRACE_H 1
> | #define HAVE_SYS_REG_H 1
> | #define HAVE_ASM_PTRACE_H 1
> | #define HAVE_LINUX_PTRACE_H 1
> | #define HAVE_STRUCT_PT_REGS 1
> | #define HAVE_DECL_PTRACE_GETSIGINFO 1
> | #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> | #define HAVE_DECL_PTRACE_SETOPTIONS 1
> | #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> | #define HAVE_MODIFY_LDT 1
> | #define HAVE_ASM_LDT_H 1
> | #define HAVE_STRUCT_USER_DESC 1
> | #define HAVE_LINUX_MEMPOLICY_H 1
> | #define HAVE_DECL_MPOL_BIND 0
> | #define HAVE_DECL_MPOL_DEFAULT 0
> | #define HAVE_DECL_MPOL_F_ADDR 0
> | #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> | #define HAVE_DECL_MPOL_F_NODE 0
> | #define HAVE_DECL_MPOL_INTERLEAVE 0
> | #define HAVE_DECL_MPOL_PREFERRED 0
> | #define HAS_QUOTAV2 1
> | #define HAVE_SIGNALFD 1
> | #define HAVE_SYS_SIGNALFD_H 1
> | #define HAVE_LINUX_TYPES_H 1
> | #define HAVE_LINUX_SIGNALFD_H 1
> | #define HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO 1
> | /* end confdefs.h.  */
> | #if defined HAVE_SYS_SIGNALFD_H
> | #include <sys/signalfd.h>
> | #elif defined HAVE_LINUX_SIGNALFD_H
> | #ifdef HAVE_LINUX_TYPES_H
> | #include <linux/types.h>
> | #endif
> | #include <linux/signalfd.h>
> | #elif defined HAVE_SIGNALFD_H
> | #include <signalfd.h>
> | #endif
> | 
> | int
> | main ()
> | {
> | static struct signalfd_siginfo ac_aggr;
> | if (sizeof ac_aggr.signo)
> | return 0;
> |   ;
> |   return 0;
> | }
> configure:5649: result: no
> configure:5677: checking for unshare
> configure:5677: gcc -o conftest -g -O2   conftest.c  >&5
> configure:5677: $? = 0
> configure:5677: result: yes
> configure:5693: checking for linux/taskstats.h
> configure:5693: gcc -c -g -O2  conftest.c >&5
> configure:5693: $? = 0
> configure:5693: result: yes
> configure:5702: checking for struct taskstats.freepages_count
> configure:5702: gcc -c -g -O2  conftest.c >&5
> configure:5702: $? = 0
> configure:5702: result: yes
> configure:5713: checking for struct taskstats.nvcsw
> configure:5713: gcc -c -g -O2  conftest.c >&5
> configure:5713: $? = 0
> configure:5713: result: yes
> configure:5724: checking for struct taskstats.read_bytes
> configure:5724: gcc -c -g -O2  conftest.c >&5
> configure:5724: $? = 0
> configure:5724: result: yes
> configure:5856: creating ./config.status
> 
> ## ---------------------- ##
> ## Running config.status. ##
> ## ---------------------- ##
> 
> This file was extended by ltp config.status LTP_VERSION, which was
> generated by GNU Autoconf 2.64.  Invocation command line was
> 
>   CONFIG_FILES    = 
>   CONFIG_HEADERS  = 
>   CONFIG_LINKS    = 
>   CONFIG_COMMANDS = 
>   $ ./config.status 
> 
> on linux-qelv
> 
> config.status:923: creating include/mk/config.mk
> config.status:923: creating lib/ltp.pc
> config.status:923: creating ltp-devel.spec
> config.status:923: creating m4/Makefile
> config.status:923: creating execltp
> config.status:923: creating README.ltp-devel
> config.status:923: creating include/config.h
> config.status:1095: include/config.h is unchanged
> config.status:1143: executing depfiles commands
> configure:7233: === configuring in testcases/kernel/syscalls/libevent
> (/home/lims/Download/ltp-full-20100131/testcases/kernel/syscalls/libevent)
> configure:7296: running /bin/sh ./configure --disable-option-checking
> '--prefix=/opt/ltp'  --cache-file=/dev/null --srcdir=.
> configure:7233: === configuring in testcases/kernel/syscalls/pcllib/
> (/home/lims/Download/ltp-full-20100131/testcases/kernel/syscalls/pcllib/)
> configure:7296: running /bin/sh ./configure --disable-option-checking
> '--prefix=/opt/ltp'  --cache-file=/dev/null --srcdir=.
> configure:7233: === configuring in testcases/realtime
> (/home/lims/Download/ltp-full-20100131/testcases/realtime)
> configure:7296: running /bin/sh ./configure --disable-option-checking
> '--prefix=/opt/ltp'  --cache-file=/dev/null --srcdir=.
> 
> ## ---------------- ##
> ## Cache variables. ##
> ## ---------------- ##
> 
> ac_cv_build=x86_64-unknown-linux-gnu
> ac_cv_c_compiler_gnu=yes
> ac_cv_env_CC_set=
> ac_cv_env_CC_value=
> ac_cv_env_CFLAGS_set=
> ac_cv_env_CFLAGS_value=
> ac_cv_env_CPPFLAGS_set=
> ac_cv_env_CPPFLAGS_value=
> ac_cv_env_CPP_set=
> ac_cv_env_CPP_value=
> ac_cv_env_LDFLAGS_set=
> ac_cv_env_LDFLAGS_value=
> ac_cv_env_LIBS_set=
> ac_cv_env_LIBS_value=
> ac_cv_env_YACC_set=
> ac_cv_env_YACC_value=
> ac_cv_env_YFLAGS_set=
> ac_cv_env_YFLAGS_value=
> ac_cv_env_build_alias_set=
> ac_cv_env_build_alias_value=
> ac_cv_env_host_alias_set=
> ac_cv_env_host_alias_value=
> ac_cv_env_target_alias_set=
> ac_cv_env_target_alias_value=
> ac_cv_func_modify_ldt=yes
> ac_cv_func_numa_alloc_onnode=no
> ac_cv_func_signalfd=yes
> ac_cv_func_unshare=yes
> ac_cv_have_decl_CAP_BSET_DROP=no
> ac_cv_have_decl_CAP_BSET_READ=no
> ac_cv_have_decl_MPOL_BIND=no
> ac_cv_have_decl_MPOL_DEFAULT=no
> ac_cv_have_decl_MPOL_F_ADDR=no
> ac_cv_have_decl_MPOL_F_MEMS_ALLOWED=no
> ac_cv_have_decl_MPOL_F_NODE=no
> ac_cv_have_decl_MPOL_INTERLEAVE=no
> ac_cv_have_decl_MPOL_PREFERRED=no
> ac_cv_have_decl_PR_CAPBSET_READ=no
> ac_cv_have_decl_PTRACE_GETSIGINFO=yes
> ac_cv_have_decl_PTRACE_O_TRACEVFORKDONE=yes
> ac_cv_have_decl_PTRACE_SETOPTIONS=yes
> ac_cv_have_decl_cap_compare=yes
> ac_cv_have_decl_cap_free=yes
> ac_cv_have_decl_cap_from_text=yes
> ac_cv_have_decl_cap_get_proc=yes
> ac_cv_have_decl_cap_set_file=yes
> ac_cv_have_decl_cap_set_flag=yes
> ac_cv_have_decl_cap_set_proc=yes
> ac_cv_have_decl_cap_to_text=yes
> ac_cv_header_asm_ldt_h=yes
> ac_cv_header_asm_ptrace_h=yes
> ac_cv_header_attr_xattr_h=no
> ac_cv_header_dmapi_h=no
> ac_cv_header_ifaddrs_h=yes
> ac_cv_header_inttypes_h=yes
> ac_cv_header_libaio_h=no
> ac_cv_header_linux_genetlink_h=no
> ac_cv_header_linux_mempolicy_h=yes
> ac_cv_header_linux_module_h=no
> ac_cv_header_linux_netlink_h=no
> ac_cv_header_linux_ptrace_h=yes
> ac_cv_header_linux_signalfd_h=yes
> ac_cv_header_linux_taskstats_h=yes
> ac_cv_header_linux_types_h=yes
> ac_cv_header_memory_h=yes
> ac_cv_header_mm_h=no
> ac_cv_header_numa_h=no
> ac_cv_header_numaif_h=no
> ac_cv_header_openssl_sha_h=no
> ac_cv_header_pthread_h=yes
> ac_cv_header_selinux_selinux_h=no
> ac_cv_header_signalfd_h=no
> ac_cv_header_stdc=yes
> ac_cv_header_stdint_h=yes
> ac_cv_header_stdlib_h=yes
> ac_cv_header_string_h=yes
> ac_cv_header_strings_h=yes
> ac_cv_header_sys_acl_h=no
> ac_cv_header_sys_capability_h=yes
> ac_cv_header_sys_epoll_h=yes
> ac_cv_header_sys_inotify_h=yes
> ac_cv_header_sys_jfsdmapi_h=no
> ac_cv_header_sys_prctl_h=yes
> ac_cv_header_sys_ptrace_h=yes
> ac_cv_header_sys_reg_h=yes
> ac_cv_header_sys_signalfd_h=yes
> ac_cv_header_sys_stat_h=yes
> ac_cv_header_sys_types_h=yes
> ac_cv_header_unistd_h=yes
> ac_cv_host=x86_64-unknown-linux-gnu
> ac_cv_lib_cap_cap_compare=yes
> ac_cv_lib_cap_cap_free=yes
> ac_cv_lib_cap_cap_from_text=yes
> ac_cv_lib_cap_cap_set_proc=yes
> ac_cv_lib_lex=-lfl
> ac_cv_lib_numa_numa_available=no
> ac_cv_member_struct_sigaction_sa_sigaction=yes
> ac_cv_member_struct_signalfd_siginfo_signo=no
> ac_cv_member_struct_signalfd_siginfo_ssi_signo=yes
> ac_cv_member_struct_taskstats_freepages_count=yes
> ac_cv_member_struct_taskstats_nvcsw=yes
> ac_cv_member_struct_taskstats_read_bytes=yes
> ac_cv_objext=o
> ac_cv_path_EGREP='/usr/bin/grep -E'
> ac_cv_path_GREP=/usr/bin/grep
> ac_cv_path_install='/usr/bin/install -c'
> ac_cv_path_mkdir=/bin/mkdir
> ac_cv_prog_AWK=gawk
> ac_cv_prog_CPP='gcc -E'
> ac_cv_prog_LEX=flex
> ac_cv_prog_YACC='bison -y'
> ac_cv_prog_ac_ct_AR=ar
> ac_cv_prog_ac_ct_CC=gcc
> ac_cv_prog_ac_ct_RANLIB=ranlib
> ac_cv_prog_ac_ct_STRIP=strip
> ac_cv_prog_cc_c89=
> ac_cv_prog_cc_g=yes
> ac_cv_prog_lex_root=lex.yy
> ac_cv_prog_lex_yytext_pointer=yes
> ac_cv_prog_make_make_set=yes
> ac_cv_type_struct_modify_ldt_ldt_s=no
> ac_cv_type_struct_pt_regs=yes
> ac_cv_type_struct_user_desc=yes
> ac_cv_type_struct_user_regs_struct=no
> am_cv_CC_dependencies_compiler_type=none
> 
> ## ----------------- ##
> ## Output variables. ##
> ## ----------------- ##
> 
> ACLOCAL='${SHELL} /home/lims/Download/ltp-full-20100131/missing --run
> aclocal-1.10'
> AIO_LIBS=''
> AMDEPBACKSLASH='\'
> AMDEP_FALSE='#'
> AMDEP_TRUE=''
> AMTAR='${SHELL} /home/lims/Download/ltp-full-20100131/missing --run tar'
> AR='ar'
> AUTOCONF='${SHELL} /home/lims/Download/ltp-full-20100131/missing --run
> autoconf'
> AUTOHEADER='${SHELL} /home/lims/Download/ltp-full-20100131/missing --run
> autoheader'
> AUTOMAKE='${SHELL} /home/lims/Download/ltp-full-20100131/missing --run
> automake-1.10'
> AWK='gawk'
> CAP_LIBS='-lcap'
> CC='gcc'
> CCDEPMODE='depmode=none'
> CFLAGS='-g -O2'
> CPP='gcc -E'
> CPPFLAGS=''
> CROSS_COMPILATION_FALSE=''
> CROSS_COMPILATION_TRUE='#'
> CRYPTO_LIBS=''
> CYGPATH_W='echo'
> DEFS='-DHAVE_CONFIG_H'
> DEPDIR='.deps'
> ECHO_C=''
> ECHO_N='-n'
> ECHO_T=''
> EGREP='/usr/bin/grep -E'
> EXEEXT=''
> GREP='/usr/bin/grep'
> INSTALL_DATA='${INSTALL} -m 644'
> INSTALL_PROGRAM='${INSTALL}'
> INSTALL_SCRIPT='${INSTALL}'
> INSTALL_STRIP_PROGRAM='$(install_sh) -c -s'
> LDFLAGS=''
> LEX='flex'
> LEXLIB='-lfl'
> LEX_OUTPUT_ROOT='lex.yy'
> LIBOBJS=''
> LIBS=''
> LTLIBOBJS=''
> MAKEINFO='${SHELL} /home/lims/Download/ltp-full-20100131/missing --run
> makeinfo'
> MKDIR_P='/bin/mkdir -p'
> NUMA_CPPFLAGS=''
> NUMA_LIBS=''
> OBJEXT='o'
> PACKAGE='ltp'
> PACKAGE_BUGREPORT='ltp-results@lists.sourceforge.net'
> PACKAGE_NAME='ltp'
> PACKAGE_STRING='ltp LTP_VERSION'
> PACKAGE_TARNAME='ltp'
> PACKAGE_URL=''
> PACKAGE_VERSION='LTP_VERSION'
> PATH_SEPARATOR=':'
> RANLIB='ranlib'
> SELINUX_LIBS=''
> SET_MAKE=''
> SHELL='/bin/sh'
> STRIP='strip'
> VERSION='LTP_VERSION'
> YACC='bison -y'
> YFLAGS=''
> ac_ct_CC='gcc'
> am__fastdepCC_FALSE=''
> am__fastdepCC_TRUE='#'
> am__include='include'
> am__isrc=''
> am__leading_dot='.'
> am__quote=''
> am__tar='${AMTAR} chof - "$$tardir"'
> am__untar='${AMTAR} xf -'
> bindir='${exec_prefix}/bin'
> build='x86_64-unknown-linux-gnu'
> build_alias=''
> build_cpu='x86_64'
> build_os='linux-gnu'
> build_vendor='unknown'
> datadir='${datarootdir}'
> datarootdir='${prefix}/share'
> docdir='${datarootdir}/doc/${PACKAGE_TARNAME}'
> dvidir='${docdir}'
> exec_prefix='${prefix}'
> host='x86_64-unknown-linux-gnu'
> host_alias=''
> host_cpu='x86_64'
> host_os='linux-gnu'
> host_vendor='unknown'
> htmldir='${docdir}'
> includedir='${prefix}/include'
> infodir='${datarootdir}/info'
> install_sh='$(SHELL) /home/lims/Download/ltp-full-20100131/install-sh'
> libdir='${exec_prefix}/lib'
> libexecdir='${exec_prefix}/libexec'
> localedir='${datarootdir}/locale'
> localstatedir='${prefix}/var'
> mandir='${datarootdir}/man'
> mkdir_p='/bin/mkdir -p'
> oldincludedir='/usr/include'
> pdfdir='${docdir}'
> prefix='/opt/ltp'
> program_transform_name='s,x,x,'
> psdir='${docdir}'
> sbindir='${exec_prefix}/sbin'
> sharedstatedir='${prefix}/com'
> subdirs=' testcases/kernel/syscalls/libevent
> testcases/kernel/syscalls/pcllib/ testcases/realtime'
> sysconfdir='${prefix}/etc'
> target_alias=''
> 
> ## ----------- ##
> ## confdefs.h. ##
> ## ----------- ##
> 
> /* confdefs.h */
> #define PACKAGE_NAME "ltp"
> #define PACKAGE_TARNAME "ltp"
> #define PACKAGE_VERSION "LTP_VERSION"
> #define PACKAGE_STRING "ltp LTP_VERSION"
> #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
> #define PACKAGE_URL ""
> #define PACKAGE "ltp"
> #define VERSION "LTP_VERSION"
> #define YYTEXT_POINTER 1
> #define STDC_HEADERS 1
> #define HAVE_SYS_TYPES_H 1
> #define HAVE_SYS_STAT_H 1
> #define HAVE_STDLIB_H 1
> #define HAVE_STRING_H 1
> #define HAVE_MEMORY_H 1
> #define HAVE_STRINGS_H 1
> #define HAVE_INTTYPES_H 1
> #define HAVE_STDINT_H 1
> #define HAVE_UNISTD_H 1
> #define HAVE_IFADDRS_H 1
> #define HAVE_PTHREAD_H 1
> #define HAVE_LINUX_MEMPOLICY_H 1
> #define HAVE_SYS_EPOLL_H 1
> #define HAVE_SYS_INOTIFY_H 1
> #define HAVE_SYS_PRCTL_H 1
> #define HAVE_SYS_CAPABILITY_H 1
> #define HAVE_DECL_CAP_BSET_DROP 0
> #define HAVE_DECL_CAP_BSET_READ 0
> #define HAVE_DECL_PR_CAPBSET_READ 0
> #define HAVE_DECL_CAP_COMPARE 1
> #define HAVE_DECL_CAP_FREE 1
> #define HAVE_DECL_CAP_FROM_TEXT 1
> #define HAVE_DECL_CAP_GET_PROC 1
> #define HAVE_DECL_CAP_SET_FILE 1
> #define HAVE_DECL_CAP_SET_FLAG 1
> #define HAVE_DECL_CAP_SET_PROC 1
> #define HAVE_DECL_CAP_TO_TEXT 1
> #define HAVE_SYS_PTRACE_H 1
> #define HAVE_SYS_REG_H 1
> #define HAVE_ASM_PTRACE_H 1
> #define HAVE_LINUX_PTRACE_H 1
> #define HAVE_STRUCT_PT_REGS 1
> #define HAVE_DECL_PTRACE_GETSIGINFO 1
> #define HAVE_DECL_PTRACE_O_TRACEVFORKDONE 1
> #define HAVE_DECL_PTRACE_SETOPTIONS 1
> #define HAVE_STRUCT_SIGACTION_SA_SIGACTION 1
> #define HAVE_MODIFY_LDT 1
> #define HAVE_ASM_LDT_H 1
> #define HAVE_STRUCT_USER_DESC 1
> #define HAVE_LINUX_MEMPOLICY_H 1
> #define HAVE_DECL_MPOL_BIND 0
> #define HAVE_DECL_MPOL_DEFAULT 0
> #define HAVE_DECL_MPOL_F_ADDR 0
> #define HAVE_DECL_MPOL_F_MEMS_ALLOWED 0
> #define HAVE_DECL_MPOL_F_NODE 0
> #define HAVE_DECL_MPOL_INTERLEAVE 0
> #define HAVE_DECL_MPOL_PREFERRED 0
> #define HAS_QUOTAV2 1
> #define HAVE_SIGNALFD 1
> #define HAVE_SYS_SIGNALFD_H 1
> #define HAVE_LINUX_TYPES_H 1
> #define HAVE_LINUX_SIGNALFD_H 1
> #define HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO 1
> #define HAVE_UNSHARE 1
> #define HAVE_LINUX_TASKSTATS_H 1
> #define HAVE_STRUCT_TASKSTATS_FREEPAGES_COUNT 1
> #define HAVE_STRUCT_TASKSTATS_NVCSW 1
> #define HAVE_STRUCT_TASKSTATS_READ_BYTES 1
> 
> configure: exit 0
> 
>  
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the
> business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 

-- 
View this message in context: http://old.nabble.com/Got-warning-message-on-ltp-full-20100131-while-running-.-configure-tp27463931p27498190.html
Sent from the ltp-list mailing list archive at Nabble.com.


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
