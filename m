From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Mar 2020 11:15:33 +0100
Subject: [LTP] [PATCH 2/8] lapi: Add a configure check and fallback for
 setns
In-Reply-To: <20200305134834.16736-3-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
 <20200305134834.16736-3-chrubis@suse.cz>
Message-ID: <20200309101533.GA355713@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

your patchset looks good to me.

There is an error for old glibc on centos 06:

https://api.travis-ci.org/v3/job/659994070/log.txt

In file included from /usr/src/ltp/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c:21:

/usr/src/ltp/include/lapi/setns.h: In function 'setns':

/usr/src/ltp/include/lapi/setns.h:16: error: implicit declaration of function 'syscall'

/usr/src/ltp/include/lapi/setns.h:16: error: implicit declaration of function 'tst_brk'

/usr/src/ltp/include/lapi/setns.h:16: error: 'TCONF' undeclared (first use in this function)

/usr/src/ltp/include/lapi/setns.h:16: error: (Each undeclared identifier is reported only once

/usr/src/ltp/include/lapi/setns.h:16: error: for each function it appears in.)

In file included from /usr/src/ltp/include/tst_test.h:14,

                 from /usr/src/ltp/include/tst_safe_clocks.h:13,

                 from /usr/src/ltp/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c:22:

/usr/include/unistd.h: At top level:

/usr/include/unistd.h:1068: error: conflicting types for 'syscall'

/usr/src/ltp/include/lapi/setns.h:16: note: previous implicit declaration of 'syscall' was here


Kind regards,
Petr
