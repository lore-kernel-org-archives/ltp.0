Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5Mu3-0005Od-Q4
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 17:10:43 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5Mu2-0005ix-KI
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 17:10:43 +0000
Received: by pwj6 with SMTP id 6so2729909pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 09:10:37 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 3 Nov 2009 09:10:37 -0800
Message-ID: <364299f40911030910l41c96c99xf0915b73e79de32a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH 1/6] numa cleanups - get_mempolicy01
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
To: LTP list <ltp-list@lists.sourceforge.net>

The patch does the following:

1. Simplifies the code in get_mempolicy01.
2. Fixes indentation (some of the output in the diff below looks
wrong, but it's correct in the real testcase file).
3. Uses TERRNO for getting the error per testcase call properly,
instead of getting the last errno value.
4. Uses basename(3) instead of hacking with strchr(3).
5. Disables the test for s390x, as described in `Build Fails on some
archs' thread.

Enabled:

get_mempolicy01    0  TINFO  :  (case00) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    1  TPASS  :  (case00) END
get_mempolicy01    0  TINFO  :  (case01) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    2  TPASS  :  (case01) END
get_mempolicy01    0  TINFO  :  (case02) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    3  TPASS  :  (case02) END
get_mempolicy01    0  TINFO  :  (case03) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    4  TPASS  :  (case03) END
get_mempolicy01    0  TINFO  :  (case04) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    5  TPASS  :  (case04) END
get_mempolicy01    0  TINFO  :  (case05) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    6  TPASS  :  (case05) END
get_mempolicy01    0  TINFO  :  (case06) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    7  TPASS  :  (case06) END
get_mempolicy01    0  TINFO  :  (case07) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    8  TPASS  :  (case07) END
get_mempolicy01    0  TINFO  :  (case08) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01    9  TPASS  :  (case08) END
get_mempolicy01    0  TINFO  :  (case09) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
get_mempolicy01   10  TPASS  :  (case09) END
get_mempolicy01    0  TINFO  :  (case10) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=14 (Bad address)
get_mempolicy01   11  TPASS  :  (case10) END
get_mempolicy01    0  TINFO  :  (case11) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
get_mempolicy01   12  TPASS  :  (case11) END

Forced disable (#undef'ed __NR_get_mempolicy):

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/get_mempolicy $
./get_mempolicy01
get_mempolicy01    1  TCONF  :  Your system doesn't properly support:
get_mempolicy

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: get_mempolicy01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c,v
retrieving revision 1.3
diff -r1.3 get_mempolicy01.c
2,3c2,3
< /* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
         */
< /*          Author(s): Takahiro Yasui
<takahiro.yasui.mp@hitachi.com>,	      */
---
> /* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd		*/
> /*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
6c6
< /*                                                                  	      */
---
> /*								  	      */
9,18c9,18
< /* the Free Software Foundation; either version 2 of the License, or
         */
< /* (at your option) any later version.
         */
< /*
         */
< /* This program is distributed in the hope that it will be useful,
         */
< /* but WITHOUT ANY WARRANTY;  without even the implied warranty of
         */
< /* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
         */
< /* the GNU General Public License for more details.
         */
< /*
         */
< /* You should have received a copy of the GNU General Public License
         */
< /* along with this program;  if not, write to the Free Software
         */
---
> /* the Free Software Foundation; either version 2 of the License, or	  */
> /* (at your option) any later version.					*/
> /*									    */
> /* This program is distributed in the hope that it will be useful,	    */
> /* but WITHOUT ANY WARRANTY;  without even the implied warranty of	    */
> /* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		  */
> /* the GNU General Public License for more details.			   */
> /*									    */
> /* You should have received a copy of the GNU General Public License	  */
> /* along with this program;  if not, write to the Free Software	       */
20c20
< /*
         */
---
> /*									    */
23,26c23,26
< /*
         */
< /* File:        get_mempolicy01.c
         */
< /*
         */
< /* Description: This tests the get_mempolicy() syscall
         */
---
> /*									    */
> /* File:	get_mempolicy01.c					     */
> /*									    */
> /* Description: This tests the get_mempolicy() syscall			*/
32,46c32,46
< /*
         */
< /* Usage:  <for command-line>
         */
< /* get_mempolicy01 [-c n] [-e][-i n] [-I x] [-p x] [-t]
          */
< /*      where,  -c n : Run n copies concurrently.
         */
< /*              -e   : Turn on errno logging.
         */
< /*              -i n : Execute test n times.
         */
< /*              -I x : Execute test for x seconds.
         */
< /*              -P x : Pause for x seconds between iterations.
         */
< /*              -t   : Turn on syscall timing.
         */
< /*
         */
< /* Total Tests: 1
         */
< /*
         */
< /* Test Name:   get_mempolicy01                                             */
< /* History:     Porting from Crackerjack to LTP is done by
         */
< /*              Manas Kumar Nayak maknayak@in.ibm.com>
         */
---
> /*									    */
> /* Usage:  <for command-line>						 */
> /* get_mempolicy01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			*/
> /*      where,  -c n : Run n copies concurrently.			     */
> /*	      -e   : Turn on errno logging.				 */
> /*	      -i n : Execute test n times.				  */
> /*	      -I x : Execute test for x seconds.			    */
> /*	      -P x : Pause for x seconds between iterations.		*/
> /*	      -t   : Turn on syscall timing.				*/
> /*									    */
> /* Total Tests: 1							     */
> /*									    */
> /* Test Name:   get_mempolicy01					     */
> /* History:     Porting from Crackerjack to LTP is done by		    */
> /*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
56a57
> #include <libgen.h>
67,68c68,69
< extern int Tst_count;           /* counter for tst_xxx routines.         */
< extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
---
> extern int Tst_count;	   /* counter for tst_xxx routines.	 */
> extern char *TESTDIR;	   /* temporary dir created by tst_tmpdir() */
73c74,82
< int  TST_TOTAL = 1;                   /* total number of tests in
this file.   */
---
> int  TST_TOTAL = 1;		   /* total number of tests in this file.   */
>
> /*
>  * Macros
>  */
> #define SYSCALL_NAME    "get_mempolicy"
>
> /* s390x doesn't support numa. */
> #if defined(__NR_get_mempolicy) && defined(__NR_mbind) && defined(__NR_set_mempolicy)
77,79c86,88
< /*
         */
< /* Function:    cleanup
         */
< /*
         */
---
> /*									    */
> /* Function:    cleanup						       */
> /*									    */
81,88c90,97
< /*              completion,  premature exit or  failure. Closes all
temporary */
< /*              files, removes all temporary directories exits the
test with  */
< /*              appropriate return code by calling tst_exit()
function.       */
< /*
         */
< /* Input:       None.
         */
< /*
         */
< /* Output:      None.
         */
< /*
         */
---
> /*	      completion,  premature exit or  failure. Closes all temporary */
> /*	      files, removes all temporary directories exits the test with  */
> /*	      appropriate return code by calling tst_exit() function.       */
> /*									    */
> /* Input:       None.							 */
> /*									    */
> /* Output:      None.							 */
> /*									    */
90,91c99,100
< /*              On success - Exits calling tst_exit(). With '0'
return code.  */
< /*
         */
---
> /*	      On success - Exits calling tst_exit(). With '0' return code.  */
> /*									    */
94,96c103,105
<         /* Remove tmp dir and all files in it */
<         TEST_CLEANUP;
<         tst_rmdir();
---
> 	/* Remove tmp dir and all files in it */
> 	TEST_CLEANUP;
> 	tst_rmdir();
98,99c107,108
<         /* Exit with appropriate return code. */
<         tst_exit();
---
> 	/* Exit with appropriate return code. */
> 	tst_exit();
104,106c113,115
< /*
         */
< /* Function:    setup
         */
< /*
         */
---
> /*									    */
> /* Function:    setup							 */
> /*									    */
108,118c117,127
< /*              typically used to capture signals, create temporary
dirs      */
< /*              and temporary files that may be used in the course
of this    */
< /*              test.
         */
< /*
         */
< /* Input:       None.
         */
< /*
         */
< /* Output:      None.
         */
< /*
         */
< /* Return:      On failure - Exits by calling cleanup().
         */
< /*              On success - returns 0.
         */
< /*
         */
---
> /*	      typically used to capture signals, create temporary dirs      */
> /*	      and temporary files that may be used in the course of this    */
> /*	      test.							 */
> /*									    */
> /* Input:       None.							 */
> /*									    */
> /* Output:      None.							 */
> /*									    */
> /* Return:      On failure - Exits by calling cleanup().		      */
> /*	      On success - returns 0.				       */
> /*									    */
121,124c130,133
<         /* Capture signals if any */
<         /* Create temporary directories */
<         TEST_PAUSE;
<         tst_tmpdir();
---
> 	/* Capture signals if any */
> 	/* Create temporary directories */
> 	TEST_PAUSE;
> 	tst_tmpdir();
127,133d135
<
< /*
<  * Macros
<  */
< #define SYSCALL_NAME    "get_mempolicy"
<
<
141,144c143,146
<         DEFAULT,        // get default policy
<         ADDR,           // get policy of memory which include mapped address
<         INVALID_POINTER,
<         INVALID_FLAGS,
---
> 	DEFAULT,	/* get default policy */
> 	ADDR,		/* get policy of memory which include mapped address */
> 	INVALID_POINTER,
> 	INVALID_FLAGS,
148,149c150,151
<         NONE,
<         SELF,
---
> 	NONE,
> 	SELF,
157,161c159,163
<         int ttype;
<         int policy;
<         int from_node;
<         int ret;
<         int err;
---
> 	int ttype;
> 	int policy;
> 	int from_node;
> 	int ret;
> 	int err;
168c170
<  *   (NONE)             man page hadn't been completed.
---
>  *   (NONE)	     man page hadn't been completed.
172,173c174,175
<  *   EFAULT             v (invalid address)
<  *   EINVAL             v (invalid parameters)
---
>  *   EFAULT	     v (invalid address)
>  *   EINVAL	     v (invalid parameters)
177,260c179,262
<         { // case00
<                 .ttype          = DEFAULT,
<                 .policy         = MPOL_DEFAULT,
<                 .from_node      = NONE,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case01
<                 .ttype          = DEFAULT,
<                 .policy         = MPOL_BIND,
<                 .from_node      = SELF,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case02
<                 .ttype          = DEFAULT,
<                 .policy         = MPOL_INTERLEAVE,
<                 .from_node      = SELF,
<                 .ret            = 0,
<                 .err            = 0,
<         },
< { // case03
<                 .ttype          = DEFAULT,
<                 .policy         = MPOL_PREFERRED,
<                 .from_node      = NONE,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case04
<                 .ttype          = DEFAULT,
<                 .policy         = MPOL_PREFERRED,
<                 .from_node      = SELF,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case05
<                 .ttype          = ADDR,
<                 .policy         = MPOL_DEFAULT,
<                 .from_node      = NONE,
<                 .ret            = 0,
<                 .err            = 0,
<         },
< { // case06
<                 .ttype          = ADDR,
<                 .policy         = MPOL_BIND,
<                 .from_node      = SELF,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case07
<                 .ttype          = ADDR,
<                 .policy         = MPOL_INTERLEAVE,
<                 .from_node      = SELF,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case08
<                 .ttype          = ADDR,
<                 .policy         = MPOL_PREFERRED,
<                 .from_node      = NONE,
<                 .ret            = 0,
<                 .err            = 0,
<         },
< { // case09
<                 .ttype          = ADDR,
<                 .policy         = MPOL_PREFERRED,
<                 .from_node      = SELF,
<                 .ret            = 0,
<                 .err            = 0,
<         },
<         { // case10
<                 .ttype          = INVALID_POINTER,
<                 .policy         = MPOL_DEFAULT,
<                 .from_node      = NONE,
<                 .ret            = -1,
<                 .err            = EFAULT,
<         },
<         { // case11
<                 .ttype          = INVALID_FLAGS,
<                 .policy         = MPOL_DEFAULT,
<                 .from_node      = NONE,
<                 .ret            = -1,
<                 .err            = EINVAL,
<         },
---
> 	{ /* case00 */
> 		.ttype	    = DEFAULT,
> 		.policy	    = MPOL_DEFAULT,
> 		.from_node  = NONE,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case01 */
> 		.ttype	    = DEFAULT,
> 		.policy	    = MPOL_BIND,
> 		.from_node  = SELF,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case02 */
> 		.ttype	    = DEFAULT,
> 		.policy	    = MPOL_INTERLEAVE,
> 		.from_node  = SELF,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> { /* case03 */
> 		.ttype	    = DEFAULT,
> 		.policy	    = MPOL_PREFERRED,
> 		.from_node  = NONE,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case04 */
> 		.ttype	    = DEFAULT,
> 		.policy	    = MPOL_PREFERRED,
> 		.from_node  = SELF,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case05 */
> 		.ttype	    = ADDR,
> 		.policy	    = MPOL_DEFAULT,
> 		.from_node  = NONE,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> { /* case06 */
> 		.ttype	    = ADDR,
> 		.policy	    = MPOL_BIND,
> 		.from_node  = SELF,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case07 */
> 		.ttype	    = ADDR,
> 		.policy	    = MPOL_INTERLEAVE,
> 		.from_node  = SELF,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case08 */
> 		.ttype	    = ADDR,
> 		.policy	    = MPOL_PREFERRED,
> 		.from_node  = NONE,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> { /* case09 */
> 		.ttype	    = ADDR,
> 		.policy     = MPOL_PREFERRED,
> 		.from_node  = SELF,
> 		.ret	    = 0,
> 		.err	    = 0,
> 	},
> 	{ /* case10 */
> 		.ttype	    = INVALID_POINTER,
> 		.policy	    = MPOL_DEFAULT,
> 		.from_node  = NONE,
> 		.ret	    = -1,
> 		.err	    = EFAULT,
> 	},
> 	{ /* case11 */
> 		.ttype	    = INVALID_FLAGS,
> 		.policy	    = MPOL_DEFAULT,
> 		.from_node  = NONE,
> 		.ret	    = -1,
> 		.err	    = EINVAL,
> 	},
263c265
< #define MEM_LENGTH              (4 * 1024 * 1024)
---
> #define MEM_LENGTH	      (4 * 1024 * 1024)
272c274
< static int do_test(struct test_case *tc)
---
> static int do_test (struct test_case *tc)
274,296c276,298
<         int sys_ret;
<         int sys_errno;
<         int result = RESULT_OK;
<         int rc, policy, flags, cmp_ok = 1;
<         nodemask_t nodemask, getnodemask;
<         unsigned long maxnode = NUMA_NUM_NODES;
<         char *p = NULL;
<         unsigned long len = MEM_LENGTH;
<
<         /* We assume that there is only one node(node0). */
<         nodemask_zero(&nodemask);
<         nodemask_set(&nodemask, 0);
<         nodemask_zero(&getnodemask);
<
<         switch (tc->ttype) {
<         case DEFAULT:
<                 flags = 0;
<                 p = NULL;
<                 // set memory policy
<                 if (tc->from_node == NONE)
<                         TEST(rc = syscall(__NR_set_mempolicy,
tc->policy, NULL, 0));
<                 else
<                         TEST(rc = syscall(__NR_set_mempolicy,
tc->policy,&nodemask, maxnode));
---
> 	int sys_ret;
> 	int sys_errno;
> 	int result = RESULT_OK;
> 	int rc, policy, flags, cmp_ok = 1;
> 	nodemask_t nodemask, getnodemask;
> 	unsigned long maxnode = NUMA_NUM_NODES;
> 	char *p = NULL;
> 	unsigned long len = MEM_LENGTH;
>
> 	/* We assume that there is only one node(node0). */
> 	nodemask_zero(&nodemask);
> 	nodemask_set(&nodemask, 0);
> 	nodemask_zero(&getnodemask);
>
> 	switch (tc->ttype) {
> 	case DEFAULT:
> 		flags = 0;
> 		p = NULL;
> 		/* set memory policy */
> 		if (tc->from_node == NONE)
> 			TEST(rc = syscall(__NR_set_mempolicy, tc->policy, NULL, 0));
> 		else
> 			TEST(rc = syscall(__NR_set_mempolicy, tc->policy, &nodemask, maxnode));
300c302
<                         result = 1;
---
> 			result = 1;
302,309c304,311
<                         tst_exit();
<                 }
<                 break;
<         default:
<                 flags = MPOL_F_ADDR;
<                 // mmap memory
<                 p = mmap(NULL, len,
PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
<                 if (p == (void*)-1) {
---
> 			tst_exit();
> 		}
> 		break;
> 	default:
> 		flags = MPOL_F_ADDR;
> 		/* mmap memory */
> 		p = mmap(NULL, len, PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> 		if (p == (void*)-1) {
311c313
<                         result = 1;
---
> 			result = 1;
313,321c315,323
<                         tst_exit();
<                 }
<                 // set memory policy
<                 if (tc->from_node == NONE)
<                         TEST(rc = syscall(__NR_mbind, p, len,
tc->policy,NULL, 0, 0));
<                 else
<                         TEST(rc = syscall(__NR_mbind, p, len,
tc->policy,&nodemask, maxnode, 0));
<                 if (tc->ttype == INVALID_POINTER)
<                         p = NULL;
---
> 			tst_exit();
> 		}
> 		/* set memory policy */
> 		if (tc->from_node == NONE)
> 			TEST(rc = syscall(__NR_mbind, p, len, tc->policy,NULL, 0, 0));
> 		else
> 			TEST(rc = syscall(__NR_mbind, p, len, tc->policy,&nodemask, maxnode, 0));
> 		if (tc->ttype == INVALID_POINTER)
> 			p = NULL;
324,326c326,346
<                         flags = -1;
<                 	break;
<         	}
---
> 			flags = -1;
> 			break;
> 		}
> 	}
> 	/*
> 	 * Execute system call
> 	 */
> 	errno = 0;
> 	TEST(sys_ret = syscall(__NR_get_mempolicy, &policy, &getnodemask, maxnode,p, flags));
> 	sys_errno = errno;
> 	if (sys_ret < 0)
> 		goto TEST_END;
>
> 	// When policy equals MPOL_DEFAULT, then get_mempolicy not return node
> 	if (tc->policy == MPOL_DEFAULT)
> 		nodemask_zero(&nodemask);
> 	cmp_ok = tc->policy == policy && (tc->from_node == NONE || nodemask_equal(&nodemask,&getnodemask));
> 	if (opt_debug) {
> 		nodemask_dump("nodemask Expect:", &nodemask);
> 		nodemask_dump("nodemask Result:", &getnodemask);
> 		tst_resm(TINFO,"policy E:%d R:%d", tc->policy, policy);
328,345d347
<         /*
<          * Execute system call
<          */
<         errno = 0;
<         TEST(sys_ret = syscall(__NR_get_mempolicy, &policy,
&getnodemask, maxnode,p, flags));
<         sys_errno = errno;
<         if (sys_ret < 0)
<                 goto TEST_END;
<
<         // When policy equals MPOL_DEFAULT, then get_mempolicy not return node
<         if (tc->policy == MPOL_DEFAULT)
<                 nodemask_zero(&nodemask);
<         cmp_ok = tc->policy == policy && (tc->from_node == NONE ||
nodemask_equal(&nodemask,&getnodemask));
<         if (opt_debug) {
<                 nodemask_dump("nodemask Expect:", &nodemask);
<                 nodemask_dump("nodemask Result:", &getnodemask);
<                 tst_resm(TINFO,"policy E:%d R:%d", tc->policy, policy);
<         }
347,352c349,354
<         /*
<          * Check results
<          */
<         result |= (sys_errno != tc->err) || !cmp_ok;
<         PRINT_RESULT_CMP(0, tc->ret, tc->err, sys_ret, sys_errno, cmp_ok);
<         return result;
---
> 	/*
> 	 * Check results
> 	 */
> 	result |= (sys_errno != tc->err) || !cmp_ok;
> 	PRINT_RESULT_CMP(0, tc->ret, tc->err, sys_ret, sys_errno, cmp_ok);
> 	return result;
362,366c364,368
<         tst_resm(TINFO,"usage: %s [options]", progname);
<         tst_resm(TINFO,"This is a regression test program of %s
system call.",SYSCALL_NAME);
<         tst_resm(TINFO,"options:");
<         tst_resm(TINFO,"    -d --debug           Show debug messages");
<         tst_resm(TINFO,"    -h --help            Show this message");
---
> 	tst_resm(TINFO, "usage: %s [options]", progname);
> 	tst_resm(TINFO, "This is a regression test program of %s system call.", SYSCALL_NAME);
> 	tst_resm(TINFO, "options:");
> 	tst_resm(TINFO, "    -d --debug	   Show debug messages");
> 	tst_resm(TINFO, "    -h --help	    Show this message");
368,369c370,371
<         tst_resm(TINFO,"NG");
<         exit(1);
---
> 	tst_resm(TINFO,"NG");
> 	exit(1);
379,384c381,383
< int main(int ac, char **av) {
< 	int result = RESULT_OK;
<         int c;
<         int i;
<         int lc;                 /* loop counter */
<         char *msg;              /* message returned from parse_opts */
---
> int main(int argc, char **argv) {
> 	int c, i, lc, ret;
> 	char *msg;	      /* message returned from parse_opts */
387,428c386,429
<                 { "debug", no_argument, 0, 'd' },
<                 { "help",  no_argument, 0, 'h' },
<                 { NULL, 0, NULL, 0 }
<         };
<
< 	progname = strchr(av[0], '/');
<         progname = progname ? progname + 1 : av[0];	
< 	
<         /* parse standard options */
<         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) !=
(char *)NULL){
<              tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
<              tst_exit();
<            }
<
<         setup();
<
<         /* Check looping state if -i option given */
<         for (lc = 0; TEST_LOOPING(lc); ++lc) {
<                 Tst_count = 0;
<                 for (testno = 0; testno < TST_TOTAL; ++testno) {
< 			 TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
< 			 while(TEST_RETURN != -1) {
< 		                switch (c) {
<                 		case 'd':
< 		                        opt_debug = 1;
<                 		        break;
< 		                default:
<                 		        usage(progname);
<                         		// NOTREACHED
<                 		}
< 		        }
<
< 		/*
< 		* Execute test
<          	*/
< 	        for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0])); i++) {
<         	        int ret;
< 	                tst_resm(TINFO,"(case%02d) START", i);
< 	                ret = do_test(&tcase[i]);
< 	                tst_resm(TINFO,"(case%02d) END => %s", i, (ret ==
0) ? "OK" : "NG");
< 	                result |= ret;
<         	}
---
> 		{ "debug", no_argument, 0, 'd' },
> 		{ "help",  no_argument, 0, 'h' },
> 		{ NULL, 0, NULL, 0 }
> 	};
>
> 	progname = basename(argv[0]);
>
> 	/* parse standard options */
> 	if ((msg = parse_opts(argc, argv, (option_t *)NULL, NULL)) != (char *)NULL){
> 	     tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> 	     tst_exit();
> 	}
>
> 	setup();
>
> 	/* Check looping state if -i option given */
> 	for (lc = 0; TEST_LOOPING(lc); lc++) {
>
> 		Tst_count = 0;
>
> 		for (testno = 0; testno < TST_TOTAL; ++testno) {
>
> 			TEST(c = getopt_long(argc, argv, "dh", long_options, NULL));
>
> 			while (TEST_RETURN != -1) {
> 				switch (c) {
> 				case 'd':
> 					opt_debug = 1;
> 					break;
> 				default:
> 					usage(progname);
> 					// NOTREACHED
> 				}
> 			}
>
> 			/*
> 			 * Execute test
> 		 	 */
> 			for (i = 0; i < (int)(sizeof(tcase) / sizeof(*tcase)); i++) {
> 				tst_resm(TINFO, "(case%02d) START", i);
> 				ret = do_test(&tcase[i]);
> 				tst_resm((ret == 0 ? TPASS : TFAIL | TERRNO),
> 					 "(case%02d) END", i);
> 			}
430,446c431,433
< 		/*
<         	 * Check results
<          	*/
<         	switch(result) {
< 	        case RESULT_OK:
<         			tst_resm(TPASS, "get_mempolicy call succeeded");
< 		                break;
<
< 	        default:
<                  	   	tst_resm(TFAIL, "%s failed - errno = %d : %s",
TCID, TEST_ERRNO, strerror(TEST_ERRNO));
<         		        tst_resm(TINFO,"NG");
< 				cleanup();
< 				tst_exit();
< 		                break;
<         	}
< 	
< 	     }
---
> 		}
>
> 	}
448,449c435
<           }
<         cleanup();
---
> 	cleanup();
450a437
>
452a440,449
> #else /* Non-existent numa implementation. */
> void cleanup () { };
>
> int
> main(int argc, char **argv) {
> 	tst_resm(TCONF, "Your system doesn't properly support: %s",
> 			SYSCALL_NAME);
> 	tst_exit();
> }
> #endif /* defined(__NR_get_mempolicy) && defined(__NR_mbind) && defined(__NR_set_mempolicy) */

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
