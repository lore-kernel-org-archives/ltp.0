From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 14:15:06 +0200
Subject: [LTP] [PATCH] android: io/diotest4: remove dependency on
 <sys/shm.h>
In-Reply-To: <20170919232713.57314-1-sspatil@google.com>
References: <20170919232713.57314-1-sspatil@google.com>
Message-ID: <20171011121505.GA12177@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The dependency causes the test to fail build when being compiled against
> bionic. The code however only seem to need that header for 'SHMLBA'
> constant used to set the mmap'ed segment size. That is replaced by
> the page size with this change. Tested on both Android device and a
> x86 workstation successfully.

Looking at the test git log it contains reverse of this patch, the
getpagesize() was replaced with SHMLBA, unfortunately the commit log
does not say why.

Digging up in LTP mailing list pointed to these:

https://sourceforge.net/p/ltp/mailman/ltp-list/?viewmonth=200804


Also see this commit:

commit 512cb343ef35cb952b87405787f2325106b5f48c
Author: Helge Deller <deller@gmx.de>
Date:   Fri Jun 16 15:55:23 2017 +0200

    mmap01: fix testcase on hppa architecture

    The mmap() syscall to map a file at any given page-aligned address (via the
    MAP_FIXED flag) can fail on the hppa architecture due to cache colouring
    requirements of the architecture.


So this will break on strange architectures such as sparc or hppa
because we do MAP_FIXED with unsuitable address.


-- 
Cyril Hrubis
chrubis@suse.cz
