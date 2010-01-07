Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NSnDF-0006fD-My
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 07:55:21 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSnDE-0002cy-70
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 07:55:21 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.27])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id D6BC9239BB7
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Jan 2010 07:55:12 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2E3C4114B810
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Jan 2010 07:55:12 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 16:55:10 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 7 Jan 2010 16:55:10 +0900
Message-ID: <000301ca8f6e$bc72b8d0$35582a70$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Build failure with 2010-01-07 cvs
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

I tried to make with latest version (2010-01-07 cvs) in RHEL4.8
(2.6.9-89.ELsmp).
But it failed with following message:
------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2010-01-07/testcases/kernel/include -g
-I/home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils
-DNUMA_VERSION1_COMPATIBILITY -I../../../../include -I../../../../include
-L../../../../lib  get_mempolicy01.c   -lltp -lnuma -o get_mempolicy01
In file included from get_mempolicy01.c:78:
/home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils/nu
ma_helpers.h:81: error: redefinition of 'nodemask_set'
/usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
here
/home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils/nu
ma_helpers.h:95: error: redefinition of 'nodemask_dump'
/home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils/nu
maif.h:85: error: previous definition of 'nodemask_dump' was here
make[4]: *** [get_mempolicy01] Error 1
------------

"numa_helpers.h" is as follows (comments are omitted):
------------
#ifndef LTP_NUMA_HELPERS_H
#define LTP_NUMA_HELPERS_H

#include "config.h"
#if HAVE_NUMA_H
#include <numa.h>

static inline void nodemask_set(nodemask_t *mask, int node)

{                                                       <----- L.81
        mask->n[node / (8*sizeof(unsigned long))] |=
                (1UL << (node % (8*sizeof(unsigned long))));
}

static inline void nodemask_dump(const char *header, const nodemask_t *mask)
{                                                       <----- L.95
        int i;
        EPRINTF("%s", header);
        for (i = 0; i < NUMA_NUM_NODES/(sizeof(unsigned long)*8); i++)
                EPRINTF(" 0x%08lx", mask->n[i]);
        EPRINTF("\n");
}

#else

typedef struct nodemask_t { };

static inline void nodemask_set(nodemask_t *mask, int node)
{
        return;
}

static inline void nodemask_dump(const char *header, const nodemask_t *mask)
{
        return;
}

#endif

#endif
------------

In my system, HAVE_NUMA_H is defined as 1.

The function "nodemask_set" defined in "/usr/include/numa.h" is same
as the one of "numa_helpers.h".
And the function "nodemask_dump" defined in "${LTPROOT}/testcases/kernel
/syscalls/utils/numa_helpers" is same as the one of "numa_helpers.h".

Why are the same definitions necessary in "numa_helpers.h" on purpose?


I'm glad if I get your help.


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
