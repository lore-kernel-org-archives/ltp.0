Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NHx7Q-0007Fd-V2
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:16:32 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NHx7I-00027p-AC
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:16:32 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Dec 2009 19:16:11 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 8 Dec 2009 19:16:10 +0900
Message-ID: <000001ca77ef$78ed7f00$6ac87d00$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Build failure with ltp-2009-12-08 cvs
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

Hi,


I tried to "make" with "ltp-2009-12-08.tar.gz" version 
in RHEL4.8 (kernel 2.6.9-89.ELsmp) and x86 architecture.

But it failed by following message:

------------
make[4]: Entering directory
`/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-12-08/testcases/kernel/include
-I/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils
-I../../../../include -I../../../../include   -L../../../../lib
get_mempolicy01.c   -lltp -lnuma -o get_mempolicy01
In file included from get_mempolicy01.c:58:
/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils/nu
maif.h:88: error: redefinition of 'nodemask_set'
/usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
here
make[4]: *** [get_mempolicy01] Error 1
make[4]: Leaving directory
`/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy'
make[3]: *** [all] Error 2
------------

For reference, "make" succeeded in my following systems:
  - RHEL5.4 (kernel 2.6.18-164.el5) and x86 architecture
  - RHEL5.4 (kernel 2.6.18-164.el5) and x86_64 architecture


"nodemask_set" is the structure whitch defined in following two header
files:
  (a) "${LTPROOT}/testcases/kernel/syscalls/utils/numaif.h"
  (b) "/usr/include/numa.h"

In "numaif.h" file, definition is as follows:

------------
#if HAVE_NUMA_H
#include <numa.h>
#else /* The following symbols clash with the numa.h ones. */

typedef struct {
        unsigned long n[NUMA_NUM_NODES/(sizeof(unsigned long)*8)];
} nodemask_t;

[...]

#endif

static inline void nodemask_dump(const char *header, const nodemask_t *mask)
{
        int i;
        EPRINTF("%s", header);
        for (i = 0; i < NUMA_NUM_NODES/(sizeof(unsigned long)*8); i++)
                EPRINTF(" 0x%08lx", mask->n[i]);
        EPRINTF("\n");
}

static inline void nodemask_set(nodemask_t *mask, int node)
{
        mask->n[node / (8*sizeof(unsigned long))] |=
                (1UL << (node % (8*sizeof(unsigned long))));
}
------------


In above definition, "nodemask_set" structure is always defined 
whether "HAVE_NUMA_H" is defined.
If "HAVE_NUMA_H" was defined, <numa.h> which defines "nodemask_set"
structure is included.
Therefore, "nodemask_set" is defined twice when "HAVE_NUMA_H" is defined.


I think that "nodemask_set" definition of "numaif.h" must be in 
"#if HAVE_NUMA_H" block.


I applied following patch, and succeeded to "make".

============
--- numaif.h.org        2009-11-13 05:30:36.000000000 +0900
+++ numaif.h    2009-12-08 10:25:09.000000000 +0900
@@ -73,6 +73,12 @@
                        return 0;
        return 1;
 }
+
+static inline void nodemask_set(nodemask_t *mask, int node)
+{
+       mask->n[node / (8*sizeof(unsigned long))] |=
+               (1UL << (node % (8*sizeof(unsigned long))));
+}
 #endif

 static inline void nodemask_dump(const char *header, const nodemask_t
*mask)
@@ -84,12 +90,6 @@
        EPRINTF("\n");
 }

-static inline void nodemask_set(nodemask_t *mask, int node)
-{
-       mask->n[node / (8*sizeof(unsigned long))] |=
-               (1UL << (node % (8*sizeof(unsigned long))));
-}
-
 #ifndef MPOL_DEFAULT
    // Policies
 #  define MPOL_DEFAULT                 0
============


I'm glad if I can get opinion that my revision is right or not.


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
