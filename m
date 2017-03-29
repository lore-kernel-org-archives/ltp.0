From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 11:18:39 +0200
Subject: [LTP] [PATCH v5 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <150812828.16512609.1490776963745.JavaMail.zimbra@redhat.com>
References: <1490292957-26941-1-git-send-email-jracek@redhat.com>
 <1490292957-26941-6-git-send-email-jracek@redhat.com>
 <20170324152658.GB9961@rei.lan>
 <150812828.16512609.1490776963745.JavaMail.zimbra@redhat.com>
Message-ID: <20170329091839.GD7089@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> build on distro that doesn't define HAVE_FALLOCATE is now failing
> for me:
> 
> # git describe
> 20170116-207-g16f4d56
> 
> # ./configure && make
> ...
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/root/ltp/testcases/kernel/include -I../../../../include -I../../../../include -I../../../../include/old/  -c -o memfd_create01.o memfd_create01.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/root/ltp/testcases/kernel/include -I../../../../include -I../../../../include -I../../../../include/old/  -c -o memfd_create_common.o memfd_create_common.c
> In file included from memfd_create_common.c:21:
> ../../../../include/lapi/fallocate.h: In function ???fallocate???:
> ../../../../include/lapi/fallocate.h:55: warning: implicit declaration of function ???syscall???
> ../../../../include/lapi/fallocate.h:55: warning: implicit declaration of function ???tst_brkm???
> ../../../../include/lapi/fallocate.h:55: error: ???TCONF??? undeclared (first use in this function)
> ../../../../include/lapi/fallocate.h:55: error: (Each undeclared identifier is reported only once
> ../../../../include/lapi/fallocate.h:55: error: for each function it appears in.)
> In file included from memfd_create_common.c:28:
> /usr/include/unistd.h: At top level:
> /usr/include/unistd.h:1011: error: conflicting types for ???syscall???
> ../../../../include/lapi/fallocate.h:55: error: previous implicit declaration of ???syscall??? was here
> make[4]: *** [memfd_create_common.o] Error 1
> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/memfd_create'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp/testcases'
> make: *** [testcases-all] Error 2

Ah, right looks like we have the old API/new API mixed again. Sorry I
should have caught that during the review.

Now easy fix would be switching on newlib/oldlib and
tst_syscall()/ltp_syscall(). Bit better one would be to rewrite the
fallocate tests to newlib and switch to tst_sycall() in the fallocate.h
header.

-- 
Cyril Hrubis
chrubis@suse.cz
