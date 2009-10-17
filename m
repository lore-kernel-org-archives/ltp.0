Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mz1ob-0000Yq-F7
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 05:26:53 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mz1oT-0003kt-NX
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 05:26:53 +0000
Received: by pzk37 with SMTP id 37so2237261pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Oct 2009 22:26:39 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 Oct 2009 22:26:39 -0700
Message-ID: <364299f40910162226h3266a625j96b408bf3632f530@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Issue with autoconf not honoring linux/types.h
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi Mike,
    Looking at the configure log, autoconf is incorrectly pruning
linux/types.h from the list of headers, and as such linux/taskstats.h
fails to compile successfully.
    Do you have any idea how I should fix this noise?
AC_DEFAULT_INCLUDES didn't help.
    The log snippet and the m4 file (minus the comments) are attached.
Thanks,
-Garrett

### ltp-taskstats.m4 ###

AC_DEFUN([LTP_CHECK_TASKSTATS],
_LTP_CHECK_TASKSTATS_FREEPAGES
)

AC_DEFUN([_LTP_CHECK_TASKSTATS_FREEPAGES],[
AC_INCLUDES_DEFAULT([
#include <linux/types.h>
])
AC_CHECK_HEADERS_ONCE([linux/taskstats.h],[
    AC_CHECK_MEMBERS([struct taskstats.freepages_count, struct
taskstats.nvcsw, struct taskstats.read_bytes],
                     [],[],[dnl
#include <linux/taskstats.h>
])
])
])

### config.log snippet ###

configure:4766: checking for linux/types.h
configure:4775: result: yes
configure:4655: checking linux/taskstats.h usability
configure:4672: gcc -c -g -O2  conftest.c >&5
In file included from conftest.c:64:
/usr/include/linux/taskstats.h:44: error: expected
specifier-qualifier-list before '__u16'
configure:4679: $? = 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "ltp"
| #define PACKAGE_TARNAME "ltp"
| #define PACKAGE_VERSION "20090930"
| #define PACKAGE_STRING "ltp 20090930"
| #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
| #define PACKAGE "ltp"
| #define VERSION "20090930"
| #define YYTEXT_POINTER 1
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_IFADDRS_H 1
| #define HAVE_LIBAIO_H 1
| #define HAVE_MM_H 1
| #define HAVE_LINUX_GENETLINK_H 1
| #define HAVE_LINUX_NETLINK_H 1
| #define HAVE_SYS_ACL_H 1
| #define HAVE_SYS_EPOLL_H 1
| #define HAVE_SYS_INOTIFY_H 1
| #define HAVE_SYS_PRCTL_H 1
| #define HAVE_LINUX_TYPES_H 1
| /* end confdefs.h.  */
| #include <stdio.h>
| #ifdef HAVE_SYS_TYPES_H
| # include <sys/types.h>
| #endif
| #ifdef HAVE_SYS_STAT_H
| # include <sys/stat.h>
| #endif
| #ifdef STDC_HEADERS
| # include <stdlib.h>
| # include <stddef.h>
| #else
| # ifdef HAVE_STDLIB_H
| #  include <stdlib.h>
| # endif
| #endif
| #ifdef HAVE_STRING_H
| # if !defined STDC_HEADERS && defined HAVE_MEMORY_H
| #  include <memory.h>
| # endif
| # include <string.h>
| #endif
| #ifdef HAVE_STRINGS_H
| # include <strings.h>
| #endif
| #ifdef HAVE_INTTYPES_H
| # include <inttypes.h>
| #endif
| #ifdef HAVE_STDINT_H
| # include <stdint.h>
| #endif
| #ifdef HAVE_UNISTD_H
| # include <unistd.h>
| #endif
| #include <linux/taskstats.h>
configure:4693: result: no
configure:4697: checking linux/taskstats.h presence
configure:4712: gcc -E  conftest.c
configure:4719: $? = 0
configure:4733: result: yes
configure:4746: WARNING: linux/taskstats.h: present but cannot be compiled
configure:4748: WARNING: linux/taskstats.h:     check for missing
prerequisite headers?
configure:4750: WARNING: linux/taskstats.h: see the Autoconf documentation
configure:4752: WARNING: linux/taskstats.h:     section "Present But
Cannot Be Compiled"
configure:4754: WARNING: linux/taskstats.h: proceeding with the
preprocessor's result
configure:4756: WARNING: linux/taskstats.h: in the future, the
compiler will take precedence
configure:4766: checking for linux/taskstats.h
configure:4775: result: yes

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
