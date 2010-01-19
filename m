Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NX82g-0000v8-92
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 06:58:22 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NX82e-00010y-Mu
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 06:58:22 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000901ca94d5$83797340$8a6c59c0$@co.jp>
	<364299f41001140019k5aa41267x5add5f7bfed1ee3c@mail.gmail.com>
In-Reply-To: <364299f41001140019k5aa41267x5add5f7bfed1ee3c@mail.gmail.com>
Date: Tue, 19 Jan 2010 15:58:08 +0900
Message-ID: <000701ca98d4$c214c430$463e4c90$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] cvs version 2010-01-14 make failed
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

I am sorry for the delay in my response.


I tried to make with 2010-01-15 cvs in my system..
But it failed at "libcpuset.c" which is before "mbind.c" execution order
of "make".

------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/LTP/ltp-2010-01-15/testcases/kernel/include -I../../../../../include -I../../../../../include  -c -o libcpuset.o libcpuset.c
libcpuset.c: In function `cpuset_membind':
libcpuset.c:3440: error: `MPOL_BIND' undeclared (first use in this function)
libcpuset.c:3440: error: (Each undeclared identifier is reported only once
libcpuset.c:3440: error: for each function it appears in.)
libcpuset.c: In function `cpuset_addr2node':
libcpuset.c:3456: error: `MPOL_F_NODE' undeclared (first use in this function)
libcpuset.c:3456: error: `MPOL_F_ADDR' undeclared (first use in this function)
libcpuset.c: In function `cpuset_unpin':
libcpuset.c:3753: error: `MPOL_DEFAULT' undeclared (first use in this function)
make[5]: *** [libcpuset.o] Error 1
------------

"libcpuset.c" could be successfully built with 2010-01-14 cvs.

In "libcpuset.c", following was changed.

---(added)------
#if HAVE_LINUX_MEMPOLICY_H
#include <linux/mempolicy.h>
#endif
----------------

---(deleted)----
 /* Policies for set_mempolicy() */
#define MPOL_DEFAULT     0
#define MPOL_PREFERRED   1
#define MPOL_BIND        2
#define MPOL_INTERLEAVE  3

/* Flags for get_mempolicy() */
#define MPOL_F_NODE (1<<0) /* return next interleave node or node of addr */
#define MPOL_F_ADDR (1<<1) /* look up vma using address */
----------------

But, in my system, HAVE_LINUX_MEMPOLICY_H was not defined.
Therefor, "<linux/mempolicy.h>" was not effective.


Regards--


-Tomonori Mitani

-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] 
Sent: Thursday, January 14, 2010 5:19 PM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] cvs version 2010-01-14 make failed

On Wed, Jan 13, 2010 at 8:53 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I tried to make with 2010-01-14's cvs in RHEL4.8 (2.6.9-89.ELsmp).
> But It failed in "mbind01.c" by following message.
>
> ------------
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-2010-01-12/testcases/kernel/include
> -I/home/LTP/ltp-2010-01-12/testcases/kernel/syscalls/mbind/../utils/
> -I../../../../include -I../../../../include   -L../../../../lib  mbind01.c
> -lltp -lnuma -o mbind01
> mbind01.c:184: error: `MPOL_DEFAULT' undeclared here (not in a function)
> mbind01.c:184: error: initializer element is not constant
> mbind01.c:184: error: (near initialization for `tcase[0].policy')
> mbind01.c:188: error: initializer element is not constant
> mbind01.c:188: error: (near initialization for `tcase[0]')
> mbind01.c:190: error: initializer element is not constant
> mbind01.c:190: error: (near initialization for `tcase[1].policy')
> mbind01.c:194: error: initializer element is not constant
> mbind01.c:194: error: (near initialization for `tcase[1]')
> mbind01.c:196: error: `MPOL_BIND' undeclared here (not in a function)
> mbind01.c:196: error: initializer element is not constant
> mbind01.c:196: error: (near initialization for `tcase[2].policy')
> mbind01.c:200: error: initializer element is not constant
> mbind01.c:200: error: (near initialization for `tcase[2]')
> mbind01.c:202: error: initializer element is not constant
> mbind01.c:202: error: (near initialization for `tcase[3].policy')
> mbind01.c:206: error: initializer element is not constant
> mbind01.c:206: error: (near initialization for `tcase[3]')
> mbind01.c:208: error: `MPOL_INTERLEAVE' undeclared here (not in a function)
> mbind01.c:208: error: initializer element is not constant
> mbind01.c:208: error: (near initialization for `tcase[4].policy')
> mbind01.c:212: error: initializer element is not constant
> mbind01.c:212: error: (near initialization for `tcase[4]')
> mbind01.c:214: error: initializer element is not constant
> mbind01.c:214: error: (near initialization for `tcase[5].policy')
> mbind01.c:218: error: initializer element is not constant
> mbind01.c:218: error: (near initialization for `tcase[5]')
> mbind01.c:220: error: `MPOL_PREFERRED' undeclared here (not in a function)
> mbind01.c:220: error: initializer element is not constant
> mbind01.c:220: error: (near initialization for `tcase[6].policy')
> mbind01.c:224: error: initializer element is not constant
> mbind01.c:224: error: (near initialization for `tcase[6]')
> mbind01.c:226: error: initializer element is not constant
> mbind01.c:226: error: (near initialization for `tcase[7].policy')
> mbind01.c:230: error: initializer element is not constant
> mbind01.c:230: error: (near initialization for `tcase[7]')
> mbind01.c:236: error: initializer element is not constant
> mbind01.c:236: error: (near initialization for `tcase[8]')
> mbind01.c:238: error: initializer element is not constant
> mbind01.c:238: error: (near initialization for `tcase[9].policy')
> mbind01.c:243: error: initializer element is not constant
> mbind01.c:243: error: (near initialization for `tcase[9]')
> mbind01.c:246: error: initializer element is not constant
> mbind01.c:246: error: (near initialization for `tcase[10].policy')
> mbind01.c:250: error: initializer element is not constant
> mbind01.c:250: error: (near initialization for `tcase[10]')
> mbind01.c: In function `do_test':
> mbind01.c:309: error: `MPOL_F_ADDR' undeclared (first use in this function)
> mbind01.c:309: error: (Each undeclared identifier is reported only once
> mbind01.c:309: error: for each function it appears in.)
> make[4]: *** [mbind01] Error 1
> ------------
>
> Following version's cvs's bring same results.
>  - 2010-01-08
>  - 2010-01-12
>  - 2010-01-13
>
>
> With 2009-12-21's cvs, I succeeded to make.
> I took a difference of "mbind01.c" between "2009-12-21's cvs and
> 2010-01-12's cvs.
> In "mbind01.c", "#include "numaif.h" changed to #include "numa_helpers.h"
>
> But the definition of "MPOL_DEFAULT" which was in "numaif.h" wasn't
> described in "numa_helpers.h". There isn't this definition anywhere.
>
> I think that it may be necessary to copy the definitions of
> "MPOL_DEFAULT", "MPOL_BIND", etc... from "numaif.h".
> I tried to apply following patch and succeeded to make:
>
> ============
> --- numa_helpers.h.org  2010-01-13 14:15:35.000000000 +0900
> +++ numa_helpers.h      2010-01-13 16:04:04.000000000 +0900
> @@ -104,5 +104,18 @@
>  }
>
>  #endif
> -
> +#ifndef MPOL_DEFAULT
> +   // Policies
> +#  define MPOL_DEFAULT                  0
> +#  define MPOL_PREFERRED                1
> +#  define MPOL_BIND                     2
> +#  define MPOL_INTERLEAVE               3
> +   // Flags for get_mem_policy
> +#  define MPOL_F_NODE                   (1<<0)
> +#  define MPOL_F_ADDR                   (1<<1)
> +   // Flags for mbind
> +#  define MPOL_MF_STRICT                (1<<0)
> +#  define MPOL_MF_MOVE                  (1<<1)
> +#  define MPOL_MF_MOVE_ALL              (1<<2)
> +#endif
>  #endif

    Please try from cvs again. I added extra checks for the constants
needed for mempolicy, so the tests and functionality will be
appropriately skipped. I also yanked the ad hoc #defines as they were
spread throughout the tree...
Thanks!
-Garrett



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
